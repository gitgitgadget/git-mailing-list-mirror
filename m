Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD3C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 14:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiANOJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiANOJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 09:09:07 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81577C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 06:09:06 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z10so6573367qkf.7
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VFJD5Rqt5EDCxesmACkx2LwjwEsRVPwrpprB+ENYzfs=;
        b=TPAFz7bmOULruVetqal0QuV78BRh5xg8aCnGEalqrfgemD/v0TdsT72Twf66N/WEz1
         Yd2eP1VwldxjMO2VtCESHfhzHyaNmhMmUan+Kd7/eGsmRkVk8Vtz1g8U955UIhslEyje
         DGdKju9c4JgM2LEeqroynzpzc0S1nNpqxtEoDxHtu0dodhuD/7q1FYivwgtwkq2KDsDQ
         E4+UC88mw54MlofmUP1J5prffiib5K+uVscFjFHFNaEeJX1cQgQWaP4sKhHy/olMyTAQ
         s5qGyn6mHfXc/vigejd2DfpRbtorCDjhAjhONH0jrldO85buMcqBfJq9OiCtMq0qsOwM
         bjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VFJD5Rqt5EDCxesmACkx2LwjwEsRVPwrpprB+ENYzfs=;
        b=5v+wK4lhLw4b7cbkvMwfZUWVz3E7GxI2wzbFzIYrLUmkqc9D0m18vGsk9HhuiNbxvB
         Je9NNFP8purm5Ynjyo3Msm5vZWfDz2AATWYhNWieGrmtLMCJEjFaDbJ0jvh3spKVDMtW
         N4Rsuro/w3D5WIUXZF9ZtA/tMvTaBO189tvXwU6XnPhEd5QYfjMGsX+xEbE1y/GqZmeT
         ByvEFaWvzwcjq6gbWHjAYGgD0/QAYGLqH71Zc4iTyP27SOPFcqKc1SkhpGiEx2sKLfsN
         HHkvM4q5yXuIsrq+caK9HAeP5oI2gYlmiDnxSSD/4rwGm/ZeQ31pgdnigQOUVeqzkXS4
         AWvQ==
X-Gm-Message-State: AOAM533gnMriy0Gr43Co/ZOBEc3nI0Br1i2IkHWLsFpQ1gSIJeMWujQG
        GYs4VchJc9/36GBPE/Vwb7M=
X-Google-Smtp-Source: ABdhPJxsQnL3XY5+2zaMGfNKhEKEXQtyKv5JnNVN2mCXIabuaGTjsAQdUXNxlbP3sa8vZhXBlI2otw==
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr6610414qke.324.1642169345405;
        Fri, 14 Jan 2022 06:09:05 -0800 (PST)
Received: from smtpclient.apple ([204.148.24.254])
        by smtp.gmail.com with ESMTPSA id k8sm3932032qtx.35.2022.01.14.06.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 06:09:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   John Cai <johncai86@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
Date:   Fri, 14 Jan 2022 09:09:03 -0500
Message-Id: <ACAECB82-3F1C-4731-BF23-A316EFE82FB5@gmail.com>
References: <8d19623b-4b11-8ecc-8f27-17ad4ba4167a@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Tilman Vogel <tilman.vogel@web.de>
In-Reply-To: <8d19623b-4b11-8ecc-8f27-17ad4ba4167a@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: iPhone Mail (19B74)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 13, 2022, at 10:14 PM, Philippe Blain <levraiphilippeblain@gmail.co=
m> wrote:
>=20
> =EF=BB=BFHi Junio,
>=20
>> Le 2022-01-13 =C3=A0 19:00, Junio C Hamano a =C3=A9crit :
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Here is how I would explain your change.
>> This topic is in "Expecting an ack or two" state for some time.
>>  - Philippe, are you OK with the attached patch?  If so throw your
>>    Signed-off-by to this thread.
>=20
> I'm not 100% OK since as I remarked to John in [1], I don't think all 4
> tests are necessary, 3 out of 4 are duplicates of existing tests, and I
> would have put the new test in t5520 with 'git pull's other "autostash"
> tests. I hoped that John would incorporate my suggestions in a v2, but he
> seems to be busy, so I'm including an updated patch at the end of this ema=
il.
> I only slightly edited the commit message you wrote, so thanks for that.
> 'pb/pull-rebase-autostash-fix' could be replaced by the patch below,
> I would think.
>=20
>>  - John, if you find Philippe's implementation a good idea (I think
>>    it is, as it is simpler and cleaner) after reading and
>>    understanding it, please throw an Acked-by or Reviewed-by to this
>>    thread.

