From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Abort mergetool on read error from stdinput
Date: Thu, 2 Dec 2010 00:38:51 -0600
Message-ID: <20101202063851.GA1407@burratino>
References: <1291271301-12511-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 07:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO2p0-0000Ze-HJ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 07:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab0LBGjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 01:39:05 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55487 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab0LBGjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 01:39:04 -0500
Received: by ywl5 with SMTP id 5so3910876ywl.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H83IHEhGUcV1LLiKd2t3oa97MN+NU4A3KM+eMItOpFw=;
        b=huHcrQe3NemzTiqyjFeCkD5QEhrYdJNxwIgvBVL24/Zfbz3K9TDG/69w+npDQ0upZB
         YmTbBL5yTZEotCq8o1dCoswW7lmkrirHJRGdJhdXhPE7xBn/YgyTpv9luGiNE7LLJWwU
         SvBLK0nYaXOQjyK503KiGM9EMnzbXVV+wiPDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TYdcsLoGjNhKGce3RQh05frQSkVEyjCacPdaiTOtzREj4a3QZj90eJ5lsHkhwbXZW3
         UCx/xg2wHMhS+LXcZBrptY6BSQ9DULAMtq+aV3kU4RZk3bM+UpECcx4DPaKQETOtW6Py
         auSa9EAcZGGi0MEGyGNCfMvkODwlWPNWRqyWw=
Received: by 10.150.186.15 with SMTP id j15mr756010ybf.395.1291271943029;
        Wed, 01 Dec 2010 22:39:03 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id y11sm116877yhc.8.2010.12.01.22.39.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 22:39:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291271301-12511-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162679>

Hi Robin,

Robin Rosenberg wrote:

> infinite loop that is somewhat tricky to stop. Abort the script
> if bash read fails.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

That motivates half the change.

> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -35,7 +35,7 @@ check_unchanged () {
>  		while true; do
>  			echo "$MERGED seems unchanged."
>  			printf "Was the merge successful? [y/n] "
> -			read answer
> +			read answer < /dev/tty || exit 1

Why not
			read answer || exit 1

so tests can still run without blocking?  Aside from that, this looks
like a good change; thanks.

What platform are you on?  ^C kills the entire process group here.
