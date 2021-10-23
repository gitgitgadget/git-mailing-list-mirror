Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19A7C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 23:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716DB60C4B
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 23:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJWX7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 19:59:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55941 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJWX7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 19:59:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2DA6FF2E6;
        Sat, 23 Oct 2021 19:57:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=co41CI8vYMN7ib59WENldu7+O0oxpS85swyi/7
        f5eDU=; b=UUzfCkM4QimDNMVxvUxT4lmJD+lF51lMNDwkfzXflioubCjKk4v8PI
        QzYcB0nG9SHHlabbjzYVfFfXu0gGoJ+k+fe8IE1LVenWObyk8VSQJ9ovJNj1eL36
        gQygK2fSwnSrUKkGGKcQIOrlPC8vndbpaCxIGvFKzRuUqZrvuPC3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA4EEFF2E4;
        Sat, 23 Oct 2021 19:57:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CE57FF2E3;
        Sat, 23 Oct 2021 19:57:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin <git@mfriebe.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re* Contradicting man page for git branch copy
References: <7a600f7e-e3a7-edac-056c-9639ff01e471@mfriebe.de>
Date:   Sat, 23 Oct 2021 16:57:30 -0700
In-Reply-To: <7a600f7e-e3a7-edac-056c-9639ff01e471@mfriebe.de> (Martin's
        message of "Sat, 23 Oct 2021 17:25:16 +0200")
Message-ID: <xmqq5ytn8fbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC9C344A-345C-11EC-9C02-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> The man page says
>
> 1) Under "Description"
> https://git-scm.com/docs/git-branch#_description
>> The |-c| and |-C| options have the exact same semantics as |-m| and
>> |-M|, except instead of the branch being renamed, it will be copied
>> to a new name, along with its config and reflog.
>
> But on the option itself
> https://git-scm.com/docs/git-branch#Documentation/git-branch.txt--c
>>
>> -c
>> --copy
>>
>>     Copy a branch and the corresponding reflog.
>>
>
> The latter does not mention the config.
>
> So does it copy the config or not ?

Thanks for a report.  

I hope that builtin/branch.c::copy_or_rename_branch() is a
relatively easy read.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: branch (doc): -m/-c copies config and reflog

The description section for the command mentions config and reflog
are moved or copied by these options, but the description for these
options did not.  Make them match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git i/Documentation/git-branch.txt w/Documentation/git-branch.txt
index 5449767121..8af42eff89 100644
--- i/Documentation/git-branch.txt
+++ w/Documentation/git-branch.txt
@@ -125,14 +125,14 @@ OPTIONS
 
 -m::
 --move::
-	Move/rename a branch and the corresponding reflog.
+	Move/rename a branch, together with its config and reflog.
 
 -M::
 	Shortcut for `--move --force`.
 
 -c::
 --copy::
-	Copy a branch and the corresponding reflog.
+	Copy a branch, together with its config and reflog.
 
 -C::
 	Shortcut for `--copy --force`.


