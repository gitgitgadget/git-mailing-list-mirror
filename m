From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 13:18:41 -0700
Message-ID: <7vmybqjxzy.fsf@gitster.siamese.dyndns.org>
References: <49B74373.3090609@gmail.com>
 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
 <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
 <7veix33f5e.fsf@gitster.siamese.dyndns.org>
 <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 12 21:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhrOB-0006iS-5i
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 21:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbZCLUSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 16:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbZCLUSw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 16:18:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZCLUSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 16:18:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C02BDA1CA0;
	Thu, 12 Mar 2009 16:18:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B8697A1C9F; Thu,
 12 Mar 2009 16:18:43 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
 (david@lang.hm's message of "Thu, 12 Mar 2009 12:29:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF81E8A0-0F42-11DE-8577-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113120>

david@lang.hm writes:

> defining terminology that was mentioned before
>
> merge drivers are run by git to do the merges and create the conflict
> markers. git already has a 'plug-in architecture' for these drivers
> (you can define file types and tell git to use a particular merge
> driver for this file type)
>
> merge helpers are run by the users if there is a conflict and make use
> of the markers. depending on what you end up using for conflict
> markers, you may not need to write a merge helper (for OO, if your
> conflict markers are good enough you can use OO to resolve conflicts
> easily, no need for a new tool)

Not really.  A merge helper can look at the stages in the index to get the
(original, ours, theirs) tuple and start to work from there (and doing a
helper as a backend of mergetool will be one way to make it easier), and
for such helper the driver does not have to do anything.

> with this terminology, you can't do merge helpers without doing the
> merge drivers first (what does the helper look for as an indicator of
> a conflict?)

The answer to that question is "the index", and your "you can't" is
too strong.

I agree with you that the original "editor" for the specific type of
document (e.g. OOo, inkskape, ...) can be used to fix things up if a
driver can leave conflict markers in such a way that the helper does not
have to do three-file merge, and that would be a nice thing to have.  But
for a helper that can do a real three-file merge (and in this thread I
think somebody said OOo can do that), then it is Ok for a driver to punt.

But even then, *if* there is a driver *and* it can do trivial merges
cleanly and safely, it would be a huge productivity win, as you do not
have to run a helper every time you see two branching touching the same
document even they did so to edit totally unrelated parts of it.
