From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 16:21:09 +0200
Message-ID: <4A55FCD5.2020908@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <200907091134.45492.johan@herland.net> <4A55E100.9010700@viscovery.net> <200907091552.44545.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 16:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOuV3-0002R2-UZ
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 16:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760857AbZGIOVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760844AbZGIOVP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 10:21:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57570 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760511AbZGIOVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 10:21:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOuUn-0005Ps-Iw; Thu, 09 Jul 2009 16:21:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 38D7B6B7; Thu,  9 Jul 2009 16:21:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907091552.44545.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122977>

Johan Herland schrieb:
> On Thursday 09 July 2009, Johannes Sixt wrote:
>> Shouldn't you reset signal(SIGPIPE) to its previous value?
> 
> Done (provided that the sigchain_push/pop infrastructure works the way
> I expect).

I'm not sure, either. Peff?

> +test_expect_success 'quickfetch should handle ~1000 refs (on Windows)' '
> +
> +	git gc &&
> +	head=$(git rev-parse HEAD) &&
> +	branchprefix="$head refs/heads/branch" &&
> +	for i in 0 1 2 3 4 5 6 7 8 9; do
> +		for j in 0 1 2 3 4 5 6 7 8 9; do
> +			for k in 0 1 2 3 4 5 6 7 8 9; do
> +				echo "$branchprefix$i$j$k" >> .git/packed-refs
> +			done
> +		done
> +	done &&
> +	(
> +		cd cloned &&
> +		git fetch &&
> +		git fetch
> +	)
> +
> +'

This test fails on Windows without the code change and passes with the
code change. So, it's a good test.

But actually I meant you to make a test that triggers the SIGPIPE that
would kill git-fetch if it were not ignored. This one doesn't trigger it,
either.

-- Hannes
