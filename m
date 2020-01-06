Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED69C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B3A2070E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apdeZuma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFVQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:16:05 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:45935 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFVQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 16:16:05 -0500
Received: by mail-il1-f172.google.com with SMTP id p8so43755726iln.12
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5hjY3OI5bzNDBslpppVywXWBWiNc/J+diQD6/gzAp+A=;
        b=apdeZumaNRLL7kEEE/evSlCOIArL0vFOOtIO1kr5VKqFU9OZeEfPvEGLlFD3A8GVa7
         9feZTJYed/V3LEXd7l9iafOs+4c96BwlVGu397MMBGyOkBtDV4xKrbPOoWZPZWnQSTUN
         hIgXfdFXPgLQgdcGhe1rkYsoqcNo1QaWIiQeljODrSNBhrqs5HKU2n71rBNL+cmz8LSj
         OC/WAbAs9KbLVQ6/jR17aVOtlExkNr56pcm0JaHGF0Ca/UZ2sl7F3VJRYZmZu2XA5BIe
         Yw8wK1r98jAa3klYBz+LQY2V1R1ticsPtMdk5ouVuPGIiuUlp/ckpqtryq7FGk+HUB9c
         vE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5hjY3OI5bzNDBslpppVywXWBWiNc/J+diQD6/gzAp+A=;
        b=bXUCIzeDfQYNyUabkM2/nSxwVIQFiOa9FdyTIunXZwbI3lRm64rA42de3chzUBtnce
         anFIKU6kLVE6ylO6JFc8BdEMGzpcJDM1nXregZYYb0JL1lxAO2xYPZv005ZpNd70LfEe
         za/ff/H4th7j1kviSeTX6ad/PdeI5tNoS27Jn1uLXMQzMh4JGFAJMCLANMkdRmOFoeqo
         1Z7H+Ky1xwwdyU9xmQnk97GCgkfH6LmyglU0oVp+mNYCcJcCmAxiCP34q0fqva08wokB
         4qppw92ZkQ/s0cr3KeE7Ioz4haSbMmxDNV/dx18cjypRYLJWkYCqw3dyKr6gEpBFItR+
         jVhg==
X-Gm-Message-State: APjAAAVjRY8m8DlhC5bdyJ59m+XCvQgCXkN1bqajZ5PK22InOrlEeI3T
        1G5Wh9SGzz7ZhmVbG8yav9tdmuzyjqn7nYVRjXeNyjtS
X-Google-Smtp-Source: APXvYqwD+4ND4H8u0/T5KKKMixM/Ekd1Jmll8v1Lyr37oldJ5A89usEb1VNamWwOAukYtktAHwFngd2sUQ5caf/2Pbw=
X-Received: by 2002:a92:9885:: with SMTP id a5mr88899794ill.107.1578345364495;
 Mon, 06 Jan 2020 13:16:04 -0800 (PST)
MIME-Version: 1.0
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 6 Jan 2020 22:15:53 +0100
Message-ID: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
Subject: [Outreachy] Return value before or after free()?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,
in run-command.c file `exists_in_PATH()` function does this:

static int exists_in_PATH(const char *file)
{
char *r = locate_in_PATH(file);
free(r);
return r != NULL;
}

I wonder if it is correct to do return r != NULL; after free(r);

Could be this version more readable? :

static int exists_in_PATH(const char *file)
{
char *r = locate_in_PATH(file);
int res = (r != NULL);
free(r);
return res;
}

Could you please give me your feedback?

Thank you!

Best,
Miriam.
