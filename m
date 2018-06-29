Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899381F516
	for <e@80x24.org>; Fri, 29 Jun 2018 22:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeF2Wab (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 18:30:31 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:56594 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbeF2Waa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 18:30:30 -0400
Received: by mail-vk0-f73.google.com with SMTP id q184-v6so3896320vke.23
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JYh1tKK/1SqiaxYlGvZfTj29mbdU6UgA2tNXnFStI8w=;
        b=ZiC3ANO+jhNKCNL1hCaOnTMTWyJzkp2b+U8Ve4aF/77hhbUxkYU2T2oJvCcEdCqzkN
         t8cW59tYS9Ce+I4XFepFD1EgvM/MtOpY+QLz5nuOskIN450Y+5AWS/q5iO/6xMduBKdv
         8vi2edI5fGpc8h+QxJDT1ssy2fkz4H1Jfgd2WGLMG3TPsa0rZ7ieHKWc8i2VYPbRG7+F
         fINXJIrCejmcuozf0/i4f8gfti34RYGPAvDyoc0482x3g6eHDDqimwS3ksbrcLpbZ4At
         HKEKPDdSro1SN1mARVch1q/hQ90+BSM0d/8ZO0QgsYMxyebnX1rzZcU8zVz/eSG7NNIq
         WDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JYh1tKK/1SqiaxYlGvZfTj29mbdU6UgA2tNXnFStI8w=;
        b=OV80JW0nqgeFHb17Mkpo4v8QID687Q353sCmtRgsu7Msmw6r0s2tyRNl4zNTvglliE
         7tMIpa02Fp4RmL8/kpdTaWwXzwPBcrREhxLS4yhuPh6PTcFA08ylpXLrc6bb32Ci37op
         KIHFpIKtyT06CvbgHCsRoKKMUa0AWpTMo7JCN6cOu55j7wE0NIsaGiNWlP4/GvkP9rln
         oDzBfELY9f/l9THt6JNQ8GKFukxQS5AZhvYR6eKV1HM88qmPALtlpXfz9AqCoXMqeN58
         hhEwqeq/FWi5TrztnljouqQ2+0dY8k+D8g+HiIP5U7dszAhl6+lUiHvNH9+yuMRoka7L
         kuug==
X-Gm-Message-State: APt69E3/tMhRAw9Xwv+FL5wwBbZUWG31AuzB2SVumsC1+kFWV/ByJEfm
        Zx7aw+rtxtkOoO8jTpWowKoC4ygil93pR72IV4fO
X-Google-Smtp-Source: AAOMgpf8lDIPGNHX8FevX6q3tB7n+muuhQuT2Tk3vTxj9o/AsfIf2zMCkqkpSK6+PBJkcmYqZfT7XZIMktsW2/WWfg/1
MIME-Version: 1.0
X-Received: by 2002:ab0:2483:: with SMTP id i3-v6mr4322546uan.58.1530311429261;
 Fri, 29 Jun 2018 15:30:29 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:30:24 -0700
In-Reply-To: <xmqqwoujdejl.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180629223024.62002-1-jonathantanmy@google.com>
References: <xmqqwoujdejl.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > That is the way it should work, but after thinking about it once more, I
> > realize that it isn't.
> >
> > opt->shallow_file is not set to anything. And fetch-pack updates the
> > shallow file by itself (at least, that is my understanding of
> > update_shallow() in fetch-pack.c) before fetch calls check_connected(),
> > meaning that if check_connected() fails, there is still no rollback of
> > the shallow file.
> 
> Ouch.  We need to fix that; otherwise, a broken server will keep
> giving you a corrupt repository even with this fix, no?

Yes, that is true - the repository will be left in a corrupt state.

I did some more investigation, and usually things are OK because
unpack-trees runs a fsck_walk on all the objects it unpacks (with
--shallow-file appropriately set). Things are bad only if the packfile
is empty (or, presumably, if the packfile only has unrelated objects).

I managed to use the one-time-sed mechanism to craft a response that
triggers this case. This both enables me to avoid the brittle check of
"rev-list" appearing in the GIT_TRACE output (as discussed in [1]), and
to verify that a rollback of the shallow file works, once such a patch
is written. I'll look into writing such a patch, so feel free to hold
off on this until that patch is done.

[1] https://public-inbox.org/git/20180627225105.155996-1-jonathantanmy@google.com/
