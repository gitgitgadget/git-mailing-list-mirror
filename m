From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Sun, 25 Mar 2012 17:15:15 +0200
Message-ID: <4F6F3683.7000900@gmx.net>
References: <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3446.9080001@gmx.net> <20120325011948.GC27651@sigill.intra.peff.net> <4F6EE7E2.1020702@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 17:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBpAX-0006T7-TX
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 17:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab2CYPPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 11:15:34 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:43879 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756355Ab2CYPOy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 11:14:54 -0400
Received: (qmail invoked by alias); 25 Mar 2012 15:14:52 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.166.17]
  by mail.gmx.net (mp040) with SMTP; 25 Mar 2012 17:14:52 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX19YO34HO/JYD1duf+ZziTc/Ro6kUZZ7CKTJqt1DIY
	+YOSMq7tiXmzzR
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F6EE7E2.1020702@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193869>

On 25.03.2012 11:39, Ivan Todoroski wrote:
> On 25.03.2012 03:19, Jeff King wrote:
>> On Sat, Mar 24, 2012 at 09:53:26PM +0100, Ivan Todoroski wrote:
>>> @@ -972,6 +976,42 @@ int cmd_fetch_pack(int argc, const char **argv, 
>>> const char *prefix)
>>>      if (!dest)
>>>          usage(fetch_pack_usage);
>>>  
>>> +    if (args.refs_from_stdin) {
>>> +        char ref[1000];
>>
>> Ick. Is there any reason not to use a strbuf here? 1000 is probably
>> plenty, but we are generally moving towards removing such limits where
>> possible.
>>
>> You'd also get to use strbuf_getline and strbuf_trim in the
>> newline-delimited case.
> 
> Right now that "char ref[1000]" code is rejecting refs on stdin if they 
> are longer than 1000 chars or if they contain an ASCII NUL char in them. 
> When I change this to strbuf_getline() should I be doing any similar 
> checks, or do I just pass on whatever I read?

Never mind, there is no checking necessary. I just saw that 
strbuf_getline() grows the buffer automatically so there is no chance of 
buffer overflows, plus it doesn't mind if NUL chars are present in the 
middle of the string. The subsequent code that reads the refs will stop 
at the first NUL char anyway so all is well.

I didn't know about this cool strbuf infrastructure, thanks for the tip.
