Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0482C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 15:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbiGNP0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbiGNP0D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 11:26:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AA046DAB
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 08:26:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so2145285pfd.9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjXRfhg7sKEK+LEAgloEIlI8uQMUtUj6eg+/oYFW1N8=;
        b=NHSz+UkIV07K8dJQJbj+nZeEus/Nl8PSlYTG85c3uetl2HmNZgEChQqd5B9DHcHe7v
         5R95NYmoAZQrWDEt9RwIXwpdkW5X6O0COU4YZWdPOHT+LBSUYCBbWn5Q36JHN3w6uA+F
         6dvL8ucS8aPZ9nSUJ+b8FphT7BYM5D/WLpqIzrhHXy1iYWLnnBlEENaQMdmHJ04iAqTj
         zybKQztkkzpubGL3BcVasjHufHvY90eB+zNBzIbX97znmOUXzgoFIwNaIiqNYUwcHyMs
         jMsTxV0eoauof/i8WkvGGf/BX5ED8whGnXgrU0T/mc2U9GBPbIJ6m1TKABwxsAUGxwnm
         Qnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjXRfhg7sKEK+LEAgloEIlI8uQMUtUj6eg+/oYFW1N8=;
        b=SrU9VY8HixGNSDqyteQJ61NE8JIv3E56L11HbdQGXbCuuq1jaEUiCrMX7QcuoWVNTn
         Azu5lmTXt2DVMq+adofVpkpwUPAPFH9TMm/nmDZhyOxygCjVPJJuIU/imClBv2upOdmp
         XW+tHPSOXIRsATBBbSKqsp5yJrkU+/twhUJda/nyMihPDVEUVKky7c3kwJSVuOFMiyf4
         dIT9sfHkOY+lq3PVy25S6cYyIvWodkkRL9WRNIoOnczRdqPBv7kqllJ9t/1zK7sj/EJV
         3Li0BiHVfMtSEG6KT7GJ0+K+RztKqzQuBLryL97bq5xeVNxwU6wGwd3K5UxgBjU7tSDl
         bPTw==
X-Gm-Message-State: AJIora9Y4941SzegmYzxH9zNP+60gfd/ai/smk/VWDKYylVHvYhs4Jcw
        O1vy1MTBYu47tJ0KWGEPUgU=
X-Google-Smtp-Source: AGRyM1uEqfy5NoO/LHSJp1NxGQZ+tG3gLPReuSdXRzeovvooKIPszR3Y7hwNu7abd819+UKjpmVUBQ==
X-Received: by 2002:a63:8341:0:b0:415:c973:18b1 with SMTP id h62-20020a638341000000b00415c97318b1mr8355297pge.292.1657812359480;
        Thu, 14 Jul 2022 08:25:59 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id u19-20020a627913000000b00528c0e516fesm1834472pfc.152.2022.07.14.08.25.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 08:25:58 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 4/7] pack-bitmap.c: don't ignore ENOENT silently
Date:   Thu, 14 Jul 2022 23:25:52 +0800
Message-Id: <20220714152552.3932-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gacb6c2f483
In-Reply-To: <xmqqpmibmjjs.fsf@gitster.g>
References: <xmqqpmibmjjs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Both the title and the body describes a complete opposite of what
> the patch does, doesn't it?
>
> 	pack-bitmap.c: do not ignore error when opening a bitmap file
>
> 	Calls to git_open() to open the pack bitmap file and
> 	multi-pack bitmap file do not report any error when they
> 	fail.  These files are optional and it is not an error if
> 	open failed due to ENOENT, but we shouldn't be ignoring
> 	other kinds of errors.
>
> or something?

Yes, will apply, thanks for this detailed assistent.

> > +	if (fd < 0) {
> > +		if (errno != ENOENT)
> > +			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
> > +		free(bitmap_name);
>
> Showing the errno is good, but I do not think it should be enclosed
> in single quotes.

Yes, it should not be enclosed around and by Ævar Arnfjörð Bjarmason's advice
the "warning" should be replaced by "warning_errno", I agree with that,
so, I think at the same time it solves this problem.

> One thing you should consider when writing a "this is an optional
> file and not finding it is perfectly fine" logic like this one is
> that you may or may not want to ignore ENOTDIR.

$ errno ENOTDIR
ENOTDIR 20 Not a directory

>ENOTDIR is what you
> get when you say open("a/b") and "a" exists as something other than
> a directory.  If you have a path with a slash in bitmap_name, and if
> in a sane and healthy repository the leading path should always
> exist (i.e. the file "a/b" may be missing, but the directory "a/"
> should be there), then getting ENOTDIR is a noteworthy event.

Make sense, and I tried to move "pack" away and touch a new file named "pack",
then executed "git fsck", it will show the result about ENOTDIR:

$ git fsck
Checking object directories: 100% (256/256), done.
error: unable to open object pack directory: /Users/tenglong.tl/Downloads/dyrone/.git/objects/pack: Not a directory

So, this is how it works in git I think, caller should also print the "errno"
when deal error and warning,  append errno string as the last part and the
first part is to describe what's wrong happened in git.

> There may be cases where ENOTDIR can justifiably and should be ignored.

Yes. If I understand it correctly, I think it's the current scene.

For example, if this happens in case like "./pack" is a non-directory, then
we print warning which contains ENOTDIR description under current change.

Thanks.
