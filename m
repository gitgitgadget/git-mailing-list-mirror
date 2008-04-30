From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 02:19:27 -0700
Message-ID: <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
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
 <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness>
 <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness>
 <7v63u05khw.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness>
 <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:20:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr8UQ-0004C2-5j
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 11:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbYD3JTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 05:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757013AbYD3JTp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 05:19:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYD3JTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 05:19:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A7643834;
	Wed, 30 Apr 2008 05:19:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E49353832; Wed, 30 Apr 2008 05:19:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 30 Apr 2008 09:47:02 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 90D2B394-1696-11DD-9AB6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80816>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But instead you are thinking of letting me just say "X", and somehow 
>> make the machinery guess by noticing "Ah, original X is a merge between 
>> original A and B, and we have a merge between rewritten A and rewritten 
>> B, so we will treat that merge as rewritten "X"?
>> 
>> I actually was hoping we could avoid that, which feels messy.
> ...
> But this got me thinking, and I think that to leave out the first parent 
> was another mistake I made, so I really would like to have this syntax:
>
> 	merge <orig-commit> <parent1> <parent2>... <message>
>
> This would allow to change the parents in the interactive rebase, and if 
> <parent1> is not the current commit at that point, it would implicitly 
> call "reset".
>
> What appeals to me is the simplicity of this approach: you refer to the 
> commits by calling them by their (original) name.

Ok, that clears my confusion, but it raises another issue.

In the context of "rebase -i", this may not be a problem, but by forcing
us to name commits always with original commits, we cannot build (instead
of rebuild) a history that does not yet exist using the sequencer
machinery, can we?

If we want to transplant "^C ^N O" in this history elsewhere:

      --o---C---N
               / 
          B---M
         /   /
        O---A

while inserting a new fix-up commit F on top of B before we merge that
side branch to rewritten A:

              --o---C---N'
                       / 
              B'--X---M'
             /       /
        O---Q-------A'

Would/Should the machinery somehow figure out that the merge between the
rewritten A (which is A') and an inserted commit X (which is made on top
of the rewritten B) corresponds to M in the original history?

This is not a made up example, but something I have to do once (on my
non-git days) or many more times (on my git days) every day when
rebuilding 'pu' on top of updated 'next' using updated tips of topic
branches.  I was hoping that the sequencer mechanism can help me
automating the process a bit more.
