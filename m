From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-daemon --inetd
Date: Fri, 16 Sep 2005 11:23:19 -0700
Message-ID: <432B0D97.2030903@zytor.com>
References: <43290EFF.3070604@zytor.com> <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org> <7vbr2tqwl0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509161027460.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 20:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKsR-0002wa-0q
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbVIPSXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbVIPSXn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:23:43 -0400
Received: from terminus.zytor.com ([209.128.68.124]:61406 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161225AbVIPSXm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 14:23:42 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8GINLa1009909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Sep 2005 11:23:22 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509161027460.26803@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8703>

Linus Torvalds wrote:
> 
> Well, the symbolic names are much nicer and more readable. So it would be 
> better to do the uid/gid translation early, and change the "chroot" thing 
> to be done after all that.
> 
> It gets a bit messy.. Easy enough to just save a "const char *new_root",
> but then you have to split up the "set_user_group()" to be two functions,
> around the actual chroot(), since the chroot needs to be done while we're
> still root.
> 

Actually, initgroups() and setgroups(), and setgid() for that matter, 
can be done before the chroot().  The only thing that needs to remain 
until the end is setuid().

At one time I played around in tftp-hpa with trying to get Linux to keep 
only CAP_SYS_CHROOT around, but I think I gave up on it.  The way Linux 
capabilities play with the rest of the permission system isn't very 
useful :(

	-hpa
