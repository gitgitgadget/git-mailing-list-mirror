From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Sun, 17 Aug 2014 12:25:51 +0200
Message-ID: <C1695CEB-B278-422A-90D6-C3EAD8B6638C@zib.de>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de> <1407303134-16635-3-git-send-email-prohaska@zib.de> <20140816102703.GD7857@serenity.lan> <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de> <20140817072746.GD23808@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 17 12:26:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIxfW-0002XU-JC
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 12:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbaHQK0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 06:26:30 -0400
Received: from mailer.zib.de ([130.73.108.11]:45649 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaHQK0a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2014 06:26:30 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7HAPwI0024126;
	Sun, 17 Aug 2014 12:25:58 +0200 (CEST)
Received: from [192.168.1.200] (95-91-208-130-dynip.superkabel.de [95.91.208.130])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7HAPu7q024068
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 17 Aug 2014 12:25:57 +0200 (CEST)
In-Reply-To: <20140817072746.GD23808@peff.net>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53F08336.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F08336.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F08336.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255363>


On Aug 17, 2014, at 9:27 AM, Jeff King <peff@peff.net> wrote:

> On Sat, Aug 16, 2014 at 06:26:08PM +0200, Steffen Prohaska wrote:
> 
>>> Is the 15MB limit supposed to be imposed somewhere or is it just a guide
>>> of how much memory we expect Git to use in this scenario?
>> 
>> The test should confirm that the the file that is added is not mmapped
>> to memory.  The process size should be relatively small independently
>> of the size of the file that is added.  I wanted to keep the file size
>> small.  The chosen sizes worked for me on Mac and Linux.
> 
> Measuring memory usage seems inherently a bit flaky for the test suite.
> It's also a little out of place, as the test suite is generally about
> correctness and outcomes, and this is a performance issue.

For files >2GB on a 32-bit system (e.g. msysgit), filtering with the previous code always failed.  Now it works.  I created the patch to change git from 'fundamentally doesn't handle this' to 'works as expected'.


> Would it make more sense to construct a t/perf test that shows off the
> change? I suppose the run-time change may not be that impressive, but it
> would be cool if t/perf could measure max memory use, too. Then we can
> just compare results between versions, which is enough to detect
> regressions.

I wasn't aware of t/perf.  Thanks for suggesting this.

I agree that testing memory usage might be a bit flaky.  t/perf might indeed be a better place.

I'm not yet entirely convinced, though.  I'm wondering whether the proposed test would be robust enough with a large enough threshold to keep it in the main test suite.

	Steffen
