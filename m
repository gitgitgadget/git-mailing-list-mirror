From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Sun, 06 Jul 2008 15:33:16 -0700
Message-ID: <7vbq1ad4nn.fsf@gitster.siamese.dyndns.org>
References: <20080620082034.GA24913@elte.hu>
 <m3d4mcmq20.fsf@localhost.localdomain>
 <37fcd2780807060916h7d8c4e6mba7f30570d527dc3@mail.gmail.com>
 <7vprpqdbjx.fsf@gitster.siamese.dyndns.org>
 <20080706203951.GB1721@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 00:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFcoO-0004oH-95
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 00:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYGFWda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYGFWd3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 18:33:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYGFWd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 18:33:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 24DDF221CF;
	Sun,  6 Jul 2008 18:33:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 147B2221CE; Sun,  6 Jul 2008 18:33:17 -0400 (EDT)
In-Reply-To: <20080706203951.GB1721@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Mon, 7 Jul 2008 00:39:52 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D32C284-4BAB-11DD-8A9D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87561>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Sun, Jul 06, 2008 at 01:04:18PM -0700, Junio C Hamano wrote:
>>     Two other shorthands for naming a set that is formed by a commit
>>     and its parent commits exists.  `r1{caret}@` notation means all
>>     parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
>>     its all parents.
>
> So, I would say that rev^! is shorthand for rev^@..rev, but it does not
> actually work:
>
> git rev-list 7ac749c^@..7ac749c
> fatal: ambiguous argument '7ac749c^@..7ac749c': unknown revision or path
> not in the working tree.
>
> yet "^rev^@ rev" syntax does:
>
> git rev-list ^7ac749c^@ 7ac749c
> 7ac749c96d143ba4f76723959892cbaddbe8ed07
>
> Is it a bug or feature?
>
> Puzzled...

After reading these paragraphs from "SPECIFYING RANGES":

        History traversing commands such as 'git-log' operate on a set
        of commits, not just a single commit.  To these commands,
        specifying a single revision with the notation described in the
        previous section means the set of commits reachable from that
        commit, following the commit ancestry chain.

        To exclude commits reachable from a commit, a prefix `{caret}`
        notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
        from `r2` but exclude the ones reachable from `r1`.

        This set operation appears so often that there is a shorthand
        for it.  "`r1..r2`" is equivalent to "`{caret}r1 r2`".  It is
        the difference of two sets (subtract the set of commits
        reachable from `r1` from the set of commits reachable from
        `r2`).

it is obvious to me that the third paragraph talks about r1 that is a
single rev (refer to SPECIFYING REVISIONS section, which does _NOT_ talk
about rev^@ nor rev^!)  and r2 that similarly is another single rev.  So I
think it is fairly clear that your "r^@..r" example is nonsense.

But perhaps these paragraphs need to be further reworded to avoid the
confusion.  I dunno.
