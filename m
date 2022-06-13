Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F82C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 23:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiFMXJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFMXJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 19:09:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593731505
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:09:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id u6-20020a63d346000000b00407d7652203so2113571pgi.18
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=XOHl/e0zlACmW/nl41jgsBXV5NG/JnRcL8QFgfqnv7w=;
        b=FnsDXWJFEeEwMsRMEqsNQPMOA9z70c0pO9WfvmyDEMcoJSehARileXsasUmxQ69Crw
         VUwxEMGuZAkvJZkLjUM3YiMbYEfgyfSy/jl5XQ7SAvvnKxu6h4fjtzeO2vNAbPAxOpqQ
         2M0QnCif+SiQbNZhIxXIPP3eJI5c5NZ/LZYVgiUeE6VVxjqe+zu7j0T3L+JRBQK8WXT3
         l2/9lOY6mKxyFACv5U3UeIkY77QlDVtEGNQ6NmuLUX+XiG/bnqAFGZQ+qIyjiOlNBKNg
         dERFyK2mb38Wfa+NpnNgP6DwpLv4MqF8mN9+Pz56jpfMQLhSKXfxHw4mB+KC24tWvuKb
         01Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=XOHl/e0zlACmW/nl41jgsBXV5NG/JnRcL8QFgfqnv7w=;
        b=kD6vlyC7wLtfrOmebqHzBNsRhycp+R6WEMkCGJfxLbQFnifC1FlQQkXgoAPpFZ0OOD
         bToYWQM8aIjNvtOGj9ZbnXaJGtXuIcDY2QzZHh+btY5kJo5903uqbUhVyhj9i1l8xfrw
         dXndNJVRG5SSvmcWlwPFDqDlutOh+R/JK/vDGVIxFPXAQ3reoxw/r4pvg1ruOUQ+65vC
         yDupypBNpWRu7ebp68SLSzHizMLfD/fEKue82Ff68IHkE6ix39OPCDYoEoZG6y1FscJV
         /vgIL/iGloTbgMSS7wdrKSI7pkKRvRzQ5fdZs2kqvkBfhr7buBr8P6kW2CMw9bYr420Q
         hmCA==
X-Gm-Message-State: AJIora++8lb2DfUbgIrNbIe+wthGrqv4Tgus6CqHJ4s3znQWtvo3jJ4X
        K4V9NyAdbHApMNRJafqdL50LXlLPcyKStA==
X-Google-Smtp-Source: AGRyM1too7rVflWhN61ZMNnqwIyh1BysJAvlAzpomsJ13x2zZ0e6NUy6i7B26El5BaaE9KY7O7ISbcvFG1Qbfw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b592:b0:168:b8ee:8166 with SMTP
 id a18-20020a170902b59200b00168b8ee8166mr1320764pls.156.1655161769724; Mon,
 13 Jun 2022 16:09:29 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:09:27 -0700
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6lwndk5ffc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 00/12] submodule: make "git submodule--helper" behave
 like "git submodule"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks! I'm happy to see this happen regardless of whose patches we use
:)

Reading the cover letter, I think it probably makes sense for this to
supersede gc/submodule-update. I haven't really looked at the changes
yet though, but I will soon.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Here's a way of breaking apart the work that makes sense to me:
>>
>> - Reuse the patches that prepare git-submodule.sh for the conversion,
>>   particularly 1-7/20 (create a "case" dispatch statement and its
>>   preceding patches).
>> - Keep my series that prepares "update", since that's the most tedious
>>   one to convert. If I don't dispatch to the "case" statement, I don't
>>   think it will even conflict with the preparatory series.
>>
>>   Some of your patches make more sense than mine, and I'll incorporate
>>   them as necessary :)
>> - Dispatch subcommands using the "case" dispatch, including "update". We
>>   might have to do this slowly if we want things to be easy to eyeball.
>> - "git rm git-submodule.sh"!
>
> Hopefully there's no stepping on toes here, but I thought I'd send
> this out now (I went back to the laptop) to avoid the duplicate work,
> since I'd already attempted combining the two, and this is the result.

