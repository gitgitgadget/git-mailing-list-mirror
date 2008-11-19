From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 14:55:59 +0100
Message-ID: <49241AEF.1080808@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>	 <4923FE58.3090503@viscovery.net>	 <alpine.LFD.2.00.0811190753420.27509@xanadu.home> <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2nYd-0007k2-2T
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYKSN4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYKSN4M
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:56:12 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54053 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbYKSN4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:56:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2nXE-0003lW-4Z; Wed, 19 Nov 2008 14:56:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C964F69F; Wed, 19 Nov 2008 14:55:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101345>

Alex Riesen schrieb:
> 2008/11/19 Nicolas Pitre <nico@cam.org>:
>> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>>> The work-around is to write the repacked objects to a file of a different
>>> name, and replace the original after git-pack-objects has terminated.
>>>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> Acked-by: Nicolas Pitre <nico@cam.org>
> 
> Are you sure? Will it work in a real repository? Were noone does
> rename the previous pack files into packtmp-something?

Oh, the patch only works around the failure in the test case. In a real
repository there is usually no problem because the destination pack file
does not exist.

The unusual case is where you do this:

 $ git rev-list -10 HEAD | git pack-objects foobar

twice in a row: In this case the second invocation fails on Windows
because the destination pack file already exists *and* is open. But not
even git-repack does this even if it is called twice. OTOH, the test case
*does* exactly this.

-- Hannes
