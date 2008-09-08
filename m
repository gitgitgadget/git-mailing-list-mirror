From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Gitk and --no-walk don't play together
Date: Mon, 8 Sep 2008 23:07:04 +0400
Message-ID: <20080908190704.GA28210@dpotapov.dyndns.org>
References: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr> <adf1fd3d0809080934s67b2a8b1w19aeb3d8e5f8b4ab@mail.gmail.com> <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi Bejar <santi@agolina.net>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcm8o-00058f-Ns
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYIHTKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 15:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYIHTKI
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:10:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:51454 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbYIHTKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 15:10:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1574479fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yjtU8hqDN/tifyXtdJGKVIAk1EYavvaoLVYKJwm72Rc=;
        b=LtRXCzcpC6Xxum7JA9SFewaJm1yUoHr/lfqnSjaSDM8tgVVLBT37jWtycGhdCx4wHp
         Zdpr+TAzeZX0DKdJ1LsNp85Cdn5dp/DzDfAgoULkDq4xDU3G7WV7N9Jq/nfmaEwbFevX
         R5sJt2AyVeghVzcFBeIPN7RdoCC7sFbp9xdHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g4/Pl73BMZWM9AiVYgSFuVz0+1QxHpy+A3DpbExMvAPbnYZrE+9lnk6hIQU/5hxRVO
         jx2ymH5N6ALLkyQxOmUeNf154gVnd29E7RDuUjleB7AkOh7lq9rTbBbgdvsWKoBl8kvQ
         XCJ5nTNRr9XxrF19sYGHqQ1McEeWyaxFzfcHg=
Received: by 10.86.82.16 with SMTP id f16mr11606095fgb.16.1220900828856;
        Mon, 08 Sep 2008 12:07:08 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id 3sm4871716fge.3.2008.09.08.12.07.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 12:07:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95292>

On Mon, Sep 08, 2008 at 01:25:12PM -0400, Jan Engelhardt wrote:
> rev-list completes without any problems. I straced gitk, and see:
> 
> 	git log --no-color -z --pretty=raw --topo-order
> 	--parents --boundary --no-walk v2.6.25 v2.6.26

git log crashed when it tried to print the boundary commit.
It seems the bug exists in all 1.5.4.x and was fixed in 1.5.5.
The commit that fixed the bug is 3131b71 when --show-all was added
to revision log. The lines that fixed this bug are the following:

> diff --git a/log-tree.c b/log-tree.c
> index 1f3fcf1..e9ba6df 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -278,6 +282,9 @@ void show_log(struct rev_info *opt, const char *sep)
>  		}
>  	}
>  
> +	if (!commit->buffer)
> +		return;
> +
>  	/*
>  	 * And then the pretty-printed message itself
>  	 */

Dmitry
