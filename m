Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBCE7D0AB
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 22:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjIUWGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjIUWF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 18:05:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381CB48A8B
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:12:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5780040cb81so1016625a12.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695330719; x=1695935519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wry1rdk5h1w2hHiEIg82WeZNrDTTBq97LT1f5rKWzp4=;
        b=ZAyLDKGjBvJYn8/Lx9Y0ExEYwpelb+EPVw5rGwRCrKsVhNQedElWsV3UBwXLTB9SLA
         q5QqVeHddrbjvd0+exfR2OilAmIk9lKFM++DzUk9n+C8OTdpPjWGkmcBDIhoP8KMkUPB
         qztDY+g9ipjvqKC/U6qy5Eb9T7skbZTus6FJjDlmyHUg/G1a/zOIICOtr91GqQuHGZdB
         8k6Ho8cMAr5HFQNu6etPuYqAGkVLYQuhfeSnj1cBJJPb2bhT868grfLEmOPfAWwqY57B
         ybY/g3sw6yEfBmP71auf8tn07nVWIG7Cn/hsNhhurof1eSeGExsCODuZgyRsOpp/yVcK
         gxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695330719; x=1695935519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wry1rdk5h1w2hHiEIg82WeZNrDTTBq97LT1f5rKWzp4=;
        b=TxOVIWbLhSRTdoj7Z1HUWCk19Ooxjsu1ASpL/P+SGCBE5ZqU6efyyGD4RsHSmYV+Ul
         ZSV152KcF0sVo/xtch+pSdv3pCdgc/9az7HqkHTUcYlMGgTStilE+KO7tAt8T1bySlaz
         4N34KjLVp+pX2V4rUwAzDCaP9CJwxpzWtMQ8LYHiVoVyi5JdxRj1QdP9jH/vqSsJi6/h
         qmYJLfuw0Y0h0MzBi+5yMNSW2AmWXfiIt6zKRbR/Xi5kLLf6wfsnluinzpAyUrJDYmOP
         JDkgGLCOr935ZEFIWdxwYYgc1z4RBOU3baIZ4C/y+fOWoLhKAP9nPvFmzu9ZzIYHTIid
         iUvA==
X-Gm-Message-State: AOJu0Yw9X2oIAaySsRAcgp5Sy08xWhmFfvN1VCtxt5QjoWHqh7BAB2Cr
        Vyk+FnarYKU8YP4r/k0Q3r/Akg==
X-Google-Smtp-Source: AGHT+IGFiRmwhZdInBPm3apXgG5XoVCZOW/e4y3tXzovWZkUw2N9LtbDuiNnDtY4ecIPYXUdMh33fw==
X-Received: by 2002:a17:90b:38d2:b0:263:72fe:3ef7 with SMTP id nn18-20020a17090b38d200b0026372fe3ef7mr6140556pjb.42.1695330719303;
        Thu, 21 Sep 2023 14:11:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00276fef82025sm989945pjf.35.2023.09.21.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:11:58 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:11:54 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v2 2/4] config: report config parse errors using cb
Message-ID: <ZQyxmq7HB12/+YYv@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
 <cover.1692827403.git.steadmon@google.com>
 <cb92a1f2e3098bede386d04da32fcc4f27fca51f.1692827403.git.steadmon@google.com>
 <xmqqttspck4a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttspck4a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.08.23 18:19, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > From: Glen Choo <chooglen@google.com>
> >
> > In a subsequent commit, config parsing will become its own library, and
> > it's likely that the caller will want flexibility in handling errors
> > (instead of being limited to the error handling we have in-tree).
> 
> And the in-tree error handling is abstracted out as the
> git_config_err_fn() function; in other words, we become the first
> client of the library interface, which makes sense.
> 
> > @@ -1035,8 +1088,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
> >  	int comment = 0;
> >  	size_t baselen = 0;
> >  	struct strbuf *var = &cs->var;
> > ...
> > +	/*
> > +	 * FIXME for whatever reason, do_event passes the _previous_ event, so
> > +	 * in order for our callback to receive the error event, we have to call
> > +	 * do_event twice
> > +	 */
> > +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> > +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> > +	return -1;
> >  }
> 
> This indeed is very curious and needs to be looked into before we
> proceed further.  How does the current control flow cope with the
> behaviour?

As Jonathan Tan mentioned in [1], on calling do_event() we set the start
offset of the new event, and execute the callback for the previous event
whose end offset we now know.

I refactored this into "start_event()" and "flush_event()" functions as
suggested, and added a new "do_event_and_flush()" function for the case
where we want to immediately execute a callback for an event.

[1]: https://lore.kernel.org/git/20230804213457.1174493-1-jonathantanmy@google.com/

> > @@ -2322,7 +2342,9 @@ void read_early_config(config_fn_t cb, void *data)
> >   */
> >  void read_very_early_config(config_fn_t cb, void *data)
> >  {
> > -	struct config_options opts = { 0 };
> > +	struct config_options opts = {
> > +		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
> > +	};
> >  
> >  	opts.respect_includes = 1;
> >  	opts.ignore_repo = 1;
> 
> This uses a bit more assignments to various members of opts. to
> initialize it, which could have been done with designated
> initializer, like the one in read_protected_config() used to do.
> 
> > @@ -2760,12 +2784,14 @@ int repo_config_get_pathname(struct repository *repo,
> >  static void read_protected_config(void)
> >  {
> >  	struct config_options opts = {
> > -		.respect_includes = 1,
> > -		.ignore_repo = 1,
> > -		.ignore_worktree = 1,
> > -		.system_gently = 1,
> > +		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
> >  	};
> >  
> > +	opts.respect_includes = 1;
> > +	opts.ignore_repo = 1;
> > +	opts.ignore_worktree = 1;
> > +	opts.system_gently = 1;
> > +
> 
> It is curious why you want to switch to manual assignment, instead
> of keeping the designated initializer for this one.  I would have
> expected the initialization in read_very_early_config() to start
> using designated initializer to be consistent, instead.
> 
> Thanks.

Agreed, fixed here and above.
