Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77EC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902A12166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0mGIT6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgBDWye (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:54:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDWye (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 17:54:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so120318pfc.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0ublwM1OPCYAgbY+ApzKgjS/Tl3POX+CugIillfGGA0=;
        b=K0mGIT6f9cWP2qQy3WCxS9a/P/iBducweS+2K53sF7i/VYkT3a08RUewkF8tuatiPo
         QApCUH5KOavJnc+QhkWhG6TpZ1SV+TDZg8EFEUE7+JNcbq8Xglzx7LoHcdVImhihJL2G
         9mhwmcHD4v95Pgwy/we2gAXUCx7pd9na7eRD6jeFbWGxuqeN2UxmYwSeKBy1YDB2KIW8
         LdychJLQ/jOIMxwz/Rgt8mKHXfjYTi7jiV81RtxBWfeO08MeMKwDXDK4U7OMJtB0bABD
         9OcVidqrCJYaQTPyIAx+Z4lEYOiYgWWZmlsxXCh0ISB+5fuaqZxxmRuY71mOwR9uTMYr
         36SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0ublwM1OPCYAgbY+ApzKgjS/Tl3POX+CugIillfGGA0=;
        b=iVlegRCuXEfSVZJKD1F2sxutG+XAQVw8UrmaOmkrANRUOTudE/R93DDJE+KVhV30aq
         LJmtwgKRhreHQDplZVvxPHhEkn1jqA0f8RjIFmgh7aaoOsFFMezBMpdd9QqNbod5ew/C
         KsUq2fQlKxFwbWFlHmCvaSHpKlpcVHhHwn456irNQ+QdJVZVZknlwgRIelflVewoc+AC
         1RkcauhlU7WILC4Hk3TvQcYSt341sgAyEKGb1h33JEcatr6bulCXIb1RFLiFCcbLW626
         TfPju6QoRPTMd7LnB71o+c48qHFcOq0q5TR/AJN5BOMQzbZO6bBC2S61QG3f19/hxTtk
         b2bQ==
X-Gm-Message-State: APjAAAUrEBImp0Kqgg/W/+8hJZIz1wupqk38KMfOEPMh4Vg9/thyEtEF
        578qkRo9X8902QcAFn2ey7+MsMiMUdk=
X-Google-Smtp-Source: APXvYqyLhTLJI90xOH+4oZ/RlgZWey6m97hDOqU3ngs6qWN16+duaTVrmJ4ewjEcNzSp+DzYOdUDRw==
X-Received: by 2002:aa7:9a42:: with SMTP id x2mr29892344pfj.71.1580856873381;
        Tue, 04 Feb 2020 14:54:33 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u13sm4707334pjn.29.2020.02.04.14.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 14:54:32 -0800 (PST)
Date:   Tue, 4 Feb 2020 14:54:28 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 07/15] bugreport: add curl version
Message-ID: <20200204225428.GF87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-8-emilyshaffer@google.com>
 <CAN0heSqiMvMopqpMrnOffsO-nZ6UPWbuHQdB9VxLhWhm-d95rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqiMvMopqpMrnOffsO-nZ6UPWbuHQdB9VxLhWhm-d95rA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:27:45PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:41, <emilyshaffer@google.com> wrote:
> > +static void get_curl_version_info(struct strbuf *curl_info)
> > +{
> > +       struct child_process cp = CHILD_PROCESS_INIT;
> > +
> > +       argv_array_push(&cp.args, "git");
> > +       argv_array_push(&cp.args, "remote-https");
> > +       argv_array_push(&cp.args, "--build-info");
> > +       if (capture_command(&cp, curl_info, 0))
> > +           strbuf_addstr(curl_info, "'git-remote-https --build-info' not supported\n");
> > +}
> >
> >  static void get_system_info(struct strbuf *sys_info)
> >  {
> > @@ -31,6 +43,10 @@ static void get_system_info(struct strbuf *sys_info)
> >         strbuf_addstr(sys_info, "compiler info: ");
> >         get_compiler_info(sys_info);
> >         strbuf_complete_line(sys_info);
> > +
> > +       strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
> > +       get_curl_version_info(sys_info);
> 
> The header here looks a lot like an implementation detail of
> `get_curl_version_info()`. Or put differently, these risk getting out of
> sync. Maybe frame the header a bit more human readable: "curl version".
> But is this "curl version", or more like "git-remote-https version"?
> There's some discrepancy here.

Hm, I think you're saying "If we switch to future-https-lib instead of
cURL for git-remote-https, then this command will be incorrectly named."
Sure, I agree. It's true that with this change git-remote-https also
tells us some info about itself.

Thanks.
 - Emily
