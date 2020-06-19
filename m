Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD6C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946DD2073E
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwf4d+lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgFSJeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbgFSJbd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 05:31:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D779EC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 02:31:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z63so4204580pfb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cUwjbOhvDiLRko6CzTEKtG6njaLF16yM887VZ8caPRw=;
        b=Zwf4d+lgbQv2aIbV/YaEH9vryA0Ev/kFlygfna3peWX7DPSo5R92k44VWiGfS+9hKe
         v9/a4N2Df6edL3C8SGIy3RBUd+GfHcfQ0EiEzJdJ4uZzMIZyAREOdMXzo6WWhpt5p5rE
         NM/ETvHaZqj6Y5CZ8J4EymJDVXCk6N5rS51lWuHfk4+fz+5PK99hwt4WzrxgtrlHBi9s
         OYPSIqlA5d8w4TxftGEgql53vjMqfekY8f9UD0BmtiEjf0VdB2nAfzP4r/zydlz6tFor
         xbZwnTLRQEk11nKtoyOz1pEJZIvWn5swepVMKcXGgkAEAUMgzpSM3+KqUjlEjWo1z0In
         IQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cUwjbOhvDiLRko6CzTEKtG6njaLF16yM887VZ8caPRw=;
        b=oO7iaGl5KYoLGZgchEnMZpUNpba5dISflErLCubtD6wp6IZEifoX3BmMczUhw3ytqH
         RkeP6SRvmt22yOrriQ2K4g5GNgDyFC56CTmXHMjnsYE+WPeQdkMN9f3V5l8quZivKahP
         wAvbI7jfuSbahy54tcFcjwgGcZVDZ81lzDCbYdzCT/Ypl7GCdIAUG1lTdgwTBUuTZvCq
         a/QhOnNAZRsEqEjsO0rpS4j12TUcyGzIBpyWSmLh7Vzluyna/jfHklzvQeYenc/1vNcb
         yI9heTWWi49Ydzp6+9ynuKnjCjVOgMzHIojccmbA381VsSXI6FO06dKiuu4emU4yc5ck
         e5Gw==
X-Gm-Message-State: AOAM532QlTJ3Xhe5WLWDgFvWdHZSswrMnEbX0BRuhpIkWnbCnGgE1BQp
        0FTZG1Wpn3wsY5qTMijkpKs=
X-Google-Smtp-Source: ABdhPJxqbroMyReH/C/fQwyaokM5vXBD056QALYB9miu7fqnauEpyWeIpZkmGEwQV3w4ccKFv8+fOA==
X-Received: by 2002:a62:191:: with SMTP id 139mr7397920pfb.94.1592559092340;
        Fri, 19 Jun 2020 02:31:32 -0700 (PDT)
Received: from mail.clickyotomy.dev ([49.206.10.129])
        by smtp.gmail.com with ESMTPSA id h15sm4857093pgl.12.2020.06.19.02.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:31:31 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:01:27 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
Message-ID: <20200619093127.GA47528@mail.clickyotomy.dev>
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
 <xmqqk104knrs.fsf@gitster.c.googlers.com>
 <xmqqbllgknfd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbllgknfd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for reviewing this; I appreciate it!

> > +     content="foo" &&
> > +     echo $content >not-empty &&
>
> The quoting decision is backwards in these two lines.  It is OK not
> to quote when the right hand side literal is clearly a single word
> without $IFS.  On the other hand, it is a good practice to always
> quote when using what is in a "$variable".

Yes, that doesn't look right, I will make changes in v2.

[...]
> > > +  touch empty &&
> >
> > Use of "touch" gives a wrong impression that you care about the file
> > timestamp; use something like ": >empty &&" instead when you care
> > about the presence of the file and do not care about its timestamp.
>
> I just realized that this is even more important in this case not to
> use "touch".
>
> The test that uses this file cares not just the presence, but it
> deeply cares that its contents is empty.  The thing it least cares
> about is its timestamp.
>
> The purpose of using "touch" is to update the timestamp, to keep the
> current contents if it exists, and to ensure it exists (as a side
> effect), in the decreasing order of importance.  Use of the command
> here misleads the readers.

Oops, you are right. That makes sense. Will update to ": >empty".

[...]
> > +     git add -N empty not-empty &&
> > +     git diff-files -p >actual &&
> > +     hash_e=$(git hash-object empty) &&
> > +     hash_n=$(git hash-object not-empty) &&
> > +     cat >expect <<-EOF &&
> > +     diff --git a/empty b/empty
> > +     new file mode 100644
> > +     index 0000000..$(git rev-parse --short $hash_e)
> > +     diff --git a/not-empty b/not-empty
> > +     new file mode 100644
> > +     index 0000000..$(git rev-parse --short $hash_n)
> > +     --- /dev/null
> > +     +++ b/not-empty
> > +     @@ -0,0 +1 @@
> > +     +$content
> > +     EOF
> > +     test_cmp expect actual
> > +'
>
> OK.  Do we want to show what happens when "diff" and "diff --cached"
> are run with these two "added but not quite added yet" paths to
> contrast with this new case?

I'm not sure if we want to repeat an older test. The test (which was
renamed in this patch) in t2203-add-intent.sh: "diff/diff-cached shows
ita as new/not-new files" is already doing that. Should  the "diff" and
"diff --cached" steps be appended here again?

Thanks.
