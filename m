From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 22:40:01 +0100
Message-ID: <4D794531.40205@miseler.de>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxnaq-0007X3-13
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 22:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab1CJVkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 16:40:09 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:61884 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab1CJVkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 16:40:07 -0500
Received: from [192.168.22.13] (f055053254.adsl.alicedsl.de [78.55.53.254])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LtUF2-1Q7nVw1Z9o-010vdU; Thu, 10 Mar 2011 22:39:57 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110309215841.GC4400@sigill.intra.peff.net>
X-Provags-ID: V02:K0:bAehstKIivM+w8V7WQ7jSDYhrCgqpTcpV+yxM8jJ3+b
 Por+OU2HMH1Zgcg6huH9g3oernKCOYuXxF2iqLZ4tMFl8NWGMs
 s44eXuyU8xeFqDfPaCimsFg6KGkmfNDmppcYm/oQwyA4inZhFj
 PssbUpBKb7MclheCM5Rh3giQNnVDHBhTRGQKDf6n9v0QDA6QEy
 Pgqw8/7jerhep569gtgjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168852>

Comments on the "Better big-file support" section:


"While git can handle arbitrary-sized binary content [...]"

This is very much not true. Git tries at many places to load the complete file into memory and usually fails with "out of memory" if it can't. With the 32bit msysGit client this places the upper file size limit, from purely empirical observation, at 600-700 MByte. When a file is to large git fails late, adding and committing works (as long as there are no filters or other complications), but you can forget about pushing, rebasing or otherwise manipulating that commit. Even worse yet, commits consisting of smaller files but with a combined size over the limit will also cause out-of-memories.

Thus a main focus should be the memory problem, e.g. by using stream-like file handling everywhere, since not working at all is orders of magnitude worse than working slowly :)



"In some cases, this may be as simple as having a "large file" codepath that avoids pulling whole files into memory (e.g., during "git add")."

Ironically git add is one of the few things that work with large files, as mentioned above. Presumably the stream-oriented zlib enforced/encouraged a steam-like handling here :)
Slow as hell though and of course it is usually not sensible to compress a 1.5 GByte file.




I'm very willing to work on this topic. Though I'm not a student and as a git code newbie I also don't have the skills for mentoring yet.
