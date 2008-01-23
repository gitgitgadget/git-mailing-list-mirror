From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch should run git gc --auto
Date: Tue, 22 Jan 2008 18:46:52 -0800
Message-ID: <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
	<20080119223249.8227.31460.stgit@yoghurt>
	<1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma>
	<20080120093436.GA10924@diana.vm.bytemark.co.uk>
	<7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
	<20080121224818.GA8872@untitled>
	<7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
	<20080122003911.GA16453@hand.yhbt.net>
	<7vtzl6vd7v.fsf@gitster.siamese.dyndns.org>
	<BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVeO-0002rK-0U
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYAWCrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYAWCrJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:47:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYAWCrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 21:47:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FC25725C;
	Tue, 22 Jan 2008 21:47:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C668A7259;
	Tue, 22 Jan 2008 21:47:01 -0500 (EST)
In-Reply-To: <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> (Kevin Ballard's
	message of "Tue, 22 Jan 2008 21:43:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71496>

Kevin Ballard <kevin@sb.org> writes:

> I just glanced at git-filter-branch.sh (and I must say I was
> incredibly surprised to find out it was a shell script) and it seems
> it never runs git-gc or git-repack. Doesn't that end up with the same
> problems as git-svn sans git-repack when filtering a large number of
> commits? I was just thinking, if I were to git-filter-branch on my
> massive repo (in fact, the same repo that started this thread, with
> over 33000 commits in the upstream svn repo), even if I just do
> something as simple as change the commit msg wont I end up with
> thousands of unreachable objects? I shudder to think how many
> unreachable objects I would have if I pruned the entire dports
> directory off of the tree.
>
> Am I missing something, or does git-filter-branch really not do any
> garbage collection? I tried reading the source, but complex bash
> scripts are almost as bad as perl in terms of readability.

Theoretically yes, and it largely depends on what you do, but
filter-branch goes over the objects that already exists in your
repository, and hopefully you won't be rewriting majority of
them.

So the impact of not repacking is probably much less painful in
practice.

But again as I said, it largely depends on what you do in your
filter.  If you are upcasing (or convert to NFD ;-)) the
contents of all of your blob objects, you would certainly want
to repack every once in a while.
