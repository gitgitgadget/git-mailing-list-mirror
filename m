Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB79C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386E820731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PtlDvVCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFXNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:13:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57718 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgAFXNX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:13:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2498AFCAE;
        Mon,  6 Jan 2020 18:13:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QkBhmesqrZADl92FVw34I2q8n/E=; b=PtlDvV
        CIqmjlAnywEXaT8GW+pFWsgZuicWPA8tvBmM3YH93hKbtA/lQtdz1AQyjgBeVuBg
        IEa606ErwNZn0xrkiNjw2MjIucO5ZRqxe4hCgai3+WwciIzzl8T8QZAspoZ0SOCH
        ahX/qDYHYNW2JPul8/k3/D+a0WEb+MzwgD2Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v4lTE7WnlBRyeiMoLCCg2+5puo4kjgXQ
        CoLtxn16jY04ZlCRPcw/j2MeSmire+p/di0/2gtHMXsyr+DrzvFRYHp46Gj/s6+/
        shqJEd8q0QmzV10d70V0N/VzTkbunW3NopHbaEwILn4QIJGzvlQvN0nX7AHYJeSj
        4BoW3i5p53k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA7A1AFCAD;
        Mon,  6 Jan 2020 18:13:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD4FCAFCAB;
        Mon,  6 Jan 2020 18:13:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
        <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
        <20200106230712.GA181522@google.com>
Date:   Mon, 06 Jan 2020 15:13:16 -0800
In-Reply-To: <20200106230712.GA181522@google.com> (Emily Shaffer's message of
        "Mon, 6 Jan 2020 15:07:12 -0800")
Message-ID: <xmqq36cs89gz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20BE048A-30DA-11EA-9704-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Thu, Jan 02, 2020 at 03:04:01AM +0000, Heba Waly via GitGitGadget wrote:
>> From: Heba Waly <heba.waly@gmail.com>
>> 
>> @@ -390,7 +390,7 @@ static int add_files(struct dir_struct *dir, int flags)
>>  		fprintf(stderr, _(ignore_error));
>>  		for (i = 0; i < dir->ignored_nr; i++)
>>  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
>> -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
>> +		advise(_("Use -f if you really want to add them.\n"));
>
> In the vein of the rest of your project, for me I'd rather see a
> copy-pasteable response here:
>
> "Use 'git add -f " + name + "' if you really want to add them."
>
> That is, if you know the name of the file that was being added here, you
> could provide it so the user can simply copy and go, rather than
> retyping.

Just being a devil's advocate, but you are opening a can of worms by
suggesting so---the path needs to be quoted proporly (and the way to
do so may be different depending on the shell in use), for example.