Fortunately I hadn't resumed work on this yet, so it works out :)

>>> Brief commentary on my patches, details in commit messages:
>>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (20):
>>>   git-submodule.sh: remove unused sanitize_submodule_env()
>>>   git-submodule.sh: remove unused $prefix variable
>>>   git-submodule.sh: remove unused --super-prefix logic
>>>
>>> I removed a bit more dead code here than yours.
>>>
>>>   git-submodule.sh: normalize parsing of "--branch"
>>>   git-submodule.sh: normalize parsing of --cached
>>>
>>> This & various other prep commits (hereafter "easy prep") make
>>> subsequent one-time conversions of whole cmd_*() easier.
>>>
>>>   submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>>>   git-submodule.sh: create a "case" dispatch statement
>>>
>>> easy prep
>>
>> This would all make sense in a preparatory series, with the exception of=
=20
>> 3/20 git-submodule.sh: remove unused --super-prefix logic.
>>
>> We have several instances where we invoke submodule--helper directly
>> with --super-prefix, e.g. inside sync_submodule():
>>    =20
>>     if (flags & OPT_RECURSIVE) {
>>       struct child_process cpr =3D CHILD_PROCESS_INIT;
>>
>>       cpr.git_cmd =3D 1;
>>       cpr.dir =3D path;
>>       prepare_submodule_repo_env(&cpr.env_array);
>>
>>       strvec_push(&cpr.args, "--super-prefix"); /* Here */
>>
>> I even have a (as of now private) patch that replaces "update"'s
>> --recursive-prefix with --super-prefix.
>>
>> This probably wasn't caught in the tests because this only affects how
>> we calculate the submodule 'displayname'.
>
> This is still in this series as 02/12. I think you've misunderstood
> that code, it *is* invoking "git submodule--helper" with
> "--super-prefix", but the option is passed as:
>
>     git --super-prefix <path> submodule--helper
>
> And not as:
>
>     git submodule--helper --super-prefix <path>
>
> This is thus handled by other code before builtin/submodule--helper.c,
> and it doesn't need to handle it.
>
> But anyway, this is confusing, so I updated the commit message (seen
> in the range-diff below)>

Ah that's right, I forgot that we have to pass it to "git" directly.
Thanks.

I wonder why we ever needed this. 89c8626557 (submodule helper: support
super prefix, 2016-12-08) doesn't really explain it, so it looks like
I'll have to dig around the ML.

>>>   submodule--helper: have --require-init imply --init
>>>   submodule--helper: understand --checkout, --merge and --rebase
>>>     synonyms
>>>   git-submodule doc: document the -v" option to "update"
>>>   submodule--helper: understand -v option for "update"
>>>
>>> not-so-easy prep for "cmd_update()"
>>>
>>>   git-submodule.sh: dispatch "update" to helper
>>>
>>> Full cmd_update() migration in one go.
>>
>> Yeah, and since it's not-so-easy, it probably makes sense to continue to
>> keep my series around. I'll borrow some of these patches if that's ok :)
>
> The proposal in *this series* is to leave this aside for now, but
> generally I wonder what part of it you find not-so-easy.
>
> Personally I find it much harder to carefully review the way you
> proposed to do it, i.e. to "buffer up" options that we "don't handle",
> but actually need to sort-of handle, as we'd still like to die if we
> have unknown options.
>
> Particularly since shellscript quoting etc. is a pain with that sort
> of thing, as it doesn't have any real list or key-value
> datastructures.
>
> Whereas getting it to the point where we're clearly just passing
> options as-is through beforehand, and then simply dropping the wrapper
> is, I think, much easier to review. You only need to trust or check
> that e.g. "git submodule--helper update" also supports a "--progress"
> option or whatever, and/or that we've got coverage for it.

Makes sense. I suppose we don't have to overthink the conversion because
we will have to make the leap of faith to C at some point.

