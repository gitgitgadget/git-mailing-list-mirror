Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B417C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE7061250
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhHVSsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHVSsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 14:48:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2DAC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 11:47:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so12545017wme.1
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=N5ELfu/iJ1nACp9DTl8/sszwHjLLlN+jM3vB6LyqzU0=;
        b=L/5/2eqclFEZjt/Hz3AkxedAQjeqKbxRs41EiIUfGVZJydzyfX0t3GHoG95lWVkccF
         O60nl7cgU3rZnYUq6QF7riMabFJ0Eib+0d7OICPHiNkJMtuVSjnoHLI2GqtkRJWMpBrd
         xernADU/jimnWABiViJnaaWdLeVScbLyE3rVFE6A1Jo4FMbZZZhCj7gJKiWWroZs36Ll
         JsBJuTsEaBF02S62GJL7L8h7XOhfO+odUBRNPfCfkLhLB1OVNJ4q+YDMBw8NqYHJrdG3
         d8awN3abmgIpT5Y8aMqy6P4Q4Jg7kf3SL2aq9AuHQe409RHrn2rkOODsBqGc9fOrMc0r
         m3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N5ELfu/iJ1nACp9DTl8/sszwHjLLlN+jM3vB6LyqzU0=;
        b=AKl9+EpavwEhIQqjaJtB0u7pkZn5FPjLcnvGGCnFZKhxPS/YmgE8NbbYCO3E1H6Lpo
         vN+lxvnNk6n2ovNfLgwnVnXtqkZnZE/+UVux5y1WtWRT0LzOnp+LnUhyLnhczePHTuTs
         Ea2uvGuq6AbExTi9c2ir8QDTzkmKRmncr3Arj7zGTq01a4b86Pohjh73Jt50dM0iuYaH
         mZs32XFlTRG3N4+45IzLYMvjTnJ4fZJ6rq6h6RrAcJ3rEzQS/fmmv9jyLj6JmkQhh0wM
         36ck3vucQ4q1i8pjwYyWHcDjBAglmO0nPEKQ2IsFKop7tUYnrtMQc9QaGAFu0l8q8CYW
         BquQ==
X-Gm-Message-State: AOAM533X70ewdTzHaqy4pMU4W+Zee9Ld/2UN0GuEcr47JX3DmY3xMRAn
        FWz4s61ZHPPIPTlYbxkmKfx7l23j6DEqOogvngYA6Auyh1YL
X-Google-Smtp-Source: ABdhPJwzJ6OUHHxTCxVczhh65QVPqu5Hpr/kWCUhF+nhsV68bGLtUjAXgGVJHZaBOHKQzrphyAmqIJhCXM9+moq6Eto=
X-Received: by 2002:a7b:c041:: with SMTP id u1mr12502818wmc.95.1629658048894;
 Sun, 22 Aug 2021 11:47:28 -0700 (PDT)
MIME-Version: 1.0
From:   Stef Bon <stefbon@gmail.com>
Date:   Sun, 22 Aug 2021 20:47:18 +0200
Message-ID: <CANXojcyX2uqAp5gLtfH8ffQFQBKkMoPqSzpDUnbFe0QBd5nJqg@mail.gmail.com>
Subject: Get tree of remote repository using custom ssh library.
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I want to add git support to my fuse workspace, enable browsing of the
users repositories.
I've got a custom ssh library:

struct ssh_channel_s *channel=create_channel(session, _CHANNEL_TYPE_SESSION);
if (channel==NULL) return -1;
set_channel_exec(channel, command);

if (add_channel(channel, CHANNEL_FLAG_OPEN)==-1) goto free;

if (send_channel_start_command_message(channel, 1, &seq)>0) {
     struct ssh_payload_s *payload=NULL;

      payload=get_ssh_payload_channel(channel, &expire, &seq, &error);

      if (payload && payload->type==SSH_MSG_CHANNEL_DATA) {

.... process the received data
      }
      free_payload(&payload);
}

Now I read:

https://git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols
and
https://www.git-scm.com/docs/protocol-v2

How can I get remote repositories of a user on a server (say
github.com, user stefbon) and browse each HEAD repository and the
source tree?

Stef Bon
