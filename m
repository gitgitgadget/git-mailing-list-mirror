From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Ignore file filter
Date: Fri, 13 May 2005 09:50:07 +0100
Message-ID: <42846A3F.4030706@dgreaves.com>
References: <4283CAF8.3050304@dgreaves.com> <7v64xodshs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 10:43:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWVke-0003Gt-W3
	for gcvg-git@gmane.org; Fri, 13 May 2005 10:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVEMIuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 04:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVEMIuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 04:50:16 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:1705 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262303AbVEMIuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 04:50:09 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A601DE6E16; Fri, 13 May 2005 09:48:43 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19935-13; Fri, 13 May 2005 09:48:43 +0100 (BST)
Received: from oak.dgreaves.com (modem-2344.lemur.dialup.pol.co.uk [217.135.137.40])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 0C8B4E6E12; Fri, 13 May 2005 09:48:43 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWVrz-0005qk-KZ; Fri, 13 May 2005 09:50:07 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64xodshs.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>Just a half theoretical question.  How well does this perform
>when your filenames have:
>
>    - ' '  (ASCII 0x20)
>    - '\t' (ASCII 0x09)
>    - '\n' (ASCII 0x0a)
>    - '`'  (ASCII 0x60) backtick
>    - '$'  (ASCII 0x24) dollar sign
>
>in them?  Or is it the case that the rest of the Cogito is not
>careful enough and it does not matter to be careful only in this
>script?
>  
>
That's what the:
zerosep=$'-d "\0"'
is for.
It looks like the shell 'read' doesn't honour it though - I couldn't
make it work.

However, thanks, after I fixed the quotes I missed in:
-o \( $pass_files -eq 1 -a -f "$file" \) \
-o \( $pass_dirs -eq 1 -a -d "$file" \) \
-o \( $pass_links -eq 1 -a -h "$file" \) \

it handles all cases above except \n (of course)

Frankly I think we're beyond shell programming and we should be using
perl (IMHO as the 'best' and most portable text handler)
It also has a *fantastic* test harness available.

David
