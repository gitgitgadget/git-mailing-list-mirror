Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D77EB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbjFNQBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbjFNQBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:01:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953112945
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:01:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-651e298be3fso7144155b3a.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686758475; x=1689350475;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+obs7pcZnXYzAkJPdZ9esAgVldgxeWOoQ/9QUGBnQYQ=;
        b=O8ZHKrBU78zRyZV/sxeG2n0RZ7XoVdQ1c8ETfPnjB3l2uXcjt2AB8GPN4hAo42IdmO
         DpDxB0pAkrTjBAD0QriaL+4+8EDYQsgKRJQiKyrabqlZOU6WhtlVd5kZ88FuuyUgvS4l
         TBMYwxozQwPyRlCDen7yVpfrBhiyqRnlME4efnV47vbbKICO62fqZjfiLDzrCLy32Xj3
         N5r9zTZGRVYJ5PYBi6zQrZIs77OTmNB1/aDqQGCQvjg8o1kuWt75yK7xMTfj0PM+YoJJ
         HlZLBbj0aPlJDYoJnlaF7VZzm/u8ZXfPX0CFnNxqgb1WZXDdlChMLGfhFmuzs4VnqTeO
         bpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758475; x=1689350475;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+obs7pcZnXYzAkJPdZ9esAgVldgxeWOoQ/9QUGBnQYQ=;
        b=aRO8f4QYG7Y695ytWh6iGi6pZ5ZdROIB+aNrX6DNS9w36PjtVWQ0qjhdTMrRbv1HhJ
         47ceERQQrli5X/Dgy1HBaWA3B+ZB0c7GePp+Fu7NBTEfzAvVm4bBZdPj0RSOmiw7kW1T
         vAGRRvvzItVrTr9f+0/gxNyr7QLoHegjrY8jJ1+A02Mw91/CZ0d79lKotECDRxvxeM4T
         FitVX3atEEe6GomBsh+oN3o5oYLNm1Rx4URdy32a5HuL1IEHC5E6OotBDchjPro6Jb6o
         ZSOURlfv/tdXmNgP7zl07WPL20bA6uZwweDLuGLMu3s2vazADdDIBUvZiWQdXIun3C4S
         ZKYA==
X-Gm-Message-State: AC+VfDy1s1DMJsmCbCuU4e2myhbFT20iUogW254Yb5zIS2+TZvIVdctD
        //DpoWYBpHjB8rAAxIc3wvod6hZgDek=
X-Google-Smtp-Source: ACHHUZ4aHbW/cOJib4QqldFZ5zftwPYmRwVQjAUZ5DjcF4O4HQxZkj6wLFtCF+oEgBkzL7gk/+UUEQ==
X-Received: by 2002:a05:6a00:884:b0:663:83ad:4804 with SMTP id q4-20020a056a00088400b0066383ad4804mr2759367pfj.1.1686758475082;
        Wed, 14 Jun 2023 09:01:15 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7908f000000b00660d80087a0sm10496864pfa.199.2023.06.14.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 09:01:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] revision: reorder `read_revisions_from_stdin()`
References: <cover.1686744685.git.ps@pks.im>
        <6cd4f79482276eae333bab8cebd114fa913659e6.1686744685.git.ps@pks.im>
Date:   Wed, 14 Jun 2023 09:01:14 -0700
In-Reply-To: <6cd4f79482276eae333bab8cebd114fa913659e6.1686744685.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 14 Jun 2023 14:18:32 +0200")
Message-ID: <xmqqr0qexcc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Reorder `read_revisions_from_stdin()` so that we can start using
> `handle_revision_pseudo_opt()` without a forward declaration in a
> subsequent commit.

Makes sense.
