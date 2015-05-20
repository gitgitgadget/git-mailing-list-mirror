From: John Keeping <john@keeping.me.uk>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Wed, 20 May 2015 14:25:34 +0100
Message-ID: <20150520132534.GI10518@serenity.lan>
References: <20150519132958.GA21130@frolo.macqel>
 <20150519233925.GA22748@peff.net>
 <20150520131359.GA7043@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Wed May 20 15:25:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv40Q-0005iA-GY
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 15:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbbETNZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 09:25:50 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:51358 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbbETNZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 09:25:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7D99ECDA5E6;
	Wed, 20 May 2015 14:25:45 +0100 (BST)
X-Quarantine-ID: <XBSKnXhgVhrH>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XBSKnXhgVhrH; Wed, 20 May 2015 14:25:44 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9ACF2CDA610;
	Wed, 20 May 2015 14:25:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150520131359.GA7043@frolo.macqel>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269466>

On Wed, May 20, 2015 at 03:13:59PM +0200, Philippe De Muyter wrote:
> My initial problem (still unresolved/unanswered) is that some commits
> that appeared between v3.14-rc1 and v3.14-rc2 (specifically
> 817c27a128e18aed840adc295f988e1656fed7d1) are present in v3.15, but not
> in my branch.
> 
> I have just checked online the v3.14 version on 
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/arch/arm/boot/dts/imx6qdl.dtsi 
> 
> and I see also the same "problem": the commit removing 738 lines is in the log
> 817c27a128e18aed840adc295f988e1656fed7d1
> "ARM: dts: imx6qdl: make pinctrl nodes board specific",
> but the v3.14 version of the file still contains the 738 removed line,
> and I see no commit restoring those lines.
> 
> I do not understand why those 738 lines are still present in v3.14 although
> they were removed between v3.14-rc1 and v3.14-rc2 :(

Commit 817c27a128e18aed840adc295f988e1656fed7d1 isn't in v3.14:

$ git describe --contains 817c27a128e18aed840adc295f988e1656fed7d1
v3.15-rc1~77^2~40^2~57

$ git tag --contains 817c27a128e18aed840adc295f988e1656fed7d1
v3.15
v3.15-rc1
v3.15-rc2
v3.15-rc3
v3.15-rc4
v3.15-rc5
v3.15-rc6
v3.15-rc7
v3.15-rc8
v3.15.1
v3.15.10
v3.15.2
[snip later tags]

However, the commit date of 817c27a128e18aed840adc295f988e1656fed7d1 is
between the dates of v3.14-rc1 and v3.14-rc2 so the default commit
ordering of `git log` will show it between those two tags.
`--topo-order` may help but I suspect the history is too complex to
infer the relationship between commits without `--graph`.
