Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A867E784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbjJBPWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjJBPWH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:22:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B7A9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:22:04 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77433e7a876so783290385a.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260123; x=1696864923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUx2aGFeKVcCjaVtOQfN+ocF8iIWMinfVBlgEfDCOek=;
        b=Owh/kKbCIYxrP+i5cUd4jo/NUJfO1OUVFFbvVO8rgTAoD0mNOOPVbBcx0Tfq7v0Zgj
         AP0/LqI5CIIC+f+iRWv4OjRcRtfdYwXUZKQe5LcD+fKwaAOZ0gpQqA9A20CMnbTmOMUD
         PysSufg6lVtRpKXCBudC+PKFrmEV6zLvdvshlQkc2JOnSfM6SBrY9Qi8n0q4Y/Im+akL
         U3x9ETEn9aeS8c4TSQLZ1Y9teiCLU3LkuqbCjcSAKMywvJ979GwAD6hStOxdW8qAu9ct
         gWVi1hLge5ib7nbMY7CcydzUHYZ4Ylh32QVHhxJPAqBb9NSNq++M0iBZgxx0XeiunLuS
         VH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260123; x=1696864923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUx2aGFeKVcCjaVtOQfN+ocF8iIWMinfVBlgEfDCOek=;
        b=lanEul2jqWqjNdqPU0O6EJJQM4XwPar2Sf62bqGzRmxiAO8SuTvcaWkriSkSxpbNMX
         9oAOvSTbmu/Ov37BpvF1lVRz4CkHuqnlFfiKsD1zz9dbseKG1NeFefwpFBY6lyzzrS9a
         VLJ6zlVDvWk0KdVCVFPrH5ZFEl+U67Ws+iYQ8R4tLdbDq3Z7RtekIi/tbC/sSm9wcl5u
         pQTQugcvXNcSJwYZ9rDqJlukFE16LKPTFkjiq2iQbPVxheN2WV7eHS7x492rrqq3UD1d
         YNksk0uMcHPpsPVSyrrLR3zjoxBgEhSOHXUPEHFJXP1+UnC/2lU42D9a1IqenAmAjnkM
         ZmYA==
X-Gm-Message-State: AOJu0YxGLpt2MCrb8+T33ypRo3tYkLfychK3qmkydvioKMrMKAPLYsqM
        HAiwdCbaqQuXR1LQhA8SP4IWpwsLnGUlE2uVugG3Ng==
X-Google-Smtp-Source: AGHT+IEKNWAOZoYy/dwSVe+m2sG8Wi+hexoO13UMix1bMp1V+UQArHXB2ZP6D4zcbFT5fhT035/k3w==
X-Received: by 2002:a05:620a:221a:b0:774:f7b:f0a with SMTP id m26-20020a05620a221a00b007740f7b0f0amr12365381qkh.76.1696260123504;
        Mon, 02 Oct 2023 08:22:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a134400b00773f008da40sm5054081qkl.125.2023.10.02.08.22.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:22:03 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:22:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 10/12] Project management practices
Message-ID: <ZRrgGlexQFZlrFjs@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Emily Shaffer, Notetaker: Jonathan Nieder)

* high hopes and low expectations! Let's play nice
* Project management related tools and practices we may be used to from $DAYJOB
   * Bug trackers
   * Long-term and short-term project planning
   * Roadmaps
   * Documented project direction
   * Tools, like wiki
* Some things other open source projects do
   * Some do things like two-week sprints with contributors, more structured
   * development of some features
* Some things that happen in regular workspaces
   * Ad hoc whiteboarding through a problem
   * Live chat with history
      * We have IRC but it's dwindling outside of IRC standup
      * There's informal discord
* Lots of tools! Are there ones we want to get benefit from?
* Example: bug tracker
   * Lots of interest, but don't have a shared understanding of what we want
     from a bug tracker
* If you could pick something from your day job and apply it to the Git project,
  what would you look for and what would you want from it?
* (Taylor) "Let's have a quick VC"
   * All being at the same organization within GitHub, people are very willing
     to just jump into a Zoom meeting and talk through a thing, whiteboard
   * There's benefit to having things documented on-list, but I think we could
     walk that back a little
   * (Emily) One thing I've liked with the contributor summit and similar events
     is sending something to the list so people who weren't there can still
     follow and respond
   * Would "Taylor and I just talked about cruft packs" emails be something we
     want more of?
   * (Taylor) Yes and no. Sometimes a conversation is for getting ideas,
     sometimes for making a decision. They deserve different approaches.
   * (Emily) By the way, I've been surprised at how open people are to VCing
     when I try it. Conversations about cruft packs, conversation about config
     based hooks series, tried "let's have a VC" and Ævar was very open to it in
     that example and it worked well
   * So it might be something we should just try more often
