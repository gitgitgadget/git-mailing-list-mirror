Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9D5C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A0A24679
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad4p6ck7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgDFOnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:43:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgDFOnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 10:43:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so17766859wrx.9
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=prhf3tgganI+Oi8AxO1wlo4Npd13cUkls+JTCFz92fM=;
        b=ad4p6ck76ozq0tVL2sLAIYSWQlfGfjphfxfQZKNF879XJkABDq5QA2daCCnW/L/z1M
         8I+mwXFeBTubG7tiNqMTEmBFrp91Kyol3ZML+LY+Lre0ejeEl9MNDmoFf/4YgYwNqano
         95CZhJNV3ha/l4XuDzSVKPz2JEHOQ+IlrDQbpdbWGqi1moDtly3T29mJLMbpb8k2mmiY
         2t1eYiMZCB2gKWntIc2ChxhVRfOjyQucGJRKvVXqkNDCs9PnO6Ii3DwWSIr+6/ziT9I6
         5AM5ubjFP1ECVS2k9auqrMzVseNRAmk2zDmKTHSwH6muGxrv8y7EwENH33bsUVsEcU/2
         aFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=prhf3tgganI+Oi8AxO1wlo4Npd13cUkls+JTCFz92fM=;
        b=KOWX3khKn8KdyQjfvP1ahJALgxz7GgZh/HBk+VnJJ1tNtcJKXBAJTqCpLPDNOTqIvZ
         fx/051rgTVGZhZnZ83ZWFZVMb34RMFHDsh4qAMtldldB9EbXbiExnRGdopqZFheh9FP8
         uxtRO8IAlnNX5Yb4euhRffABRU6VvpsZghLFIOPOqQVc3snTQ3CvkIkuH4mKJkFBPoF0
         80xYEnYeJv4IQw7LsWqrjIzNIzHVcn8aimG6vLD4xuSh9i+m7TEyhNNyZ0rSYEjXgvv7
         8FCH4HIEwP+9KYx9XUdG9xPw25hkd0jyeRZ8i+YwQlBRgkzh/gIec4y7SV0XdMY009K5
         fHZA==
X-Gm-Message-State: AGi0PuaDSfGe45ONlLsEBKO7b1Fi5ae+kQmcCR4uGSi5xPUNqHjicl9e
        Y+vE0Cf/jh4DMAkXJVgDSzs=
X-Google-Smtp-Source: APiQypJH/rqVon5/HVHvjs9U0/LeaetoZeMe5TAogyF2sGC6yWf7VVwrwws29C2q63uYR8pwLDZsZA==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr25689808wrq.16.1586184181235;
        Mon, 06 Apr 2020 07:43:01 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id n131sm6404289wmf.35.2020.04.06.07.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 07:43:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 04/23] sequencer: reuse strbuf_trim() in
 read_oneliner()
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <c7a3cfa20005aeeedc27d2eb4af1e2c4470ad73d.1585962672.git.liu.denton@gmail.com>
 <4e04fd90-bb71-0d7e-e611-5c408161d3e5@gmail.com>
Message-ID: <1c382358-08ca-8bf8-cbd6-d00406472bcd@gmail.com>
Date:   Mon, 6 Apr 2020 15:42:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4e04fd90-bb71-0d7e-e611-5c408161d3e5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 06/04/2020 15:03, Phillip Wood wrote:
> Hi Denton
> 
> On 04/04/2020 02:11, Denton Liu wrote:
>> In the original read_oneliner() logic, we duplicated the logic for
>> strbuf_trim_trailing_newline() with one exception: instead of preventing
>> buffer accesses below index 0, it would prevent buffer accesses below
>> index `orig_len`. Although this is correct, it isn't worth having the
>> duplicated logic around.
>>
>> Reset `buf` before using it then replace the trimming logic with
>> strbuf_trim().
> 
> I should have picked up on this before but this changes the semantics of 
> the function as it strips all whitespace from the start and end of the 
> strbuf. Above you talked about using strbuf_trim_trailing_newline() 
> instead which would not change the semantics of this function. You could 
> test to see if we've read anything and only call 
> strbuf_trim_trailing_newline() in that case without messing with 
> strbuf_reset(). (there is a corner case where if the buffer ends with 
> '\r' when the function is called and it reads a single '\n' then the 
> '\r' would be stripped as well but I think that is unlikely to happen in 
> the wild)

I'd also be fine with dropping this patch and leaving the trimming code 
as is

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
>> As a cleanup, remove all reset_strbuf()s that happen before
>> read_oneliner() is called.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>>   sequencer.c | 18 +++++-------------
>>   1 file changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index faab0b13e8..09ca68f540 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -420,8 +420,8 @@ static int write_message(const void *buf, size_t 
>> len, const char *filename,
>>   }
>>   /*
>> - * Reads a file that was presumably written by a shell script, i.e. 
>> with an
>> - * end-of-line marker that needs to be stripped.
>> + * Resets a strbuf then reads a file that was presumably written by a 
>> shell
>> + * script, i.e. with an end-of-line marker that needs to be stripped.
>>    *
>>    * Note that only the last end-of-line marker is stripped, 
>> consistent with the
>>    * behavior of "$(cat path)" in a shell script.
>> @@ -431,23 +431,19 @@ static int write_message(const void *buf, size_t 
>> len, const char *filename,
>>   static int read_oneliner(struct strbuf *buf,
>>       const char *path, int skip_if_empty)
>>   {
>> -    int orig_len = buf->len;
>>       if (!file_exists(path))
>>           return 0;
>> +    strbuf_reset(buf);
>>       if (strbuf_read_file(buf, path, 0) < 0) {
>>           warning_errno(_("could not read '%s'"), path);
>>           return 0;
>>       }
>> -    if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
>> -        if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
>> -            --buf->len;
>> -        buf->buf[buf->len] = '\0';
>> -    }
>> +    strbuf_trim(buf);
>> -    if (skip_if_empty && buf->len == orig_len)
>> +    if (skip_if_empty && !buf->len)
>>           return 0;
>>       return 1;
>> @@ -2471,7 +2467,6 @@ void parse_strategy_opts(struct replay_opts 
>> *opts, char *raw_opts)
>>   static void read_strategy_opts(struct replay_opts *opts, struct 
>> strbuf *buf)
>>   {
>> -    strbuf_reset(buf);
>>       if (!read_oneliner(buf, rebase_path_strategy(), 0))
>>           return;
>>       opts->strategy = strbuf_detach(buf, NULL);
>> @@ -2494,7 +2489,6 @@ static int read_populate_opts(struct replay_opts 
>> *opts)
>>                   free(opts->gpg_sign);
>>                   opts->gpg_sign = xstrdup(buf.buf + 2);
>>               }
>> -            strbuf_reset(&buf);
>>           }
>>           if (read_oneliner(&buf, 
>> rebase_path_allow_rerere_autoupdate(), 1)) {
>> @@ -2526,7 +2520,6 @@ static int read_populate_opts(struct replay_opts 
>> *opts)
>>               opts->keep_redundant_commits = 1;
>>           read_strategy_opts(opts, &buf);
>> -        strbuf_reset(&buf);
>>           if (read_oneliner(&opts->current_fixups,
>>                     rebase_path_current_fixups(), 1)) {
>> @@ -4006,7 +3999,6 @@ static int pick_commits(struct repository *r,
>>                   res = error(_("could not read orig-head"));
>>                   goto cleanup_head_ref;
>>               }
>> -            strbuf_reset(&buf);
>>               if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
>>                   res = error(_("could not read 'onto'"));
>>                   goto cleanup_head_ref;
>>
