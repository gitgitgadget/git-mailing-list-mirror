Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347E7C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C1205C9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 14:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRnVp/6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCOO0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:26:35 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36051 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCOO0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 10:26:35 -0400
Received: by mail-lf1-f44.google.com with SMTP id s1so11757848lfd.3
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bhXnLKOdCF3eOtIIzBQtGze/WzgF47eMzFeWDYN7lPk=;
        b=tRnVp/6mOGOmfGrSbRt48sh8orR2gFKCq7kfzSjXqXUkP0hJHjvLu0O0f3uZ/lQljH
         qdTAnwGTxOL6nfDXRSEupaKOarcN2aA0ODSLXzdQnRNCfYQqKeCJHabzH6q5zovfOdSv
         tb5eTq6sww0pZnssEVPagCcPJ0I+aWcSnnteLDhSBEE8tRa0q70MV/3EAZzakzKSGkj3
         R1T/5C6PpGYryGDHiZGh/ybU9pPgwNm9NFC1MDL21ZnHKwdN0Cdi0B8MJ1fafSMXFDQU
         g+oGcM3EPGakbjwnVuAohzbVmdUmkEkNrhb7fkZ74G+H/JUGaNcjfEwZ2lAsbqfhLxPT
         CiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=bhXnLKOdCF3eOtIIzBQtGze/WzgF47eMzFeWDYN7lPk=;
        b=gcNsqZfVC+PtabYsei08eZziUw0YVMwEp395QeTiNSFCR5Yg+ytz6ZbHKDSKI/1Ywo
         clF9p7MmlEUVttAUDLwyI11ta1UyrzD1VRGeDJVavRojo2p4Ab4lYTyzQATovlYVyMG3
         wYIRMGAfTI268Nh57slL6v20EryYSKHIxlV0w4v7ojTwn6Ld9scqSSzavU0VBP3b07qh
         zKD+BKut/pPXBUL4Q1P6G9J9i2P7uwQ00n0jbknhS1W4hx1ZwR7nFRDWvjNvrvN9YT8g
         DWhR14rl7DcONepElBPCP9LlEBS/WpF0mflzZ6bmkOX7riYODUcHoLLvPOIMKu2qtohL
         Ayhg==
X-Gm-Message-State: ANhLgQ0zStoA6nB1yzFJ5eq+Kcza+uidP8v24CyyxtpGH0CT1VmSO6GU
        JJtnYjBzmRuBx78GfTzULQM=
X-Google-Smtp-Source: ADFU+vtWpg+L8xjSw65qP7u9umfGhgUOKpmCrVJj5S3aK2cOveC4CuV6ihzR6YwtMoI3U7Fb7kKQ+w==
X-Received: by 2002:a19:ec08:: with SMTP id b8mr14140769lfa.34.1584282392621;
        Sun, 15 Mar 2020 07:26:32 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id l28sm13019320lfp.85.2020.03.15.07.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 07:26:31 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <xmqqo8t2hfxj.fsf@gitster.c.googlers.com> <86tv2s34lo.fsf@gmail.com>
Date:   Sun, 15 Mar 2020 15:26:28 +0100
In-Reply-To: <86tv2s34lo.fsf@gmail.com> (Jakub Narebski's message of "Fri, 13
        Mar 2020 11:56:51 +0100")
Message-ID: <86zhch7kyz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc:  Abhishek Kumar

Jakub Narebski <jnareb@gmail.com> writes:

> Cc: Stolee, Heba, Jonathan T., Emily Shaffer.=20
>
> Junio C Hamano <gitster@pobox.com> writes:
>> Jakub Narebski <jnareb@gmail.com> writes:
[...]
>>> ### Graph labelling for speeding up git commands
>>>
>>>  - Language: C
>>>  - Difficulty: hard / difficult
>>>  - Possible mentors: Jakub Nar=C4=99bski
>>
>> I am not running the GSoC or participating in it in any way other
>> than just being a reviewer-maintainer of the project, but I would
>> appreciate a well-thought-out write-up very much.
>
> I have prepared slides for "Graph operations in Git version control
> system" (PDF), mainly describing what was already done to improve their
> performance, but they also include a few thoughts about the future (like
> additional graph reachability labelings)... unfortunately the slides are
> in Polish, not in English.
>
> If there is interest, I could translate them, and put the result
> somewhere accessible.

Here it is, traanslated into English, but otherwise almost exactly as I
have presented it on December 2019.  Those slides includes much of
introductory information, so one would be interested probably in few
last slides (the "Future work" section).

  https://drive.google.com/file/d/1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK/view?us=
p=3Dsharing

I will be extending those slides with more information about interval
labeling, and then I will update the file, and I can post it also on
SlideShare (or other site, if one can recommend it).

> Or I could try to make this information into blog post -- this topic
> would really gain from using images (like Derrick Stolee series of
> articles on commit-graph).

This would take a bit, I'll try to do it when I would have some more
free time.

Regards,
--=20
Jakub Nar=C4=99bski
