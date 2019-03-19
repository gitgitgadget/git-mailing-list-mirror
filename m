Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992AF20248
	for <e@80x24.org>; Tue, 19 Mar 2019 04:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfCSEIy (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 00:08:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38270 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfCSEIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 00:08:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so19384773wrm.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qsaDhqu4yDAxOGsqfjT40K/gwuAwGpCj6ZhfMsj0XS8=;
        b=banBPOYxkxyCifc6GgMM0hgV0jVb+E7T2N/KPr3awHJ8zshzxzD3/7en/+7tyMToCB
         73QuG1liQs8asLtIuF7XllKR0PUtEKwCcDW/Uh+af77SAGROk0QPSwzYx0LBqlGys66e
         EbrUoZO2mcUFr0BfkCcBGS02LltmEKDt5+Kt9hND8tuWlcOvqXi5v3VYnBx+CoIclZJf
         Wu0XIhFNJf2B/V6wRXCW/7UPFhdvMFbNuYHxgSXumspreeTKKJ4FO+Z7wtBNlEMtdqLD
         AzQeBE0NfposaGlQ7yZAHVtcg90wpoBd4yT3mPBNsvpfrHpeVNtfJVnx1QNdRw3C3/fR
         wKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qsaDhqu4yDAxOGsqfjT40K/gwuAwGpCj6ZhfMsj0XS8=;
        b=DtbFUX7j9WUMFiXmRbTX0Z1VHJC5rYBVvhtO3seIUm8ucgVCaGgXOgii39XVuC/ox0
         M2J9xXjGHRDlITFrwzg+QWfioCZ1mLemCJJW+T23PNF8tvqpbIF1r+irMpz0o/YyZQS1
         SiJP36ljj4clNpHE0N5TMtOfuqkgIpxLayrWFp583SeitHKjjqNXOdBJJ0/ZDYNFmoQx
         X7XOUtqR/3/BPVm4QgUlJXlGxLSDM6k+kKdwENGeRzKisWK6KfKdr+9Xr5fmdLduIlQt
         YBjP8ER3g7wg5D88SYnvCBrj7Se22oBkqiSOTyo92Pbse8bmYR96+YnhDD4RX7IMCgSv
         1bvg==
X-Gm-Message-State: APjAAAWGbBPsEUBgOwaRJDWDxvB0N2ilBbwPWIPdAwZ/PJty8zmapQvJ
        VjxL0tIMx4eD1S7P3cGEQSU=
X-Google-Smtp-Source: APXvYqxcblt+jAf3L4VEm1SCSIJa4Tz4Ql0s5mgvE4YOG7rpA3yofO7BC0P4p8Q7mJKoLd9uZkDwwA==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr8529437wrm.302.1552968531775;
        Mon, 18 Mar 2019 21:08:51 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id m24sm646165wmi.46.2019.03.18.21.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 21:08:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] midx: verify: group objects by packfile to speed up object verification
References: <pull.166.git.gitgitgadget@gmail.com>
        <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com>
        <87pnqodvr9.fsf@evledraar.gmail.com>
        <9c4da72d-6066-8d05-f181-a93c3926705f@jeffhostetler.com>
        <87lg1bet9d.fsf@evledraar.gmail.com>
Date:   Tue, 19 Mar 2019 13:08:50 +0900
In-Reply-To: <87lg1bet9d.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 18 Mar 2019 23:02:06 +0100")
Message-ID: <xmqqmulry08d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>>> +	if (a->pack_int_id < b->pack_int_id)
>>>> +		return -1;
>>>> +	if (a->pack_int_id > b->pack_int_id)
>>>> +		return 1;
>>>> +
>>>> +	return 0;
>>>> +}
>>> ...
>>> succinct subtraction idiom of e.g. (in this case):
>>>
>>>      return b->pack_int_id - a->pack_int_id;
>> ...
>> On 43+M objects, your version is a hair faster, so I might
>> as well take it instead.
>
> Cool!

Yup, following a well-known short idiom lets readers' eyes coast
over without forcing them to make sure the two if statements have
comparison going in the right direction and return the constant with
the right sign, etc.  Even if the idiomatic version weren't faster,
it is worth using it.

Thanks.
