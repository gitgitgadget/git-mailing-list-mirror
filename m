Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E6C4BA04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED6246A6
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHr/8N48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgBYX3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:29:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgBYX3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:29:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so386092pfg.12
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 15:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5D1bE1FvQ/TKV62KrrG2ftYZCFmiwV/Xxkkv5bItAE=;
        b=BHr/8N48xRpN//SLtR8A1pKKURirzkmInNUpT0Juk+o9OyJgySejCs/Uah4hcWRS5b
         of5qFoTk3t+g0sGehPmE4MepjTebW9D+zQdF6B0HTGubI+XdzjP4kCr+usvGS4cFMx1L
         yatYtEBuZpKurKsMvS2UqtpaBoIhgKN7dgeEf90V5+z2psaa9sS/xyD8xWynL/MSZZij
         sti4X4fF8C9E5Fz/aAnDYx6ZqkFTHK2emGsTs3XCBqBsmbYYRVk662f9Q7hZaDxF/IeA
         gUqNFZP8GibvTZeCbjXBr3CumAfyns+VlTlWuj5DyvNXHoFp4mdWQsxqI7ueSEDVtj9T
         hqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5D1bE1FvQ/TKV62KrrG2ftYZCFmiwV/Xxkkv5bItAE=;
        b=pg34nnpRa+KGA671S3eXMGL8Wr4DSbRuYoHEbULvbSw0EeP6JFpncFf5ukfDWFRVNx
         fTO5z6zhj2Ts/39KUwNl/NmsuBtJ3ts0d9q1B9dKw2ynljPhQdBR4NHwNraZVFLFWkrl
         NtYdt0frATPmUON3U101qrN1Azz3/pjbnEsEx+bWJcpgE+53Syp+UFUBDXYJrVr8Bl9m
         7SeuV/q1L82GpJho+piV8FMMkiSoeJXYWOO6pRSv5swZGjchdGnlCyi/48CZZgCihYtM
         8D0Jj/UMUUS0VXu9yrE7r4jOvT/+Ssx4OsM/UiUCvbjbIuHbiXR0HndDKcU2qvlI9Zea
         xHoQ==
X-Gm-Message-State: APjAAAUAW7VgdoMxhWcmW9Bo24Z1cowmT+NaCbxmqJqS3MmaX9uCKFOu
        ZQrI+GdungbA41yfi0sAHts5dF6h0Q8=
X-Google-Smtp-Source: APXvYqyQq4uYO6fX1ZIwgs+nKqBeiLJC+m6agqcKOAEdTSL76OluVB/YBTQCdCIANjpjrXIC/66TTA==
X-Received: by 2002:aa7:914b:: with SMTP id 11mr1176639pfi.69.1582673385583;
        Tue, 25 Feb 2020 15:29:45 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h2sm102821pgv.40.2020.02.25.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:29:45 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:29:40 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
Message-ID: <20200225232940.GF212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-8-emilyshaffer@google.com>
 <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
 <20200220232812.GH2447@google.com>
 <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
 <20200225220838.GB212281@google.com>
 <xmqqtv3el2w5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv3el2w5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 02:26:34PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > How about if I localize the bugreport template, headers, and formatted
> > comments (e.g. "3745 local loose objects"), and include a tip in 'git
> > help bugreport' suggesting that if it doesn't look right, maybe the user
> > wants to run it with 'LANG= LANGUAGE= git bugreport' to ensure it
> > actually gets generated?
> 
> I think that will be what is going to happen anyway in the real
> world.  We'd spend a reasonable effort for localization (and I
> personally am perfectly OK if the effort for the initial round is
> "almost zero"), but make sure C-locale is left as an escape hatch.

OK.

> 
> > I had another thought, actually, that this is maybe semantically similar
> > problem to the malformed config we discussed earlier in the review. Does
> > it make sense to include some kind of --safemode flag to 'git' which
> > asks it to not perform localization and not read configs?
> 
> I suspect that "git --safemode" would always end up being buggy than
> running "git" under LANG=C LC_ALL=C GIT_CONFIG=/dev/null or something
> like that ;-)
> 
> Wouldn't it defeat more than 30% of the value of the tool if we
> do not read and report the contents of the configuration file(s)?

If you mean "the tool" = "Git", I won't argue with you. But if you mean
"the tool" = "git-bugreport", I'd say that 70% of the value of the tool
is better than 0% because my config is broken and I don't know why or
how.

 - Emily
