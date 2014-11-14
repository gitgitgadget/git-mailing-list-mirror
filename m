From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Fri, 14 Nov 2014 22:04:19 +0100
Message-ID: <87zjbtlcj0.fsf@igel.home>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
	<20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
	<5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net>
	<546470D0.3080809@kdbg.org> <20141113090832.GA8329@peff.net>
	<546653D6.7040505@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpO2f-0000Lq-A6
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161709AbaKNVEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 16:04:25 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43998 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbaKNVEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 16:04:25 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jfXH86HBfz3hjGK;
	Fri, 14 Nov 2014 22:04:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jfXH85Yk4zvh3q;
	Fri, 14 Nov 2014 22:04:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id p04yp_01h_aj; Fri, 14 Nov 2014 22:04:19 +0100 (CET)
X-Auth-Info: f+8AXrdS6OHb1yicW5nrMp0tTzZ5D/vBqZXOBLdBADe8YMbnaNtbP2+1yD9Gu9Ve
Received: from igel.home (ppp-93-104-156-1.dynamic.mnet-online.de [93.104.156.1])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 14 Nov 2014 22:04:19 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id A1F2B2C30D7; Fri, 14 Nov 2014 22:04:19 +0100 (CET)
X-Yow: Is this my STOP??
In-Reply-To: <546653D6.7040505@kdbg.org> (Johannes Sixt's message of "Fri, 14
	Nov 2014 20:11:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 2ee3fe3..fc64b73 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -312,7 +312,7 @@ int mingw_open (const char *filename, int oflags, ...)
>  		return -1;
>  	fd = _wopen(wfilename, oflags, mode);
>  
> -	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
> +	if (fd < 0 && (oflags & (O_WRONLY|O_RDWR)) && errno == EACCES) {

O_WRONLY and O_RDWR aren't flags, but two values of a 2-bit field
(O_ACCMODE).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
