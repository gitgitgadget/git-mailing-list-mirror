Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD6FC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiKGVvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKGVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:51:10 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6C2FC1A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:51:08 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q21so7154465iod.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7D9yLvqvFVDo13UNL0zAJY02pA0NEWUePZApqc7vF8=;
        b=azgGWjkVl33/t4ghUOcscTq2ziBufg9qX/bTUROc9cA8IgTu36wWe3f2Hj7bbJ/jis
         Cjbzcfo4QJhM6i0XF6G+l970QjjpjtDtzYfjmWqmS6byh71fcK3cz6mUPFksZONCW3Pp
         X2JDmjpQeHIUsrT0nZccEbHwrdvUThCsP4eCXQxc7FFMaaSnreE/juFAfKFU1yio4gTp
         swu5ORLVOKZyiMJAn1pp0fXM1Pzrz/RDGjrR2+XBV23ReiNKof/pz0oyfiEdGF0WQpi9
         K8c630aYfxTYxfPUzF2NNO6shdOaVTQLPe7+maiwAeek93XaJqW6VWLQwQnh3xB/BTRv
         3AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7D9yLvqvFVDo13UNL0zAJY02pA0NEWUePZApqc7vF8=;
        b=oPZegB7oKVzeME1VaPT49eZErHzZZT4y4gU3IKitSSDtGQW+eOcAn7jdkw+PEEkf7V
         qvlJ2snHlPnUOIiiyg4k6hASQPUBzjO7STedT4WNBuj5pcaauWb+oChqIUwQDRxP3djm
         qqucQ834vlzzNz1sC916Q79cXTpsox+Qr/VehJf49vhfoZ/EDPpx7bbslFFpRQpkk9ZN
         l9w5hk7AYtUo35uvw+LJ3/hnEUtPVKvaPhR8rSY3InEkf6II2bCmGjHqt2xYbfUpax3A
         1tUJEo5JypvZtF04MGVqzZ9C7scWlMZzSexdJ1xX6KIQWQdMDLWRastpgJHWCca0oO7M
         rQDw==
X-Gm-Message-State: ACrzQf0LgJBipCGI13jeb0B1P2BlBjWDgm5INERMzLRONLUpi3HIr446
        0ZrsnyjdZAPzMEszV5AWvfW3RQ==
X-Google-Smtp-Source: AMsMyM6VHLBpufTEtUr55dXvJlvZyqOpzv+G+Q1ph5lLpBGnFaF5Ummk+H+DmS/H5tk+mPIJC+l8Yw==
X-Received: by 2002:a05:6638:447:b0:375:3284:4a2e with SMTP id r7-20020a056638044700b0037532844a2emr31882654jap.195.1667857868268;
        Mon, 07 Nov 2022 13:51:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w8-20020a029688000000b003754d61acc2sm3128863jai.44.2022.11.07.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:51:08 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:51:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 2/3] notes.c: fixed tip when target and append note
 are both empty
Message-ID: <Y2l9yfOhiT7r2+H6@nand.local>
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <5dbe014a09cca6ffa01dc9f61d0ddc095d31d518.1667828335.git.dyroneteng@gmail.com>
 <221107.86cz9yx1wh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86cz9yx1wh.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 03:40:03PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > @@ -567,9 +567,15 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >  	struct notes_tree *t;
> >  	struct object_id object, new_note;
> >  	const struct object_id *note;
> > -	char *logmsg;
> > +	char *logmsg = NULL;
> >  	const char * const *usage;
> > -	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> > +	struct note_data d = {
> > +		.given = 0,
> > +		.use_editor = 0,
> > +		.edit_path = NULL,
>
> Most of this is an unrelated "use designated init" cleanup, which is
> good, but let's do that in a different commit if we need it. And then
> you can drop all of these...
>
> > +		.buf = STRBUF_INIT
>
> ...and only need to keep this one.

I don't mind seeing the cleanup here, but I don't see why we need to
keep that portion of the hunk at all for this series.

IOW, your "...and only need to keep this one" does not make sense to me.

Changing "char *logmsg" to be initialized to NULL is important, though,
since we now only set it conditionally still free it unconditionally. So
that should be kept.

Thanks,
Taylor
