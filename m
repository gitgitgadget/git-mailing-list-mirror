Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013D5207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 01:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163940AbdDXBh0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 21:37:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758890AbdDXBhY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 21:37:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31089804BD;
        Sun, 23 Apr 2017 21:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P+d5nlkihA7PmuWzErHhRMGKczI=; b=V/2jCf
        LHRWwUiBehpXG1a3iAtE4R8u0nOXeLad/5kT5M+1RIH9P9psFYecNfF9BRrmkG4w
        U3FmkC0LJWuJjrEmvmRqYv697zKkNRdvewGkzSRTQSjPb6MJAVnXAIjwjEUzHTdA
        ObeJcXjQ7isaofnbQh7JgdWNyhgCSyBYDptdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OwGBLfKWaaKhyXa7N5Ql2ZHrdnQ2L0qO
        BI0Zd8M5tJR2cpeNGCtpgeOPny7v/TnuI3u3YA8Nx1cBjSZzEE6cgmJHXvdjQ80d
        LzxXR/NNhhsnhy1RO0SXIMvt3ipGFEzAnthSsUDerUIoyCFl6hPBnGUxdN0aoNlx
        Yjkyom7Cfo8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28A82804BC;
        Sun, 23 Apr 2017 21:37:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8125E804BA;
        Sun, 23 Apr 2017 21:37:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] git_fopen: fix a sparse 'not declared' warning
References: <130ef8bd-1c7b-0206-e1cd-076afae7e292@ramsayjones.plus.com>
Date:   Sun, 23 Apr 2017 18:37:21 -0700
In-Reply-To: <130ef8bd-1c7b-0206-e1cd-076afae7e292@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 22 Apr 2017 01:58:23 +0100")
Message-ID: <xmqqshky37se.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 900EB098-288E-11E7-9B37-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit 8f4f6e53d2 ("config.mak.uname: set FREAD_READS_DIRECTORIES for
> Linux and FreeBSD", 20-04-2017) caused sparse to issue a 'not declared,
> should it be static?' warning on Linux. This is a result of the method
> employed by 'compat/fopen.c' to suppress the (possible) redefinition of
> the (system) fopen macro, which also removes the extern declaration of
> the git_fopen function.
>
> In order to suppress the warning, introduce a new macro to suppress the
> definition (or possibly the re-definition) of the fopen symbol as a
> macro override. This new macro (SUPPRESS_FOPEN_REDEFINITION) is only
> defined in 'compat/fopen.c', just prior to the inclusion of the
> 'git-compat-util.h' header file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Duy,
>
> Could you (or Junio) please add this to your 'nd/fopen-errors'
> branch, either as a separate patch or squash it into commit
> 8f4f6e53d2 ("config.mak.uname: set FREAD_READS_DIRECTORIES for
> Linux and FreeBSD", 20-04-2017). I think it would be better as a
> separate commit, but I will leave you to decide on that. ;-)

Yeah, I think it makes sense to have this as a separate patch,
applying even before the other series.

Thanks.
