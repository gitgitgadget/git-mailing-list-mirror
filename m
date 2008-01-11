From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 19:29:51 +1300
Message-ID: <47870CDF.4010606@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org> <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org> <4786BFCD.1000303@vilain.net> <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 07:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDDPa-0003Nh-5Z
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 07:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYAKGaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 01:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbYAKGaK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 01:30:10 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56116 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbYAKGaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 01:30:08 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 72CDD21D192; Fri, 11 Jan 2008 19:29:58 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id CC00F21D18C;
	Fri, 11 Jan 2008 19:29:52 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70123>

Linus Torvalds wrote:
> 
> On Fri, 11 Jan 2008, Sam Vilain wrote:
>> Without compression of deltas:
>>
>> wilber:~/src/perl-preview$ du -sk .git/objects/pack/
>> 86781 .git/objects/pack/
>>
>> With compression of deltas:
>>
>> wilber:~/src/perl-preview$ du -sk .git/objects/pack/
>> 72907 .git/objects/pack/
> 
> Ok, so non-compressed deltas are 20% bigger.
> 
> That may well be a perfectly acceptable trade-off if the end result is 
> then a lot faster. Has somebody done performance numbers? I may have 
> missed them.. The best test is probably something like "git blame" on a 
> file that takes an appreciable amount of time.

The difference seems only barely measurable;

wilber:~/src/perl-preview$ time git annotate sv.c >/dev/null

real    0m8.130s
user    0m6.712s
sys     0m1.412s

wilber:~/src/perl-preview-loose$ time git annotate sv.c >/dev/null

real    0m7.930s
user    0m6.480s
sys     0m1.408s

(each one is last of three runs - dual-core x86_64 @ 2.1GHz w/512KB cache)

sv.c has about 1500 revisions, though the oldest line is    I also tried
annotate and log on the YACC generated parser which only has about 165
revisions, with similar results - a very minor difference or no difference.

Sam
