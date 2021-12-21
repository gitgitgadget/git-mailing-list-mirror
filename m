Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2649C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhLUXHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhLUXHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:07:51 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9100DC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:07:51 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so208841pgo.21
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eHcy1xH39+76xc/iJ8UCLR8aPhxvitd+UxY206+23c4=;
        b=Gw7wmSzVeZWhlY0MdTulUKIoL063JKRh48/xujV+Cvwm3y+7xj5+WiW4goKdJBOacv
         zZEloeIGP6/wCx1Iz5VlOBLYof2/SSVcX+T8N9YkJXt9VgFMPs+15oWFzzl2Kf7gNTbP
         gIlCCh1Y3U/qirFZUKTQ3F3WfWWwkWTQ6HrGCeBUvU/NHRDoPscPnRoSOqu0BqacqvjK
         Dq0dec7BKrHPLWekpifwdqYT+KF5EIBHKWNT1DVmyQJnUHa0ntXwMQXsRRfBm4t2kC2t
         iU1ucXfII4u0ru3QyWB6R/eHgjdIYR6o6R4xGPIacPVxUMHZ5wfjpXB26qMiSZv6IDg9
         ag/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eHcy1xH39+76xc/iJ8UCLR8aPhxvitd+UxY206+23c4=;
        b=5P6E/bNdZQrssVjTWdmBjLRAPDL2Sjyo3K7Od4IlY8hjogWqsmqzlhuoXNA+234Z4N
         h9AImAYpa2L9gsvvoH9ZRRY5Qjn7S4IgzvCs9xnXAVetFQl+o3AgrFa8v4Kjn27v8pmy
         RSUfCKk8dbbo0IirDn6TXwrPAje/LyrGHOAm1e1AWlXZj5z1PaFUkm3Ia9LkVPdiwes6
         Rx3cvHbIdOndSqfSkP8Vkel0dD9mu0U7JVFR2/oIM+GLGEW8KXDhjIbfljQFTNq43Lcm
         JrGgvavWjwdipPyyY3jCrdWYV82gZHf8DVHzxMwggDWBcazVdsCrjvABNQo5Vzpmiw3B
         k2OA==
X-Gm-Message-State: AOAM531gfKUvmXOvL+JeQ8q5dRuVFVzR99EpZ8o9GhDlft6zEjwHgHnw
        bY1A3eFZmTsM/CBqEqJm1Zw4GenmpE4c6Q==
X-Google-Smtp-Source: ABdhPJyVm7gpz5tfuUClzysR7FU1SgPXOEgPi3YoIcbS4xTDjbF734eQ+Hg+ujRT1BDkHPmjk885qIIhBytzZQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1385:b0:4ad:580d:8a8 with SMTP
 id t5-20020a056a00138500b004ad580d08a8mr590990pfg.10.1640128071037; Tue, 21
 Dec 2021 15:07:51 -0800 (PST)
Date:   Tue, 21 Dec 2021 15:07:48 -0800
In-Reply-To: <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lczlpzhdn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com> <20211217000235.68996-1-chooglen@google.com>
 <xmqqilvm24bb.fsf@gitster.g> <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>>>  	prepare_repo_settings(the_repository);
>>
>> This is existing code, but I wonder why it can be done _SO_ late in
>> the sequence.  We've already called the transport API for the
>> negotiate-only communication at this point, but a call to this
>> function is the only thing that gives fetch_negotiation_algorithm
>> member in the_repository its default value, isn't it?
>
> That's right, this looks like it could be a bug. Maybe Jonathan knows
> more.

It seems that fetch negotiation always calls prepare_repo_settings().
Fetch negotiation uses negotiate_using_fetch(), which calls
fetch_negotiator_init(), which calls prepare_repo_settings():

  void fetch_negotiator_init(struct repository *r,
          struct fetch_negotiator *negotiator)
  {
    prepare_repo_settings(r);
    switch(r->settings.fetch_negotiation_algorithm) {
    case FETCH_NEGOTIATION_SKIPPING:
      skipping_negotiator_init(negotiator);
      return;

    case FETCH_NEGOTIATION_NOOP:
      noop_negotiator_init(negotiator);
      return;

    case FETCH_NEGOTIATION_DEFAULT:
      default_negotiator_init(negotiator);
      return;
    }
  }

If anything, this seems safer than calling prepare_repo_settings() in
cmd_fetch() :)
