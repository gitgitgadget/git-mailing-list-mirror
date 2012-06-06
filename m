From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Handling racy entries in the v5 format [Re: [GSoC] Designing
 a faster index format - Progress report week 7]
Date: Wed, 06 Jun 2012 15:01:02 +0200
Message-ID: <4FCF548E.8060708@viscovery.net>
References: <20120604200746.GK6449@tgummerer> <87aa0gbwon.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, mhagger@alum.mit.edu, pclouds@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:01:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScFrP-0000SV-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab2FFNBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:01:10 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18403 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab2FFNBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:01:09 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ScFsF-0007VC-9r; Wed, 06 Jun 2012 15:02:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7CB7B1660F;
	Wed,  6 Jun 2012 15:01:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <87aa0gbwon.fsf@thomas.inf.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199321>

Am 6/6/2012 11:45, schrieb Thomas Rast:
> Proposed Solution
> -----------------
> 
>   When writing an entry: check whether ce_mtime >= index.mtime.  If so,
>   write out ce_mtime=0.
> 
> The index.mtime here is a lower bound on the mtime of the new index,
> obtained e.g. by touching the index and then stat()ing it immediately
> before writing out the changed entries.

Portability note: To "touch" on Windows will mean that the file is
modified (at least one byte is written), then closed. Only then the stat
information is reliable. The reason is that the time stamp is only valid
after (the last handle of) the file was closed.

> Note that this is a fundamentally different approach from the one taken
> in v[2-4] indexes.  In the old approach, it is the *next* writer's
> responsibility to ensure that all racy entries are either truly clean,
> or smudged (since they will presumably lose their raciness).  In the new
> approach, racy entries are immediately smudged and remain so until an
> update.

-- Hannes
