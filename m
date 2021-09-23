Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D32C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC6260F24
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhIWNoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhIWNob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 09:44:31 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33DC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:42:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u22so9705170oie.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/KQ8YHueVW6xSOKp3yv24P03d+ADDcJB7YEQmb9mmg=;
        b=iVpZpKb88VFNkhKxg0lVWRppiqqsX1kPb1q6xFU8VhxjAGkOCex9LT99tjHT1+RgcD
         m+HjBkXwvxS8zdWdy5056Jvn7Xxg3bpvzh/mJOKLzXpTB9x/HBz0+yuJkDktch4VCxsH
         GvGJqVbBMJjOITChCN19Zo0HDKj+g6A2BiRzgGS5P0/xZMq3n7zhgPFdO35ZSD09Nwdf
         BEYN0h/S1llUEWr0+SsOx4Es8V2WvPQ7u68RogWL0f5PE8YYxMMe2aCTzux7laWZljGu
         ieV8WMKEC9ZoT7RA9S30IEPBojO4LR3SyEgO6mVYNDfPzmcuavwPXtRhBROH0ejqfrd8
         lXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/KQ8YHueVW6xSOKp3yv24P03d+ADDcJB7YEQmb9mmg=;
        b=EX0jyZiU9qk6pNPQNHqdIHS0XhG/rFXxFRfgcCU3QIU1iTgSG992mMi+ug5K+9OXpH
         e94HD3a/vTE0bexixQEon1qUa25zAQLeIF7OiKQXxfJ8vi3ySIX66Xro+aoV8EidS8YN
         IT6Cs7xFlXuDPoMzbJ56qaCp1YgHJc8FkJmEWk1yr91avau7OEBcMCe6rSIjO1plwwtE
         POpBbLsqyJyRBcYzVkCfFwiJ9Esy7QTxl7tgmLQKNHMMdQGsena1CE7bsLet7ylvE/pj
         yR00rFkWhFJkRZmfgkUQlCovKyVZQEpRBC8q0vMy0sWEsmIvAD9jzpJ93v7pAHllsb2U
         JPKw==
X-Gm-Message-State: AOAM533yWG4mZ9SdFeY4ry14UAC+/dxoVumfPA4UT57stdUJHS5NjuSR
        1a9GepMXav7JD2HC9SAnJVBOTEziael3Aw==
X-Google-Smtp-Source: ABdhPJzV8WQP3iWbEJZkRdgzm6KlkmwbKC+xgKzW5mAHKpV4HdWXYWgeV7WU41jxOCXCc16j7tv2lA==
X-Received: by 2002:a05:6808:11c5:: with SMTP id p5mr3709275oiv.94.1632404578620;
        Thu, 23 Sep 2021 06:42:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe? ([2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe])
        by smtp.gmail.com with ESMTPSA id t6sm1291052ots.55.2021.09.23.06.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:42:58 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] dir: extract directory-matching logic
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
 <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
 <xmqqwnn8430s.fsf@gitster.g> <36475af0-1021-f59d-cb33-b3b402c13767@gmail.com>
Message-ID: <a99a58ee-c3fe-501b-3116-8b54eaed0e53@gmail.com>
Date:   Thu, 23 Sep 2021 09:42:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <36475af0-1021-f59d-cb33-b3b402c13767@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2021 9:39 AM, Derrick Stolee wrote:
> On 9/22/2021 7:13 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +static int path_matches_dir_pattern(const char *pathname,
>>> +				    int pathlen,
>>> +				    int *dtype,
>>> +				    struct path_pattern *pattern,
>>> +				    struct index_state *istate)
>>> +{
>>> +	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
>>> +	if (*dtype != DT_DIR)
>>> +		return 0;
>>> +
>>> +	return 1;
>>> +}
>>
>> The function name and parameter list have "pattern" but as far as I
>> can see any "matches" or "pattern" comes into the picture.  The code
>> in the caller after calling this function may be doing pattern
>> matching, but not this one.
>>
>> What this helper is doing is "signal if the pathname in the working
>> tree is supposed to be a directory with the return value, while
>> filling *dtype with what kind of thing it is."
>>
>> path_must_be_dir_in_working_tree() or something, perhaps?
> 
> Yes, a rename would be prudent here. Thanks.

Of course, when I go to amend the commit, the commit message says

	We will expand the path_matches_dir_pattern() method in a following
	change.

which means that more will follow that will actually care about the
pattern and matching as a directory.

After looking at the extension in the next patch, do you still think a
rename is necessary? Specifically, this diff hunk:

diff --git a/dir.c b/dir.c
index 652135df896..9ea6cfe61cb 100644
--- a/dir.c
+++ b/dir.c
@@ -1305,10 +1305,35 @@ int match_pathname(const char *pathname, int pathlen,
 
 static int path_matches_dir_pattern(const char *pathname,
 				    int pathlen,
+				    struct strbuf **path_parent,
 				    int *dtype,
 				    struct path_pattern *pattern,
 				    struct index_state *istate)
 {
+	if (!*path_parent) {
+		char *slash;
+		CALLOC_ARRAY(*path_parent, 1);
+		strbuf_add(*path_parent, pathname, pathlen);
+		slash = find_last_dir_sep((*path_parent)->buf);
+
+		if (slash)
+			strbuf_setlen(*path_parent, slash - (*path_parent)->buf);
+		else
+			strbuf_setlen(*path_parent, 0);
+	}
+
+	/*
+	 * If the parent directory matches the pattern, then we do not
+	 * need to check for dtype.
+	 */
+	if ((*path_parent)->len &&
+	    match_pathname((*path_parent)->buf, (*path_parent)->len,
+			   pattern->base,
+			   pattern->baselen ? pattern->baselen - 1 : 0,
+			   pattern->pattern, pattern->nowildcardlen,
+			   pattern->patternlen, pattern->flags))
+		return 1;
+
 	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
 	if (*dtype != DT_DIR)
 		return 0;

Thanks,
-Stolee
