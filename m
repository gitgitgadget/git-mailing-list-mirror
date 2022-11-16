Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED3C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiKPT6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPT57 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:57:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FB64A23
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:57:59 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z3so14088431iof.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5P21D1vAsxmPa2mdf4AnrUw2Gh7Tr+lFG9r9QNp7Dk=;
        b=SnJG4TWYMBqqzFVJ+Pdx6g4qVAmJF349CGkOKSMum8/D8A4shy2T5Q3SWaISbOH3P8
         FE+n9FwzGyxHP9Qn14ORHJmGn8BQgyjWzKTnIs1ktowqhTfWxdqDhaRNGLA/uSL0HHF9
         U01SeGuYRSkpULBLL9Oy/KoHsfuGJpvSWEhx/J3IebfFY6gN4KA1lgpZivgAl7LzuIPu
         /QMbDRCobAqVreDu4ELNTqOF6NyIWw4yW+vx2z6Xgiu8SJYKnSkMMbNB9R3fKzp6QZg1
         1iAcraaN+90sFvijXvR5lDQtzUr1+SZ56gUO7FJnjgeSgq+k/IJ6jfNcjXof5lPReuJr
         aaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5P21D1vAsxmPa2mdf4AnrUw2Gh7Tr+lFG9r9QNp7Dk=;
        b=W8OtvNv28o91YKN8rrg1w8PP/WyPPf1vRdH8m4lm6Brqi/QcJvLICb9d6v8CLVT9S6
         YjZKzfM6WXgkVyGo0mcUpGvMhfA3LUc63EAgpWCL/K7JOVZ7KNXe2taRlIxT0fX+NIXZ
         +0ZvLt/WjTiwKPegs9cnpdNzz6br6Dw7qA/YoD0Ade201YlP131Z8IHyvh6gt3TA7LVw
         JeIcBd3bnUrCSDC/vmvyZxvtLzWwg4GFiM1JTPzRbgdrgo1Y2TGfJQzeMQrPZ1RmwDMP
         IY1WYWOnh6p2pHiEtPtAQkk0zJMTAMxVJAJHCxc7hM9kfqkU8jrIZAHWm+W2ZuLOn3Ti
         kURw==
X-Gm-Message-State: ANoB5pmIRtzTulIwwHMNu4QwOfeqQJybmPcyrDKuO7hMY/ziDHcINWV/
        WUlcsQpNQ+tHEs6EUja6aFRJZ6+YOyCrSw==
X-Google-Smtp-Source: AA0mqf7nOztAh4PbJCpMrWAaT6LJMDz4lRYjUSYlHxcCL6YawVDo8m7ytLCfQMHURtOJ8O4HzjrkYA==
X-Received: by 2002:a05:6638:1209:b0:374:f6a9:8948 with SMTP id n9-20020a056638120900b00374f6a98948mr10482166jas.313.1668628678573;
        Wed, 16 Nov 2022 11:57:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j20-20020a023214000000b00356738a2aa2sm5797723jaa.55.2022.11.16.11.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:57:57 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:57:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [PATCH] notes: avoid empty line in template
Message-ID: <Y3VAxO+EQVXVu92z@nand.local>
References: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
 <Y3Uxh25Gh5fPQrMq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3Uxh25Gh5fPQrMq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 01:52:55PM -0500, Jeff King wrote:
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index be51f69225..80d9dfd25c 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -181,7 +181,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
> >  		strbuf_addch(&buf, '\n');
> >  		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
> >  		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
> > -		strbuf_addch(&buf, '\n');
> > +		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
>
> And the patch looks obviously good. The irony is the version two lines
> above which does it correctly. ;)

Thanks, both. ;-).

Thanks,
Taylor
