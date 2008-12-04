From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-rebase safety hook
Date: Thu, 04 Dec 2008 11:35:56 -0800
Message-ID: <7vbpvrens3.fsf@gitster.siamese.dyndns.org>
References: <e1a5e9a00812040958u3af4c69ofba66567baacb79c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8K0v-0000zm-6S
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 20:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbYLDTgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 14:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbYLDTgG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 14:36:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbYLDTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 14:36:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 200418451B;
	Thu,  4 Dec 2008 14:36:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AFFFA84516; Thu,
  4 Dec 2008 14:35:59 -0500 (EST)
In-Reply-To: <e1a5e9a00812040958u3af4c69ofba66567baacb79c@mail.gmail.com>
 (Tim Harper's message of "Thu, 4 Dec 2008 10:58:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C93E7C4A-C23A-11DD-874C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102361>

"Tim Harper" <timcharper@gmail.com> writes:

> Is anyone aware of a pre-rebase hook script that will prevent (or at
> least warn) you from letting a rebase rewrite a commit that has been
> pushed or merged into any branch except it's own?
>
> I've activated the pre-rebase.sample, and it does seem to give me any
> warnings at all:
>
> Here's the terminal output demonstrating what I mean:
>
> http://pastie.org/331082

The example script starts like this:

    #!/bin/sh
    # ...
    # This sample shows how to prevent topic branches that are already
    # merged to 'next' branch from getting rebased, because allowing it
    # would result in rebasing already published history.

As it says, it explicitly checks against 'next'.

The sample was written way before "branch --with" feature was added, and I
suspect what it does can be expressed more concisely in modern git.


If you want to prevent a branch whose tip commit is on more than one
branches from being rebased, I think something like this would suffice.

    #!/bin/sh
    LF='
    '
    in_branches=$(git branch -a --with "${2-HEAD}")
    case "$in_branches" in
    *"$LF"*)
	: this commit is on more than two branches
        exit 1
        ;;
    esac
    exit 0

But I didn't test it.
