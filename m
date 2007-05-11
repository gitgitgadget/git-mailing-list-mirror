From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] read-tree -m -u: avoid getting confused by intermediate symlinks.
Date: Fri, 11 May 2007 16:08:15 +0200
Message-ID: <81b0412b0705110708y7e3a9024p9e117e2da84ae916@mail.gmail.com>
References: <7vveezde8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 16:08:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmVnE-0003vY-16
	for gcvg-git@gmane.org; Fri, 11 May 2007 16:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXEKOIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbXEKOIT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 10:08:19 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:32806 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXEKOIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 10:08:17 -0400
Received: by an-out-0708.google.com with SMTP id d18so235552and
        for <git@vger.kernel.org>; Fri, 11 May 2007 07:08:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qlqP/12uQGFmSjpHQCc5gqJrWJfjVyGlWkfBYgScrrgklAHYg3IJ4ppWFx3yt/jKiEnQ6DGPllHiLIJwBDqSIbBeD2B0jDBhzGy64tAeV5ozXPcTW+9Ra5jkbWMqwRyR/wConSWKcj7SJ9HKrM401aepRuyqnJk2mhF6PTEJZFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y76nnfo3OwVho+05vPGwYzalVXuzpdcEN4lXiEU7M8fiCBPPaFV2SMrH8aW0DOET2oiLzDTzDotH8uhbX05eBozTP7Vc3ixA3l141uE7EWUpbPWnGakB9dAbZRoQ97kuOGTjM0nAfp/vfY6EzQ1M54OgOgI62Y8GX6D3+n16jtQ=
Received: by 10.100.190.8 with SMTP id n8mr2220980anf.1178892495786;
        Fri, 11 May 2007 07:08:15 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Fri, 11 May 2007 07:08:15 -0700 (PDT)
In-Reply-To: <7vveezde8b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46959>

On 5/11/07, Junio C Hamano <junkio@cox.net> wrote:
> @@ -268,6 +268,8 @@ static void unlink_entry(char *name)
>  {
>         char *cp, *prev;
>
> +       if (has_symlink_leading_path(name))
> +               return;

This can slow down the unlink case quiet considerably.
Maybe the symlink paths can be cached?
