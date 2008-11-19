From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 15:52:17 +0100
Message-ID: <49242821.50604@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com> <4923FE58.3090503@viscovery.net> <alpine.LFD.2.00.0811190753420.27509@xanadu.home> <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com> <49241AEF.1080808@viscovery.net> <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 15:54:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2oQz-0005un-3E
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 15:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYKSOwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 09:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbYKSOwW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 09:52:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18979 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYKSOwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 09:52:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2oPh-0005uk-EP; Wed, 19 Nov 2008 15:52:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 289C969F; Wed, 19 Nov 2008 15:52:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101351>

Nicolas Pitre schrieb:
> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>> The unusual case is where you do this:
>>
>>  $ git rev-list -10 HEAD | git pack-objects foobar
>>
>> twice in a row: In this case the second invocation fails on Windows
>> because the destination pack file already exists *and* is open. But not
>> even git-repack does this even if it is called twice. OTOH, the test case
>> *does* exactly this.
> 
> OK.... Well, despite my earlier assertion, I think the above should be a 
> valid operation.
> 
> I'm looking at it now.  I'm therefore revoking my earlier ACK as well 
> (better keep that test case alive).

Hold on a moment: When I tested the above sequence, I was fooled by a flaw
in mingw_rename() (it doesn't replace read-only files). With that fixed,
it works as expected in repeated invocations (note that foobar is outside
the .git/objects/pack directory).

If I use .git/objects/pack/foobar instead, then I get the failures on
Windows, and I won't argue that this should be "fixed". ;)

-- Hannes
