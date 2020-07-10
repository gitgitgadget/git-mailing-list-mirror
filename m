Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CC1C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5156D20725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XQypuT3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJCUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgGJCUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 22:20:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55DC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 19:20:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so1935505qvl.4
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kNS6yqlBaLNrvr9csnBPN9Pbo8TSitfZ9hS51ZkMqTQ=;
        b=XQypuT3lUIUSIJbNviuzLxQL+DycJXv3i/R+w3u9vvomOUK3L3ey6tmXgu21L6VPBh
         HsC+Qw55g6f577RvwLjSApian4eaYm3FqqMekkmbmSa16ntlolvgU4IPY8kyQ0e/cXNW
         mJK64KDEBkseRnkEHubbXw3QVuojl3fUaOrpcmOOH3hyAp3iQ9PJ8ucqwKtoodsyNDG5
         OmbjzIfN6t9TJcBRGS3GZRk5hwkiTixqvaAXwygN8Mwbwj+a0hnDDth3QvMZ8X+OryS8
         RUwZ01Oya5HINNTEys5b/h3WSryYhWhQluM1Hyw19WPbqZwfBNstTUtJnqbJ1IonUB4O
         5s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNS6yqlBaLNrvr9csnBPN9Pbo8TSitfZ9hS51ZkMqTQ=;
        b=luySsYvKO6pMLskku3UvR61nc+FsRCKKt/ZKuoI8rwSvRInhmJP/biu2Sug00xZyNV
         sMAsmeIh4CzpwFM4028ArRvha5gspP2BkV8qGi7Oo1KXweMwccsEaVdzukeUT4FcaLyz
         WoQV3rpx+L1EikxpsccRQMW2/vNYWmLK2QQiP6mBqzUtQM5zK6o5CYd+fWz1DxN18Ahb
         k5HpWorykojv9bm5ZsJ9HEV1djqOpqTM9wq9ULsPUYlR0UOrZ5ghf4VJLngOArsPSJOz
         KCbmfnXeYZuqE5YrBLovyhcgYROvkvpdly0WHm4tNhddzLJEdN2diS+V+Ur1NQb9dXDN
         2huQ==
X-Gm-Message-State: AOAM532YXk3fGnh8sq5/HR9/03MSO9ylvVdlY0YJB3COV2gfPTgQrlsw
        R+p5iKg79pbExrYIZ1P5UDvcvEXURZq6gA==
X-Google-Smtp-Source: ABdhPJxXyLnD4UMDeja2cYf18kl/F3SNYm67ODOLBw7aD/w5Kdn55rpfX7OUzugr/7tr0vABsXfyNg==
X-Received: by 2002:ad4:4f09:: with SMTP id fb9mr57595666qvb.20.1594347641701;
        Thu, 09 Jul 2020 19:20:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4c16:d6c9:a96a:4df9])
        by smtp.gmail.com with ESMTPSA id u68sm6346179qkd.59.2020.07.09.19.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 19:20:41 -0700 (PDT)
Date:   Thu, 9 Jul 2020 22:20:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
Message-ID: <20200710022040.GB39052@syl.lan>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-3-emilyshaffer@google.com>
 <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 09, 2020 at 10:01:08PM -0400, Derrick Stolee wrote:
> On 7/9/2020 9:42 PM, Emily Shaffer wrote:
> > display_progress() and stop_progress() are tolerant to NULL inputs.
> > Remove some places where redundant checks are performed before these
> > NULL-tolerant functions are called.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  builtin/commit-graph.c | 3 +--
> >  commit-graph.c         | 3 +--
> >  read-cache.c           | 9 +++------
> >  3 files changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index ae4dc2dfcd..7964de3126 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -263,8 +263,7 @@ static int graph_write(int argc, const char **argv)
> >  cleanup:
> >  	string_list_clear(&pack_indexes, 0);
> >  	strbuf_release(&buf);
> > -	if (progress)
> > -		stop_progress(&progress);
> > +	stop_progress(&progress);
> >  	return result;
> >  }
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index b9a784fece..30d9a75932 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1424,8 +1424,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
> >  				    flags, split_opts);
> >
> >  	oidset_clear(&commits);
> > -	if (data.progress)
> > -		stop_progress(&data.progress);
> > +	stop_progress(&data.progress);
> >  	return result;
> >  }
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index 2ddc422dbd..feb7abe37a 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1581,8 +1581,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> >  		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
> >  		if (new_entry == ce)
> >  			continue;
> > -		if (progress)
> > -			display_progress(progress, i);
> > +		display_progress(progress, i);
> >  		if (!new_entry) {
> >  			const char *fmt;
> >
> > @@ -1614,10 +1613,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> >
> >  		replace_index_entry(istate, i, new_entry);
> >  	}
> > -	if (progress) {
> > -		display_progress(progress, istate->cache_nr);
> > -		stop_progress(&progress);
> > -	}
> > +	display_progress(progress, istate->cache_nr);
> > +	stop_progress(&progress);
> >  	trace_performance_leave("refresh index");
> >  	return has_errors;
>
> Looks obviously correct to me.

To me too, although note that this will generate merge conflicts with
Szeder's patch from earlier today[1].

Unfortunately, the conflicts are a little deeper than "we both removed
an unnecessary 'if' statement", since Szeder's patch moves the
'stop_progress()' call earlier to avoid a bug that I introduced.

This is just something for Junio to look out for while queuing,
otherwise I think just removing the hunk in builtin/commit-graph.c would
be fine, too.

> Thanks,
> -Stolee

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqq5zawy4x5.fsf@gitster.c.googlers.com/T/#mbd2d5236a7fecf1287be75ffa396f3776fc9b891
