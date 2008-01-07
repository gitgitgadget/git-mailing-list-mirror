From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to use git merge -s subtree?
Date: Mon, 07 Jan 2008 13:04:34 -0800
Message-ID: <7vlk71z6sd.fsf@gitster.siamese.dyndns.org>
References: <20080105230004.GY29972@genesis.frugalware.org>
	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
	<flpah7$beg$2@ger.gmane.org>
	<BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
	<47803CB6.4050102@gmx.net> <7vir277jz6.fsf@gitster.siamese.dyndns.org>
	<BAYC1-PASMTP1079A31936B4563801537DAE4E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBz9n-0008Bq-P7
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbYAGVEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYAGVEs
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:04:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYAGVEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:04:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FF6AE34;
	Mon,  7 Jan 2008 16:04:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 27DFEAE33;
	Mon,  7 Jan 2008 16:04:40 -0500 (EST)
In-Reply-To: <BAYC1-PASMTP1079A31936B4563801537DAE4E0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sun, 6 Jan 2008 03:06:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69808>

Sean <seanlkml@sympatico.ca> writes:

> ...  Asking for the history of a file does make
> sense.  Through path limiting you can ask to see just the subset of history that
> touched a certain file or directory etc..

That's asking for the history of a _path_ (or subset defined by
paths, as in "what changes were made to paths under 'arch/'"),
which is very different from asking "I have B/foo.c -- show me
the history of that _file_".

Remember, David stated:

>> ... So you cannot do git-log B/foo.c as git doesnot know where
>> to search it as it thinks it is in /foo.c not in B/foo.c ...

Notice "as git does not know where to search it" part?

Think --- what does that "it" refer to in that sentence?

The statement is not about paths.  If it were about paths, then
the output of "git log B/foo.c" does show what he wants.  The
question "git log B/foo.c" asks is "what change were made to the
path at B/foo.c".  The changes made to B/foo.c (i.e. what's
shown with the diff headers that begin with "--- a/B/foo.c") are
shown.  The changes made to foo.c are not shown.

But that is different from what David is asking.  He wants to
know what changes were made to B/foo.c or to foo.c, and wants to
make the choice between the two depend on commit.  The reason
you think you can pick between foo.c and B/foo.c is because
there is an illusion that somehow there is an i-node like file
identity that is kept track of, and it is preserved across
renames and merges.

That's keeping track of the history of a _file_.

And as you know, git doesn't do that.

What git does is to keep track of the history of the whole tree,
but prune the parts that are not interesting away when you view
the history.  And the pruning can be specified by _PATH_.

See the difference?
