From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 31/31] rebase -i: remove unnecessary state rebase-root
Date: Wed, 29 Dec 2010 23:31:37 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012292325220.7175@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-32-git-send-email-martin.von.zweigbergk@gmail.com> <201012281740.52374.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 30 05:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYAA5-00014S-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 05:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0L3Eao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 23:30:44 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34568 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0L3Eao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 23:30:44 -0500
Received: by qyk12 with SMTP id 12so11979174qyk.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 20:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=6t6BGtY2X63/4p//sfwyB5F5BTAbDahrvkJbC2W6tQo=;
        b=rvFlzzzEm0UarEkQEQqS8m+jiTho3dU3BkKoHqTLy1VXL9DzbXebPQxToWJHbM4qaP
         aXR5e9T00+HANbzwruMBDSbmEl5J0I4CbUCgB951RpJYVEmjvbNOpdK28J5It9ZSPUHs
         qmrDw4IHXVr+6qrDv/NesrQTg+OXeZ1xjfB4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=D0DtVE5eCgVpMUM9z7dalq4hHjX3vVegL7ph96HKqZsl1hFORw1DfM31hieKD3nKxO
         Wjhf5XrGH7GORKdrZiqsUoA8DDroIOSr12vk2JbL+g5bEr0+H5lc2Pho9IgtZQffyHM3
         RVdld/se0lQdYn2fFy5fAyq17xJ/ILzyKrmYo=
Received: by 10.224.20.2 with SMTP id d2mr14675212qab.300.1293683443527;
        Wed, 29 Dec 2010 20:30:43 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm7471129qco.23.2010.12.29.20.30.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 20:30:42 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201012281740.52374.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164348>

On Tue, 28 Dec 2010, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > @@ -168,11 +168,6 @@ pick_one () {
> >  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
> >  	test -d "$REWRITTEN" &&
> >  		pick_one_preserving_merges "$@" && return
> > -	if test -n "$rebase_root"
> > -	then
> > -		output git cherry-pick "$@"
> > -		return
> > -	fi
> >  	output git cherry-pick $ff "$@"
> >  }
> [...]
> > While factoring out the state writing code a few patches back, I went
> > through each of the pieces of state that was written. I was a bit
> > hesitant to include this patch since I'm not quite sure why the code
> > was introduced, but I thought I would include it anyway to hear what
> > you have to say.
> > 
> > There used to be bug when using --ff when rebasing a root commit. This
> > was fixed in 6355e50 (builtin/revert.c: don't dereference a NULL
> > pointer, 2010-09-27). Could this have been the reason for the check?
> > Thomas, do you remember?
> 
> I think this just ended up being such a strange test because of the
> following hunk in 8e75abf (rebase -i: use new --ff cherry-pick option,
> 2010-03-06):
> 
> @@ -232,16 +232,7 @@ pick_one () {
>                 output git cherry-pick "$@"
>                 return
>         fi
> -       parent_sha1=$(git rev-parse --verify $sha1^) ||
> -               die "Could not get the parent of $sha1"
> -       current_sha1=$(git rev-parse --verify HEAD)
> -       if test -z "$no_ff" && test "$current_sha1" = "$parent_sha1"
> -       then
> -               output git reset --hard $sha1
> -               output warn Fast-forward to $(git rev-parse --short $sha1)
> -       else
> -               output git cherry-pick "$@"
> -       fi
> +       output git cherry-pick $ff "$@"
>  }
> -- 

Yes, I saw that one as well, so it would probably have made more sense
to ask Christian instead (the author of 8e75abf). So do you remember,
Christian?

Anyway, thanks for your input, Thomas. That makes me feel a little
less worried about this patch.


/Martin
