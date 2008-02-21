From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix amending of a commit with an empty message
Date: Thu, 21 Feb 2008 14:01:44 -0800
Message-ID: <7v8x1et1dj.fsf@gitster.siamese.dyndns.org>
References: <20080221195438.GA6973@steel.home>
 <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org>
 <20080221203506.GA20143@steel.home> <20080221203802.GB20143@steel.home>
 <7vmyput4dn.fsf@gitster.siamese.dyndns.org>
 <20080221213204.GC20143@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:02:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJVK-0007y6-4P
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934429AbYBUWB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbYBUWBz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:01:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbYBUWBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 17:01:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EF042D1F;
	Thu, 21 Feb 2008 17:01:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3AEC72D1C; Thu, 21 Feb 2008 17:01:49 -0500 (EST)
In-Reply-To: <20080221213204.GC20143@steel.home> (Alex Riesen's message of
 "Thu, 21 Feb 2008 22:32:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74668>

Alex Riesen <raa.lkml@gmail.com> writes:

>> Having said that, here is a quiz.  When the user says "git
>> commit --amend", what are the valid reasons not to allow it,
>> other than:
>> 
>>  - the index is unmerged.
>>  - the branch is yet to be born.
>
> There are no tree changes in the commit to be amended.
> And if there is a strong wish to do just the amendment,
> there is always --allow-empty.

If the original commit had some changes, but the final tree,
after hacking, experimenting and fixing, ended up in the same
shape as the parent's, the user might rather want to "reset
HEAD^" away the commit than amending now-empty commit.  Erroring
out when --allow-empty is not given (like we currently do) would
be sensible in such a case.

However, if the original commit was made with --allow-empty, it
might have been done for a reason, and I was not sure if forcing
the user to say --allow-empty while amending (like we currently
do) was such a good idea.  The user previously may have created
that empty (in content changes) commit to piss in the snow, or
perhaps the empty commit is due to foreign SCM import, and the
user may be trying to improve the log message that is attached
to it.  The user might even be an automated script in the case
of foreign SCM import, but admittedly, it could choose to always
say --allow-empty.

That was the motivation behind that quiz.
