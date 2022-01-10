Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2047C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiAJTBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiAJTBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:01:10 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D1C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:01:10 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bp39so15442625qtb.6
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dA6kOdKOiSwYkKDhihTi/4q7xyNNSQ2GqFO/XDtDkc0=;
        b=fM54zkCX8CGZ5TRCQMrdbDvRU1uecT5TkWP+jF4airHnepASioNrk/K5Jh//Lb40zm
         YtlAN0P4ZkuP31nlhh7Falo1FmbVbOkJoOeDx+Rfe93L8YyyqLVCAGUFD9sIWDbbCfvp
         Qnqjf79G7OmZ/rTCUYyMTnr5HN+7Ia4wfu9Va73FJgZ+w+0FkA4hp8xBHvM4+kK8v80I
         TRJO2jmP5hxq0vbmDc5TcpUwQTLxJN9seuid7zArs4ytQIjnOvh5m29oMQY2wsOstR66
         +E5MXP6LQNdNSu4dXs4M3I9aBs0VnPxeaiySYN/d1xIDKVkWhGu+UdMpLWw5Ojz2oePw
         AOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dA6kOdKOiSwYkKDhihTi/4q7xyNNSQ2GqFO/XDtDkc0=;
        b=G2MDRQ7o2pJP9ZMDVzwKKzt/XuNzge4k38Qk8SiM9xHfoAisaGaQ0IHLBELDtzMQon
         KLSvXHSMvbtQ6PCDstdbq1HcTXJNtDnUhorq+KID3mrBBKWI06cnFjzPoYodq2eWNC/g
         yga8muBxLnpa9pJldmP7FiZ9C3f55PR+oLHO/2cEoX0/eFmGi3mALM+kcm7Z1MFzYipU
         7hIMj0Mojjsnb5y2Wb5p9zpZ42e2L1p3/dAakyDFDA8/lTwaDq+Ju5XgeCxp2aU6pAVp
         kuEUqNxt8AvFbKWmI+DkdRgl65RhDgH5x8+lPEBDSkz17333xTvE2BFNLR78ye4VKczK
         vLKg==
X-Gm-Message-State: AOAM531wAsR9MRmg+W61ggYFlHwVCDA6JDPmD7dAOze6fdgGGI9KJkGx
        ZIvmTjmoCsiU0lcDGidXrwI=
X-Google-Smtp-Source: ABdhPJwZoBn1sHSsLPFsg2Wq+rPqE7d2hFlm1P2HAdeC03E0OacVkwVkbDDk/AkYLu4JGd6XeLg0ew==
X-Received: by 2002:a05:622a:1713:: with SMTP id h19mr981408qtk.464.1641841269693;
        Mon, 10 Jan 2022 11:01:09 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id c7sm5196508qtd.62.2022.01.10.11.01.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jan 2022 11:01:08 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v7 1/2] name-rev: deprecate --stdin in favor of --annotate-stdin
Date:   Mon, 10 Jan 2022 14:01:06 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <A869C5DC-98D0-4093-90ED-5F7933041968@gmail.com>
In-Reply-To: <xmqqo84j1oel.fsf@gitster.g>
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
 <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
 <153f69ea9b6cfc3fff47c91fa237cf97efd6bfae.1641425372.git.gitgitgadget@gmail.com>
 <56FFAD1E-D081-4D13-A12E-DD6807375B69@gmail.com> <xmqqo84j1oel.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc=E2=80=99ing Phillip, as he was the one who made the suggestion to make=
 it hidden

On 10 Jan 2022, at 12:38, Junio C Hamano wrote:

> John Cai <johncai86@gmail.com> writes:
>
>> Hi Junio,
>>
>> ...
>
> Please trim quotes that are irrelevant for understanding what you
> want to say in your message to save recipient's time to find what
> you wrote.
>
>>> +		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text f=
rom stdin")),
>>>  		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `und=
efined` names (default)")),
>>
>> I=E2=80=99ve changed this back to a non hidden bool. I believe this sh=
ould be the last thing needed on this one.
>> Let me know if anything else needs adjustment, thanks!
>
> As I said, my mention of hidden vs non-hidden was not my preferrence
> of non-hidden over hidden, but was soliciting opinions from others,
> so I was a bit surprised to see a reroll to change only that thing
> and nothing else so soon.
>
> But if it is your preference to leave it unhidden for now, that is
> fine as well.  I have no strong preference over the matter either
> way.

I think it makes sense in this first iteration to keep it non-hidden for =
visibility purposes.
Maybe in the next release we can make it hidden before we move it altoget=
her.

>
> I see only Dscho on the CC list, but I have this feeling that he
> wasn't the one who suggested to hide the old option.  Whoever it
> was, if we can get an ack from them, that would be nicer.
>
> Thanks for working on this.
