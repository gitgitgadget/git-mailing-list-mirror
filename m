Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F456C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 07:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3EC206F6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 07:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="K/EqUsVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGGHSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGHSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 03:18:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A5C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 00:18:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so19586613pgb.6
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 00:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=vc5uZPBSmYt4L0iP0Ue9aBsycffXoHjcjeaum44rjvM=;
        b=K/EqUsVj2S0Gt7oxEpr2t0bMAhHYBj7KqR0UzJILRCd3U49rEYK5YzLxk7R90SLLo0
         UURS/zs+6GXwFendoXAPOYWX08LFZrBJh6y3lM4PEVFueSFAWStuwJE+uG7jvBKbNBLA
         L5A/sDRAJ4NL+BoyCNTCG+VYRj4y/M/cjFoS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=vc5uZPBSmYt4L0iP0Ue9aBsycffXoHjcjeaum44rjvM=;
        b=N9Q6BLgq5lfghDlh+YAWqBfpy2r/CR+3dQeP2MlUlKkIGKiutoB8Orelytp3zDl3rD
         RkksqwLuGzBkBBPmOfd441STeDMnXntW6czS+nOPfAwhLRzX38La8K7lUP3heikQGZXa
         YaRluuYQ7Pr3tXSbWZdDwrkQZpoDNC0JF/QbQ/oi7lIprdExZgJuIKXQGOUjrKqBDZKd
         wbK9f/8laPpJNcmN7uud3ytlpksdevsEpe6dZHbwrDwxzaEos5ifW0ueNSAge0e3kidz
         3dC1FKD29ZdzaVXUYCkK7fL0mMOFo9EMJtrn+pBa98hp3H4OntLeRd6JZPf1Lu105h0v
         3fGA==
X-Gm-Message-State: AOAM532swvzf5ijCTNd4Z/Kd1YSMaHA3DGPon77LBIYhVGGfCrOrS23b
        Yk7aGrYKYrm7E7WdJ/rdmu5BU6qFryCpU+mZWzdYMtDjFvuhzoh98Pvd2tstb4LbwTfPnUWFi9Y
        o66LI3MwmMwUQnJ4/1o78jjRUv0fAiADjT94Fdto2rmoq7ba1ui+7s81CoA==
X-Google-Smtp-Source: ABdhPJzNScy28s3Nm9M+R1ygA8dLDbxc7mEzgVP1nzy+cjD8MZvuVQ8FbMVEM+HFCCOI/+aVGUiqeQ==
X-Received: by 2002:a63:e241:: with SMTP id y1mr21799072pgj.410.1594106328595;
        Tue, 07 Jul 2020 00:18:48 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id oc6sm1698445pjb.43.2020.07.07.00.18.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:18:47 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
Subject: [PATCH v10] Support auto-merge for meld to follow the vim-diff behavior
Date:   Tue, 7 Jul 2020 15:18:43 +0800
Message-ID: <006501d6542e$daef4130$90cdc390$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZULo0vtxcNaWG8SROTK0QImsJW0w==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

The [PATCH v11] is uploaded, it correct the misunderstanding in preview =
patch.
https://lore.kernel.org/git/pull.781.v11.git.git.1594106024078.gitgitgadg=
et@gmail.com

Please review again, thank you so much.

Regards
Lin

