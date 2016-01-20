From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Wed, 20 Jan 2016 08:55:20 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601200846010.2964@virtualbox>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com> <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: larsxschneider@gmail.com, git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 08:55:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLncG-000528-HB
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 08:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbcATHzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 02:55:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:58834 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbcATHzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 02:55:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MJXEd-1aIlbV2hpL-00338a; Wed, 20 Jan 2016 08:55:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:h1YB6kB5pT1jMlXBdOdShBZUl4NmBkPupQKG6OxaASZ8YyN0nV+
 EuvGjSRNmeq0AyJAomb4YI0fZ291keIBtYS5KvDoOOaY++iRlVMxygso8VO6MJS3D5n/OEQ
 yCnN1WG+ST2bw6Er6rHY/N70tVhNsPl5lxlh6uhc5+FOuek9wsKS5oixMO+9nr1L4gXmhjk
 S9OtVMSllWkt65sXS76Cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7MUcQq9uFU8=:T4WqfQ6+rW308i3OTdO/Kv
 H69Fn3+XcRQZX+P/ekAAI+ME0/dCR3tSoeDvaWwYKvBp27GENmoPZAdu2gQ70WcSoxJBboD0C
 ubuPMYLE8fwMGaS0qWbaUDppvBymYiQrwPueffvv12ZJBRNAb8biR/C/WINoLukxbKlMsOLLD
 e/TB5lqQC8JSZRjLqdJMXf6c6MLLTjrL4mLxvAPJ6ZO3kXYLFghu38K6pYH5mScOJZjtP07oz
 ONtdeCxmhqV9Y5P10Gb2oTd5EoF10TNgRtrR6BXoktuFMZAohcWpiC1nPJTkhHjA6DnKLCRD6
 wOI1HMb98NC7rfOX6iC+94NLrq5nvZ/3CcX90ESpO+SC+SzoHVgqsszNbTu6fTV/RIzHZ4yfG
 6gM9RYWCqQ9HCCNYH9KIAAgVdPfEcTRd6I3Hw7hBYGnJqq625rEgPznJRKNEUNbJuBKTMuSaK
 oUPGoIhHi73HK7X/nLNmd0WI/y3Iq7VUuOAbOi45bgyOOR1qZIDk8acm+PQpv9D0XT80eYTCx
 9w8FEa5eUnsw8cz0tkOa6PlmMZRaIYNtDMVWSlqPYxRBZAGZpgxA2k6Y3EvmJynT/ocUSZ/0O
 at1r727MdUFDLJpohxK0yPcahJkg/fE0lYxjZQ7oDPJJg6BgFvabSiGY7RoY1aoLdST+2GNNy
 qoVsIE0Hc6P+DdxImnhYgI7aq3n4ghyrGR3qhofWSjkarU5xU8M90vUi9NbbIaojFFDLVr2gA
 Tw7izuP0s4Lr4Q0Gyid2RXtyT3G49tVhj9yUWSfNzog43aJ/xpxB9AK/e5K4jI92VkRqshTX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284430>

Hi Junio,

On Tue, 19 Jan 2016, Junio C Hamano wrote:

> larsxschneider@gmail.com writes:
> 
> > From: Lars Schneider <larsxschneider@gmail.com>
> >
> > Use the Travis-CI cache feature to store prove test results and make
> > them available in subsequent builds. This allows to run previously
> > failed tests first and run remaining tests in slowest to fastest
> > order. As a result it is less likely that Travis-CI needs to wait for
> > a single test at the end which speeds up the test suite execution by
> > ~2 min.
> >
> > Unfortunately the cache feature is only available (for free) on the
> > Travis-CI Linux environment.
> >
> > Suggested-by: Jeff King <peff@peff.net>
> > Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> > ---
> >  .travis.yml | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> This is cute, but isn't it useful even outside Travis's context?  I am
> not suggesting to touch anything other than .travis.yml file in this
> patch, but if I wanted to get the benefit from the idea in this patch
> when I run my tests manually, I can just tell prove to use the cached
> states, no?

You are basically talking about prove's support to modify behavior based
on previous runs. This patch does not introduce that support, it was
introduced long ago: 5099b99 (test-lib: Adjust output to be valid TAP
format, 2010-06-24). This commit also advertises that feature in t/README.

> IOW, I am confused by the beginning of the log message that says
> this is taking advantage of "the Travis-CI cache feature".

Lars' patch is really about Travis and its useful feature to retain state
from previous runs. AFAICT this is the feature Lars is talking about, and
it is absolutely necessary to make use of this prove feature (don't try
this with BuildHive, for example, its workspaces are typically
garbage-collected before the next CI run).

As such, I think it makes sense to talk about the Travis-CI feature in the
commit message (and not about the prove feature because we introduced
support for prove much, much earlier in Git's history, and advertised its
benefits at that time, as I stated above).

Ciao,
Dscho