* (Emily) At a Git contributor summit, some attendees mentioned wishing they
  could see a published Git project direction
   * Various companies are putting dedicated time into the Git project, and
     those aren't published anyway
      * Page with "GitHub cares a lot about cruft packs, here's how you can
        help"
      * Is that something we could write down somewhere more static than the
        mailing list?
   * (Junio) How quickly would that become stale?
   * (Emily) It depends on how you build it into your own processes. Every
     quarter we write quarterly objectives and key results for my team, publish
     that to everyone at Google. I could also publish that to the Git mailing
     list, part of that normal process could be posting it on a Wiki page.
   * (Jonathan Tan) One thing I'd find difficult in publishing such a thing is
     understanding the priority of line items. Currently I learn about people's
     priorities from patches and from what they say in venues like a contributor
     summit
      * Contributor summit is once/year, if you're saying something, it's
        probably important to you
   * Things that change once/quarter are harder to judge. How much are you
     dedicating to them?
   * (Taylor) Suppose this existed. What would people use it to answer? Mutex?
   * (Emily) There have been some good cross-company collaborations in the past,
     such as partial clones. Noticing the opportunity to work together on such
     things is the kind of thing I'm thinking of.
   * (Taylor) Back in 2014-15, GitHub had an awesome tradition of there being a
     "radar issue", people could comment on this big long thread on what they
     want to hack on.
      * I think that's a little different than publishing a committed roadmap,
        with pressure and accountability. "What is Jonathan Tan interested in"
      * Could be as simple as every quarter we send an email to the list and all
        reply to it.
   * (Jakub) We can attach a roadmap to the same place Git Rev News[c] is, you
     can get news and a roadmap in the same place.
   * (jrn) Sharing your plans and priorities helps people know what they can
     expect you to care about. E.g. if your work is all reliability, all the
     time, maybe a new UX change is not as exciting right now, versus
     reliability focused work is a good place for collaboration.
   * (Calvin) Having timestamps, e.g. a pinned message on Discord, helps you
     know if something is stale.
   * (Jeff Hostetler) Make a repository, publish there "I'm working on this".
     Send a pull request, get feedback. Nice and compact, has timestamps, stays
     in our ecosystem.
* (Emily) I don't like the trend of projects being only managed on discord. But:
  I'm wondering, what changes would make the git community discord more of an
  official channel in the same way as the git mailing list is?
   * https://discord.gg/aUCkDVUqqu
   * (Elijah) There's a Git Discord?
   * (Taylor) We just needed to make Elijah aware of it. ;-)
   * (Jeff Hostetler) I think discord is a bit childish, git repos are something
     professional we all use every day.
   * (jrn) There's a bit of a shift IRC -> Slack -> Discord in a lot of projects
   * (Emily) A big benefit of IRC is that it's a decentralized protocol. Having
     a part of our infrastructure be a centralized, nontransferrable thing is
     scary to me, but maybe there are technical ways to address that. Export
     logs, matrix bridge to IRC, ?
   * (Taylor) I think a barrier to use of chat can be fear of decentralization
     of information, it's convenient that the git mailing list is a one-stop
     shop
      * (Jeff Hostetler) +1, having too many things to check
      * (Emily) I think this is also why we're hesitant about other things like
        bug trackers etc
* (Jonathan) Bug tracking
   * (Emily) This year we moved crbug.com/git (Monorail) to
     git.issues.gerritcodereview.com. There's 80ish issues there. Our team
     within Google uses it. But of course in reality no one else is making use
     of that issue tracker. If there were somewhere else to put bugs instead,
     we'd use it - I don't think it's too important where that is, as long as we
     can do it somewhere.
   * (Junio) Someone needs to curate it.
   * (Emily) It would be possible for us to curate, triage
     git.issues.gerritcodereview.com if people start using it.
   * (Junio) Not limited to bugs, but we from time to time talk about other
     aspects of tracking. Things like patchwork. We talk about mechanisms, but
     not so much about enforcing use of those mechanisms.
   * One work practice I like at work is that anyone can write a CL, and then
     people are forced to review or look at the patch in a reasonable amount of
     time.
   * It can be frustrating as a maintainer, because I don't want to be reviewing
     and looking at all the patches on the list myself. And I don't like having
     to queue patches not looked at by anybody.
   * (Emily) This makes me wonder if we should be having conversations about
     things like "whose turn is it to take action on this patch".
