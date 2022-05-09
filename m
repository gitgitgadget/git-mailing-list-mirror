Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB662C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiEIQCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiEIQCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:02:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A52D9ECD
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:58:23 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m1so3906058qkn.10
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8e0q7KTps17Y6pcMw7krBl/XGuvqfmneBpenrDxL7hc=;
        b=kTgKGYl4ZhafQeQDdZLzW13pTqU3kV4KLXuMosEY6FKFSdBKI8CfvPz7+qIMoXVD21
         GxHbexI1YRc7xBaPP9oKTt5Ir4Vqi0VkJzberwbONq0ue0WP8ARPzYRc1CP7Yifqnyyp
         uJZXKxIN0RDdbUNwBh6TResLMwbFUnqrFhDFJ7U/3c+PMjOBfXwrlKH+DgzkAwJV4jqS
         PCkwchf0Z9P0HPSvwAzcLjfkJrLfDIkTk4ujFZr8ct3hi5Zs9B6EjmUCn1YWud7toXJS
         mNbEsG03a+5eOGtPzEsArPBA2YHDy6/ZjJZCGfiz/S4DjmdFAtUnELy5xxqRL9p+QPOQ
         3C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8e0q7KTps17Y6pcMw7krBl/XGuvqfmneBpenrDxL7hc=;
        b=QUP30uEJ0QF0DG7VtqKAUt234I+RAcFSx6vajHvCg0syIIflnDYR4XubUUZDbHpRLP
         rXW2g5hTZFWY2vZI5/9RPvtl0tzOElrUVrmfAoDCWbDlEVPkcHTCbdJkBihMtMylbIqk
         zCEE/vu87Xr3oltdUN+XCklFaMs103rJOXLShaqfdp13dmLzH+P44MdB53zTTfMvXHBA
         ni4JeRukyK6Akom+PGzIoQKODHDIt4hwRjcoqZhAqz+dk30doofZYoJcFyspsdIgfnAt
         jQeSt2vwIGE0V2BvKtEgxusXjKpLlhGZhK+XrN+856jJ8GQm8zoWTatksgMo05OXaMBn
         ea/A==
X-Gm-Message-State: AOAM532o16u105KkBZ8zJIG98tS6m4Su9BuXyKhRtSWO1czUT7V4Tydz
        zesgEXwFckvwk/iTx3vgK5XD/TfUPIgV1cL/
X-Google-Smtp-Source: ABdhPJzA/NIaAC17BRKW6PLmdjnqTnTf48Hpa2TooIs8vrFYu+MjvVs6K2gAelyrg0Q14lX+yMPEaA==
X-Received: by 2002:a05:620a:2892:b0:67e:be24:e5d7 with SMTP id j18-20020a05620a289200b0067ebe24e5d7mr11931511qkp.762.1652111902959;
        Mon, 09 May 2022 08:58:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l1-20020ae9f001000000b0069fd35d2abcsm7153689qkg.112.2022.05.09.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:58:22 -0700 (PDT)
Date:   Mon, 9 May 2022 11:58:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] dir.c: avoid gcc warning
Message-ID: <Ynk6HdsPqYH9Np92@nand.local>
References: <cover.1651859773.git.git@grubix.eu>
 <cd50ec73ddafaaeba04298ae79cbf625cc0d7697.1651859773.git.git@grubix.eu>
 <xmqqy1zejtte.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1zejtte.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 01:21:33PM -0700, Junio C Hamano wrote:
> Michael J Gruber <git@grubix.eu> writes:
>
> > Related to -Wstringop-overread.
> >
> > In fact, this may be a false positive, but reading until the correct end
> > is desirable here anyways.
>
> But the correct end is start + (end - start), not start + (end -
> start + 1), isn't it?  We've stripped trailing junk like /.git and
> end is point at one byte beyond the end of URL to the repository.
>
> E.g. for "https://auth@host/", we have advanced start to point at
> "h" at the beginning of "host", and we have moved end back from
> pointing at the NUL at the end to point at "/" at the end of
> "host/".
>
> We are trying to make sure that the resulting "host" string between
> start and end do not have a slash to apply this special case.
>
> If the original URL were "https://auth@host:4321/", the end points
> at "/" at the end of "host:4321/", making the string to be checked
> to "host:4321" and we are trying to see it has no '/' in it (which
> is the case).  By extending the string by one, memchr() will see the
> '/' at the end that is outside.
>
> This seems to be a behaviour breaking change and I am not sure what
> we are trying to achieve with it.  Is this a suggestion made by a
> broken compiler you have, or something?

I agree with this reasoning; the change here does not seem correct to
me, and the original version looks to be doing what it advertises.

Thanks,
Taylor
