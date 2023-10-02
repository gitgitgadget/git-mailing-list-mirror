Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E1E784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbjJBPWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjJBPWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:22:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C669A9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:22:27 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77575531382so456610285a.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260146; x=1696864946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH/0ovMcrnAThr6CjiRydG46fjyjGFPQSstwo4AdUfI=;
        b=DFvHIOMzpDup7dMfb5jBlhYxJm0Y040HKogytruqJ0gY9HH18ifnj1XrBSfKy3lEN5
         SSnbL9/OiWQF4CE2CDJEKPFgsgFqnv1tciMHKjEhMiQq4jylzehf81wiWg/kK9D9zNrO
         jS/HDPyZrM71Rk6pEnSlw/QCBZhNIv/QF/I8ZWa+EH5nxZfSTb4SJEw6D7jpsC+YOzzb
         Qyy27KECFNDSbJ3513D6pLaw4e6FuIotkm8xbCIjXNly81QrXHlVjHx04jWLhfzjoNxZ
         UyU5c3rURmPSiLabAijZiziK94OtBWpJ8o/WxKCRZIek0ku3ge/+fujOEWcWCSWfHS8y
         PGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260146; x=1696864946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH/0ovMcrnAThr6CjiRydG46fjyjGFPQSstwo4AdUfI=;
        b=H6xWonU6lMpViHYsgVkrNW72mIdKX1eRGfWYt9oZIGKi4nJe4Q6rvPFym6NQX8sbfV
         Fa8Zr94UScgvGsMImk6gMWh356sTyDyS3MI0A+8PMddUF+pJ3fXlTcWm670vk7c3bCg7
         nyYUbjlhZwhu7WiPeu8lOWfENSQHRLmKiJMqz1ZGxWty1X6lE0ynuLV0RKcDU1STszIM
         oUseUD1k4Sgb9ahFc7J8dDiXRMF2sIWh5j22fEnH8mJW6qPzOaRMbozSCWQ7+QBgkpVp
         1hFVf/4kqsrGTIX/U94PGhtNsVDfCSAmlik2FMydXx+zmBmeQOSE5s6fEafhdx+LYJZM
         tvJg==
X-Gm-Message-State: AOJu0YyVHCd2oXmWakBdq4JSmIjT9OQu6ueXhWY4oByHiwssfX2HvHEO
        TkBV5MGndu9MdhDhYiOz32yZMf9s5rF3SWm9ui5Obg==
X-Google-Smtp-Source: AGHT+IHgxdwh79mNUSqPx/H48+g0Af5XMw44h+TcVDrjqCjRcLdnGJEztcJwkIeP32bWzRbYatH5kQ==
X-Received: by 2002:a0c:e284:0:b0:65a:f206:5dda with SMTP id r4-20020a0ce284000000b0065af2065ddamr12020080qvl.39.1696260145862;
        Mon, 02 Oct 2023 08:22:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z12-20020a05620a100c00b007756fe0bb17sm4326729qkj.19.2023.10.02.08.22.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:22:25 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:22:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 11/12] Improving new contributor on-boarding
Message-ID: <ZRrgMDacYpj41DcO@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Jonathan Nieder, Notetaker: Xing Huang, Ronald Bhuleskar)

* (Jonathan Nieder) Not as structured of a conversation, but I see a lot of
  interest, let's see how the conversation goes. Any open sourced project can be
  scary for newcomers; the git project in particular has its unique aspects of
  its workflow, such as the mailing list that rejects http formatted mails, etc.
  I think overall we are welcoming. Ideally, we would like to attract all types
  of contributors, in part because they help different kinds of users have more
  of a voice.
* I am interested in how to make the onboarding process easier for the new
  contributors; what do we see to make things easier? MyFirstContribution works
  well as a tutorial doc, what is the next step for someone after they send
  their first patch and get their first review in reply? How do you find a
  mentor? Things like how to interpret the reviewer's tone can be hard to
  navigate.
* (Emily) We can mark a patcher as a beginner's patch - the golang (?) project,
  for example, assigns a mentor to newcomers. We have a mentorship list that's
  inactive; could we use the same volunteers from there to give more hands-on
  mentoring?
* (Jonathan Tan) We could use a guideline on what's expected in terms of code
  quality.
* (Taylor) Folks who are newer contributors or haven't contributed much, do you
  have perspectives to share?
   * (Vincenzo) Finding a starting point, a problem to tackle, was difficult.
   * #leftoverbits search term is listed in our
     Documentation/ReviewingGuidelines.txt, but Taylor suspects no new comers
     are looking into it.
   * People in the project will start looking at the next event and get to meet
     the person face to face to have a less daunting relationship.
   * (Phillip) There is a lot of information for  new contributors to digest in
     CodingGuidelines, SubmittingPatches and MyFirstContribution. How do we find
     a balance between providing useful guidelines and overwhelming them?
   * (Jacob Stopak) As a newcomer, sent an idea that was too big to solve
     completely myself, but I would have liked to know where it was going, what
     is my part, what others will help with, and to be able to participate more
     in its implementation instead of it being done by others.
* (Jonathan Nieder) The mailing list is noisy and someone interested in a
  specific topic but the mailing list is flooded with lot of other things,
  unless they are specifically cc-ed on the right things. There's no easy middle
  ground between "my life is in the list" and "I only see what is sent to me".
* (Jakub) There's a bit of a middle ground - you can use a newsreader
* (Jonathan) In a project with a bug tracker, it's easier to know who is
j assigned to and who the collaborators are on something and what to expect
  moving forward. The information is in one place. In the Git project, if
  someone sends a patch on something I'm interested in, I have to interpret why
  they're doing that - do they want to take this over? Are they giving me a
  suggestion?
* (Han Young) Han finds contributor guide to be lacking in details, he finds
  READMEs and discord to be complementary to his newcomer experience.
* (Emily) Which of these ideas should be implemented that makes the most sense?
   * Auto assign 1:1 mentors to new contributors
   * Split up the doc a bit more
   * Wiki: Where to start
   * Have more conferences
   * Have a bug tracker
   * Process documentation: What to do when a review comes in, next steps beyond
     what MyFirstContribution describes.
* (Taylor) The mentor assignment bit is what excites me the most
   * Most new contributors use GitGitGadget, it could notice new contributors
     and find a mentor for them
   * The key there would be documenting what that relationship should look like.
     Helps with clear guidelines on avoiding the kind of hijacking case Jacob
     mentioned (sorry about that!)
* (Jonathan Nieder) Great thing to do if we have a pool of mentors available.
  This cultiire is appreciated.
   * (Emily) Such culture is ingrained in Google in the form of community
     contribution. (Junio) Hmm, where are the reviewers? :)
* (Glen) Discord or other informal channels are easier for mini-mentoring.
* (Jeff Hosteler) GitGitGadget is also doing mini-mentoring recently at a small
  scale that polishes before the author submits.
   * (Emily) Mostly GitHubbers? Should others pitch in?
   * (Jeff Hostetler) I think I'm auto-subscribed because I have write access to
     the repo.
   * (Junio) I've done some reviews there (it shouldn't be limited to GitHub
     folks).
* (Jacob) Thanks much for the documentation, step-by-step instructions are great
   * I used instructions on how to send patches with "git send-email". I didn't
     use GitGitGadget because it wasn't clear to me what it is.
