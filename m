Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188EA1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeGLUFS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:05:18 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37756 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbeGLUFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:05:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id n17-v6so7259997wmh.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4Px5CHZrSFu8wweEeFlFYc8OnGkZA7gjUDkqLidCubU=;
        b=RR01Ao7YFj2gegt9hVTrfyC8BJNnu+/5RNE3+GP+k8hozrDeT7J19bYnoiYYQJ4d8Y
         RHBA2WFFOSrE8uTlvRWi7arZyYbk74peqkOqjMwX9VP2FHBNfSIeM+/71B0E9CJk95kf
         SUYA8BCebJMovLrXNzLl3LxEZ6P5+5ilj+A6f9zYJXfLMbP7y2gAYnHuWTvczpuPu1cS
         Baq2f2HXkY8uo+I91WtDtsMQanwKJjXsSa6T62thJHfxdZnEoKq8+WE9OR9oYsk27ciP
         8/0ecGT7Xjc4PM9rgh3omthpMvrwI8FwvW2/m0TvvAvJMGKZbCuRYasF6PJBGnuqc9Aj
         IqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4Px5CHZrSFu8wweEeFlFYc8OnGkZA7gjUDkqLidCubU=;
        b=LW1JTH1fv1iu15L5nA6Q1hfgF0lIX2mDWYl//kMTyat7y7z0uyZj3wSMb+skIbPVdI
         3//zU8XHICPSzihsoupX6XDTAmlZqgK2ZGOtK641BUF6HNZro4xDxCAENb0CR/HN8n8L
         8sCrmBqZ9OVhE4SLduGSM4UtpN68MTvjL8nIofPXOT77k4XHfa03Fw8piPQn3/ap1yBO
         4SU914tGFbD4VVg8zTt1j4A18NW5qXJdRcIIYpCzYfFeN3GDyJ+JDDziSTibvbs2nT0l
         ohIrW7oVfhbZz6216dcveHl2XtWfDK96tpkjFzNrd8a9FTUd4qkEnCcRk28s/t6HpGy1
         3CMw==
X-Gm-Message-State: AOUpUlHbUtJHh/SuFXcoITvdbRr/inZsm93qwcBRJjOEagZ7cLPOsYav
        /vxfFNZ3PF0gGY//SbHI6MQ=
X-Google-Smtp-Source: AAOMgpeqIpNjxOnQM0waBTPLF/QfoX/ldgZw197fO/mWXWNQSROoXguUasvUqF5cUICJpYP7xI2/Yg==
X-Received: by 2002:a1c:b584:: with SMTP id e126-v6mr1471520wmf.136.1531425253876;
        Thu, 12 Jul 2018 12:54:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u4-v6sm12670142wrt.31.2018.07.12.12.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 12:54:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com>
        <20180711064642.6933-1-sunshine@sunshineco.com>
        <20180711064642.6933-2-sunshine@sunshineco.com>
        <xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com>
        <CAPig+cS+fFZNZMxc0ARu=cZ2RVjHSP0iiLTsAJ_L7iOarwftgg@mail.gmail.com>
        <20180712165608.GA10515@sigill.intra.peff.net>
        <CAPig+cRmAkiYqFXwRAkQALDoOo-79r2iAumdEJEZhBnETvL-fw@mail.gmail.com>
Date:   Thu, 12 Jul 2018 12:54:12 -0700
In-Reply-To: <CAPig+cRmAkiYqFXwRAkQALDoOo-79r2iAumdEJEZhBnETvL-fw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 12 Jul 2018 15:32:50 -0400")
Message-ID: <xmqqin5kw7q3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> However, existing tests aside, the more important goal is detecting
> problems in new or updated tests hiding genuine bugs in changes to Git
> itself, so it may have some value.

Yes, indeed.
