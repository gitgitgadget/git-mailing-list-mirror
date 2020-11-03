Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF21C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5338A22243
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mjksbyCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKCBBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:01:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62845 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCBBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:01:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65960E40A1;
        Mon,  2 Nov 2020 20:01:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yn7oMkHIcTrA7JSh80xMS3kVJsw=; b=mjksbyCl+uUO7T+QKXZj
        hh8mZm8SV4NdTiUP+11i8ZE2tqqummkct83O4oLax3rb457VjAVU3bFQSg8kNTXC
        pg9WaX6ODC/xesr0NgyX/IomyE+ERIAbXgakDhYx+L6Xiiz6dHUwEYEWlQ/6lssR
        ZO3hSd2Ro262I+dnYKGk/Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=jyAbNBz+V8kP3hECfNeCxqxvwsnbmHmO/FSckZlcbAFcoy
        rGPT7K93oxs47NBvyA0XHbXe1cXSFxvaMs5xi8pjUVAvjzKYgeluHFRfhOXyDRV9
        rAJG8ElekIBp1r1yrmz3SKN95FDDUszdqsRcRMxPz01EnXSkpAyxhHSF/gh+U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ED7BE409C;
        Mon,  2 Nov 2020 20:01:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9066EE409B;
        Mon,  2 Nov 2020 20:01:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sangeeta Jain <sangunb09@gmail.com>
Subject: Re: sj/untracked-files-in-submodule-directory-is-not-dirty, was Re:
 What's cooking in git.git (Oct 2020, #04; Tue, 27)
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011020251520.18437@tvgsbejvaqbjf.bet>
Date:   Mon, 02 Nov 2020 17:01:47 -0800
Message-ID: <xmqqa6vzqmmc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2731D7BE-1D70-11EB-A3B2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
>>  - diff: do not show submodule with untracked files as "-dirty"
>>
>>  "git diff" showed a submodule working tree with untracked cruft as
>>  "Submodule commit <objectname>-dirty", but a natural expectation is
>>  that the "-dirty" indicator would align with "git describe --dirty",
>>  which does not consider having untracked files in the working tree
>>  as source of dirtiness.  The inconsistency has been fixed.
>>
>>  Needs doc update.
>
> I *think* the original rationale for marking submodules with untracked
> (_un-ignored_) files was to avoid deleting a submodule that has
> uncommitted (because untracked) files.

I agree with you that that the motivation was exactly that, but I
have a suspicion that its execution was misguided.

> This patch affects e.g. if some script wants to determine whether a
> submodule can be deleted safely and uses `git diff` to do so. With this
> patch, it is possible to lose data irretrievably.

Let's play devil's advocate.

When one has a subdirectory D where one might or might not have an
untracked new file that one does not want to lose, but one otherwise
would want to clean up (perhaps an errant process created tons of
garbage files in the directory), one would not

	git diff D

to see if there are important changes in that directory before doing

	rm -rf D && git checkout D

to bring it back to pristine state, exactly because one would not
want to lose newly-created but not added files.  One would instead
use

	git status D

for checking.  Why would a user change the habit when D happens to
be a submodule?

So I would say that "git status [D]", if it does not let the user
notice that there is untracked contents in the submodule working
tree, would be a bad idea.  "git diff" that ignores untracked paths
in the submodule working tree, on the other hand, is a good thing.

Now, the patch as-is may change the behaviour of "git status D" in
this case, and the internal invocation of diff-files made somewhere
in wt-status.c may have to be adjusted to keep such a submodule with
forgotten newly created files shown as modified.

Further discussion on this should be done on the original review
thread for continuity, not here, in any case.

Thanks.
