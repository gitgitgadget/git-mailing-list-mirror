Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF9C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiCHWag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbiCHWae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:30:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3421958E45
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:29:37 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso341126pjq.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OU1fZz5kv+rjfwuCsl2+pMwUt+cuZblODSKs5wqVT1E=;
        b=I9kqPMF0WDh0SBM8z+Z/QAMHehV6hCc79mT92KR3sJEPFmIhoY1gaOrFBYHelyiWQz
         +W+j7p40r3Q6bL42YOV102o3Cu3lvBftjjegz+m1QC6VgHy+zsBBe9i5aNy//aBZuHAA
         jcRN6QkMqZrX7ZScYtvzCy0dFRktm45BQYBS1bL6I+VRBRdvB1FEfWuBCkdWaLChviAm
         kvRItXhV1CWrvDhUEdsodf6sifpRqOolONL3yU5C9LD+AE80kO7InfCtznZ6krkrRglQ
         /E8+o7OOD5bkA/0cycH/CjHhLpl2ys84E6+SSaeO8Hh//TvIj7xfgTeMSvBTIt3GxKSg
         MVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OU1fZz5kv+rjfwuCsl2+pMwUt+cuZblODSKs5wqVT1E=;
        b=fL43dIvhMp86Gj0Q3EYj4AggjaXCJIHFcKH+rZPKopWcJ8PcLQKSnu0MUrhUJ8TWa8
         eA1qEtWtvE6xT/+/2xNw+gN2el3k7frYgqhL5RnhGMQLoDQmz1OEYLMFRelG3zhPeX3F
         PmbE0/H3WLi1WjvBd0JyrXBhveNCVYyU9qGwdVXPDtQ/g7i0BfiOnynSEI3qTRNjXdjc
         Tf91QiPkJsOYBII8+s+t4zPbbCsRWWBNt3kyL+MhHi+YgbsZOwg/QrxIOI1ET24+jf3C
         RM84cQuE1a0SDpO9KOIY5Iaxf6mcv1BFJLY5XPF1BEJZk7H7jmWshSkkbum8vwOzq2iP
         2f8A==
X-Gm-Message-State: AOAM532sSgmRnm+rYXkOoIhpfURUNJ+ZvUfopLkQOj7UG1UbMnUDw6VH
        508xpmVcADPAwGttYD+ffSuA370jdIjY8Q==
X-Google-Smtp-Source: ABdhPJyJ8VDecjTucrb1ZQDR4EYQkCa5idUzjdN0mRF57fa9YXSOboBKMda2Q689B66zWHl4v6lR7OLUjKx47g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b709:b0:151:49e7:d4e1 with SMTP
 id d9-20020a170902b70900b0015149e7d4e1mr20259408pls.144.1646778576664; Tue,
 08 Mar 2022 14:29:36 -0800 (PST)
Date:   Tue, 08 Mar 2022 14:29:32 -0800
In-Reply-To: <kl6lee3c5bzl.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lbkyg5b8z.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
 <20220301002613.1459916-1-emilyshaffer@google.com> <20220301002613.1459916-3-emilyshaffer@google.com>
 <kl6lee3c5bzl.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 652861aa66..59dffda775 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -449,6 +449,9 @@ cmd_update()
>>  			;;
>>  		esac
>>  
>> +		# Note that the submodule is a submodule.
>> +		git -C "$sm_path" config submodule.hasSuperproject "true"
>> +
>>  		if test -n "$recursive"
>>  		then
>>  			(
>
> This hunk has a textual conflict with 'ar/submodule-update reroll pt
> 2', but the fix is easy - just teach "git submodule--helper update" to
> set the config in C.

From our dicussion (offline), it turns out this statement isn't really
correct because we do set the config in C, but we do it in clone_submodule():

   diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
   index c5d3fc3817..92986646bc 100644
   --- a/builtin/submodule--helper.c
   +++ b/builtin/submodule--helper.c
   @@ -1839,6 +1839,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
       git_config_set_in_file(p, "submodule.alternateErrorStrategy",
                  error_strategy);

   +	/*
   +	 * Teach the submodule that it's a submodule.
   +	 */
   +	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
   +
     free(sm_alternate);
     free(error_strategy);

>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 11cccbb333..422c3cc343 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>>  	)
>>  '
>>  
>> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
>> +	(cd super &&
>> +	 git -C submodule config --unset submodule.hasSuperproject &&
>> +	 git submodule update &&
>> +	 git -C submodule config submodule.hasSuperproject
>> +	)
>> +'
>> +
>>  test_done
>
>
> I think there is a gap in the test coverage. I notice that this doesn't
> test that we set submodule.hasSuperproject when the submodule is cloned
> for the first time with 'git submodule update'. I thought that maybe the
> test for this was here...
>
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index 40cf8d89aa..833fa01961 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -115,6 +115,10 @@ inspect() {
>>  	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
>>  	git -C "$sub_dir" update-index --refresh &&
>>  	git -C "$sub_dir" diff-files --exit-code &&
>> +
>> +	# Ensure that submodule.hasSuperproject is set.
>> +	git -C "$sub_dir" config "submodule.hasSuperproject"
>> +
>>  	git -C "$sub_dir" clean -n -d -x >untracked
>>  }
>>  
>
> But when I removed the "set submodule.hasSuperproject in submodule"
> line, i.e. 
>
>  		git -C "$sm_path" config submodule.hasSuperproject "true"
>
> t7400 still passes.

So we would expect that newly cloned submodules would pass even without
this .sh line.

I don't think we need to do this twice in C and in shell. We can move
this line:

   +	git_config_set_in_file(p, "submodule.hasSuperproject", "true");

into run-update-procedure (and out of clone_submodule()). This way it's
guaranteed to touch every submodule (newly cloned or not).
