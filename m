Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C48C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C22078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFGGvqCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgKETMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKETMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 14:12:43 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D35C0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 11:12:41 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so1453183pfn.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdU0oy+/D31y8kDrz+IKRJOU0IIuGa82nDwD0QayHCU=;
        b=nFGGvqCAWiEdoDSYSTydsPF1cH4C1PGmCgwRzwpzryU4AO1blZwGIpj18/9PcfCIQm
         JTy6dOaL7dIf1oC0ByqytB3tqk2lwso1vLIoMiBI5BIhtybKDWVZ5ZImMEDmuDB/R0/L
         RCLQYMrTflGOmkN15cBa9lftN6LsgBAEZ5sUVA7sWuyvJhk75wmDba1ZZR/7g9b6ZFEf
         sOHsJ97NAIz7YBpXOjeKiGaNIElagq+h6ZYR411WXkQ0l+YkzOBv8BWIUW+w2TiUoRyz
         kKvzyQGrmN1/VzO1uI8rTQKOhrkb5LQxdT8DVtMlWjwqTVq1kh3V1IFDKNWhm+HzGrPw
         WONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fdU0oy+/D31y8kDrz+IKRJOU0IIuGa82nDwD0QayHCU=;
        b=Ktcl+m9bGHndsraf7uVCWKnVkn6tauaOaBKA7C5JnZ4Qt/8u1TDxWDAHTWJI2k6jsL
         Hk4ioMbG90SGGKOkqR7vt6S18mUm8hBHa8pVfoqVxp79ghPuIxNqHMUad1Au8vQhCMXf
         BB4o5XMgNoAxWuNU8kOmEWdZwrctGiZYW7ZZe+aBq7k6SRpyGBRUyt8mD0ZdU9aKaZTF
         Dl/F6gd+D1U4GBqFswm+Siw0f1fxBTs5etIhyLNmTbuDhk/CWnRcRf83qFStV/8UeG0a
         9zWwvqPJAfq/vIW80XDqlKpikBCY8C1fJkDUHFj5ftEGfdavUVAlGAgJ0w2/CrvH81I7
         nGhw==
X-Gm-Message-State: AOAM533GdNjlF6xBghuhVHKiQPYxYSPKcWZqik8yvB90oJvQDZt3mzcK
        jMGSqzvG+EqYEkyXl3T3VXtkgwK+l80M9A==
X-Google-Smtp-Source: ABdhPJxEejtf8+RfYe4+1hAb+i7Z8QAUuS/nbB7NTPtRXnEH2Q2oOIctheRCCr+e38oGBPCc4J1W8g==
X-Received: by 2002:a63:d46:: with SMTP id 6mr3737482pgn.227.1604603561249;
        Thu, 05 Nov 2020 11:12:41 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id u10sm3401723pfn.101.2020.11.05.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:12:40 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:12:35 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 09/11] upload-pack, serve: log received client trace2
 SID
Message-ID: <20201105191235.GC36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <23f44bc904dfdd31f68a27c587b4b61df4bc0041.1604355792.git.steadmon@google.com>
 <xmqqeel8lso1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeel8lso1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.04 13:26, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 3bb01c5427..d938603c97 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -1058,6 +1058,7 @@ static void receive_needs(struct upload_pack_data *data,
> >  		const char *features;
> >  		struct object_id oid_buf;
> >  		const char *arg;
> > +		int feature_len;
> >  
> >  		reset_timeout(data->timeout);
> >  		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
> > @@ -1109,6 +1110,12 @@ static void receive_needs(struct upload_pack_data *data,
> >  		if (data->allow_filter &&
> >  		    parse_feature_request(features, "filter"))
> >  			data->filter_capability_requested = 1;
> > +		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
> > +		{
> 
> Style.  '{' block is opened on the same line as "if (condition)"
> ends, e.g.
> 
> 		arg = parse_feature_value(...);
> 		if (arg) {
> 
> Avoid assignment in the condition part of if/while unless there is a
> compelling reason to do so.  e.g.
> 
> 		if ((arg = ...) && further_check_on(arg)) {
> 			...
> 
> might be justifiable, but here, I do not see any such reason.

Will fix in V3.


> > +			char *client_sid = xstrndup(arg, feature_len);
> > +			trace2_data_string("trace2", NULL, "client-sid", client_sid);
> > +			free(client_sid);
> > +		}
> >  
> >  		o = parse_object(the_repository, &oid_buf);
> >  		if (!o) {
> 
> Thanks.
