From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 13:21:03 -0700
Message-ID: <434D702F.4060409@zytor.com>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home> <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home> <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost> <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net> <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org> <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org> <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org> <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org> <Pine.LNX.4.63.0510121452030.23242@iabervon.org> <Pine.LNX.4.64.0510121220230.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Paul Eggert <eggert@CS.UCLA.EDU>,
	Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 22:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPn6t-0000Br-9d
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 22:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVJLUVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 16:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVJLUVx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 16:21:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8630 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964774AbVJLUVx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 16:21:53 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9CKL4lP026995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Oct 2005 13:21:05 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510121220230.15297@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10046>

Linus Torvalds wrote:
> 
> Nope. The traditional vt100 escape sequence is "ESC" followed by a 
> character to indicate the type of sequence (the most common one is '['). 
> That's all 7-bit and fine.
> 
> HOWEVER, they made the 8-bit extension be such that any of these vt100 
> begin sequences where the second character is in the appropriate range can 
> be instead shortened by one character, by instead using a single 8-bit 
> character of "0x80+(char-0x40)". Ie the traditional "ESC + '['" (\x1b\x5b) 
> can also be written as a single '\x9b' character, aka CSI.
> 
> In other words, 0x80-0x9f are _all_ just vt100 shorthand for ESC+'@' 
> through ESC+'_'.
> 
> (I guess it's not strictly "vt100" any more - it's the extended vt220 
> format).
> 

Actually, it's even trickier than that.

CSI is character 0x1b of control code set C1; there are two "windows" 
for control codes -- CL (0x00-0x1f) and CR (0x80-0x9f).  Normally CL is 
mapped to C0 and CR is mapped to CL, but ESC will temporarily map C1 
into CL.

VT1xx didn't support this since they didn't support 8-bit anything.

Anyway, a *lot* of character sets -- not just UTF-8 -- use the CR range 
of bytes for printables.

	-hpa
