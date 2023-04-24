Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AEC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjDXTlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDXTls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 15:41:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDD1BCB
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:41:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a8097c1ccfso53721595ad.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682365307; x=1684957307;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teh690eJp9aVEdlQJxcHSazzrQnzCX1rhK/sqxahaAk=;
        b=REYPTJQUTA9KKSKA6rIr0mmYsLpvpaJ92qZ3L7uFgWXQJbkowBkEGuTiS6veOH64yt
         +lsZX/YIdT53ZRmPe0Ihg24wwaIbeP5lgxkuhqumJwRfWkDhHlgT5Hkv0TG82vh/NMFo
         QZTp6kptPEST3HGFl/vCqBGQFIPuPOGKD+9SaIHWg5U0QGk9wr11sVW70WMvT2RpOmqM
         KVfTZhA1g2kMhFHCTAqyR0dhN12yjMUOFAKkvUi0qqJfBOGbXGktr+BzUZ2nJJQLvx3P
         JO8Vkhdp7DVrRP6VqEjX0hHxwFKtlJ5decJglLqYtfJ4Rjstci6ipZeRmmiEqPX6t9ir
         CjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365307; x=1684957307;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=teh690eJp9aVEdlQJxcHSazzrQnzCX1rhK/sqxahaAk=;
        b=gJRX+RqoGi8COYP0/67S5msHdu6esxdmOWVmcYitF0G9tAkWWQTGopanYZqlH1AbBI
         7WbqJ7WF9yRk4QTNkhnG9VSOuCjNzE8CEbXJm8XoE8Lh8TaxszZl/YgT3+QzV67PUFVJ
         HVZHRKk16fMZgyQKlkk57CuQk2KcDZwhopjvbt/qecH7ONJQp9JgfNmcNerS+qtBs7KM
         t9Eg0wmE5MNvmX3UykEDvxVC2ZPEjrPPQbrDcIPQfL6RinReE9/DYmuwkW3k7lwM4pIz
         h7dlbqsRRS8GgrD8Ez8UiKAq5jrXjvuv48u0jzhom1Npm8OxRHtHdlIirHFYEuOkD5HT
         EkbA==
X-Gm-Message-State: AAQBX9fexTQicslLuPHWu70SqvnCu6YfjxnrHj5PbFDZ3DZ0AuyKQ2j4
        +5W13WtcwJIkX2ABsiP02nlcZGZFWHQ=
X-Google-Smtp-Source: AKy350Z4N0/rpSjsjtVHGbviYErUYDBqFCRKoA3CEkKEFqkyKs3ToRY4zJHcTBMmDCcda7V2+1keoQ==
X-Received: by 2002:a17:902:e545:b0:1a6:6f3f:bc3 with SMTP id n5-20020a170902e54500b001a66f3f0bc3mr21229811plf.57.1682365306734;
        Mon, 24 Apr 2023 12:41:46 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001a072aedec7sm6950710plw.75.2023.04.24.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:41:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Morton <admin@game-point.net>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: tell git a file has been renamed
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
Date:   Mon, 24 Apr 2023 12:41:45 -0700
In-Reply-To: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net> (Jeremy
        Morton's message of "Sat, 22 Apr 2023 19:01:45 +0100")
Message-ID: <xmqq8rehdq4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Morton <admin@game-point.net> writes:

> The standard answer for this is to rename the file in one commit, then
> make the changes.

Oh, by the way, this is a pure myth that would unlikely be helpful
in the bigger picture.

When you rename and heavily modify the resulting new path because
you have to solve something, such a work would likely be done on the
same topic branch.  One step of it may be a pure rename, and other
steps may involve heavily changing the renamed result, or you may
update the contents in the original and the do a rename at the end,
but either way, when you integrate the end result of the whole topic
branch into the master history, what such a merge will see is that
the original file has disappeared and a new file with contents not
at all similar to the disappeared file has appeared.  "pure rename
with changes in separate commits" would have no effect when showing
such a history with "git log --first-parent -p" for a birds-eye
view.

