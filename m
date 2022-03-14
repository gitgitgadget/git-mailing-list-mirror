Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E450AC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 14:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiCNOMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiCNOMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 10:12:30 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E313F83
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:11:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id n11so7545968qtk.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+Ay2kF64sg1KfndhDFI8ba+lEX9YyPA9UuhKpjm/cY=;
        b=m7hvctE0CM3YIXKvL53yNKeawi1gD2OCnQt7Nj2X3v+wW9C/tfNNI1ibmxdlHVAw50
         deLNgcb64LqhLj46FPFngXrL9jFetrVCrz1GYYl38VJrHV05eqtAaPFwxqmZVtZa+GJ4
         H0JjpOUzwcCLppKc9B3pjIFvpurSRSgNx6BVCVlmmlTfLhHK65GnFEp1p6+oO8ji0DEo
         pLDq9Fs72lZTnlYrWG6sx+WQpoMj4s2TU4rnWbtZZaAaojN1yjGXi7EF44N28jhGmEkK
         pHCXrGGV3SWnf+YcOrGWP7IGg1+hd0vmwnseDg1Ky96PVxbIJkhxUxAbKdjDal6jGwSd
         S6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+Ay2kF64sg1KfndhDFI8ba+lEX9YyPA9UuhKpjm/cY=;
        b=Ik4yF1gkZXBYV1uykuPkNIiDoCbVmtezYxUTSOy3QXEBq5o6lxwVejBxdLWbY/2khQ
         fm24mSEmTymfJMfQUXeBLLGpCpqvEO1Ct/69jb2wm7KK7irvIJetdRhWbORIq1vqrSRk
         Uma5u7gjrt5xPEm01j5MzTlhfIQxfMGYV/UDNzpAczs2QnRCCs9/N00p7Q5s+nQ/rMGp
         0EVhyZ8rwG/RRxVFuYbX8IucZCpH3fzJwri6GaTXiAy5TvCZgH5EZJbBUwV3sWm2tW+6
         fNsKgmuoopAxpw7w1GP0Dhd1y+eRNF02q2c53wls7ifLTBcsNVvuh33XNxEaH7ia3/ba
         RwzQ==
X-Gm-Message-State: AOAM530wGGu+e1M7Z3PfHeDoSgXiJtCwu4DJMl//4YlVA+KzcJ1LZuBL
        x5eVb4CwHAM+NjtsNmAh8WQ=
X-Google-Smtp-Source: ABdhPJxesV9A2TeI1/chb7Tl9R/UOzzzRAgCO9nVaNcQz32PypFpSciG/f2vIIXGepPWA4rv9WI0uw==
X-Received: by 2002:ac8:7dd5:0:b0:2de:adc0:d7f5 with SMTP id c21-20020ac87dd5000000b002deadc0d7f5mr18854328qte.105.1647267079478;
        Mon, 14 Mar 2022 07:11:19 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id 75-20020a37044e000000b0067d47fb5aa4sm7298199qke.63.2022.03.14.07.11.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:11:19 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Date:   Mon, 14 Mar 2022 10:11:18 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <4313B834-90B4-41B3-B810-746EF91F8BBB@gmail.com>
In-Reply-To: <xmqq7d8ywaf0.fsf@gitster.g>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
 <xmqq7d8ywaf0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 13 Mar 2022, at 3:58, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/reset.c b/reset.c
>> index e3383a93343..f8e32fcc240 100644
>> --- a/reset.c
>> +++ b/reset.c
>> @@ -101,6 +101,9 @@ int reset_head(struct repository *r, const struct =
reset_head_opts *opts)
>>  	if (opts->branch_msg && !opts->branch)
>>  		BUG("branch reflog message given without a branch");
>>
>> +	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
>
> It's just style thing but it probably is easier to read to have
> an extra () around the bitwise-&.
>
>> +		BUG("attempting to detach HEAD when branch is given");
>
> I wonder if there is a valid use case NOT to use RESET_HEAD_DETACH
> when switch_to_branch =3D=3D NULL.  If there isn't, it could be that
> we can get rid of RESET_HEAD_DETACH bit and base this decision
> solely on switch_to_branch'es NULLness.
>
> But that is totally outside the scope of this fix.  I'd prefer to
> see a narrowly and sharply focused fix, and to be quite honest, I
> would be happier if this assertion weren't in this topic.

I'm okay with taking this out, but would be good to get an ack from Phill=
ip.

>
>>  	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ER=
ROR) < 0) {
>>  		ret =3D -1;
>>  		goto leave_reset_head;
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 0643d015255..d5a8ee39fc4 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -394,6 +394,15 @@ test_expect_success 'switch to branch not checked=
 out' '
>>  	git rebase main other
>>  '
>>
>> +test_expect_success 'switch to non-branch detaches HEAD' '
>> +	git checkout main &&
>> +	old_main=3D$(git rev-parse HEAD) &&
>> +	git rebase First Second^0 &&
>
> Good.  For reproduction, the fork-point "First" does not have to be
> a raw object name.  "Second^0" not being a branch name does matter.
>
>> +	test_cmp_rev HEAD Second &&
>> +	test_cmp_rev main $old_main &&
>> +	test_must_fail git symbolic-ref HEAD
>
> All correct and to the point.  Good.

Thanks to Phillip for his help on this!

>
> Will queue.  Thanks.

More of a question about protocol. If there are some minor adjustments th=
at are
not really worth more disussion on the ML (like removing the BUG assertio=
n),
is it still protocol to send another series or just re-roll on the branch=
 without
sending out another patch series?

Thanks!
John

>
>> +'
>> +
>>  test_expect_success 'refuse to switch to branch checked out elsewhere=
' '
>>  	git checkout main &&
>>  	git worktree add wt &&
