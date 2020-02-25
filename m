Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C0C4BA06
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCCC2075D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdFRoBdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBYX6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:58:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34688 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBYX6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:58:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so1527171pjq.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 15:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4a95Y0KnV5Ci9HBSvZITmGiR77t5xWotJBQH68WwSjQ=;
        b=CdFRoBdcaLqVErWSMc9WBnlo7eJBVNcKvBRt2S6O42VGx9yBm/4w23SR9CsrCGE47w
         Q2uBw1RHmQToVs8rMIqhjuY7c13ZUWecCerxWd3ag16ZOFPCHzOK1063DsNoAWPH2Okv
         978QNt2e5Ibp1na1yr2e/kAWUDW1+7QiixIINXjn9ANoVrzMw3JZVHgNeY4mxtRh1fbZ
         C7AUYhOiDj6Q8pDGb+tgqqAATame5wAPN/9GRXIx0kX3K+mxvVoG3XDKd3swdtaovwYu
         77fRXi167uqWup/zVFxO459a5co0pN3Tke+3duU+o5dNx+hycuzh54LWJE3NNl7MYE9O
         43yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4a95Y0KnV5Ci9HBSvZITmGiR77t5xWotJBQH68WwSjQ=;
        b=IBob8OzwmvIVC9dec8YOCGBeC/2egrndl1frxXlEQYTJcso2xqpOkyk80ggi/ZzWfH
         UYY2qR16TChZtzvsTmCY2uVI+3jw/eszlzppqbECkzVMzfz8Q138sv9CjtQpU/XwisoC
         OKejpRSp6cEAwJqWGlSCIN9sKIEZqZecCh03JFm1ur6pjPCYCWn5YuOqGCOa51y6YfkG
         wO2SqusZPaNPoBKsP4K7njmY939AisMWeta1x68BYhAPMdpNWqF04e7fUtAiLmqJ8seY
         iJ0wG8z848Qbd6qPBnmya/7UcIflr9BZqkY93XCW7hMSfre5IfHLKN6nRE1Kq8tD1lIE
         xpGg==
X-Gm-Message-State: APjAAAVl+2LJGXj14xR0GwnQ0mVuYhFhUrV+YuYn7vnoRdcsbjaU3f3l
        sm76qqfmkSOTHZ44ebu41GmvMA==
X-Google-Smtp-Source: APXvYqxYhl7/zOWO9qkynUSHT5SdqPf2JYtQuKjyoOpE1x4o4ZAp/rxdr417ldBNpS+E2pKXA42zmw==
X-Received: by 2002:a17:90a:fa8d:: with SMTP id cu13mr1769079pjb.68.1582675131745;
        Tue, 25 Feb 2020 15:58:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r17sm138217pgn.36.2020.02.25.15.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:58:51 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:58:46 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 13/15] bugreport: add packed object summary
Message-ID: <20200225235846.GH212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-14-emilyshaffer@google.com>
 <xmqq1rqoapa3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rqoapa3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 02:04:52PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +static void get_packed_object_summary(struct strbuf *obj_info, int nongit)
> > +{
> > +	struct packed_git *pack = NULL;
> > +	int pack_count = 0;
> > +	int object_count = 0;
> > +
> > +	if (nongit) {
> > +		strbuf_addstr(obj_info,
> > +			"not run from a git repository - no objects to show\n");
> > +		return;
> > +	}
> > +
> > +	for_each_pack(the_repository, pack) {
> > +		pack_count++;
> > +		/*
> > +		 * To accurately count how many objects are packed, look inside
> > +		 * the packfile's index.
> > +		 */
> > +		open_pack_index(pack);
> > +		object_count += pack->num_objects;
> > +	}
> > +
> > +	strbuf_addf(obj_info, "%d total packs (%d objects)\n", pack_count,
> > +		    object_count);
> > +
> > +}
> 
> Makes sense.
> 
> > @@ -447,4 +448,9 @@ int for_each_object_in_pack(struct packed_git *p,
> >  int for_each_packed_object(each_packed_object_fn, void *,
> >  			   enum for_each_object_flags flags);
> >  
> > +#define for_each_pack(repo, pack) 		\
> > +		for (pack = get_all_packs(repo);\
> > +		     pack;			\
> > +		     pack = pack->next)
> 
> I generally avoid #define'ing a control loop pseudo-syntax unless it
> makes the resulting code hide overly ugly implementation detail.
> 
> for_each_string_list() is there to hide the fact that items are
> stored in an embedded array whose name is .items and size is .nr
> that is sufficiently ugnly to expose, but iterating over packs
> does not look so bad.
> 
> If you MUST have this as a pseudo-syntax macro, we need
> 
>  - to match for_each_string_list_item(), have iterating variable
>    'pack' as the first parameter, and the scope of what's iterated
>    'repo' as the second.
> 
>  - to make sure the syntax works correctly even if a parameter is
>    *not* a simple identifier (I think the above is OK, but there may
>    be cases that it does not work well).
> 
> Regarding the latter, the way 'item' is incremented at the end of
> iteration in for_each_string_list_item() is subtle and correct.
> 
> #define for_each_string_list_item(item,list)            \
> 	for (item = (list)->items;                      \
> 	     item && item < (list)->items + (list)->nr; \
> 	     ++item)
> 
> You would break it if you changed pre-increment to post-increment
> for a user like this:
> 
> 	struct string_list *list;
> 	struct string_list_item *i, **p;
> 	p = &i;
> 
> 	for_each_string_list_item(*p, list) {
> 		...
> 	}
> 
> because ++*p is ++(*p), while *p++ is (*p)++, and we do want the
> former (i.e. increment the memory cell pointed at by pointer p).
> 
> Personally, I would prefer not to introduce this macro if I were
> working on this topic.

Ah, I thought this is the kind of thing you meant here[1]. But I agree
with what you point out about the shortcomings of this kind of macro.
The implementation details are not so ugly; I'll drop it.

 - Emily

[1] https://lore.kernel.org/git/xmqq8sli89eu.fsf@gitster-ct.c.googlers.com

> 
> >  #endif /* OBJECT_STORE_H */
> > diff --git a/packfile.c b/packfile.c
> > index 99dd1a7d09..95afcc1187 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -2095,8 +2095,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
> >  	int r = 0;
> >  	int pack_errors = 0;
> >  
> > -	prepare_packed_git(the_repository);
> > -	for (p = get_all_packs(the_repository); p; p = p->next) {
> > +	for_each_pack(the_repository, p) {
> >  		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
> >  			continue;
> >  		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
