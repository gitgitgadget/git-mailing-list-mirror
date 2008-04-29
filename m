From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 09:12:50 +0200
Message-ID: <4816CA72.8070405@viscovery.net>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de> <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?J=F6?= =?ISO-8859-1?Q?rg_Sommer?= 
	<joerg@alea.gnuu.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:13:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqk26-0007Uh-CC
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbYD2HM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYD2HM4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:12:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59859 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbYD2HM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:12:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jqk1D-0001cI-Eq; Tue, 29 Apr 2008 09:12:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1BD676D9; Tue, 29 Apr 2008 09:12:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80661>

Junio C Hamano schrieb:
> This is just a minor syntax issue and I am not sure why we got into this
> misunderstanding, but let's try again.  Suppose you want to recreate this
> history on top of a different O'.  For merges, upper parents are earlier
> ones:
> 
>      A         reset O'
>     / \        pick  B
>    /   X       reset O'
>   /   / \      pick A
>  O---B   Z     merge B -- recreate X
>   \   \ /      reset O'
>    \   Y       pick C
>     \ /        merge B? -- recreate Y
>      C         reset B -- go back to recreated X
>                merge B? -- recreate Z
> 
> The above sequence does not work.

Because it is hand-crafted. I'd expect rebase to suggest a series that
works as long as the user doesn't modify it. Like this:

	reset O'
	pick C
	reset O'
	pick B
	merge C -- recreate Y
	reset O'
	pick A
	merge B -- recreate X
	merge Y -- recreate Z

Here all commit names are clearly the original in the first insn that
references it, and the rewritten version in later references. No marks needed.

If the user modifies the insns, he better knows what he's doing, in
particular, when it's necessary to rebuild such complex histories.

-- Hannes
