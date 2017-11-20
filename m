Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D9C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbdKTSYt (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 13:24:49 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39467 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdKTSYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 13:24:45 -0500
Received: by mail-wm0-f48.google.com with SMTP id x63so7979011wmf.4
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0Qp85sNprlLD5YVt0mV7ZM5G1M/5d3ux2qlOALptTQ=;
        b=A8DIYrWYwPEKbsOm2B0Ia4J3DQaKfm0CjX38N6v5bZkD04r/ngUj1ffsQSGAxJh1LI
         Pq9HY8SO0xsN/8e9yZcAE2nqKB6p4l2jch3fKyrPKljcGmAYrdhsP6km5bk1EIrXxKbI
         fdSkIwKFehuV0waTOuvC9X8cK+QjE+8GRgVZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C0Qp85sNprlLD5YVt0mV7ZM5G1M/5d3ux2qlOALptTQ=;
        b=R+uCYWWLqcGUq7jr8PngXa2KFmz9xYVtKeoucGXB+fk0uZmx6rFHtf9PQ5Cc3vTBxU
         K9LU9Vh52Iu8q0tc6YquMo5R2EQEoDD4N+i27fiL22egm0DeuZL4fmrIq91jcv+OL93w
         LYOQehTto36/SduRCSW/xDikt+UaRIsnGNnOKjdNQdzkVHjHJHC+8SCDDKlqOLC99aPL
         cvdPBGU1EO+C6FxeKFwc+HXoUSuneXg4XRM9rPT510hx6qmL9Xes7tGg991jJieJIKz/
         0/63evgLKkaJb0b5z63FfvLYhdvXcuOU7L9UI8/UFJV0bVOSWKJPs6RZJTeF+aMg3bEv
         YHUA==
X-Gm-Message-State: AJaThX7ckykvcxBwEmvygP9VPSGkQOjX89FIcZnLyC7don5pPRfbRp0k
        TJMPUWL9tm94bzGbAX/jHJhwI1ySYv4=
X-Google-Smtp-Source: AGs4zMbPHq3ec2Wm8Dsk5YPEbpJCuRRBj/eIg8CbjUKP5dUSScrAiFQOApOLSSHtYDKIUAG7vwMmBw==
X-Received: by 10.28.67.68 with SMTP id q65mr9975444wma.26.1511202283729;
        Mon, 20 Nov 2017 10:24:43 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id 138sm13691999wmf.21.2017.11.20.10.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 10:24:42 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [RFC PATCH v2 0/2] bisect: add a single command for editing logs
Date:   Mon, 20 Nov 2017 18:24:37 +0000
Message-Id: <cover.1511200589.git.adam@dinwoodie.org>
X-Mailer: git-send-email 2.15.0.281.g87c0a7615
In-Reply-To: <20171108135931.166880-1-adam@dinwoodie.org>
References: <20171108135931.166880-1-adam@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I'm bisecting, I sometimes want to edit the bisection log, e.g. to
remove the "skip" marker by a commit I've now found a way to avoid
skipping.  Rather than requiring users to save off the log, edit it,
then replay the edited log as separate commands, this patch series adds
support for a "git bisect edit" command which does all three steps in
one.

Christian Couder has already said he's happy with the broad idea in the
previous spin of this RFC, so here's a first attempt at actually
implementing the function within "git bisect".

There are a few issues of varying significance before I think this is
ready to be actually used.  I'm not sure how to approach them, and would
be very grateful for advice from the list:

- It's possible to start a bisect session with a command like `git
  bisect @ @~10`.  This will lead to the bisect log including the `@`
  and `@~10` literally, and the interpretation of those values changes
  depending on the current HEAD.  As a result, if you do a `git bisect
  edit` after starting a bisect like that, but don't actually edit the
  file, you'll nonetheless be in a different state.

  I can see a few ways of coping with that:

  1. Change the existing `git bisect start` behaviour to run arguments
     through `git rev-parse` before recording them.  It appears `git
     bisect good` et al. already do that, but it is a change in
     behaviour that I guess could impact badly on other people using
     `git bisect log`-based workflows.

  2. Do a full `git bisect reset` before replaying the log, so the
     revisions will be parsed in the same way as they were originally.
     I'd be slightly sad about that, as it seems an unnecessary
     inefficiency, but it may well be the simplest approach.

  3. Somehow get Git to parse the relative references as relative to the
     original commit rather than the current HEAD.  I'm not sure if
     there's code for doing this already, but if not I suspect it's
     beyond my ability to implement in the immediate term.

  4. Just detect when users are in this scenario, and warn them that
     Git's behaviour might be unexpected.

- I can see `git rebase --interactive` detects when the edited file
  hasn't changed, and in that case prints a success message but
  otherwise takes no action.  I've not implemented that behaviour here
  because I couldn't immediately work out how rebase does it, and I
  didn't want to reinvent that particular wheel.  (Plus I think the
  impact of performing such unnecessary steps will be considerably lower
  than the equivalent with rebase.)

- I'm not entirely happy with the error handling, primarily as I
  couldn't seem to find a consensus on what best practice is for
  handling errors between the existing shell code in this script and
  git-rebase--interactive.sh.

- There aren't yet any tests or documentation changes; I wanted to get
  commentary on the initial code changes before I spent time on those
  parts.

Adam Dinwoodie (2):
  bisect: split out replay file parsing
  bisect: add "edit" command

 builtin/bisect--helper.c |  3 ++-
 git-bisect.sh            | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.15.0.281.g87c0a7615

