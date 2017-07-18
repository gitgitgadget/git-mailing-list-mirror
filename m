Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150CC2029F
	for <e@80x24.org>; Tue, 18 Jul 2017 16:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdGRQj1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 12:39:27 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36518 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdGRQj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 12:39:26 -0400
Received: by mail-pg0-f51.google.com with SMTP id u5so15525505pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbe7reIX/f+relcnLHu9381EvaL0Y7eRYch5AAN41ow=;
        b=baMpN2Gt9gGjegFSsDXKn4Bgfj+Sr5RA9RHNEggI1Cs99BQxKlNTGxQpx6qoER8WZI
         +AQEBVgdVpcFz8M+B6DdWHXJguIaJKq/z5MC92HgMWiQqDy6YTzD7A4joTsSOk8Hc4ve
         2GTSeQDTgy3gy0mU/SvwmMo8w8wMMl3up5SdUPw/M0zvp+xf0Idp8UYxj/kuovsaeAHD
         LA69j9l5EEsU11chAyzlr120aSUS9Ji4ErV+EnL5FXuMkC632BuN1GikoxXXTpbMmd/f
         Ns4X5OebnMoL2Lfn7RJcdq4htuFpaWhL4wpmT1ALFfW3+SfSO61IQMA5JapKQTwoCGGc
         57WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbe7reIX/f+relcnLHu9381EvaL0Y7eRYch5AAN41ow=;
        b=blfNE1RzrUMHHMGKKFxttEDoRZWvJP76eNvHlVMqdkE8A8Ru8UnzjncjEPFtqNGwR3
         LRkFZL/H8BW3rBSShE0RteTLmhpgjAp6fqJb2Flwmcu6Ak2bnu2+1t+4WRq6E3r7B3t3
         uiQX5Bi8WMq1XbobgpIVuT8BIQDcxt3dTwSLMTpeCrVnY17a+qp0aUvUIYBax6y81ix5
         TCAN9AXrc9+/4MxSaFA4qWOnvkDp1T/KsrQJw8Yn/A/M1x040eiQDm2MN/v/a93GUBtV
         g59x7Vjaxw5N0boeaukZWOmH2QSTTeAJh38rzMG2z1+Sbj5Wj8ZxdlNRZQNhP9mcID/A
         2TzA==
X-Gm-Message-State: AIVw111RHpRbeQcVN54oGzxCFHHGglVeorpuMo8G3ZEUSu5m2cttAy5P
        /oeJTG+RAvPX6usl4dSyKA==
X-Received: by 10.98.198.87 with SMTP id m84mr2618310pfg.122.1500395965735;
        Tue, 18 Jul 2017 09:39:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:ace9:96f8:8e38:5051])
        by smtp.gmail.com with ESMTPSA id q19sm4954843pgq.51.2017.07.18.09.39.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 09:39:24 -0700 (PDT)
Date:   Tue, 18 Jul 2017 09:39:20 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 8/8] sha1_file: refactor has_sha1_file_with_flags
Message-ID: <20170718093920.3265c67f@twelve2.svl.corp.google.com>
In-Reply-To: <CAP8UFD24QVAuTXXH3zvR5zwZwub20o37uGyt8Uf+rRtjjk8QTA@mail.gmail.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1498091579.git.jonathantanmy@google.com>
        <a4f04b3ec9cc1ba08a5dd7f459dce95411fb03e2.1498091579.git.jonathantanmy@google.com>
        <CAP8UFD24QVAuTXXH3zvR5zwZwub20o37uGyt8Uf+rRtjjk8QTA@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Jul 2017 12:30:46 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> On Thu, Jun 22, 2017 at 2:40 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> 
> > diff --git a/sha1_file.c b/sha1_file.c
> > index bf6b64ec8..778f01d92 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -3494,18 +3494,10 @@ int has_sha1_pack(const unsigned char *sha1)
> >
> >  int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
> >  {
> > -       struct pack_entry e;
> > -
> >         if (!startup_info->have_repository)
> >                 return 0;
> > -       if (find_pack_entry(sha1, &e))
> > -               return 1;
> > -       if (has_loose_object(sha1))
> > -               return 1;
> > -       if (flags & HAS_SHA1_QUICK)
> > -               return 0;
> > -       reprepare_packed_git();
> > -       return find_pack_entry(sha1, &e);
> > +       return sha1_object_info_extended(sha1, NULL,
> > +                                        flags | OBJECT_INFO_SKIP_CACHED) >= 0;
> >  }
> 
> I am not sure if it could affect performance (in one way or another) a
> lot or not but I just wanted to note that has_loose_object() calls
> check_and_freshen() which calls access() on loose object files, while
> sha1_object_info_extended() calls sha1_loose_object_info() which calls
> stat_sha1_file() which calls lstat() on loose object files.
> 
> So depending on the relative performance of access() and lstat() there
> could be a performance impact on repos that have a lot of loose object
> files.

That is true, but from what little I have read online, they have about
the same performance.
