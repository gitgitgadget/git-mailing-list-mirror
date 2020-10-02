Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E034BC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953AA206B7
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lV/CIK3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgJBGvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBGvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:51:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC562C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:51:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c19so398349qkk.20
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=00jwIG3jZ1Qf2/a+mb2jpFdzp3kmcB9Jv/RJ1r3X/Po=;
        b=lV/CIK3yUmmaOZgN6D4joYgN67f+xfAR8WF45I6gcvY5MhxlLmFc1dB9U4JeRdoFl+
         NzYSYhmx0fn+/X4tLyvZr45wp6tdNqcsfFiWsp4a22IcWX1Uvr0+5b4Z7TY+8jkZrf78
         kxzyj6HQliBSZ1DhDMP58TAE0Wr/iMxkAs/NnHK+NRzxq3YycAFqx6TiUN4u+2WF//kQ
         tzQItCzBvwK31wGpX8AQNsl/OwqWas5juI4XQvzafrSwu34gDlsgtcVWPBRPLU7eA9zQ
         EdMQHL9PekPVuOeup4pAb0XerUY294+YsfgaNSGnqK/ppg7LJx0wkxlaF24Z56oG4lxV
         AIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=00jwIG3jZ1Qf2/a+mb2jpFdzp3kmcB9Jv/RJ1r3X/Po=;
        b=lPxqCkpgePKc73D9Mw4cVx1cDEh+hoBl9q+FqLct1jrIlVadHIT4YiNisxnSEwcruN
         UrPR3xIQJ4dV1qAl1DTvruLP3uDr6+rMMOY8A0tHEee+NMetSIHVjqYaWoDabBsqd5TA
         EfjZTeDf1FIDP1xU+BGBPdBtU+R8rPRGInJAwEt3oLvCzW+0LGf8snxIVyoHM6pEREvL
         tadSOJvN+t7jFre2YmoP2GcNAycIQpGKeLFOz2TkE2XzP84LzKdYnHgIhdGpG99m/MRN
         eJlBJHLlyUYIM4hA1Dq6rMoldxi+Y5Q8lkQY+Md30rPXvtivpvJ1FaQ7ZUacNvwjzfrq
         OBvw==
X-Gm-Message-State: AOAM530YwiqbQhns2UcFejuhIWmHGaYV6dWZ5IJ2uTWTVpkccannlFqu
        w/rvOAvzGr/e2GdjmMsv3ubrGmAVBtNw
X-Google-Smtp-Source: ABdhPJz8h9cAsCLPtVF6J8Azame4gWv/jeR+Soz/xox8tPHO3fj3TcIZOySX5QcqiJeJ3MsJdwyjc4HadPwG
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a0c:9e0e:: with SMTP id
 p14mr787821qve.25.1601621496108; Thu, 01 Oct 2020 23:51:36 -0700 (PDT)
Date:   Fri,  2 Oct 2020 06:51:35 +0000
In-Reply-To: <xmqqh7rees6h.fsf@gitster.c.googlers.com>
Message-Id: <20201002065135.4096175-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqh7rees6h.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Users requested hiding location in the world from source control
>> trail. This is an implementation to read user.hideTimezone in
>> cmd_commit and set timezone to UTC if it's true.
>
> Not a very good proposed log message, that sounds as if "it is
> what 'Users' requested, so it must be a worthwhile thing to do",
> which is not the line of thinking to go by.

That's a good point. Users requested does not necessarily equivalent
to  worthwhile thing to do. Thanks for pointing it out.




