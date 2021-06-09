Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518AAC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E283613E6
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFIUUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:20:22 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:40648 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIUUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:20:21 -0400
Received: by mail-pg1-f173.google.com with SMTP id j12so20591004pgh.7
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A9fEOIDGGFctv/hGibLauNm0ly0j+fmgrHjfqxg7yr8=;
        b=QmAIl+CnoGSJI9iZrRDWBg4WJBRVwDfh+2uRYWzcTyeGiXTnrvyWHoPgYXBHSeyptI
         rwVoHe8Xl/t5GFGgFokvYdV/BQPtYdTquXlzilGw5KkrTNIxFRxV/AzrPXmp6i5ErG6O
         x8slV8lOLF/t6MT5kQFAz3PMOHvlUDDRDOTr2ENCUl/vXRnbGYC1wW6oT5Mxy4V53r8f
         osAh4LlwUqB3a3IgVngey/E0NwEJSpp/wBhgxNT6OBjGs5StEygLFyWM3MMRcwBDg9AX
         RZ+s29A3ZFBDdfkbB29sMTDFbdeE1ZtfSCmfxjm4M/l8zj5/b4O22D8QWBfrdq9yU25x
         y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A9fEOIDGGFctv/hGibLauNm0ly0j+fmgrHjfqxg7yr8=;
        b=jo9CaR2KmUaM3jTWMqkHvTRld0QsRv/LG18QGDK1iWKWjKGcIdJht3hKZZhGiBfo3a
         nHS4HC4HflLEuqHFbXjvlp7u1gimvAiq5qQun3gWS6Bac72lwi4xVqqKnqLF5EM48xML
         exNnJfl+vbRyOVMb0vZmwMIJ/2bOKW4XMzRJ/BLbtmM0NNPmaLgFAhP3UPpzw4DCrdfX
         fY56heCSwguLwogEyegTkOqXPrnSEgxfzcpMwV234FKuPpGdADxR15BoBzB2Yjgtyw3f
         WTp5MTQH8ZlyQyoaNKJbYfGgBmVUagYWfDzjGgOv9vi8vV0ctORM9X+k5s+8OZaVlSmw
         wvuQ==
X-Gm-Message-State: AOAM532jhFo3VmP9CKGK6sTVCh4NPzgzZ4gL9hvaKGFcBMIvGfydEhK+
        uXVoJ+u4R5NGXMxJrWaWb6k4TftnlzxvfA==
X-Google-Smtp-Source: ABdhPJxPXnXPSbDork1xkhgzMxPPvCJGsAUkWDNFKsTB7jxv4/+kvLlgWNn7NZaDmbNhtTU77oKf7w==
X-Received: by 2002:a65:6a0f:: with SMTP id m15mr1374469pgu.253.1623269846790;
        Wed, 09 Jun 2021 13:17:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2f68:a87b:28f9:3d54])
        by smtp.gmail.com with ESMTPSA id m5sm517898pgl.75.2021.06.09.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:17:25 -0700 (PDT)
Date:   Wed, 9 Jun 2021 13:17:20 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff Hostetler' <git@jeffhostetler.com>,
        'Bagas Sanjaya' <bagasdotme@gmail.com>
Subject: Re: [PATCH v5] tr2: log parent process name
Message-ID: <YMEh0P3sVM8qMZji@google.com>
References: <20210608185855.668050-1-emilyshaffer@google.com>
 <20210608221059.1935021-1-emilyshaffer@google.com>
 <023201d75cb4$02006d10$06014730$@nexbridge.com>
 <YL/uNYuADscBJUu2@google.com>
 <023701d75cb7$1ff995a0$5fecc0e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023701d75cb7$1ff995a0$5fecc0e0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 06:39:15PM -0400, Randall S. Becker wrote:
> On June 8, 2021 6:25 PM, Emily Shaffer wrote"
> >> We are probably going to have to discuss this one at more length. On
> >> NonStop, in some cases, I have access to the program arguments of the
> >> parent (rather like ps -ef) in POSIX-land, but not from the other
> >> personality. I do have access to the program object name, in both
> >> sides, although if someone replaces the object - which is not actually
> >> possible for a running program, but a rename is - the object may end
> >> up being somewhat meaningless or mangled. My suspicion is that I'm
> >> going to have to supply different things for the two personalities,
> >> but I'm not sure what as of yet.
> >
> >I guess I'm having trouble understanding - it sounds like you're
> >describing one process with a graph of ancestry instead of a line.
> >Does that mean we shouldn't be tracing the ancestry the way we are?
> 
> It's more like this (g = Guardian, p=Posix, for illustration), for a
> typical interactive situation coming from the non-POSIX side):
> 
> gMonitor -> gAncestor1 -> gAncestor2 -> pAncestor3 (/bin/sh) -> git
> 
> And when started from an SSH window:
> 
> gMonitor -> gAncestor1 (SSH) -> pAncestor2 (/bin/sh) -> git
> 
> I can get the program object name from any of the above, and the pid
> from a POSIX process, or the name (or cpu and process number) of a
> Guardian process. In the case of POSIX, obtaining program arguments
> may be possible. An ancestor, as with Linux, can have multiple
> children in a tree but a child can only have one parent - well,
> technically one at a time anyway because there are some funky
> exceptions where a child can adopt a different parent in
> Guardian-land. In both cases, I can get the program object file of the
> process (like /usr/local/bin/git), but if someone renames git because
> an install happened during a long-running operation, like git gc
> --aggressive, the object may be named something else, like
> /usr/local/bin/ZZLDAG01, for argument sake).

Interesting. One thing that might be helpful (if you don't care about
the later name, since it looks like it might be junk) is that
trace2_collect_process_info() provides some hint about when it was
invoked, via the 'enum trace2_process_info_reason' arg. So if you're
worried about a long-running process being renamed, the
TRACE2_PROCESS_INFO_STARTUP reason happens very early in common-main.c.
(And you could capture info like "the name changed later" at
TRACE2_PROCESS_INFO_EXIT if you wanted.)

> I'm not sure any of this is really relevant, but describes some of
> what is possible. It also might be useful to pull out the tty that the
> process was running on. That is easy to get if the terminal is still
> connected. I think that particular bit of information might be very
> useful, as well as user information.
> 
> -Randall
> 

(I don't have much insight into what would or wouldn't be useful to log
here in your case, but I will say that it all sounds very cool and I
appreciate your thorough explanation.)

 - Emily
