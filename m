From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 20:57:18 -0800
Message-ID: <7vmysz9dch.fsf@gitster.siamese.dyndns.org>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	<7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	<9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	<BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Sean" <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwI-0004Ta-CT
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:46 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxF70-0006Q6-17
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 06:05:26 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxF5t-0006E9-IT
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 06:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXK1E5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 23:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXK1E5f
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:57:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55718 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbXK1E5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 23:57:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6BEDF2EF;
	Tue, 27 Nov 2007 23:57:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E2DF79A941;
	Tue, 27 Nov 2007 23:57:51 -0500 (EST)
In-Reply-To: <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 27 Nov 2007 22:55:05 -0500
	(EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required=5.0, autolearn=disabled, AWL=2.106,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 6891695A5E5E226C9086C1B690BFA9FD9F544EE3
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -48 maxlevel 200 minaction 2 bait 0 mail/h: 13 total 723843 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66308>

"Sean" <seanlkml@sympatico.ca> writes:

>> After doing the commands I located my last commit before the rebase
>> and edited master back to  it. But my system was still messed up since
>> moving master got me out of sync with the state stg stored in .git/*.
>> The 'stg repair' command had changed the stored state.
>
>  From your description is seems that Git proper was able to handle the
> situation just fine.   It sounds instead like you're describing a problem
> with Stg where it became confused without a way to restore _its_ meta
> data.  There's not much Git itself can do to help in this situation
> unless Stg stores all of its meta-data as standard Git objects, rather
> than just using the .git directory.

Essentially, he does not want to use "git rebase" and have a way to
disable the command on a branch that stg is actively munging.  And that
is something git proper can help with the user, which is why I earlier
referred him to pre-rebase hook.

As you suggested, however, git proper should not know the internals of
Porcelains, so I'd rather not to have that logic deep in git-rebase
itself.  But the pre-rebase hook shoud be the appropriate place for the
user to actually populate with stg specific logic ("is stg set to
actively munge this branch") and activate it for his repository.
