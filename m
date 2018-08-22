Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CA91F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbeHVTFT (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:05:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44478 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeHVTFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:05:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id v16-v6so1973679wro.11
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=aS6XYr9tvwbciGjMdN4KGz1bthsIxIWovP1T4OJiIjF997Mqw93CEXznuJfDS8AnDy
         ZpSBroMk7gm3u0K0nru9b0jwBJWlMc2fIenJd1H5sm2pCkwXZJVVXJbvRxMI3Qpouiwl
         QHryEIc+qBy6MEPT2mk7cNO3HLFXgZ9Jo4bsSHFIOYPBOv3wGInOO0YGIiyafovuX0xR
         K06Ih7a5hBpHtd9zLgCWVq3KC05z3AWMcv8iIrnZy6PYkOkSEf2CrLY/0jDvA3lTSaH2
         HL16PwNK8PQlqsGd5DR7WrJEydFj1zNEiXqTRusf/tI1cEIOPczQ0Vsz8wgFyyGI6Seb
         w5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=MQXcBLh4zExF9zzkztUWGB5DsiHmCo7LaRNKs704SAllAgMWbr2ghSc2V2ktxkXD+1
         qeZvIBJyaTzWQyk6a5l8iwDsU/OtNs4xz1lgWeq7zHYkDQ0KidXNCiAlJW9/zfsUAzw6
         2SiVn4ujdhhynrVdVL9SiX2PQ0IbZ2QPPac0eZsOzgKihiWDH7kGWH+iUuft+hYHctvF
         5dvbn2tIKvQpZy+XIjJNz1f8D7TY3e5BraQIhnkblWocE6juTFs3haKL70FNs0M4fz/j
         ZLLzq5z92erKJqQpIyawzOXIK63O7BcaJC2QF8LbtOGbLkd63G0PTp4mu3XnfP7f7CXp
         DTKA==
X-Gm-Message-State: AOUpUlFogdriiR0s7ouSDt6OAytPou0ynWDNcZofV1uVYtrdnMFrxubN
        b7WgcE1vTkrp8PpnQLVoaZI=
X-Google-Smtp-Source: AA+uWPzUaiYkZEUECMokdkAwhHtkeyKbsKVmbXpsq3mThnOG5lG3zB9lBS3UfwDbrDI9PclZJvdkRw==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr37816294wrq.225.1534952394347;
        Wed, 22 Aug 2018 08:39:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s13-v6sm2561086wrq.39.2018.08.22.08.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 08:39:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Smith <ischis2@cox.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
References: <72756249.nAoBccgOj7@thunderbird>
        <1455590305-30923-1-git-send-email-ischis2@cox.net>
        <28440975.G22uFktzHy@thunderbird>
Date:   Wed, 22 Aug 2018 08:39:53 -0700
In-Reply-To: <28440975.G22uFktzHy@thunderbird> (Stephen Smith's message of
        "Tue, 21 Aug 2018 22:33:09 -0700")
Message-ID: <xmqq4lfm76ly.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

