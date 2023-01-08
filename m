Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309BC46467
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 02:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjAHCen (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 21:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjAHCel (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 21:34:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973991DF32
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 18:34:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id dw9so3956578pjb.5
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 18:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbcBmXAGqRwqa9vgftk8oVJx+AEhcjD7FZ8gyDqsewo=;
        b=N+rmqd47Gk8DJCfX1H4W1cXlW5hYt9gFr116+PP+abbW/b9E2pz83te3XBGkXDgR5H
         j1Z0uGmUorUCNAK2VuYB+2lFcbaGK7e5DIn+RIKnpJlsoWtvtS3UPjPkh+UlxhpyycZc
         tWOra4RGv2OPxuq1t3nI2kR3RjSrm7nS5j/r7oIzn+VD1qoPqnMcReOWvtEEzy1SpNba
         S4pBLinnhjvXr3Y5zXOX3ASToXFaRuPii9Rzw2VmtaJkzBTBSDxp99DHjwKjsSDbm3lx
         CVHlFDUSuAIkRxcCuRvAzp0rtkRhSKOXWBhbo3orrpkP38zKXky92KgCsHR4J+psKiY8
         fThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbcBmXAGqRwqa9vgftk8oVJx+AEhcjD7FZ8gyDqsewo=;
        b=NpsU98PVlH4TuBNoRkGCHWofcL3bk+lKMEHhFYcJK66GElUzv3B0l09EuzoxZAGpMR
         EzD4cEYG45Ss7jW+cu1zLxpQfZ+RMgNiQgf1Ti9QDONPq6mU01zkwZF/BD6g9oMrEomk
         NPNtW9mj6qrLo/xneF2TMcfTYlXhlcaHdSDBnz0hjmtpbOkfQk0DVr8pK5E7kUV5Jk6O
         odrGpobyBYsMHPvzUCJbCI4J1qoQg+XBQXJ4ETMS09/62Ztr2+6AMS96k/NG947t3h4S
         eqen24d3g+h0Di55jkXh9HN1rksQd6R21+BcuQ5xwvFotyPXa88tosl5aUpN4ikZ65JS
         Ahjg==
X-Gm-Message-State: AFqh2kpeA6YDki115gX1eFkofS4kY/7KnNpOBJBxLjq3D9aV2wCpHlRz
        zsB+RM5m/CMNyVfC+5suau7J36ERP2R1JQ==
X-Google-Smtp-Source: AMrXdXvelmGlhphSc5AO4cP5JcZvz0j0Ze4J137eXlzXZJB24M1Rv/DIieU/6FgHifA43cbGEF55TA==
X-Received: by 2002:a17:902:f80c:b0:189:ea4c:e414 with SMTP id ix12-20020a170902f80c00b00189ea4ce414mr65753158plb.61.1673145279938;
        Sat, 07 Jan 2023 18:34:39 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001925016e34bsm3428308plg.79.2023.01.07.18.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 18:34:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: should git rev-parse -q --verify on a range produce output?
References: <CANgJU+Vo3B=YuqgWVgiRMMiBwTFEh98O0LSJJ+ES6EM=MP4Cew@mail.gmail.com>
Date:   Sun, 08 Jan 2023 11:34:38 +0900
In-Reply-To: <CANgJU+Vo3B=YuqgWVgiRMMiBwTFEh98O0LSJJ+ES6EM=MP4Cew@mail.gmail.com>
        (demerphq@gmail.com's message of "Sun, 8 Jan 2023 00:03:55 +0100")
Message-ID: <xmqqmt6tzrcx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

> I was curious if it is a bug that `rev-parse -q --verify` produces
> output for a commit range, and only reveals it is supposed to be used
> with a single commit as an error message?

I know that the original scenario that the combination of "--verify"
and "--quiet" was invented for was "I have a string that ought to
resolve to a single object name, but the object may be missing", and

	if git cat-file -e "$name" 2>/dev/null
	then
		rawname=$(git rev-parse --verify "$name")
		true
	else
		false
	fi &&
	... do something that uses $rawname here ...
	
is a mouthful.  It becomes easier to use if we can say

	rawname=$(git rev-parse -q --verify "$name") &&
	... do something that uses $rawname here ...

I do not think the behaviour in usecase outside that was carefully
designed to the details.
