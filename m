From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Wed, 10 Dec 2008 15:36:11 -0800
Message-ID: <7voczjy55g.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <7vzlj3ycr4.fsf@gitster.siamese.dyndns.org>
 <20081210211147.GA13624@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYce-0003HT-4d
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYLJXgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbYLJXgW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:36:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYLJXgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:36:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D4DD18954;
	Wed, 10 Dec 2008 18:36:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B431D18922; Wed,
 10 Dec 2008 18:36:13 -0500 (EST)
In-Reply-To: <20081210211147.GA13624@localhost> (Clemens Buchacher's message
 of "Wed, 10 Dec 2008 22:11:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58A21522-C713-11DD-9E3E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102740>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Dec 10, 2008 at 12:51:59PM -0800, Junio C Hamano wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>> 
>> > If it's a regression, it dates far back, since 1.5.0 fails as well.
>> 
>> A good lit(h)mus test to see if it is a regression or just a plain bug in
>> the recursive strategy would be to see what 'resolve' strategy does
>> (replace "merge" with "merge -s resolve" in your test).
>
> "merge -s resolve" fails with
>
> Trying really trivial in-index merge...
> error: Merge requires file-level merging
> Nope.
> Trying simple merge.
> Simple merge failed, trying Automatic merge.
> ERROR: c1.c: Not handling case ae9304576a6ec3419b231b2b9c8e33a06f97f9fb ->
> -> 8173b675dc61bb578b411c769c9fb654625a7c4e
> fatal: merge program failed
> Automatic merge failed; fix conflicts and then commit the result.
>
> and therefore passes the test.

Are you saying that:

 (1) the step should result in conflict and the merge should fail, but it
     should not clobber c1.c nevertheless; and

 (2) resolve fails to merge (as expected), and it does not clobber c1.c
     (as expected); therefore it passes the test.

If so, then you now established that it is a bug in merge-recursive,
right [implementors of recursive-in-C CC'ed]?

Or are you saying that the step should not fail to begin with?
