From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] ls-files --others --directory: give trailing slash
Date: Sat, 7 Jan 2006 15:35:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601071533060.3169@g5.osdl.org>
References: <7vy81racv7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 00:35:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvNap-00050A-2k
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 00:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWAGXfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 18:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWAGXfY
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 18:35:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161056AbWAGXfX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 18:35:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k07NZBDZ003590
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 7 Jan 2006 15:35:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k07NZ8RI029578;
	Sat, 7 Jan 2006 15:35:09 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy81racv7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14286>



On Sat, 7 Jan 2006, Junio C Hamano wrote:
> 
>  * Likes, dislikes?  This suits better for *my* purpose of
>    calling this from git-status, but it might be undesirable for
>    your Porcelain.

Likes.

However, I'd re-write it as just

	memcpy(fullname + baselen + len, "/", 2);
	len++;
	if (show_other_directories &&
	    !dir_exists(fullname, baselen + len))
		break;
	read_directory(fullname, fullname, baselen + len);

because let's face it, every user wants the "+1", so just do it once 
up-front instead of adding one in three different places.

		Linus
