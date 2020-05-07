Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8484AC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5556F207DD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U94fsqdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEGKtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEGKtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 06:49:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFEBC061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 03:49:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u4so4048707lfm.7
        for <git@vger.kernel.org>; Thu, 07 May 2020 03:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zaCT6S+oWMa7zGU8ZtP5r3pR54CI2CFLV09f4tdKNCM=;
        b=U94fsqdhUb83G3YzUgh78qd1fYa6jYf1xT3Ahh9WQiz2FCoLE9p2FC6lmsFpbDSBWp
         IsbY7N0F0nViazhKuVhLyaf0LFMvT5iw17NUzz8nSqAxp3zJKsmukvnvbAJ/JZXOLyNM
         OoEf96eTWEeeBCFzemu29H7AgxE25vamfV2DtCZx0TboaP7fOwR7rY5VFqk+JrDtdpfI
         T64xn/yGmbd72hRWQWw2pzj1imwieFFh+jXGkxfo6OlYcf89ZoiQz8c29NiNgt9eCjGV
         e62dYlybWYk+2yZMl2PV2uxU2ulatOyZERYMnQ278wNmJrls6alA9GOa1Fw0xcN0kbHq
         7Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=zaCT6S+oWMa7zGU8ZtP5r3pR54CI2CFLV09f4tdKNCM=;
        b=hN7kLh6tnSgiaOWV74HqJJ7klsjnxiVUGrLRAHvOtv0Rpi7+HJnBpF9HYxNYLTcymu
         ObWG+aR1Uqd7i8XnkpPi41SMQKP16SeloM1zLjM5l6+Htt9nmENWe/F90q0z4d4YrH/+
         SegtBJHxorBK7F8o2nryo4PdrucszXd2GDRyOLsd1TWqiLw5VO7C5gREfB049JJQ2ebs
         UoSg3af9NeZzIcXsIdBrBSx1iwDE6l413czUeBKbMvTxemRazjRqzknTVbNdvaFmT1X4
         jfDl/H6uN+OnVfDHGRN03S3qHxoGSpSSZIXNA9ADHsi2NLhT6Iun91vnKfFh9T2Gr+dN
         Fw/w==
X-Gm-Message-State: AGi0PubHqf/iZxqI9CW8dMXQqrFN4W95A3wCCrAquBMLmhTx3yNT1d1A
        8KKwA2J49OA5dkhy5geXpb0wCvk3
X-Google-Smtp-Source: APiQypL6MuLvtM1jJfHU8dCbdHTi1yDAzxq47EGUuIZluHbi8PXF/uiHWQhin4JHCjIRGpc4KpPV6A==
X-Received: by 2002:a19:4f02:: with SMTP id d2mr8512498lfb.180.1588848570953;
        Thu, 07 May 2020 03:49:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h22sm3077794ljb.65.2020.05.07.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 03:49:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Solomon Ucko <solly.ucko@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: rebase -i: quick/inline reword
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
Date:   Thu, 07 May 2020 13:49:29 +0300
In-Reply-To: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
        (Solomon Ucko's message of "Thu, 7 May 2020 00:27:16 -0400")
Message-ID: <87imh8m346.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solomon Ucko <solly.ucko@gmail.com> writes:

> Currently, `rebase -i` allows modifying the commit titles in the list, and
> the modified title is shown in the lists of previous and next commands, but
> the changes are not saved. Currently, modifying just the titles of many
> commits requires `reword`ing each one and separately and consecutively editing
> each message, which is annoying when making small, repetitive edits, especially
> since it requires double-checking each one separately. It would be much easier
> if there were a mode where any changes to the commit titles in the list
> modified the commits' titles. Maybe `git rebase -i --reword`?
>
> Any thoughts, suggestions, questions, etc.?

Yes, thanks for raising the issue!

I've needed the feature many times myself, but then, as Junio already
described in his reply, I realized it's likely a no-go with current
design of the todo lists. Changing just the titles probably still could
be implemented in a useful way (as with your --reword suggestion), but
its application is in fact rather limited, so maybe isn't worth the
trouble.

It'd be really nice if it were possible to, say, search&replace in, or
spell-check, interactively, all the commit messages (including titles)
of a bunch of commits to be published, all in a single file handled by
single rebase run.

This is a feature that I'd like to see being considered if and when we
decide to design a history editing feature that is more powerful than
current dos-batch-files-alike processing enhanced with comefrom labels.

-- Sergey
