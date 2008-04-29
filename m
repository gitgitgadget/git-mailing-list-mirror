From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 14:16:48 -0700
Message-ID: <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
 <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
 <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
 <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net>
 <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:18:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxCz-00031M-Hf
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbYD2VRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYD2VRD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:17:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYD2VRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:17:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D58B324C;
	Tue, 29 Apr 2008 17:16:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2664C3244; Tue, 29 Apr 2008 17:16:53 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> (Johannes
 Schindelin's message of "Tue, 29 Apr 2008 11:52:32 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 99D54854-1631-11DD-B74D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80736>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 29 Apr 2008, Johannes Sixt wrote:
>
>> Junio C Hamano schrieb:
>> > This is just a minor syntax issue and I am not sure why we got into 
>> > this misunderstanding, but let's try again.  Suppose you want to 
>> > recreate this history on top of a different O'.  For merges, upper 
>> > parents are earlier ones:
>> > 
>> >      A         reset O'
>> >     / \        pick  B
>> >    /   X       reset O'
>> >   /   / \      pick A
>> >  O---B   Z     merge B -- recreate X
>> >   \   \ /      reset O'
>> >    \   Y       pick C
>> >     \ /        merge B? -- recreate Y
>> >      C         reset B -- go back to recreated X
>> >                merge B? -- recreate Z
>> > 
>> > The above sequence does not work.
>> 
>> Because it is hand-crafted. I'd expect rebase to suggest a series that 
>> works as long as the user doesn't modify it. Like this:
>> 
>> 	reset O'
>> 	pick C
>> 	reset O'
>> 	pick B
>> 	merge C -- recreate Y
>> 	reset O'
>> 	pick A
>> 	merge B -- recreate X
>> 	merge Y -- recreate Z
>> 
>> Here all commit names are clearly the original in the first insn that 
>> references it, and the rewritten version in later references. No marks 
>> needed.
>> 
>> If the user modifies the insns, he better knows what he's doing, in 
>> particular, when it's necessary to rebuild such complex histories.
>
> I fully agree.  rebase -i is _not_ about the same goal as git-sequencer.  
> rebase -i is about user interaction.  sequencer is about having a common 
> plumbing for the different porcelains.

The problem is that both of you stopped reading after the part you quoted.
