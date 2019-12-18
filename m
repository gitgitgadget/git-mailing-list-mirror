Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1B6C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94762227BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9176xgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLRLuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:50:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43751 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRLuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:50:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so1392080edb.10
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UgUkJdkHRNAZwO7ua4YaZrSfjHki8hFHv5sEXNEw8bc=;
        b=o9176xgNsIoeKRH2KY1z+wLcu59LfODnVJnq3tKmXaL5lEG1KICE5hVT4c3sYgVEBl
         bal9ZqD6oVlW1a3bIEPnfVVx8dtgaLeYTWVAzqFPf6PJoGkMflv5NfI6jhUJZOxnzNpZ
         S5uVVJhh0yOFuqls/gTotSJOJpsTFDQa6ewRM7bRSEvORwLLkR0YqGiRINha//hfpObq
         VuqhMYw/oPPFzCMsBIvH2o3AkaHs4kMtVkAS0J69IrUW4gCv1uc2Xg0GDWqNQDQy+zhm
         CsdYC41BN0xWwKUTRPYFzR61DnaPuHdIxEkdTgtNlB6YW3muvTSTeWWb0+HLnlqZ/w5N
         /rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UgUkJdkHRNAZwO7ua4YaZrSfjHki8hFHv5sEXNEw8bc=;
        b=oY9ncuAuL4qnnV/2azuyYGtDGDqGY50yfkfaHuXQUV45KRPAOS0RluDj85seWMbw2z
         8RwLGoadlh3cJkrB0QvaiVr3UIchoshE/l/c9D0J28Hr3WP5H60x6lcPjNV7hEkHvx8+
         G4WP2ZBpMZuxSWoPD+I3JMUlvE1qEsA+7RGVVCyHXyDKTJAacYxjovAqdjrRAIqIBlKX
         D0aspMBP7nIo6L0yzg6Ocipn6BGxfjlBMjYe5Vn+RpIc27c7woA4WqjfE/vs6bJTz9Jw
         TNFqksc1waPy7LOZmUMJ6AoT7Hq5a9nQycCkcb/4G9SawSJevfwM3C+mczmMViLzcY+6
         qtYA==
X-Gm-Message-State: APjAAAW1+12RJRibf0SPFGdNhwmms8+lrID1SQB3tAhvYGVgCXk3Rc+c
        F8WQux55Ghiq6XQgrji56EY=
X-Google-Smtp-Source: APXvYqzFo3CqgWMKt8DWP33IDzCmBtG2tpr6IkHn0MYPm7/IDU6x6Pwz1oL4+N1d3sO1q4dFmZKcYA==
X-Received: by 2002:a17:906:a3da:: with SMTP id ca26mr2209773ejb.332.1576669799134;
        Wed, 18 Dec 2019 03:49:59 -0800 (PST)
Received: from szeder.dev (x4db36940.dyn.telefonica.de. [77.179.105.64])
        by smtp.gmail.com with ESMTPSA id p18sm79981ejx.80.2019.12.18.03.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 03:49:57 -0800 (PST)
Date:   Wed, 18 Dec 2019 12:49:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex
 must match in starting revision
Message-ID: <20191218114954.GC8609@szeder.dev>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
 <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
 <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com>
 <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com>
 <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
 <d8e753ec-2835-331f-99de-35a4a5369b48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8e753ec-2835-331f-99de-35a4a5369b48@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 05:55:25AM -0500, Derrick Stolee wrote:
> On 12/17/2019 10:28 PM, Philippe Blain wrote:
> > 
> >> Le 17 déc. 2019 à 13:16, Junio C Hamano <gitster@pobox.com> a écrit :
> >> Even when you specify <start> or <end> as a line number, they must
> >> exist in the starting revision or it would be a fatal error.  If we
> >> are clarifying with this patch for completeness, I think we should
> >> also mention it together.  
> ...
> >     git log -L 300,2000000085:Documentation/git-log.txt 
> > errors out:
> >     fatal: file Documentation/git-log.txt has only 239 lines
> 
> This case seems important enough to include what it means to "match".
> 
> Specifically, the range must match at least one line in the file.
> 
> > But 
> >     git log -L 300,-2000000085:Documentation/git-log.txt
> > does not error out and shows the history for the whole file. Also,
> >     git log -L 1,-2000000085:Documentation/git-log.txt
> > does not error out and gives the history for the first line.
> 
> Negative numbers in the ranges are a bit strange to include, and the
> large magnitude you include here seems unnecessary for the test.
> However, it appears that we do store signed values in the line-log
> machinery:
> 
> /* A range [start,end].  Lines are numbered starting at 0, and the
>  * ranges include start but exclude end. */
> struct range {
> 	long start, end;
> };
> 
> Perhaps these should be replaced with an unsigned value instead,
> just to be clear that negative values do not make sense in this
> context?
> 
> Or rather, do we want to enforce start < end if they are to be
> valuable? We apparently do assert() this in
> range_set_check_invariants() for all that does.

We have different contexts for start,end here: the '-L <start>,<end>'
specified on the command line and the 'start' and 'end' fields of the
internal 'struct range' are not the same and different constraints
apply to them.

'-L X,+Y' and '-L X,-Y' are explicitly allowed, and mean that Y is
interpreted relative to X, the former meaning Y lines starting at X,
while the latter meaning Y lines ending at X.  These are interpreted
while parsing the '-L ...' options, during which we do pass around
negative values in (signed) long parameters, see
line-range.c:parse_loc().  (though, arguably, having unsigned types
and a separate flag parameter might make the code more clear)

The purpose of range_set_check_invariants() is different: as the
file's content changes over its history the internal line ranges must
be adjusted (grown, shrunk, shifted around or sometimes even merged)
accordingly, and this function makes sure that the resulting 'struct
range' instances after these adjustments still make sense, because the
rest of the line log machinery expects sorted and non-overlapping line
ranges.


> The current behavior of showing only the first line
> is a strange byproduct of allowing these odd ranges, but we may
> want to keep it for consistency. That would imply we allow
> start <= end, and auto-correct these negative values to have
> end = start. (This does not fix the 300,-1 case, but that
> is strange enough to be considered a bug, right?)
> 
> Thanks,
> -Stolee
> 
