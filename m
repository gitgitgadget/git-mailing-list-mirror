From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 2/3] Re: mailinfo: allow individual e-mail files as input
Date: Fri, 7 Aug 2009 03:36:50 +0200
Message-ID: <20090807013650.GE12924@vidovic>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:37:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEOK-00035u-FX
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbZHGBgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbZHGBgz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:36:55 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:33147 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbZHGBgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:36:54 -0400
Received: by ewy10 with SMTP id 10so1239926ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=3+RtsX/D0/vLiYTqMfXuklPHyKZgJF0D04948YN5a3A=;
        b=rSa0gUXmUpyHHVC7AtnlpnIHVTFIW/tQzsktGHes71OsFf35JTDQ6PvMeJoazgCQXe
         43EPfNROjuKYGBstpNnOvSEvMUBFP0kSu8rMX4HvoeXvZZK4Os4dgMkW0BXXimvvTTrl
         kGu1hjFWb7upYecybuXcR/s0jyzLw7lgmTzF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GaQWGMW0Tndb+jh89gzfJE4Kex7Hz/7g5qj5M4EG22+O2NigENzabCX74nUuPz8dPF
         SIGe1rt/AFkmjRSW4gRCberbdG2FdHZisJbdbJctEBgRyBEXx/u3A2MEi4LB+aOqsimW
         tV4Kw4zih/bM4e/delF8yC9AJWEuA79pdJtf4=
Received: by 10.211.178.12 with SMTP id f12mr663940ebp.31.1249609013122;
        Thu, 06 Aug 2009 18:36:53 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 24sm1361954eyx.43.2009.08.06.18.36.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 18:36:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125156>

The 06/08/09, Brandon Casey wrote:

>  git-am.sh     |   14 ++++++++++++++
>  t/t4150-am.sh |    2 +-
>  2 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/git-am.sh b/git-am.sh
> index d64d997..dd60f5d 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -191,6 +191,20 @@ check_patch_format () {
>  			esac
>  			;;
>  		esac
> +		if test -z "$patch_format" &&
> +			test -n "$l1" &&
> +			test -n "$l2" &&
> +			test -n "$l3"
> +		then
> +			# This begins with three non-empty lines.  Is this a
> +			# piece of e-mail a-la RFC2822?  Grab all the headers,
> +			# discarding the indented remainder of folded lines,
> +			# and see if it looks like that they all begin with the
> +			# header field names...
> +			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
> +			egrep -v '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
> +			patch_format=mbox
> +		fi
>  	} < "$1" || clean_abort
>  }

May I ask why you resurrect this "first three lines check for rfc2822"
instead of dumbly falling back to the "mbox" patch_format? Performance?

-- 
Nicolas Sebrecht
