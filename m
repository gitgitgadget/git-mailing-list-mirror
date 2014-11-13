From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Thu, 13 Nov 2014 09:41:13 -0800
Message-ID: <xmqqfvdn2e2u.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoyOj-0006M7-8h
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 18:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702AbaKMRlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 12:41:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932596AbaKMRlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 12:41:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9061D4CA;
	Thu, 13 Nov 2014 12:41:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gtLc4FZwZGwcZUNWAIId/31TukQ=; b=ZQaPJ3
	kfLZthLfPfup6QQthz5TIojpFHlRAploslCbf+lzIaz+ll4xn+jJlK6+gZBJ5aJn
	FDiil5NXu+P217bmXRb2ltgGCuQsB4uCZ4JFYvqfCWtaRU8tX2uXdFO9AxzZu3Jh
	Uyyu30N0lV5vIxd4QTZZcR0K0vmWufKoa35xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Za89w2KD+QmoTo/ZTnfJFgmgaT6iFZ70
	N7PBPGjZ6HzcUMcz5lz7LmhH0Y4UFmKDImFB4a8N2q33JVFkDNXK2vXwcmrzx9Dw
	Q9qsWGyVYXDSNTP5hZ7W1A7hzwo8LKMrukifLXp9vCPvkYE09DdgYj+hUV8F6Yzv
	mYHqTAe2lH0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 749441D4C9;
	Thu, 13 Nov 2014 12:41:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB5F01D4C8;
	Thu, 13 Nov 2014 12:41:14 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 13 Nov 2014 11:38:25 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43F2C22C-6B5C-11E4-A63E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 13 Nov 2014, Johannes Schindelin wrote:
>
>> Due to that experience, the documentation also states pretty clearly that
>> `updateInstead` succeeds only in updating the current branch if the
>> working directory is clean.
>
> To clarify why `updateInstead` is stricter than the `merge` scenario: when
> pushing into a remote repository with attached working directory, we
> cannot simply clean up merge conflicts or other problems introduced by a
> merge. Indeed, it is even possible to push without having any option to
> fix files in the working directory afterwards. Therefore, the
> `updateInstead` feature really needs to be adamant about the working
> directory being clean.

As the stricter check (which I think is unnecessarily strict and
which you don't) can be loosened later without making something the
user used to be able to do in an early version unable to do later,
I am OK to accept the design as-is.

But after reading this addendum, I feel the need to double check.

A "reset --keep <new-commit>", which is the same as "checkout -B
<current> <new-commit>" (note the lack of "-m"), does not have
any "merge conflict" issues.

To see what I mean, follow along this simple experiment.

    # Just make sure we start clean
    $ git reset --hard

    # Create a playpen
    $ git checkout -b throwaway master

    # Pick one random path that is different.  We pretend that
    # somebody pushed the commit at the tip of 'next' from the side
    $ git diff --name-only next | head -n 1
    Documentation/git-clone.txt

    # Make sure another random path used in the experiment is unchanged
    $ git diff next -- COPYING | wc -l
    0

    # Smudge a path not involved in the branch/HEAD switching
    $ echo >>COPYING

    # attempt to updateInstead to the other version succeeds.
    $ git reset --keep next; echo $?
    0
    $ git status -suno
     M COPYING
    # Notice that we did not get into a funny state.
    # You can verify it with "git diff".

    # Go back and try smudging what would need a real merge
    $ git reset --hard master
    $ echo >>Documentation/git-clone.txt

    # attempt to updateInstead to the other version
    $ git reset --keep next; echo $?
    error: Entry 'Documentation/git-clone.txt' not uptodate. Cannot merge.
    fatal: Could not reset index file to revision 'next'.
    128

    # See that HEAD did not move
    $ git log HEAD...master | wc -l
    0

    # See that the working tree change is intact
    $ git status -suno
     M Documentation/git-clone.txt
    # Notice that we did not get into a funny state.
    # You can verify it with "git diff".

The semantics is just as safe as "checkout <another-branch>" without
the "-m" option; if a local change may be clobbered or needs real
file-level merge, the operation fails without touching anything to
preserve the local state.

It is OK for us to agree to disagree, and I am willing to accept the
stricter design for an initial version because loosening it later is
possible without harming users.

But I wanted to first make sure that your disagreement is an
informed one.  Do you still feel the need for "absolutely clean",
even if you take the safety built into "reset --keep" shown in the
above demonstration into account?
