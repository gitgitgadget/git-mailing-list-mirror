Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1658C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57152072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0fZ3/tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbgAXT7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:59:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57005 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388974AbgAXT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 14:59:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44E894AFFC;
        Fri, 24 Jan 2020 14:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FsDCwt6IeM3xs1ldKOpHsNwbNlA=; b=Z0fZ3/
        tf7UMkjk+jYCTkY/9c2BAw6NKYBYbVW+EjuVtEYiSpr4qvSzqr86KefJUjFPsjWA
        xbSt1tXLftcUDUtd0rYwirfR+sqMb8MWIArXR5K3i6EJUYXM7GhvMl+RBnZwlZhp
        Uo/GAd0xPOfojIZ+h/IN0rBZzzkSUroyH5kcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wf35BGopUAlYCsGNkiNtAhWkcQilR4go
        byfSF1ZRuv03qfttL2iwJpgxq8zij/SyWFmQQ7EkAthIYdn6wFfAdlz/kBQWxhjB
        mdjo/bwIilBJrQS2dFIaWu91NLZwx+JKHlaSjKudH0AfVUPw25QXPfy9vkL7SRYX
        ngVraMEO6Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C2CB4AFFB;
        Fri, 24 Jan 2020 14:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4E434AFFA;
        Fri, 24 Jan 2020 14:59:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Crabtree\, Andrew" <andrew.crabtree@hpe.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results from git rev-parse --show-toplevel
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
Date:   Fri, 24 Jan 2020 11:59:07 -0800
In-Reply-To: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
        (Andrew Crabtree's message of "Fri, 24 Jan 2020 18:07:55 +0000")
Message-ID: <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB8B0DA8-3EE3-11EA-AD96-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Crabtree, Andrew" <andrew.crabtree@hpe.com> writes:

> I ran into an issue where 'git rev-parse --show-toplevel' is reporting the current directory instead of the root of the repository.
> In my case I'm running it from within the pre-commit hook, and it seems like it might be related to GIT_DIR being set. 

Running "git" with GIT_DIR exported (or "git --git-dir=<dir>") tells
Git that it should not perform the usual "does this directory has a
subdirectory .git that is a repository?  If not, go one level up and
repeat the check" repository discovery.  Because the repository
discovery serves the purpose of finding both the repository and the
top of the working tree, disabling the discovery means you either
need to tell Git where the top of the working tree is, or you are
already at the top of the working tree by chdir()'ing to it.

Because you do not know where the top level is (otherwise you would
not be asking "rev-parse --show-toplevel" about it), either is
an option for you, but you can "unset GIT_DIR" to stop telling Git
that it should not perform the repository discovery.