I agree-think Philippe=E2=80=99s implementation is a better solution.

I don=E2=80=99t have the bandwidth these couple of days to reroll the patch s=
o if someone else can take over that would be great!

>=20
>=20
> Thanks,
>=20
> Philippe.
>=20
> [1] https://lore.kernel.org/git/fe0b7337-3005-d09c-a3b6-65a100799676@gmail=
.com/
>=20
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> =46rom 28edde4e302e14c900e314268e4eeaeadc240bcb Mon Sep 17 00:00:00 2001
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> Date: Thu, 13 Jan 2022 21:58:05 -0500
> Subject: [PATCH] pull --rebase: honor rebase.autostash when fast-forwardin=
g
>=20
> "pull --rebase" internally uses the merge machinery when the other
> history is a descendant of ours (i.e. perform fast-forward).  This
> came from [1], where the discussion was started from a feature
> request to do so.  It is a bit hard to read the rationale behind it
> in the discussion, but it seems that it was an established fact for
> everybody involved that does not even need to be mentioned that
> fast-forwarding done with "rebase" was much undesirable than done
> with "merge", and more importantly, the result left by "merge" is as
> good as (or better than) that by "rebase".
>=20
> Except for one thing.  Because "git merge" does not (and should not)
> honor rebase.autostash, "git pull" needs to read it and forward it
> when we use "git merge" as a (hopefully better) substitute for "git
> rebase" during the fast-forwarding.  But we forgot to do so (we only
> add "--[no-]autostash" to the "git merge" command when "git pull" itself
> was invoked with "--[no-]autostash" command line option.
>=20
> Make sure "git merge" is run with "--autostash" when
> rebase.autostash is set and used to fast-forward the history on
> behalf of "git rebase".  Incidentally this change also takes care of
> the case where
>=20
> - "git pull --rebase" (without other command line options) is run
> - "rebase.autostash" is not set
> - The history fast-forwards
>=20
> In such a case, "git merge" is run with an explicit "--no-autostash"
> to prevent it from honoring merge.autostash configuration, which is
> what we want.  After all, we want the "git merge" to pretend as if
> it is "git rebase" while being used for this purpose.
>=20
> [1] https://lore.kernel.org/git/xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.googl=
e.com/
>=20
> Reported-by: Tilman Vogel <tilman.vogel@web.de>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> builtin/pull.c  |  7 +++----
> t/t5520-pull.sh | 13 +++++++++++++
> 2 files changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1cfaf9f343..9f8a8dd716 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1036,14 +1036,13 @@ int cmd_pull(int argc, const char **argv, const ch=
ar *prefix)
>        oidclr(&orig_head);
>      if (opt_rebase) {
> -        int autostash =3D config_autostash;
> -        if (opt_autostash !=3D -1)
> -            autostash =3D opt_autostash;
> +        if (opt_autostash =3D=3D -1)
> +            opt_autostash =3D config_autostash;
>          if (is_null_oid(&orig_head) && !is_cache_unborn())
>            die(_("Updating an unborn branch with changes added to the inde=
x."));
> -        if (!autostash)
> +        if (!opt_autostash)
>            require_clean_work_tree(the_repository,
>                N_("pull with rebase"),
>                _("please commit or stash them."), 1, 0);
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 93ecfcdd24..3e784f18a6 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -330,6 +330,19 @@ test_expect_success '--rebase --autostash fast forwar=
d' '
>    test_cmp_rev HEAD to-rebase-ff
> '
> +test_expect_success '--rebase with rebase.autostash succeeds on ff' '
> +    test_when_finished "rm -fr src dst actual" &&
> +    git init src &&
> +    test_commit -C src "initial" file "content" &&
> +    git clone src dst &&
> +    test_commit -C src --printf "more_content" file "more content\nconten=
t\n" &&
> +    echo "dirty" >>dst/file &&
> +    test_config -C dst rebase.autostash true &&
> +    git -C dst pull --rebase  >actual 2>&1 &&
> +    grep -q "Fast-forward" actual &&
> +    grep -q "Applied autostash." actual
> +'
> +
> test_expect_success '--rebase with conflicts shows advice' '
>    test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
>    git checkout -b seq &&
>=20
> base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
> prerequisite-patch-id: 3c6b4be75d7a634bf45f0264b3f04216818a0816
> --=20
> 2.29.2
