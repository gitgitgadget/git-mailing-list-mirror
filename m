From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 18:23:25 -0700
Message-ID: <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
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
 <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness>
 <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness>
 <7v63u05khw.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 03:24:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr13b-00046H-UQ
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 03:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbYD3BXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 21:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbYD3BXk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 21:23:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbYD3BXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 21:23:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FA8321FB;
	Tue, 29 Apr 2008 21:23:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E9A5F21F4; Tue, 29 Apr 2008 21:23:32 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 30 Apr 2008 00:31:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F495482-1654-11DD-B098-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80778>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 29 Apr 2008, Junio C Hamano wrote:
>> Perhaps it would help to go back to the message J6t incompletely quoted, 
>> and try the example with the parent order of Y swapped (i.e. B == Y^2, C 
>> == Y^1)
>> 
>> Recreating X and Y both need to refer to the rewritten B as the 
>> parameter to "merge" insn.  You create X first then you cannot refer to 
>> B anymore to recreate Y.  The other way around you cannot name B to 
>> recreate X.
>
> If you refer to "B" as the "short name of the original commit which refers 
> to the rewritten commit as soon as B was rewritten", then I really do not 
> see the problem.

Hmmm.  Perhaps you are thinking about using not just A, B, C but also
names like X, Y, and Z in the insn sequence?  I was operating under the
impression that you used only single parent commits to name things, and a
name will stand for the result of the last operation that used the name
(e.g. after "pick B", B names the result of cherry-picking the original B
to detached HEAD).


                 A
                / \
               /   X
              /   / \
             O---B   Z
              \   \ /
               \   Y
                \ /
                 C

            X = checkout A, merge B
            Y = checkout C, merge B
            Z = checkout X, merge Y

I start from Q, create A', B' and C' with:

	reset Q
	pick A
        reset Q
        pick B
        reset Q
        pick C

Then I can recreate X by doing

	reset A
        merge B

The problem I had was to figure out the way to go back to "rewritten X".
I assumed you would say "B" because that is the last insn in the sequence
that used that name.

But instead you are thinking of letting me just say "X", and somehow make
the machinery guess by noticing "Ah, original X is a merge between
original A and B, and we have a merge between rewritten A and rewritten B,
so we will treat that merge as rewritten "X"?

I actually was hoping we could avoid that, which feels messy.

But now I may be misunderstanding what you meant to say.
