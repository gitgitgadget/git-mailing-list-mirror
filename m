Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3BCE95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbjJHQMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjJHQMg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 12:12:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F1BAB
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 09:12:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41985082620so9260501cf.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696781554; x=1697386354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnUSyDa88/JYctBDfvH1Ro4ykAcdNfAPKdblviJ2LRI=;
        b=JLr8N7NBQyncmvB49+/p9Ww3AaJeESlY6XdSozgywcbn4qG/EqiXUCxOHDAfa4rlDM
         ++WnMJnxzJGDU5iMSrqWjdojyCVpi+uPmX4r2WtR56Qi4Bj7dCCoXBDrtNoB21Ult3l6
         MkP38CMx2toNoccl3ve3+m5PhXE2iEkjiF0i9Qs0DXDTY/vF6L/YlTwTcgKjKiz7GWI8
         nW8uemFnigMWRdQIv1IcE2VVMjkScKrKPIQjDEv9dGyLFfmLS6kyP/DqQ7e3BK1coi7h
         NU29bEjgSFLo4tgYurPrzMAvT13dKP17xvfeW2kN9Yq5hSkdCNn8Xn50jVkNKnsFPFvZ
         GMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696781554; x=1697386354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnUSyDa88/JYctBDfvH1Ro4ykAcdNfAPKdblviJ2LRI=;
        b=WpAWs+nUcrTLOziCO4kb9iXszrelc0zIRC7ueXLpFpdJ13yBKnUKyyl+agvSXQIPAx
         qGvclXiqemOJxv9ShahDq2Bajdy0TFiSoNZGPFDBtbTl9J3238RRXYk4kzrJRj86Qojz
         sZudAaC1xgbBC6LPFfSoWQCy+lskRDTkH6sZV7djYYzCUek8yIV5aNwSakWBL0eGs3ZT
         t6Ed1oexWHxaJqN2CsGuQ/xwgkkUiqosAt5OmMuRztzCd7Bi4HVb3+jrk1qEUMOqQIbt
         tsEWE9/rqGhZ+t3A4gOUGaBl6jmOyHjhsHctg8e2XDxyJP05iNWNoUWdmsSEBo6BJxsY
         Bk+g==
X-Gm-Message-State: AOJu0YyUCmcD/UemK1YBvkUws9iMMy1fd9nChQ7TFTDOPXtTsKwHX1HF
        rhbrQT7SbdbDcLeotT2wRZk6OBkkw9HMkg==
X-Google-Smtp-Source: AGHT+IFm7GmuaDfpjExx/QofsqnjxHX3Ko6vX0+jhCTh07eOQNg4mI9XdDpZrRrtfrzLoXFe3yekyg==
X-Received: by 2002:ac8:5745:0:b0:412:12e8:8538 with SMTP id 5-20020ac85745000000b0041212e88538mr15235994qtx.1.1696781554090;
        Sun, 08 Oct 2023 09:12:34 -0700 (PDT)
Received: from [192.168.1.240] (ool-4570b665.dyn.optonline.net. [69.112.182.101])
        by smtp.gmail.com with ESMTPSA id a2-20020ac844a2000000b00419cce4a5ffsm2878137qto.82.2023.10.08.09.12.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Oct 2023 09:12:33 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] merge-ort: initialize repo in index state
Date:   Sun, 08 Oct 2023 12:12:32 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <BA926591-DC68-4929-AC20-54B019A43183@gmail.com>
In-Reply-To: <CABPp-BG_cQ011a15HSVRtJDq7MxgqY2_tD8aZm0Qc4F6ZU0NPA@mail.gmail.com>
References: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
 <CABPp-BG_cQ011a15HSVRtJDq7MxgqY2_tD8aZm0Qc4F6ZU0NPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 6 Oct 2023, at 1:14, Elijah Newren wrote:

