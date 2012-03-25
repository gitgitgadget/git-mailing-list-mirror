From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Sun, 25 Mar 2012 11:39:46 +0200
Message-ID: <4F6EE7E2.1020702@gmx.net>
References: <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3446.9080001@gmx.net> <20120325011948.GC27651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBjv9-0008Bp-0W
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 11:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab2CYJj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 05:39:28 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:57900 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755159Ab2CYJj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 05:39:27 -0400
Received: (qmail invoked by alias); 25 Mar 2012 09:39:25 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.174.228]
  by mail.gmx.net (mp041) with SMTP; 25 Mar 2012 11:39:25 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1/BEXYm0JfB8VY26te+wbMaEwGv2IQzwBC1OLDC+q
	EVWo20GPdbxw96
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120325011948.GC27651@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193862>

On 25.03.2012 03:19, Jeff King wrote:
> On Sat, Mar 24, 2012 at 09:53:26PM +0100, Ivan Todoroski wrote:
> 
>> ---
>>  Documentation/git-fetch-pack.txt |    9 ++++++++
>>  builtin/fetch-pack.c             |   44 ++++++++++++++++++++++++++++++++++++--
>>  fetch-pack.h                     |    3 ++-
>>  3 files changed, 53 insertions(+), 3 deletions(-)
> 
> Give more of a commit message. Why is this option useful (I know, of
> course, from our previous discussion. But keep in mind the audience of
> developers reading "git log" a year from now).

Definitely. This was just work in progress I posted while I figure out 
the test suite problem. I will add full commit messages when I complete 
the test cases. Thanks for reviewing, I will incorporate all your 
suggestions in the next version.

>> @@ -972,6 +976,42 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>>  	if (!dest)
>>  		usage(fetch_pack_usage);
>>  
>> +	if (args.refs_from_stdin) {
>> +		char ref[1000];
> 
> Ick. Is there any reason not to use a strbuf here? 1000 is probably
> plenty, but we are generally moving towards removing such limits where
> possible.
> 
> You'd also get to use strbuf_getline and strbuf_trim in the
> newline-delimited case.

Right now that "char ref[1000]" code is rejecting refs on stdin if they 
are longer than 1000 chars or if they contain an ASCII NUL char in them. 
When I change this to strbuf_getline() should I be doing any similar 
checks, or do I just pass on whatever I read?
