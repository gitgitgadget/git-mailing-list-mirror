From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 17:53:00 +0200
Message-ID: <20120913175300953765.9ccf790f@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
 <20120913154309.GB726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 17:53:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCBjC-0001TS-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 17:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758404Ab2IMPxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 11:53:08 -0400
Received: from [92.246.25.51] ([92.246.25.51]:62131 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758445Ab2IMPxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 11:53:07 -0400
Received: (qmail 83903 invoked from network); 13 Sep 2012 15:53:01 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 13 Sep 2012 15:53:01 -0000
In-Reply-To: <20120913154309.GB726@sigill.intra.peff.net>
X-Mailer: GyazMail version 1.5.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205390>

Hi Jeff and Drew.

Thank you for your quick replies! :)

The diffs look nasty yes; that's my main issue.
It can be worked around in many ways; eg a simple (but time consuming) way:
$ git diff mypcb.osm >mypcb.diff && nano mypcb.diff

-It'd be better to just pipe it into a regex, which changes CR to LF on the fly.

OsmondPCB is able to read files that has mixed LF and CR. (By mixed, I do not talk about CRLF)

The files do not need line-by-line diffing, but I think it would make it more readable.
Thank you very much for the hint on the clean/smudge filters. I'll have a look at it. =)


Love
Jens

On Thu, 13 Sep 2012 11:43:10 -0400, Jeff King wrote:
> On Thu, Sep 13, 2012 at 11:34:50AM -0400, Drew Northup wrote:
> 
>>> I've read that git supports two different line endings; either CRLF 
>>> or LF, but it does not support CR.
>>> Would it make sense to add support for CR (if so, I hereby request 
>>> it as a new feature) ?
>> 
>> Even if Git can't do CRLF/LF translation on a file it will still store
>> and track the content of it it just fine. In fact you probably want
>> translation completely disabled in this case. 
> 
> Yeah. If the files always should just have CR, then just don't ask git
> to do any translation (by not setting the "text" attribute, or even
> setting "-text" if you have something like autocrlf turned on globally),
> and it will preserve the bytes exactly. I suspect diffs will look nasty
> because we won't interpret CR as a line-ending, though.
> 
> Do the files actually need line-by-line diffing and merging? If not,
> then you are fine.
> 
> If so, then it would probably be nice to store them with a canonical LF
> in the repository, but convert to CR on checkout. Git can't do that
> internally, but you could define clean/smudge filters to do so (see the
> section in "git help attributes" on "Checking-out and checking-in";
> specifically the "filter" subsection).
> 
> -Peff