> On Thu, Oct 5, 2023 at 9:14=E2=80=AFAM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: John Cai <johncai86@gmail.com>
>>
>> initialize_attr_index() does not initialize the repo member of
>> attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=3D<tree=
>"
>> global option to "git", 2023-05-06), this became a problem because
>> istate->repo gets passed down the call chain starting in
>> git_check_attr(). This gets passed all the way down to
>> replace_refs_enabled(), which segfaults when accessing r->gitdir.
>>
>> Fix this by initializing the repository in the index state.
>>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> Helped-by: Christian Couder <christian.couder@gmail.com>
>> ---
>>     merge-ort: initialize repo in index state
>>
>>     initialize_attr_index() does not initialize the repo member of
>>     attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=3D"=
 global
>>     option to "git", 2023-05-06), this became a problem because istate=
->repo
>>     gets passed down the call chain starting in git_check_attr(). This=
 gets
>>     passed all the way down to replace_refs_enabled(), which segfaults=
 when
>>     accessing r->gitdir.
>>
>>     Fix this by initializing the repository in the index state.
>
> Out of curiosity, are the changes in 44451a2e5e and its predecessors
> sufficient to allow us to gut this nasty initialize_attr_index() hack
> from merge-ort?  See the comment at the top of the function and this
> old mailing list thread:
> https://lore.kernel.org/git/CABPp-BE1TvFJ1eOa8Ci5JTMET+dzZh3m3NxppqqWPy=
Ep1UeAVg@mail.gmail.com/.

Honestly, I'm not familiar enough with the attr code to know if the index=
 can be
taken out of the call chain. From first glance, it looks like that would =
take
some additional work, which I agree would be nice to do.

>
> I never wanted to generate an index, Stolee didn't like it either, but
> the attribute code seemed hardcoded to require an index and I had gone
> down enough rabbit holes trying to get merge-ort into shape.  But I
> still absolutely hate this awful hack.

Perhaps a follow up patch series could address this--will keep it in mind=
=2E

>
> If we do have to live with it still, then...
>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-=
1583%2Fjohn-cai%2Fjc%2Fpopulate-repo-when-init-attr-index-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-158=
3/john-cai/jc/populate-repo-when-init-attr-index-v1
>> Pull-Request: https://github.com/git/git/pull/1583
>>
>>  merge-ort.c           |  1 +
>>  t/t4300-merge-tree.sh | 20 ++++++++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/merge-ort.c b/merge-ort.c
>> index 7857ce9fbd1..172dc7d497d 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_o=
ptions *opt)
>>         struct index_state *attr_index =3D &opt->priv->attr_index;
>>         struct cache_entry *ce;
>>
>> +       attr_index->repo =3D the_repository;
>
> Can we use opt->repo instead and reduce the number of places
> hardcoding the_repository?

sounds good!

>
>
>>         attr_index->initialized =3D 1;
>>
>>         if (!opt->renormalize)
>> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
>> index 57c4f26e461..254453fff9c 100755
>> --- a/t/t4300-merge-tree.sh
>> +++ b/t/t4300-merge-tree.sh
>> @@ -86,6 +86,26 @@ EXPECTED
>>         test_cmp expected actual
>>  '
>>
>> +test_expect_success '3-way merge with --attr-source' '
>> +       test_when_finished rm -rf 3-way &&
>> +       git init 3-way &&
>> +       (
>> +               cd 3-way &&
>> +               test_commit initial file1 foo &&
>> +               base=3D$(git rev-parse HEAD) &&
>> +               git checkout -b brancha &&
>> +               echo bar>>file1 &&
>> +               git commit -am "adding bar" &&
>> +               source=3D$(git rev-parse HEAD) &&
>> +               echo baz>>file1 &&
>> +               git commit -am "adding baz" &&
>> +               merge=3D$(git rev-parse HEAD) &&
>> +               test_must_fail git --attr-source=3DHEAD merge-tree -z =
--write-tree \
>> +               --merge-base "$base" --end-of-options "$source" "$merg=
e" >out &&
>> +               grep "Merge conflict in file1" out
>> +       )
>> +'
>> +
>>  test_expect_success 'file change A, B (same)' '
>>         git reset --hard initial &&
>>         test_commit "change-a-b-same-A" "initial-file" "AAA" &&
>>
>> base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
>> --
>> gitgitgadget

thanks
John
