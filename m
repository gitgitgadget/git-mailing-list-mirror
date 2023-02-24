Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F88C7EE2E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBXRDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBXRDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:03:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752A16328
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:03:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y2so12820345pjg.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI+WJI+X22fYmMbJtwVO9SLJkUQ4OeBjsnGxp5TAmqw=;
        b=OZ7Ci9N9lhAFG/qYgnOa/5ujRkc/nvI9gE4cogTgh6wDlsR1tuqHMNgReH34qcamhB
         Ue6qzz1qnPsERrQFhLp+K+oXjEjkc+RtDavAjqN8K3pnO9c3n3l75zU952grP7cRLS+Y
         8LzGH65iTDWfTUdvCJo8NEB+a/Ui7zyTpwZ/NCK3YMVYCMGP9/tWIq9idfBDhi05pp8H
         G5Zb/hG2aiOa5cZPV4NzXY5SNpqBlMXnbZ+kwDbYCT/QZg4X/F/ddDMBc6c7V8wKynbu
         FL86hoo6Q3cHcZ7SRJhUrpRhyapV6a08FSTltvZEK6OSJx8di0uI4sxivInysuvIKiqP
         FGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bI+WJI+X22fYmMbJtwVO9SLJkUQ4OeBjsnGxp5TAmqw=;
        b=H4Jj//Bjzh/g0iXb0UT8qu3hOgtSCDzX2czVIrH9VFm42O2U2Kj89rUKxmqrV6HZxb
         bXEQbQZTcS0KOvf+H4fxmUlc3dFsOSJDHJ2tMwKVWHsC1+m+cRJNaU6RDOIpJz0fGlbw
         IrbGFsMCXhFJIcyRXFyjb4DjEJWDBFRY+IPRza7q2/IwoJSE8lqOMEPn+51WFGYp6lvY
         BypwOtaQvy+nl+MXiTWHC2D1l093p44P5WEiPP83MmnwOl+QjjZCCiXJG7efYQa06Ill
         6Lq3ji7MiZm7BF9RdMZOF+FlE0UZJN7blwLUBfRqZ/3z/a9ary0CR1QzKzPVvrXk10vm
         cIMg==
X-Gm-Message-State: AO0yUKXywzGdj0Fro6VmiFPAkJDUIExXqqWt/W/65bNfBlMmri0ZouP+
        EuNnclcwHj5gN8E9cyOQSWI=
X-Google-Smtp-Source: AK7set+mniypU/zcwZ16nXDqm3N6tsj7k9l9AafiFPZSSMip7R4MbMCd3sxSaCITa7mXly2mkSvi7A==
X-Received: by 2002:a05:6a20:bfc5:b0:cc:1ec7:45e5 with SMTP id gs5-20020a056a20bfc500b000cc1ec745e5mr5332521pzb.35.1677258201000;
        Fri, 24 Feb 2023 09:03:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id n21-20020aa79055000000b005aa60d8545esm8722894pfo.61.2023.02.24.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:03:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] sequencer parsing fixes
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
        <7fd72747-e076-3741-adb4-954bd4c7e9e5@gmx.de>
Date:   Fri, 24 Feb 2023 09:03:20 -0800
In-Reply-To: <7fd72747-e076-3741-adb4-954bd4c7e9e5@gmx.de> (Johannes
        Schindelin's message of "Fri, 24 Feb 2023 15:02:11 +0100 (CET)")
Message-ID: <xmqqa6132dyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Phillip,
>
> On Thu, 23 Feb 2023, Phillip Wood via GitGitGadget wrote:
>
>> Fix a couple of small bugs in the parsing of todo lists
>
> Thank you, those fixes look quite good to me.

Thanks, both.  Let's merge them down quickly.
