From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 17:48:59 +0800
Message-ID: <46dff0320801120148r1a760bcdq4b9dcdf31354d9e0@mail.gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	 <7vejcnv3zk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:49:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDczu-0000dh-1A
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762152AbYALJtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 04:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYALJtF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:49:05 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:40673 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762257AbYALJtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:49:01 -0500
Received: by py-out-1112.google.com with SMTP id u52so2076823pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UL6EYnpd7qu+ODmcmfF63AKYCUzJUc0Tg96fqDWBXjc=;
        b=fN7/4cgIUqI6UErt0aClxLkLYyZwOglELBiJRxGgXt1XRehw9kolq4Xs94Fi9zl0FQRi7qn3YAGDyD0lCeqeMj8R9rTja72UPpW/X20ZDJREQGH963O3ThmumzqQ//iZqHWGKDW20WxS3xN4ZCMWeKpYdiqgiLrhXGnzlitZibU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=yCjLhwi0hQgSxorurUZoFdBegz2qLbLnS3miRlFOjjJJKUdJgEVTWykD/4GvwiOrdSgdV9Hr9zQnwT+Y64CGXCgpWyp9hwTYlDahDb3qnNIROrmD4PD7D90C0UralYjcXyosoaZzIHt9xlWXPeRKd4VGFgjLXO0whITojHiAR2A=
Received: by 10.35.90.1 with SMTP id s1mr4805512pyl.53.1200131340224;
        Sat, 12 Jan 2008 01:49:00 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 01:48:59 -0800 (PST)
In-Reply-To: <7vejcnv3zk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70303>

On Jan 12, 2008 4:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>
> > +             check_dst=t
> > +             check_src=t
> > +             case $status in
> > +             D)
> > +                     check_dst=
> > +                     ;;
> > +             A)
> > +                     check_src=
> > +                     ;;
>
> I'd loosen the above grep (see my comments to your 1/5) and also
> add this:
>
>                 *)
>                         continue ;# punt
>                         ;;
>
> so that the rest of the code won't break when seeing a path that
> was submodule in the HEAD but is a blob in the index.

Right. I thought 'M' should be the default case because I missed the
case 'T' (head blob but index submodule, or the reverse) .

>
> > +             esac
> > +
> > +             (
> > +                     errmsg=
> > +                     unfound_src=
> > +                     unfound_dst=
> > +
> > +                     test -z "$check_src" ||
> > +                     GIT_DIR="$name/.git" git-rev-parse $sha1_src >&/dev/null ||
>
>
> I think you would want to read full 40-char sha1_src and
> sha1_dst with "while read", and keep that full 40-char in these
> variables, and use them when calling rev-parse here.

Hmm, precision is really a problem. However, "git diff --raw" will not
always give full 40-char sha1, instead it will give sha1 with enough
length. So maybe i can use the sha1 from "git diff --raw" ?

>
> If you are checking if that the object exists in the submodule,
> use "rev-parse --verify", which was designed for exactly that
> purpose.  If you also want to verify if the object is a commit,
> which may be a good idea anyway, "rev-parse --verify $sha1_src^0".

Yes, --verify is better.
                   ;;
>
> When reporting errors, you would want to give full 40-chars...
>
As said before, enough is ok?

> > +                     *)
> > +                             left=
> > +                             right=
> > +                             test -n "$check_src" &&
> > +                             left=$(GIT_DIR="$name/.git" git log --pretty=format:"  <%s" \
> > +                             ${check_dst:+$sha1_dst..}$sha1_src 2>/dev/null)
> > +
> > +                             test -n "$check_dst" &&
> > +                             right=$(GIT_DIR="$name/.git" git log --reverse --pretty=format:"  >%s" \
> > +                             ${check_src:+$sha1_src..}$sha1_dst 2>/dev/null)
> > +                             ;;
> > +                     esac
> > +
> > +                     echo "* $name $sha1_src...$sha1_dst:"
>
> While reporting like this, you would want the shortened form,
> perhaps produced your "cut -c1-7".
>
> > +                     if test -n "$errmsg"
> > +                     then
> > +                             echo "$errmsg"
> > +                     else
> > +                             test -n "$left" && echo "$left"
> > +                             test -n "$right" && echo "$right"
> > +                     fi
> > +                     echo
> > +             ) | sed 's/^/# /'
> > +     done
>
> I'd prefer to always have "-e" before the sed expression.
Is it not portable without "-e"?

>
> Any reason why you want separate invocation of sed inside the
> while loop?  IOW, why isn't it like this?
>
>         git diff --raw |
>         while read ...
>         do
>                 ...
>         done | sed -e 's/^/# /'
>
Just because i'm stupid. :)



-- 
Ping Yin
