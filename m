From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Fri, 14 Oct 2011 09:06:11 +0200
Message-ID: <4E97DF63.104@viscovery.net>
References: <20111014012320.GA4395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-dev@github.com,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 09:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REbrF-00076K-Kg
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab1JNHGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:06:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35120 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1JNHGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 03:06:14 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1REbqO-0007Ov-Fe; Fri, 14 Oct 2011 09:06:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2DA3D1660F;
	Fri, 14 Oct 2011 09:06:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111014012320.GA4395@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183543>

Am 10/14/2011 3:23, schrieb Jeff King:
> In practice, however, adding this check still has value, for
> three reasons.
> 
>   1. If you have a reasonable number of packs and/or a
>      reasonable file descriptor limit, you can keep all of
>      your packs open simultaneously. If this is the case,
>      then the race is impossible to trigger.

On Windows, we cannot remove files that are open. If I understand
correctly, this patch keeps more files open for a longer time. Is there
any chance that packfiles remain now open until an unlink() call?

I am not worried about parallel processes (we already have a problem
there), but that this can now happen within a single process, i.e., that a
single git-repack -a -d -f would now try to unlink a pack file that it
opened itself and did not close timely.

I'll test your patch later this weekend to see whether the test suite
finds something. But perhaps you know the answer already?

-- Hannes
