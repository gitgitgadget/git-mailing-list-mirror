Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A66C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C054D21775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOD2EbVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFTtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:49:36 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:40121 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFTtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:49:36 -0500
Received: by mail-pj1-f42.google.com with SMTP id 12so426366pjb.5
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uDmSuApAdJGhTQC+wFk7yHJTlmSgFbRTUo2t8H/Y7ro=;
        b=UOD2EbVz5jIvKXuWXY5D+fLDDj28ERwORkMXwzNaL9pLilrBEDpy3YBZ417tyxWWPL
         gH3cYmBUcS6YK1oExkUpB4d3UgmbmFCkdgUqdy/Nj6pGGewPbgvVizLk28BFO67UKUAz
         TLKESUT4cg5ySWk4bZr9Y5mpZofUVZjBIp+MEnyEHOgzq7AlU1ez6G6jAnUETXYyHJo1
         Ymki/t57yrAyqbpLKx/MVlUZxvkEb6F+AE1WAknmoaJymakuKk1A6ISCe6BP9LnL47X5
         bMEC6y032w8TgOgKV4PE09xtpIH0zCpcP2ourvH341rk48ecwn95F9h24hQDrg5OuGlv
         GAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uDmSuApAdJGhTQC+wFk7yHJTlmSgFbRTUo2t8H/Y7ro=;
        b=ZdwBYeaPC5F29UOd/8VI0BQ4KA13LpmAXSTj9JEO7t6aEqf9YGxJnZ13ZIoGUNsGVo
         EnQVNTJt7tkAJ+A/bWKEF2K4+5t8HbuIgHVfykWX2ikhUwt0+diYtGIzLEeKcVZJTxhI
         i6r3AXwmHV2DC6e81qCQo80oncnC3zMXtUrVkF4aic+exm5fIRf/Wi7/zxKsCp9gdHws
         gtMAePa1foDuPGkxOpwj2MzDp5HupoFHwgyzo5jqrWb1Zy52kXCdyO3zUF0B1ri6xZEL
         F6If5FaNj9V9L+FykeKIi/qL5m5KBdkl/WAbDUuP4sHvS3P6Gq0+YznQjRUyi4tBdixb
         KVDQ==
X-Gm-Message-State: APjAAAURME6y5v2BJa/eshcmC2k5+c4OvI1ivq1nmpvTPBo/3eNwdr9w
        br/Higl+QGmAwpXCUzyBDvX35g==
X-Google-Smtp-Source: APXvYqzCOQ2JAYCyuOxZUc9NwRI2rtve+NxtWiMHOLRDJxB/FgqXEB0Rm2DkVxvjDrUM7etC2VqRZg==
X-Received: by 2002:a17:902:c693:: with SMTP id r19mr5962173plx.25.1581018575387;
        Thu, 06 Feb 2020 11:49:35 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e1sm189833pff.188.2020.02.06.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:49:34 -0800 (PST)
Date:   Thu, 6 Feb 2020 11:49:29 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
Message-ID: <20200206194929.GA190927@google.com>
References: <20200124210148.220007-1-emilyshaffer@google.com>
 <20200124212602.74194-1-emilyshaffer@google.com>
 <20200124215628.GI6837@szeder.dev>
 <xmqqh80kctcn.fsf@gitster-ct.c.googlers.com>
 <20200206010704.GN10482@szeder.dev>
 <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:33:54AM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Fri, Jan 24, 2020 at 03:44:40PM -0800, Junio C Hamano wrote:
> >
> >> ...  The more important part, from my point of view,
> >> is that we offer choices (the proposed doc update illustrates
> >> three).
> >
> > I remember a discussion about whether that list and its archive should
> > be open or closed, and I agree that offering choices is good.
> > However, since that mentoring list requires registration, we have to
> > carefully consider how to present it to newcomers.
> >
> > Openly accessible knowledge is a fundamental value, and it's the
> > foundation of open source.  Therefore, we definitely should not direct
> > newcomers to a closed mailing list as the first option, it can only be
> > a fallback.
> 
> I am not that dogmatic ;-) I would be very unhappy and probably
> would not have joined if the main development community was closed,
> but I do not think the "knowledge" the "closed mentoring list for
> those who are shy" are meant to impart to newbies will be something
> that will be so well kept secret that are shared among only those in
> the closed list.  I expect the mentoring list to be repeating what
> those who graduated "new"-ness consider pretty much common public
> knowledge.
> 
> Having said that, my reading did hiccup when queuing Emily's text,
> in that it listed the mentoring list first, and (more problematic)
> the only choice among the three described with a word "great" was
> that one.  Also, now I re-read it, the last sentence "You must join
> the group to view messages or post", without explaining why it is
> set up that way is bound to give a wrong impression, I suppose.  I
> presume that the reason why those who wanted to make the mentoring
> list closed was because they thought it would be nicer for shysters,
> but if that is the case, it probably is better to spell that out.

Sure. I think I didn't do so in an effort to be brief. I'll think on
this today and send some suggestions here (rather than rerolling).

> 
> > The text should list git@vger as the first option, since that's the
> > only open mailing list we have, it should clearly emphasize that
> > newcomers are very welcome, and should explicitly encourage them to
> > post their questions here, no matter how trivial or silly they think
> > those questions are, we'll be always glad to answer them.
> 
> I have no problem with seeing an expanded invitation to the main
> list.  I do not have a strong opinion on the order of three items.

Me neither, and placing git@vger first does give me an opportunity to
say something like "if you feel worried about asking publicly, this list
is a more private setting" in reference to the mentors list. So that's
an option I could get behind.

> 
> > The closed mailing list can be mentioned third as a fallback for those
> > who would prefer not to end up on public record right away or who have
> > any technical issues with posting to the main mailing list.
> 
> I'll mark the topic on hold (it is in 'next'), and would give the
> stakeholders some time to settle the discussion, perhaps with
> counter-proposals in an incremental patch form.  Would it be
> reasonable to set the deadline around the end of the next week?

Yeah, that is OK for me. I'll try and send another email with some ideas
today or tomorrow.

Thanks for the feedback, Gábor - I appreciate it.

 - Emily
