Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64334C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE94206B7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE7U55lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCMTCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:02:17 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40383 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:02:17 -0400
Received: by mail-pg1-f180.google.com with SMTP id t24so5502156pgj.7
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNR8jZ2RYd2hrj4D8qw0YbIDnQFp3OYu2Z7MyfXmdq4=;
        b=pE7U55lkS35GFTonAJdsgUAA6Su9bfrpVxdh6oSn2Molq7PXLKocYkNfyM+eCc27jR
         JokAW0ZL0TzF4Lwu3K4ehX1LzUKDEZ/HZfPdr3lHpqFSOzQQ3V5muXMc2n+PpUVrNlos
         fpBD2sfkWpuSkaB9HXZDwFPRaZ8pbwH3709eL/DqoX6dHi0tbVLzXLO0FLv0h99ZPSRQ
         YwIaRHxL6sb9kXOhaTfWXUI8iYOvDT7LOWi4JSNziC2ft7WTkMUbNdo2gGjDTybBNkNV
         ufdgFgi0iT/+ELbJPsDNHoffnr6LC7f5Ha9mI2N3y2aapfZ8ZnwwdoMnW45nM6/VoMQE
         GK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNR8jZ2RYd2hrj4D8qw0YbIDnQFp3OYu2Z7MyfXmdq4=;
        b=VxFjSVkIf5NZcWIfU/1yQW3bUz0mB3bdHSyaQwiIVTKFgcFPFWErj5RrNS025jDqEi
         aaHKMXJZWcOINYrru5lLs3b+PlkRX9mpN//wnQapqn/aricL5W9NVSS0wcHqa76WuZEM
         qZCvuCEdS8cQGXDgnfQfXKNKtZBzrEb9ldFG5ne55iYJNcQ5W8BQxzj1lqK8gWyBRXNq
         OMu/axtVxZdRyyRhXdtsd6efAKqt1OW/VrN8lrbinZLeO6LV2nNJjQ+pouUpKtKZWbc+
         0nzptDhqKbBDCEtMqd4kchIw9kMmn1EBX0I7gudYBNMfCQYYxjQGaTPwp6O0rMx5RoTu
         XSpQ==
X-Gm-Message-State: ANhLgQ0iWBEjTowUz5y13Qktt2rfHQbBi1fwFYMi0FEa9lh2S7kIaqNR
        bS8jPfV4/RcQLtIWzHJ/G9I+AiKP
X-Google-Smtp-Source: ADFU+vuwwWDWf8Uxst4XZShaaNssRhoLV8pDGKollaA2lGEFRMmHxklruwOHYNQb+OGu07fTIsymxA==
X-Received: by 2002:a62:3888:: with SMTP id f130mr12264838pfa.141.1584126136039;
        Fri, 13 Mar 2020 12:02:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q26sm3161861pff.63.2020.03.13.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:02:13 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:02:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
Message-ID: <20200313190211.GA178103@google.com>
References: <3091652.KAqcNXvZJ4@cayenne>
 <20200312233504.GH120942@google.com>
 <xmqqk13pdsw1.fsf@gitster.c.googlers.com>
 <xmqq36accdpt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36accdpt.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> If nobody complains in the coming 4 hours or so, I'll squash this in
> to e6c57b49 ("prefix_path: show gitdir if worktree unavailable",
> 2020-03-02) and mark the topic as "ready for 'next'".
>
> Thanks.
>
>  t/t6136-pathspec-in-bare.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Emily's out of office today, so this is well timed.  Thanks for tying
that loose end.
