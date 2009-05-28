From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 20:11:45 -0700
Message-ID: <4A1E00F1.4030709@zytor.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 28 05:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9W2M-0004oZ-TV
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 05:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbZE1DMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 23:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbZE1DMB
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 23:12:01 -0400
Received: from terminus.zytor.com ([198.137.202.10]:37524 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZE1DMA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 23:12:00 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n4S3BnOe001211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2009 20:11:50 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id n4S3BmuC007267;
	Wed, 27 May 2009 20:11:49 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n4S3BjFv026885;
	Wed, 27 May 2009 20:11:46 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9397/Wed May 27 07:48:50 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120139>

Ealdwulf Wuffinga wrote:
> 
> For git-bisect, Sam and H Peter are proposing a heuristic to trade off
> between information gained and likelihood of testing a bad commit. For
> bbchop, I am already doing calculating the information gain directly,
> so if I can incorporate the probability that a commit is broken - has
> to be skipped - then the trade-off will happen automatically.
> Therefore it would be useful to have some plausible theory as to how
> the probability of a broken commit should be calculated, given some
> known-broken and known-not-broken commits.
> 

Again, given a bisection, the information gain by "bisecting" at point x
 where 0 < x < 1 is:

	-(x log2 x)-((1-x) log2 (1-x))

At x = 0.5 this gives the optimal 1 bit, but the curve is rather flat
near the top.  You don't drop to 1/2 bit of information until
x = 0.11 or 0.89, and it doesn't drop to 1/4 bit of information until
x = 0.04 or 0.96.

Thus, the lack of optimality in searching away from a skip point is much
smaller than the potential cost of having to having to skip multiple
nearby points.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
