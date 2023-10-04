Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CFE936EB
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 22:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbjJDWO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjJDWOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 18:14:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B31FCB
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 15:13:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50435a9f800so417517e87.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696457603; x=1697062403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUmL/zpGEZnUiSa+Trc18HyYD3fLdRe+Mz/te9yejbY=;
        b=G4rQE9G6nAPz7IQgG3iAhYG/dJojnCrJWPrdtAQg3iHAegnlS/agoPmWYzPIyLR1U1
         C4dv1F2Vnx5dkgIGKEbUFMGLveoD2gOiN7eU/sbH5KMZTG2xUlxwzAd/KiNEQKYBqVZY
         +PwKwkO6fw5BEdA8nG4C+8tJR6lCyoegtLv9+7bKK5w9oy/XikmIwMhZ4UnlHia9sDkD
         FoB62K0b5IJVfBa9LH7xpJEB8i2cYJoEGQgv7HWmO5iQ/2ePfOzr8y+5ZEvxAiOoBoPH
         rlKnvJtXjcn6/023358mD2nzjT+j1IfJK8ywV+/eMcHOJNdvkODdXVvhey3UCQRe13jz
         4sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696457603; x=1697062403;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUmL/zpGEZnUiSa+Trc18HyYD3fLdRe+Mz/te9yejbY=;
        b=GoXs8qYKGS5Rm7Cxqt+OwN5AyAD3g9YtbjhWImJm1UrRZfnDz+s5Rqwsgu+GIk+4S1
         ndKS5slFfJDSTQ3NrwlexHon9JWABwgHDoAv99wdn/cS3Ekj3eN8ZYSxhsnMJemna8s6
         cDEVVoMWxSZO/wUzrJzr7y8hR+zyij/DVzmMbHzSvJCTbhOLbBcLcdlxEqq8lor5LgtJ
         pM5QxL1KeM8zIsFaoSD1VDh7zJjrkdoYUVaqQnslStw+BjYVKZGWr2tvOpCi1IKhQcRz
         xUXRz9Oo21M3OV7EDBOLipg8NgYg86yQ+OllGSyfAfCsB+eApmVJrgZEDYGtWbc+ME4a
         035Q==
X-Gm-Message-State: AOJu0YzZ2YYo7KdmLZxWpc1IishnpnVaHMUOnGKkX58NL0PMPjZ/HrvQ
        kNoGWD8nZptj1bTKL5gkIEHnJP9Pn8g=
X-Google-Smtp-Source: AGHT+IHsBftYJ9VUz2IRfDNw9dkJAyDMNdaT3rhONcboa8rqtnEUoxjjnFmG09xYLjFy+KCCOnKY9A==
X-Received: by 2002:a05:6512:38c7:b0:500:daec:280a with SMTP id p7-20020a05651238c700b00500daec280amr2496832lft.2.1696457603206;
        Wed, 04 Oct 2023 15:13:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z18-20020ac25df2000000b005008c11ca6dsm30485lfq.184.2023.10.04.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:13:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <CAPig+cT63L2+XmDRKw4Pc+iDmUL+UFcyummOcOtS+3wYaNbFvg@mail.gmail.com>
Date:   Thu, 05 Oct 2023 01:13:21 +0300
In-Reply-To: <CAPig+cT63L2+XmDRKw4Pc+iDmUL+UFcyummOcOtS+3wYaNbFvg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 4 Oct 2023 18:02:26 -0400")
Message-ID: <87r0madoji.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Oct 4, 2023 at 5:51 PM Sergey Organov <sorganov@gmail.com> wrote:
>> * Put descriptions of convenience shortcuts first, so they are the
>>   first things reader observes rather than lengthy detailed stuff.
>>
>> * Get rid of very long line containing all the --diff-merges formats
>>   by replacing them with <format>, and putting each supported format
>>   on its own line.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> @@ -43,66 +43,74 @@ endif::git-diff[]
>> +-m::
>> +       Show diffs for merge commits in the default format. This is
>> +       similar to '--diff-merges=on' (which see) except `-m` will
>> +       produce no output unless `-p` is given as well.
>
> I'm having difficulty grasping the parenthetical "(which see)" comment.

I believe it's translated full form of q.v., see:

https://en.wikipedia.org/wiki/List_of_Latin_abbreviations

"q.v.
 quod vide
 "which see"

Imperative, used after a term or phrase that should be looked up
elsewhere in the current document or book."

HTH,
-- Sergey Organov
