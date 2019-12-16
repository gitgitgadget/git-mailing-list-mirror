Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB2C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E125206E6
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tr8SbvKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfLPX4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:56:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36446 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLPX4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 18:56:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so5218046pll.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fvk+ubssSnSvqfl7UYsJyx2KPDRzRDXerW5w5DoLh8g=;
        b=tr8SbvKexviZsVRDp/+arcco8fnIiDdQ13zWyMTDhS1UYvGzUsAgGA2yHeozNU81Tc
         tkc0OHtxxl6SJ7jWUgetn2WWCg8zTYaArweDGu6dcV5e/OELcklmLNBy2EHsK3EAdmeF
         kzte3JARQaBs2oMQ5s51NfNbrDvzCEzl1JRC6fm2JtJMkQKuhT4VVPnaIi0zh4y4vmu6
         /ToEUQ2V3S/Jnaob82sCD2qON680NIm3TIq2WNkOE4BP4sHhvO66Pic4iOxPdDQjeQCK
         mOrjJnwDtaqkPWftb3JEzHeJoGyTldCZOd3dNj0QI/x/ffkAUKsF0FGEyW/B6pYpwo/B
         eUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvk+ubssSnSvqfl7UYsJyx2KPDRzRDXerW5w5DoLh8g=;
        b=GygTpIMWrq9vF8HS087qkavMedXdJvg2eSeiLHZ8GSNDu6fpW8NvxhLlVMXw3RI2Qh
         dPxhdfsKt/hcPxJhUEzqtEJNuWrCAyxkZbBbPuwFF/OzocqivMWc1C6/mrtNYWPQL1e9
         5lXjh8pqK87qW7hkWKrNdWzVPkdMcGf7Sg/Qg87xDM/M8QmXNdD6rxbadXI3eRI2bSH8
         H5/wz2uxWEUcANbw44LRrjS75XoYKLz6utuqblgLskfdl+MtMXeXzkoUurpFdxX4R2bh
         oPX47DGFlCekZ34kJlvbqV6+8FYRw1E2ld/ZRUfr0UkwwlHkWbcLAGvpfXu+3I24/fnz
         GaGA==
X-Gm-Message-State: APjAAAWROKMOfauK/b1LsP4nuLh43IWLQ9vEkB9g0iFxRBKiqq/Jzsig
        KRwN7yipNQXcK4pQJOIauJtXpw==
X-Google-Smtp-Source: APXvYqxITBJ7kk8U+Opb54UlvYmyIhC8p3TWO9ufK/zeErDahraDTnn0RMFdu4dhyNlhS3+bevYSbw==
X-Received: by 2002:a17:902:8c90:: with SMTP id t16mr18959079plo.186.1576540580297;
        Mon, 16 Dec 2019 15:56:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d2sm679356pja.1.2019.12.16.15.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:56:19 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:56:15 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 13/15] bugreport: add packed object summary
Message-ID: <20191216235615.GN135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-14-emilyshaffer@google.com>
 <xmqqr217houg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr217houg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:56:07PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Alongside the list of loose objects, it's useful to see the list of
> > object packs as well. It can help us to examine what Git did and did not
> > pack.
> 
> Not exactly the same comment, but is in the same spirit, as the
> previous step applies to this one.
> 
> Would it be too much work to libify the bulk of cmd_count_objects()
> that computes numbers, making the cmd_count_objects() into a thin
> wrapper that calls the libified "counter/collector" function and
> prints the resulting numbers received from it?
> 
> That way, the get_packed_object_summary() can be another consumer       
> of the same "counter/collector" function, no?

That sounds like a good approach. Will do.

> 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  bugreport.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/bugreport.c b/bugreport.c
> > index 3abb83d77f..992d8f9de7 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -234,6 +234,34 @@ static void get_loose_object_summary(struct strbuf *obj_info) {
> >  	strbuf_release(&dirpath);
> >  }
> >  
> > +static void get_packed_object_summary(struct strbuf *obj_info)
> > +{
> > +	struct strbuf dirpath = STRBUF_INIT;
> > +	struct dirent *d;
> > +	DIR *dir = NULL;
> > +
> > +	strbuf_addstr(&dirpath, get_object_directory());
> > +	strbuf_complete(&dirpath, '/');
> > +	strbuf_addstr(&dirpath, "pack/");
> > +
> > +	dir = opendir(dirpath.buf);
> > +	if (!dir) {
> > +		strbuf_addf(obj_info, "could not open packed object directory '%s'\n",
> > +			    dirpath.buf);
> > +		strbuf_release(&dirpath);
> > +		return;
> > +	}
> > +
> > +	while ((d = readdir(dir))) {
> > +		strbuf_addbuf(obj_info, &dirpath);
> > +		strbuf_addstr(obj_info, d->d_name);
> > +		strbuf_complete_line(obj_info);
> > +	}
> > +
> > +	closedir(dir);
> > +	strbuf_release(&dirpath);
> > +}
> > +
> >  static const char * const bugreport_usage[] = {
> >  	N_("git bugreport [-o|--output <file>]"),
> >  	NULL
> > @@ -307,6 +335,9 @@ int cmd_main(int argc, const char **argv)
> >  	get_header(&buffer, "Loose Object Counts");
> >  	get_loose_object_summary(&buffer);
> >  
> > +	get_header(&buffer, "Packed Object Summary");
> > +	get_packed_object_summary(&buffer);
> > +
> >  	report = fopen_for_writing(report_path.buf);
> >  	strbuf_write(&buffer, report);
> >  	fclose(report);
