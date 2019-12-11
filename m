Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3588C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 00:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB942073D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 00:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKey3BT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLKA3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:29:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43172 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLKA3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 19:29:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so809733pfe.10
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QbK0MLYXmyNIKXM1StMdvOENMX/JjksZbvgqSyvlG8=;
        b=jKey3BT2Jb2r58oYa21zLxZNeHngpw3WzEQLU1RWRNBWOFdTksbEVkcJyqQqgNtczJ
         Q9tQul1rMce3hMsdF+KMuWiWATAy2hZKnCbTB0ONFDVfUsktBf/kdC0PcEKXq3mClwKh
         +6d0cy3zWQPJOK10qkDzdt2xctbpRcCZQsraSdEEiL76e+sohZGYkxQRN7JZ2boHrkbI
         +mRyhQmpfqWBeRqOLw+rAc+8HYAqoe8iHr5G25lHATMHy9GGe3u3ds8akZxG7gsnnPn/
         tz3luPt5ccdQPulTNs69nzE0h30WgYaBDXdaTT322vmChCgvZinbcgcND8QoqMNt3/JG
         zO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QbK0MLYXmyNIKXM1StMdvOENMX/JjksZbvgqSyvlG8=;
        b=loe64rFt4dqUWuRw3tT3Bj3srXD7IPRI/kxC9d76ZUpmCBeF7axqxraiOpDdQjxXfV
         lkk1Kmveb0svtFfJi4l3G4E3RJ7W7AOlH+WB1I3BzixWJ9VcGLzn31nGJ8kPzznfP6KF
         qKgdzXYAlqQbYbi6vNeKCY3AJ+N4qlc6XkCcK5HFwBX2d7K+PGdK5mzYRB9uPtG8sg9x
         CmC14KyuXSYyZz5BVN61C3PAE06Q94jUTWrxf3GWJPuG4UXkJvCNL4U4ZylG5vHj6TlO
         +3GfpMqkmsgoA2OQVNWDjYMz4RfK46OAMQp+KhXSvYeP5Vy8qfuysdgLDeYI+kSvd8G1
         PCiA==
X-Gm-Message-State: APjAAAUPVmEEcyH3FPLyXegtFOyu1TanNhNOl4gduny1xZon54jwAcDl
        sHtT1tSRrGCsPu5efIginxiTBQ==
X-Google-Smtp-Source: APXvYqxrJQQGdDVtxsXbpzmhleBRuK1D1jxrA/HzVkHJZMD6FsIXVnEydRu/YAbi661kXnMMi5REUQ==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr1011280pgx.286.1576024179006;
        Tue, 10 Dec 2019 16:29:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z7sm211548pfk.41.2019.12.10.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 16:29:38 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:29:34 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/9] bugreport: add packed object summary
Message-ID: <20191211002934.GB107889@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-8-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281608170.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281608170.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 04:43:50PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 24 Oct 2019, Emily Shaffer wrote:
> 
> > Alongside the list of loose objects, it's useful to see the list of
> > object packs as well. It can help us to examine what Git did and did not
> > pack.
> 
> Yes, I was write! Packs are next ;-)
> 
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  bugreport.c         | 21 +++++++++++++++++++++
> >  bugreport.h         |  6 ++++++
> >  builtin/bugreport.c |  4 ++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/bugreport.c b/bugreport.c
> > index 54e1d47103..79ddb8baaa 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -219,3 +219,24 @@ void get_loose_object_summary(struct strbuf *obj_info)
> >  			    objects.nr);
> >  	}
> >  }
> > +
> > +void get_packed_object_summary(struct strbuf *obj_info)
> > +{
> > +	struct strbuf dirpath = STRBUF_INIT;
> > +	struct string_list contents = STRING_LIST_INIT_DUP;
> > +	struct string_list_item *entry;
> > +
> > +	strbuf_reset(obj_info);
> > +
> > +	strbuf_addstr(&dirpath, get_object_directory());
> > +	strbuf_complete(&dirpath, '/');
> > +	strbuf_addstr(&dirpath, "pack/");
> > +	list_contents_of_dir(&contents, &dirpath, 0, 0);
> > +
> > +	// list full contents of $GIT_OBJECT_DIRECTORY/pack/
> > +	for_each_string_list_item(entry, &contents) {
> > +		strbuf_addbuf(obj_info, &dirpath);
> > +		strbuf_addstr(obj_info, entry->string);
> > +		strbuf_complete_line(obj_info);
> > +	}
> > +}
> 
> Okay, but I think that you will want to discern between regular `.pack`
> files, `.idx` files and `tmp_*` files.

Discern in what way? How would you like to see them treated separately?
They're all being listed here, not just counted, so it seems to me like
I can read the generated bugreport and see which files are index, pack,
or temporary here.

> 
> > diff --git a/bugreport.h b/bugreport.h
> > index 09ad0c2599..11ff7df41b 100644
> > --- a/bugreport.h
> > +++ b/bugreport.h
> > @@ -24,3 +24,9 @@ void get_populated_hooks(struct strbuf *hook_info);
> >   * will be discarded.
> >   */
> >  void get_loose_object_summary(struct strbuf *obj_info);
> > +
> > +/**
> > + * Adds a list of the contents of '.git/objects/pack'. The previous contents of
> > + * hook_info will be discarded.
> > + */
> > +void get_packed_object_summary(struct strbuf *obj_info);
> > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > index b2ab194207..da91a3944e 100644
> > --- a/builtin/bugreport.c
> > +++ b/builtin/bugreport.c
> > @@ -68,6 +68,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
> >  	get_loose_object_summary(&buffer);
> >  	strbuf_write(&buffer, report);
> >
> > +	add_header(report, "Packed Object Summary");
> > +	get_packed_object_summary(&buffer);
> > +	strbuf_write(&buffer, report);
> > +
> 
> Hmm. At this point, I am unclear whether you want to write into an
> `strbuf`, or directly into a `FILE *`? I would rather have only one, not
> a mix.
> 
> Ciao,
> Dscho
> 
> >  	fclose(report);
> >
> >  	launch_editor(report_path.buf, NULL, NULL);
> > --
> > 2.24.0.rc0.303.g954a862665-goog
> >
> >
