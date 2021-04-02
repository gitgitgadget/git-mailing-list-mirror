Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01742C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 23:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B972261178
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 23:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhDBXoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 19:44:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53628 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBXoo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 19:44:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B3D11304CD;
        Fri,  2 Apr 2021 19:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ANI3j3KloYNZmKiTP7LXAvCskWw=; b=rDX+Zt
        R19xaf/eh9lf33Ofykcybim4uPir3hWDbdMDPipMMJjON5wyXiqkGQsvwSBMMpBS
        eWryudfIopGF+AqFV0WvKdVx+5wtlWx+Eb4/FnnD0GuWX7KroLpWeo6aqde06DqJ
        22JtjdIkRGc+YsM5MG9nI/q6Zn6svrLKqpcMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TmE67BiX9V9BWEmYQFcEIfdZdYZ3IjWt
        xZA/Fzv8l7iUyoDCQkKvkszGyNnm/AC3r3X13whiCJRjlAvWuxbVbw6sivwrNHpA
        Leb7uG4WYyglYmXIlbwWiRIWJ2pR2kkSbcyELPE1B6zUyrkwnrwWZ//3sJIytXOU
        QuMFY3qBdkc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 441321304CC;
        Fri,  2 Apr 2021 19:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CE931304CB;
        Fri,  2 Apr 2021 19:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
Date:   Fri, 02 Apr 2021 16:44:37 -0700
In-Reply-To: <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 02 Apr 2021 13:26:12 +0000")
Message-ID: <xmqq35w82qvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63D46344-940D-11EB-8342-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> The `trailer.<token>.command` configuration variable
> specifies a command (run via the shell, so it does not have
> to be a single name of or path to the command, but can be a
> shell script), and the first occurrence of substring $ARG is
> replaced with the value given to the `interpret-trailer`
> command for the token.  This has two downsides:
> ...
>
>  Documentation/git-interpret-trailers.txt | 82 +++++++++++++++++---
>  t/t7513-interpret-trailers.sh            | 95 +++++++++++++++++++++++-
>  trailer.c                                | 38 +++++++---
>  3 files changed, 193 insertions(+), 22 deletions(-)

Merging this to anything that has zh/commit-trailer (which extends
the tests in t7502) seems to break t7502.  Running the test with the
"-i -v" option ends like so.

expecting success of 7502.24 'commit --trailer with -c and command': 
	trailer_commit_base &&
	cat >expected <<-\EOF &&
	hello

	Signed-off-by: C O Mitter <committer@example.com>
	Signed-off-by: C1 E1
	Helped-by: C2 E2
	Mentored-by: C4 E4
	Reported-by: A U Thor <author@example.com>
	EOF
	git -c trailer.report.key="Reported-by: " \
		-c trailer.report.ifexists="replace" \
		-c trailer.report.command="NAME=\"\$ARG\"; test -n \"\$NAME\" && \
		git log --author=\"\$NAME\" -1 --format=\"format:%aN <%aE>\" || true" \
		commit --trailer "report = author" --amend &&
	git cat-file commit HEAD >commit.msg &&
	sed -e "1,/^\$/d" commit.msg >actual &&
	test_cmp expected actual

[main 6b1e5e9] hello
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
[main 97c7a39] hello
 Author: A U Thor <author@example.com>
 Date: Thu Apr 7 15:22:13 2005 -0700
 1 file changed, 1 insertion(+)
--- expected	2021-04-02 23:43:10.649082950 +0000
+++ actual	2021-04-02 23:43:10.673085111 +0000
@@ -4,4 +4,4 @@
 Signed-off-by: C1 E1
 Helped-by: C2 E2
 Mentored-by: C4 E4
-Reported-by: A U Thor <author@example.com>
+Reported-by:
not ok 24 - commit --trailer with -c and command
#	
#		trailer_commit_base &&
#		cat >expected <<-\EOF &&
#		hello
#	
#		Signed-off-by: C O Mitter <committer@example.com>
#		Signed-off-by: C1 E1
#		Helped-by: C2 E2
#		Mentored-by: C4 E4
#		Reported-by: A U Thor <author@example.com>
#		EOF
#		git -c trailer.report.key="Reported-by: " \
#			-c trailer.report.ifexists="replace" \
#			-c trailer.report.command="NAME=\"\$ARG\"; test -n \"\$NAME\" && \
#			git log --author=\"\$NAME\" -1 --format=\"format:%aN <%aE>\" || true" \
#			commit --trailer "report = author" --amend &&
#		git cat-file commit HEAD >commit.msg &&
#		sed -e "1,/^\$/d" commit.msg >actual &&
#		test_cmp expected actual
#	
