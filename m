From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 9 Jan 2008 15:07:59 +0600
Message-ID: <7bfdc29a0801090107j292eeaf5u2b49651ed23ca783@mail.gmail.com>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	 <47848CDD.7050806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 10:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWvL-00088V-CF
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 10:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYAIJIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 04:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYAIJIE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 04:08:04 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:40569 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYAIJIA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 04:08:00 -0500
Received: by fk-out-0910.google.com with SMTP id z23so34969fkz.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VYvEOIOD1U+da+rU2Gjxqh++NIoBV/CvnXMuX4nNhY4=;
        b=akq5+G29UbnhFMX9gb1Ygi+h+IPbjmU8sq4G6KIVnld5DaAXNyLcA5nAq6lmzdu9SoGP8sl5dDFwzN5GXjntBP93E8K9+xpoqF85zOeL65kwd35lsaGkeXJ18zcSHL1026vn5EBKGMSEmvQUFbHanfrLO5ecJOan2ugXcQVK7tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=udy0GB/RNhmFJ9kxHqfAy/DtWOg/3KTVaTQwTbGfEyIwQtOCbZC166KXiG8FrUrlcYkpJEujkstNVKEk65MXPz1IcKkU13aW7V60E2Ec+fAIqV0YRuvJnH307+65CiIT4jotlsCpAcESGLrFdejpdoRhxNWa+DO77/JiM5eJN4s=
Received: by 10.78.170.6 with SMTP id s6mr172516hue.62.1199869679194;
        Wed, 09 Jan 2008 01:07:59 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 01:07:59 -0800 (PST)
In-Reply-To: <47848CDD.7050806@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69972>

I already saw that mistake Johannes, thank you for pointing it out.

On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> imyousuf@gmail.com schrieb:
>
> > @@ -16,6 +16,7 @@ update=
> >  status=
> >  quiet=
> >  cached=
> > +command=
> >
> >  #
> >  # print stuff on stdout unless -q was specified
> > @@ -293,20 +294,23 @@ modules_list()
> >       done
> >  }
> >
> > +# command specifies the whole function name since
> > +# one of theirs prefix is module not modules
> >  while test $# != 0
> >  do
> >       case "$1" in
> >       add)
> >               add=1
> > +             command="module_$1"
> >               ;;
> >       init)
> > -             init=1
> > +             command="modules_$1"
> >               ;;
> >       update)
> > -             update=1
> > +             command="modules_$1"
> >               ;;
> >       status)
> > -             status=1
> > +             command="modules_list"
> >               ;;
> >       -q|--quiet)
> >               quiet=1
> > @@ -320,7 +324,7 @@ do
> >               branch="$2"; shift
> >               ;;
> >       --cached)
> > -             cached=1
> > +             command="modules_list"
>
> Don't remove cached=1 because otherwise --cached is effectively ignored.
>
> >               ;;
> >       --)
> >               break
> > @@ -345,20 +349,8 @@ case "$add,$branch" in
> >       ;;
> >  esac
> >
> > -case "$add,$init,$update,$status,$cached" in
> > -1,,,,)
> > -     module_add "$@"
> > -     ;;
> > -,1,,,)
> > -     modules_init "$@"
> > -     ;;
> > -,,1,,)
> > -     modules_update "$@"
> > -     ;;
> > -,,,*,*)
> > -     modules_list "$@"
> > -     ;;
> > -*)
> > +if [ -z $command ]; then
> >       usage
> > -     ;;
> > -esac
> > +else
> > +     "$command" "$@"
> > +fi
>
> - Previously 'git submodule' was equvalent to 'git submodule status', now
> it is an error.
>
> - Previously, passing --cached to add, init, or update was an error, now
> it is not.
>
> -- Hannes
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
