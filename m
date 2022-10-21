Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5C2C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 02:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJUCEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUCEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 22:04:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F95F1EEA1A
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 19:04:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e15so1192038iof.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 19:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bSXbwVPvg6ecvZQvTzfRyFnru0dFZTvNAv9XrqQMzA=;
        b=pSfQJUJgOqZEcQsMLjp+Jkl5tUQadUyMn6gNjb2+H96ZobvKQfEZmk41beX02IaqcA
         eU/kL9IxLmDKtAfN05qiknQMk5BVpply2g1PAltB4iFUZewFjDsWzOIqTHa37Sdr/Lsu
         SSt+/k127caipWUc7jnRoXGdiUTj7iJU6fKXhhZU7yjaNq8f/eRAdD4GVaa6wf7mNReM
         t4yqiY4q6tTOr6naAL5X0DR2KwhMnkA8mG3ZnUqIO8AF6OmliququivLFO1S37dMt9ga
         IOjlUGBhZ+H3FRXFzEzm+l5hChvkoRF9Vj5wlK9C7/12J30CuIVL465N0OZUK0rOF7Jy
         veGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bSXbwVPvg6ecvZQvTzfRyFnru0dFZTvNAv9XrqQMzA=;
        b=J1qWx89JmSNI0fZBJ4oU5fOyf/zeKXHcAiicHyoLkChcirlGG1zSYoAaxXQmhc5kHM
         S4fI9qwAXhptJ6yEJ+XZLwh74WWANdS1oN47sk+QgtLwsyLQSM4Fqsy2GUUQz7WMalct
         IkKfyrx33Zia2RClMWXroAfUiMSAZl5rQKMG2QwDYb3w0nbe0R3pEc8fItR6MMPdFWG/
         xaupp6eChbV5Eyzgt3OA5jJVjKBFqxb2KAvoglg0LIWT4+Gxhna0NxQHgc24ljs3ICcM
         anxP5DrHSVXYLPytz/4+PVvmEMZgnbmD1PQAwGlhM1HCCy4NhhmmctpxubGFeFVz0Rzt
         RyrQ==
X-Gm-Message-State: ACrzQf3U7BtF193RswveTRJhBaj8qvwswHvfS4s507ZXVyqjfpZ2eZ6a
        b0TA8UYPjZQcgbM/sqGRKrX9LOO79kpX/xds
X-Google-Smtp-Source: AMsMyM7QKXeRdquCwm80NitSnMiBptFIHlfduRZmg2c6LsXT2MU+Tp5jR+tpq1O70g/Nanx5+szNAA==
X-Received: by 2002:a05:6638:42cc:b0:363:740f:8f2e with SMTP id bm12-20020a05663842cc00b00363740f8f2emr13845129jab.27.1666317840818;
        Thu, 20 Oct 2022 19:04:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l9-20020a922909000000b002f9f001de24sm3642506ilg.21.2022.10.20.19.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:04:00 -0700 (PDT)
Date:   Thu, 20 Oct 2022 22:03:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y1H+DyZknfcQ+YAV@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
 <Y0TLf/J22ioQ5UCt@nand.local>
 <Y0TRxDRFRgFonhtH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TRxDRFRgFonhtH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 10:15:32PM -0400, Jeff King wrote:
> > > > @@ -439,8 +440,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
> > > >  	log.file = rev.diffopt.file;
> > > >  	log.date_mode = rev.date_mode;
> > > >
> > > > -	if (!log.groups)
> > > > -		log.groups = SHORTLOG_GROUP_AUTHOR;
> > > > +	shortlog_init_group(&log);
> > > > +
> > > >  	string_list_sort(&log.trailers);
> > >
> > > Now that we have a "finish the shortlog init" function, probably this
> > > trailer sort should go into it, too. The current caller doesn't need it,
> > > but it removes on more gotcha from using the shortlog API.
> >
> > We'll drop this list by the end of the series, too, so it probably isn't
> > worth moving it into shortlog_finish_setup() in the interim.
>
> Ah, right. Well, see my other comments. :)

Seen ;-). Now that this series no longer touches the log.trailers bits,
we should move this around. Done locally, will send a reroll shortly or
tomorrow.

Thanks,
Taylor
