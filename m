Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1731F42D
	for <e@80x24.org>; Tue, 29 May 2018 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbeE2FbM (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 01:31:12 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46939 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeE2FbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 01:31:09 -0400
Received: by mail-pg0-f44.google.com with SMTP id a3-v6so6064678pgt.13
        for <git@vger.kernel.org>; Mon, 28 May 2018 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q94PHzigSxVRssqFY/maGL6VmWYKxM5sHuElbFbJDvQ=;
        b=YVPi1LdW7BCCKGGm4UUd4e52XLalZwllmc4wf6icNoamoMD78Bja6KKgawH/wlc6vo
         tc+sSjIaZeRi7Vyt0fJmcuLS8hwrWs/M/B8h42/BZAeFRk0gE29oOYCs2ClAlViBiL5C
         AHX+SaoGeqwIF8GfoVyLcAIYdzdmRxQjPSvDoayaqQ9YF3VaEF8o6jnP82NE2kqD1EjD
         EbkDkHQ0wfCaNuqtpDD6mQDelPcfpO4nUvo13VLA3J8ln5pDq8phl2ne5t6GlkyqLX5s
         b2GL3qfZhOQwV00gCHoj837kq/EQ7/6bewFWmkAmO9TuLOGpFWK/xfGWTKVuUzCWQ8Cn
         1Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q94PHzigSxVRssqFY/maGL6VmWYKxM5sHuElbFbJDvQ=;
        b=J4OhHrPf++91i5rzfa2Ad+te6XeBmYvV3exhnlmV9R7BKEMxpscQgsQ+1CqmrfnvWa
         Og08as3OSWea2zrs2Ga5AAnep9U9MbTLrqH41YiCTJMS24SPRXpdOLDc1Ie+38Af5k99
         Lt9zZ9chnX1gWHNJMbYAAxAl19ziJ0jD4wxEVG9nCtmlssOuWN4UrVqSrbipGli76ADg
         pKx3GkljvqYmSwogW+w1ugXp0zTyHepcBtdoSAM5gwCzbZQE1Tz4ha0EwcLvubCVlWR2
         7p31aJiOW2PZGzS6kpEWVn5kSUAk/nuqxbGKfg6TmKpUn7Fgka9h4N/nTweX4stMxp9y
         6tEw==
X-Gm-Message-State: ALKqPwe1H/9IwLr41zcvXZgVUvVTN3yX1gcRvvUz96/3xTk0PEhGI6oe
        WG9mmjavQ/25NSpMU2FCoKSkRA==
X-Google-Smtp-Source: AB8JxZoUgJLMQ3ggaLL8C00/yf6r35yxP6CyYXwU3YgOfdcC17etdBVxz4dwFKCp8vROJober4xwjQ==
X-Received: by 2002:a63:a05d:: with SMTP id u29-v6mr12690515pgn.80.1527571868921;
        Mon, 28 May 2018 22:31:08 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id 23-v6sm80866291pfs.147.2018.05.28.22.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 May 2018 22:31:08 -0700 (PDT)
From:   istephens@atlassian.com
To:     gitster@pobox.com
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com
Subject: [PATCH v5 0/2] blame and log: prevent error if range ends past end of file
Date:   Tue, 29 May 2018 15:30:35 +1000
Message-Id: <20180529053037.38015-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com>
References: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, I think that sounds reasonable. I've amended the patch so that the
line number is clipped to 1 when reading in a line range. And -L,-n is now
treated the same as -L1,-n i.e. it will blame (or log) the first line of the
file only.

