From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Fri, 12 Jul 2013 14:19:51 -0700
Message-ID: <7vy59biih4.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
	<7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 12 23:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxkkx-0007QP-HA
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454Ab3GLVT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:19:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965377Ab3GLVTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:19:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648EA305CB;
	Fri, 12 Jul 2013 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rAw49yJYkh8n+8UJp+JkGiL0/IE=; b=vwvsGJ
	++GInBrYUpRr+fU3XLcZi3ZvFgpBmCckh36yDQ48ru2/S4U9gV2JKrgiQkvv7wUw
	crS7mB46UBiXE7H6BESkHq+Bax9uMrshSXHMak/Z9cqzTvsWpbsXLLL5a5Oav3zh
	4ddO3zYab2tLhtHCFqgXKcp+Hn9RTUMs58604=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iNwdSogS1YoD9E8VGV9b+4yi1NKALD5q
	PXCJnWyyzHEkNAemElOjU1Bcb27SmiJk/eIBNWGYTkwQO0TAkVR7BMreMZpevbK+
	R1691w1P2TKw+wiLGIxDb15GB8QdWSHigdZvv4pQfwIVJzwPs6jYfvLKkW8ch6yh
	DIdNk+zsbJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 534BA305CA;
	Fri, 12 Jul 2013 21:19:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E3E2305C8;
	Fri, 12 Jul 2013 21:19:53 +0000 (UTC)
In-Reply-To: <51E0605E.9020902@kdbg.org> (Johannes Sixt's message of "Fri, 12
	Jul 2013 22:00:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB2D0E28-EB38-11E2-AA02-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230257>

Johannes Sixt <j6t@kdbg.org> writes:

> We have three independent options that the user can choose in any
> combination:
>
>  o --force given or not;
>
>  o --lockref semantics enabled or not;
>
>  o refspec with or without +;
>
> and these two orthogonal preconditions of the push
>
>  o push is fast-forward or it is not ("ff", "noff");
>
>  o the branch at the remote is at the expected rev or it is not
>    ("match", "mismatch").
>
> Here is a table with the expected outcome. "ok" means that the push is
> allowed(*), "fail" means that the push is denied. (Four more lines with
> --force are omitted because they have "ok" in all spots.)
>
>                        ff   noff     ff      noff
>                       match match mismatch mismatch
>
> --lockref +refspec     ok    ok    denied   denied
> --lockref  refspec     ok  denied  denied   denied

I am confused with these.  The latter is the most typical:

	git fetch
        git checkout topic
        git rebase topic
	git push --lockref topic

where we know it is "noff" already, and we just want to make sure
that nobody mucked with our remote while we are rebasing.

If nobody updated the remote, why should this push be denied?  And in
order to make it succeed, you need to force with +refspec or --force,
but that would bypass match/mismatch safety, which makes the whole
"make sure the other end is unchanged" safety meaningless, no?

>           +refspec     ok    ok      ok       ok

This is traditional --force.

>            refspec     ok  denied    ok     denied

We are not asking for --lockref, so match/mismatch does not affect
the outcome.

> Notice that without --lockref semantics enabled, +refspec and refspec
> keep the current behavior.

But I do not think the above table with --lockref makes much sense.

Let's look at noff/match case.  That is the only interesting one.

This should fail:

	git push topic

due to no-ff.

Your table above makes this fail:

        git push --lockref topic

and the user has to force it, like this?

	git push --lockref --force topic ;# or alternatively
        git push --lockref +topic

Why is it even necessary?

If you make

	git push --lockref topic

succeed in noff/match case, everything makes more sense to me.

The --lockref option is merely a weaker form of --force but still a
way to override the noff check.  If the user wants to keep noff
check, the user can simply choose not to use the option.

Of course, that form should fail if "mismatch".  And then you can
force it,

	git push --force [--lockref] topic

As "--force" is "anything goes", it does not matter if you give the
other option on the command line.

> (*) As we are talking only about the client-side of the push here, I'm
> saying "allowed" instead of "succeeds" because the server can have
> additional restrictions that can make the push fail.

Yes, you and I have known from the beginning that we are in
agreement on that, but it is a good idea to explicitly say so for
the sake of bystanders.
