From: Jeff King <peff@peff.net>
Subject: Re: git log --pretty=format joins lines in the subject of commit
 message
Date: Fri, 17 Sep 2010 10:55:22 -0400
Message-ID: <20100917145522.GB2860@sigill.intra.peff.net>
References: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
 <AANLkTikXwKBUKvrNs3ezKWjBh35Y87q6gZKSyZ=1cZyG@mail.gmail.com>
 <4D8D88A4-FEBF-4FA9-A39F-410D76289E4B@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 16:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwcL1-0007yg-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 16:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab0IQOyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 10:54:50 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab0IQOyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 10:54:49 -0400
Received: (qmail 24663 invoked by uid 111); 17 Sep 2010 14:54:47 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 17 Sep 2010 14:54:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Sep 2010 10:55:22 -0400
Content-Disposition: inline
In-Reply-To: <4D8D88A4-FEBF-4FA9-A39F-410D76289E4B@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156386>

On Fri, Sep 17, 2010 at 03:56:53PM +0400, Kirill Likhodedov wrote:

> I think that if it is a feature, it should be reflected in the
> documentation for custom pretty formats.

I agree it should be documented. I'm not sure where, though. The
subject-munging affects more than just pretty formats. For example, at
least git format-patch also has --keep-subjects to turn off munging. I
guess a note should be made in a all relevant places.

> Anyway, that doesn't seem consistent enough: Git knows that the
> subject is "first line\nsecond line\nthird line" (because it shows it
> correctly in full or raw formats). Why does it join the lines in the
> custom format's %s?

Because then the consumer of "git log --format=%s" knows that they will
get exactly one line per commit.

The convention in git is to do "subject\n\nbody", with subject on a
single line. However, we often see commits imported from other version
control systems without this format. The subject-munging is an attempt
to make them useful in git-aware tools (e.g., gitk or gitweb, which show
the subject). Showing just the first line of a multi-line subject is
often useless. People complained, and we got the behavior we have today.

-Peff
