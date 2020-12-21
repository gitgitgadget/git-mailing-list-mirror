Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE904C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792A822BF3
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgLUUHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 15:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLUUHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 15:07:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2FC061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:07:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m12so26613178lfo.7
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u2SpiRznsEgEML4pJY2XBR3VMYGpsSjbMNYWxbn6Iq4=;
        b=K5VPPvNnkGxS5xOpHjdGx/M9M91fQsJsM3nJ1eSstEx0Xsism1zA5Lrqg9OIXrlUjl
         t0ScrzVdJ+29Km3nbKZ36NAoFPQfbr2GofIlclB9iVTEIVis7XTAojaNTUT95OtRyB+h
         9ZPzK3jHb7JBOdxfXp1EAj29iYWjlbMi9Yto0UWkP2rkPaxAfYQlgtsZeyV6uIt1xPbN
         A9+N4SWjY5/P5FMh582xW13NwGdPbkV7bDTDi8Cvo2ZQjZ5a+xjVL1FVMnu0H/e/5mni
         4Kn4BY9BK9rddOqwneA1AF8PHJ2HZzWG0kFWWIjAJAQMnk/xwF8+X+3OTc4RsVuFCc1P
         WmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=u2SpiRznsEgEML4pJY2XBR3VMYGpsSjbMNYWxbn6Iq4=;
        b=mc8UcX04DslMrRvgnboUjC2Fdp6ysLzCq8Ow3rnZjBYAZ/F6Zw3yXd6FdOCTKieZd9
         g+IxoV1M4JaNb095+79ax5XNWh2hktHlXNQiC/1hjMlakjwfcAM6z+mJVxx2YNAQOC5m
         GY4JRFH3Pmpu21wlEq4asiK66OKohUiv6JK33WI1eWPavQf8Bgu86j68icqjdiTVgNRB
         LIh5Mf5vXV52rREmNoAufj65oLfUfUp+bBWWvDjNkAL/niva+2yRPnh6PSdwsroBHmKU
         BmBG0hoeZvL2CKDqdeplALd+3ImOz+SzXYThd/4CMJ0tA6LrFfHMVCYiRlv8yF4RRjN+
         XcWw==
X-Gm-Message-State: AOAM530uEZZqKqFzX2+lxyOM6wJQ8iOAKNpcuegjzchPjecPUPS6unXr
        a/Ag5CjfcGvLRw9RXwCZcKVXQw7eU98=
X-Google-Smtp-Source: ABdhPJzWVjfKcaxi7iiYSyOZBaNfTeJwxD7pmApxeiD/43tvJIezMw+F7yKE6C4EiXc0TNMAWj9NJQ==
X-Received: by 2002:a19:ecb:: with SMTP id 194mr7186045lfo.70.1608581230070;
        Mon, 21 Dec 2020 12:07:10 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 206sm2232120lfd.180.2020.12.21.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:07:09 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 25/32] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201221152000.13134-1-sorganov@gmail.com>
        <20201221152000.13134-26-sorganov@gmail.com>
        <5fe0ec103ad4f_e6ff208f5@natae.notmuch>
Date:   Mon, 21 Dec 2020 23:07:08 +0300
In-Reply-To: <5fe0ec103ad4f_e6ff208f5@natae.notmuch> (Felipe Contreras's
        message of "Mon, 21 Dec 2020 12:40:16 -0600")
Message-ID: <87sg7yrkib.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> diff --git a/log-tree.c b/log-tree.c
>> index f9385b1dae6f..9f50a81e537e 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>>  	int showed_log;
>>  	struct commit_list *parents;
>>  	struct object_id *oid;
>> +	int is_merge;
>> +	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>>  
>> -	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
>> +	if (!all_need_diff && !opt->merges_need_diff)
>>  		return 0;
>>  
>>  	parse_commit_or_die(commit);
>>  	oid = get_commit_tree_oid(commit);
>>  
>> -	/* Root commit? */
>>  	parents = get_saved_parents(opt, commit);
>> +	is_merge = parents && parents->next;
>> +	if (!is_merge && !all_need_diff)
>> +		return 0;
>> +
>> +	/* Root commit? */
>>  	if (!parents) {
>>  		if (opt->show_root_diff) {
>>  			diff_root_tree_oid(oid, "", &opt->diffopt);
>
> FWIW this logic does make sense to me.

Thanks for reviewing!

-- Sergey
