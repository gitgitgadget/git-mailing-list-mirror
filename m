Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91251C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 20:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629DD2072A
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="crJfz4Xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgAIUEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:04:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62054 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIUEH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 15:04:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1153EAC94B;
        Thu,  9 Jan 2020 15:04:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nSbSImzzqnxKCZ+DqrwpGWNICEc=; b=crJfz4
        Xh1zp1jxaHhteoATzj43+462dtnI8Ymr9mIhbk5F4SINMDVq8OnZIkcR7aK4xuAQ
        rSyOTk+7/F3khOZZinCir5TdtSebv8NcWiZ83cWvJx4swgMZS0TtbkPuF6JjXunY
        52y5QXIA5O8MGngY9th0xp3A8jqIvLVGtRAYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ubt+/ycB1L3E8+uburvdi1O0gLhpFD9r
        bZx4cPoTmoV7mX0HH6KLvusqTimWBUG3aaR5kl2cjtKSY4JKg8YhHMwkiNq0De8M
        z+eAh1GSAbT0gv66cVxplll30iScHHoCRQdguQ7sSNKymkQEsT+QFjZCM89xb9zI
        QWtD0UsR2Tc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08E59AC94A;
        Thu,  9 Jan 2020 15:04:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3533BAC948;
        Thu,  9 Jan 2020 15:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Wood <carlo@alinoe.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodule update  strange output behavior.
References: <20200109192040.46aaa01e@hikaru>
        <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 09 Jan 2020 12:03:55 -0800
In-Reply-To: <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 09 Jan 2020 10:54:27 -0800")
Message-ID: <xmqq8smgz9as.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C85CEA4-331B-11EA-80D8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Wood <carlo@alinoe.com> writes:
>
>> In a project containing submodules, one of the submodules
>> contains a submodule itself, which in turn also contains
>> a submodule.
>>
>> Overview:
>>
>> project/foobar  [submodule]
>> project/cwm4    [submodule]
>> project/evio    [submodule]
>> project/evio/protocol/matrixssl       [submodule]
>> project/evio/protocol/matrixssl/cwm4  [submodule]
>>
>> ('protocol' is a normal subdirectory)
>>
>> Running (with or without the --quiet),
>>
>> $ git submodule --quiet update --init --recursive --remote
>> Fetching submodule protocol/matrixssl
>> Fetching submodule protocol/matrixssl/cwm4
>> Fetching submodule cwm4
>>
>> This is odd (a bug imho) because
>>
>> 1) it seems to only print this fetching information for submodules inside submodules,
>> not for the top-level submodules.
>> 2) it even prints this when using --quiet
>> 3) it prints this every time (also when there is nothing more to fetch).
>
>
> Sounds like a symptom of (a) the top-level "git submodule update"
> knowing how to react to "--quiet" but (b) it forgets to pass down
> the "--quiet" when it recursively runs "git submodule update" in its
> submodules?

Just a shot in the dark.  Not even compile tested ;-)

 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 9da7181321..535bb6bf04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1454,11 +1454,12 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_pushv(&cp->args, spf->args.argv);
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
-
 			strbuf_addf(&submodule_prefix, "%s%s/",
 						       spf->prefix,
 						       task->sub->path);
 			argv_array_push(&cp->args, submodule_prefix.buf);
+			if (spf->quiet)
+				argv_array_push(&cp->args, "--quiet");
 
 			spf->count++;
 			*task_cb = task;
