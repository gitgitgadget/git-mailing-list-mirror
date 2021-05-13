Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9AC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262B161175
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhEMVWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:22:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60177 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMVWq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:22:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1415E11DC07;
        Thu, 13 May 2021 17:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9x1CnNU5UPoYect5XpW5Q7uUbKLaI2guZEzxMW
        f+0xE=; b=un+8627K4WlJraPbohCN8TVL7mJEyJ9kllhj284IOSGuQXUJg5R70X
        jaFP6EvActiIdBuYQomY+7GgFlByMwAo2FtCuI6ozDh6YUVIQ89S2W4MPbuKk2yU
        IBE6oMRdSmJCGWWBqmdUSF/Ytk7YOuF2niWSzd6Gg8U92DFORZue0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D05811DC06;
        Thu, 13 May 2021 17:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E37511DC00;
        Thu, 13 May 2021 17:21:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] git-send-email: add option to specify sendmail command
References: <20210512033039.4022-1-greg@gpanders.com>
        <20210513023212.72221-1-greg@gpanders.com>
        <xmqq8s4jcmj7.fsf@gitster.g> <YJ0qMro2oP1Q5Ohw@gpanders.com>
Date:   Fri, 14 May 2021 06:21:31 +0900
In-Reply-To: <YJ0qMro2oP1Q5Ohw@gpanders.com> (Gregory Anders's message of
        "Thu, 13 May 2021 07:31:30 -0600")
Message-ID: <xmqqfsyq9vok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30FF229E-B431-11EB-9928-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders <greg@gpanders.com> writes:

> On Thu, 13 May 2021 12:58 +0900, Junio C Hamano wrote:
>>In short, it is far from sufficient to just "$concatenate @variables"
>>to form a single string.  $sendmail_cmd should be left as-is (after
>>all, we do want the shell to split it at $IFS whitespace into tokens),
>>but each element of @sendmail_parameters should be protected from
>>the shell (both word splitting and $interpolation rules).  Perhaps
>>something along the lines of this instead?
>>
>>    exec ("sh", "-c", "$sendmail_cmd \"\$\@\"", "-", @sendmail_parameters);
>
> Does this pose a problem for platforms such as Windows that don't have
> a 'sh' (not sure if there are any others)? Is git-send-email meant to 
> support Windows?

Seeing what run-command.c::prepare_shell_cmd() does under
GIT_WINDOWS_NATIVE (or on other platforms), I doubt the construct
would be a problem.  Our Windows experts would certainly chime in
if it is.

Thanks.


