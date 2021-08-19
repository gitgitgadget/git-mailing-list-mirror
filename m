Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C79EC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E33A60ED5
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhHSV0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 17:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhHSV0j (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Aug 2021 17:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629408362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICgIXZSw9e1ycHJvpv/7a5z0yRhRBNN+uRKVTbDFCBE=;
        b=KGXa0Se7r9zQhKudtZTuW5oQbO/Dfu9m54zCynFgD6/CimGoAqYDxFhyv5PmLUt4QbkUNS
        7ZoEe+UGJk18N0I3JJSseDzj5ttkRck9GgG37u7fz942sDSMiQycNGfWN2BKmypYW/fnVI
        c+XTnweJNfLqekVc4zHDmCEq9sc4CQQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-57mzcDlrMOq6JTzwlXcs4w-1; Thu, 19 Aug 2021 17:26:01 -0400
X-MC-Unique: 57mzcDlrMOq6JTzwlXcs4w-1
Received: by mail-pg1-f198.google.com with SMTP id u3-20020a6323430000b029023ba96595fdso4057416pgm.7
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 14:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ICgIXZSw9e1ycHJvpv/7a5z0yRhRBNN+uRKVTbDFCBE=;
        b=sYCENV0/MpE8DA8BZhFFXnIg5Oeaeex4AYerW/snJlAWRpBeeRhj0rtSwv7IcmWcE5
         JHt0e0Qk7HNBuHc0kgTiu4sxJII/Xonw1fyeOUmEgA3iZJtClDfXw2Y0iVVbeq9BWTLq
         meDVoFdvSlX9wRivwrzC0vCpsaG5/8Klrb3b5JbNTrJZNgCZR7uG38zxwg4p3Jywx93P
         XomFVhfUlb+9nf2xx6zTfZaZj0UDUYDErc/MgFAYwPbPLrhpCD1dRMxcoNGx+kbYIC6V
         U8KZBT+VJijtE4DWT4on5bHw7s74zwD8J3uY5Ei+AhZBbdZYJ1V68n2QRW1AKx7Wzagn
         5g6g==
X-Gm-Message-State: AOAM530ff3uIkRNUf3HXeF8iyj1MpGXywpirER3bvf4UxjMRkHP2XQtm
        +Yqoo53TwlXdFE9U1q5Sc2u7TpoPjAtIdWImdU9IeAQpmEmPZ7wCWmQjAsbycQzXSHadKbuv4u0
        eA0ZwljX8Nto=
X-Received: by 2002:a63:f62:: with SMTP id 34mr15894898pgp.159.1629408359978;
        Thu, 19 Aug 2021 14:25:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoRmO5GfFPWr622ymQylD8pJEmNfOyhkRXCec8nxfaU9RlVDAdfEkghBMqWTZdL6gZK0nCjQ==
X-Received: by 2002:a63:f62:: with SMTP id 34mr15894886pgp.159.1629408359635;
        Thu, 19 Aug 2021 14:25:59 -0700 (PDT)
Received: from xps13k.happyassassin.net ([184.71.189.90])
        by smtp.gmail.com with ESMTPSA id s16sm4585515pfd.95.2021.08.19.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 14:25:59 -0700 (PDT)
Message-ID: <953c8ccbbb282850191b199345465dac485b933e.camel@redhat.com>
Subject: Re: git format-patch produces invalid patch if the commit adds an
 empty file?
From:   Adam Williamson <awilliam@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 19 Aug 2021 14:25:57 -0700
In-Reply-To: <xmqq5yw1ywdk.fsf@gitster.g>
References: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com>
         <xmqq5yw1ywdk.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 (3.41.1-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2021-08-19 at 14:09 -0700, Junio C Hamano wrote:
> Adam Williamson <awilliam@redhat.com> writes:
> 
> > Hi folks! So I ran into an odd issue with git today. I'm kinda
> > surprised I can't find any prior discussion of it, but oh well. The
> > situation is this: I ran git format-patch on a commit that adds three
> > empty files to a repository - this commit:
> > https://github.com/mesonbuild/meson/commit/5c87167a34c6ed703444af180fffd8a45a7928ee
> > the relevant lines from the patch file it produced look like this:
> > 
> > ===
> > 
> > diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt
> > new file mode 100644
> > index 000000000..e69de29bb
> > diff --git a/test cases/common/56 array methods/b.txt b/test cases/common/56 array methods/b.txt
> > new file mode 100644
> > index 000000000..e69de29bb
> > diff --git a/test cases/common/56 array methods/c.txt b/test cases/common/56 array methods/c.txt
> > new file mode 100644
> > index 000000000..e69de29bb
> 
> I do not have very ancient build of Git handy, but I know Git as old
> as v1.3.0 (which I consider is one of the two versions of historical
> importance, the other being v1.5.3) behaved this way and we haven't
> changed it ever since, so I am surprised too to learn that "GNU
> patch" cannot grok it.  Even though you didn't mention it, am I
> correct to assume that "patch" has a similar issue with a change
> that removes an empty file?

Hi Junio!

I didn't test that. It does seem likely, though.

> I do not think our patch injestion machinery in "git apply" minds if
> we added the "--- /dev/null" + "+++ b/<path>" headers (and the
> reverse for removal of an empty file) to the current output, and I
> am not fundamentally opposed to such a change.
> 
> But because it is such a rare event (and a discouraged practice) to
> record a completely empty file, I wouldn't place a high priority on
> doing so myself.

Thanks.
-- 
Adam Williamson
Fedora QA
IRC: adamw | Twitter: adamw_ha
https://www.happyassassin.net


