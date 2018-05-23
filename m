Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F1C1F42D
	for <e@80x24.org>; Wed, 23 May 2018 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933727AbeEWRLA (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 13:11:00 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:43634 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWRLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 13:11:00 -0400
Received: by mail-vk0-f51.google.com with SMTP id x191-v6so13594737vke.10
        for <git@vger.kernel.org>; Wed, 23 May 2018 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L0reGct0aaPljCyRrCMWxSSQ1QZG5NqztJE0RjDySlE=;
        b=iZ8Vl5TZrLI2TDZ2IMqj5m0DV7/mVBVNZFpdnSKz/eZkYVEWDuTDPcFdhO5gPVN/FT
         4HMWunP7GRrOU6Pgn8XJATrSOu2A5d5FbwSTXo0n6ngtBimlOI+HsQuYKI/F1n46G3cX
         xMO3aNnU9WULw7iWhjo7FMRDVubFZArS38YBq9eFFQ3EoyxHotnJ9RM+RF5lepDeMS+Q
         nzxFxiAYSkmyQm10ZYgVdHp3CjBw2A77RHApCIE4NeiyA/sTgzPJLQUQXW+jENXGGSDs
         GJOcA0yAMsafHtj9WK6Tc7by47yFmQjpNm54SEw31aoHPL2HP1nJxEJtCk6jmuXsW6cL
         JO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L0reGct0aaPljCyRrCMWxSSQ1QZG5NqztJE0RjDySlE=;
        b=TmdFZu8ZeoIqOjRASyXu8KzunjjlfTV8PKWF00imgbDdbiArHRsIEJ/HMEbOwlAc0N
         o3pWIaUrXHJZp9Owj/8HAFw4sWFf4it3t5GWyTrL5L10p/I43z9r6w+PX4LLowB0N/lJ
         60Zhkym5YTEjMk9WmuIO7kbXU6bes/BX5JQtQrwBjN1X82F8mH8/AmFv2EMy/haw/Oqu
         gv84FtWZ2CYv1yxmPU2s3flhcOIbLWdd+gzabj2RKmmO5Vws1JS3loYtN61zICIXtllA
         g2GZGR7pIVb+MLA9HhEyCHb+ikobTo9Hihj229oxmR9AHA8LHy9bkNC4HAlUOD06ADw6
         DUtA==
X-Gm-Message-State: ALKqPwesPLpGCs2JLjjEIc9aPJ028e2fxEUGMQeyB5Li+rH3P4TWmJOU
        dw4mnk6UGimsYQyez6aCxmcluUOKlQbeUpivp0hZiw==
X-Google-Smtp-Source: AB8JxZoL+KgaUzdtFFMnSc0C00WFN4JE9EnMUMLy0HgQNSUldOY4+ohEaY80F6T07IEmZB1p0tT5JE06RFanHXYF8HQ=
X-Received: by 2002:a1f:304:: with SMTP id 4-v6mr2483526vkd.120.1527095459045;
 Wed, 23 May 2018 10:10:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:16d4:0:0:0:0:0 with HTTP; Wed, 23 May 2018 10:10:58
 -0700 (PDT)
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 23 May 2018 19:10:58 +0200
Message-ID: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
Subject: Weird revision walk behaviour
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is this topic 'jt/partial-clone-proto-v2' currently cooking in
'next' and pointing to ba95710a3b ({fetch,upload}-pack: support filter
in protocol v2, 2018-05-03).  This topic is built on top of the merge
commit ea44c0a594 (Merge branch 'bw/protocol-v2' into
jt/partial-clone-proto-v2, 2018-05-02), which gives me the creeps,
because it shows up in some pathspec-limited revision walks where in
my opinion it should not:

  $ git log --oneline master..ba95710a3b -- ci/
  ea44c0a594 Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2

But as far as I can tell, there are no changes in the 'ci/' directory
on any of the merge's parents:

  $ git log --oneline master..ea44c0a594^1 -- ci/
  # Nothing.
  $ git log --oneline master..ea44c0a594^2 -- ci/
  # Nothing!

And to add to my confusion:

  $ git log -1 --oneline master@{1.week.ago}
  ccdcbd54c4 The fifth batch for 2.18
  $ git log --oneline master@{1.week.ago}..ea44c0a594 -- ci/
  ea44c0a594 Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2
  $ git log -1 --oneline master@{3.week.ago}
  1f1cddd558 The fourth batch for 2.18
  $ git log --oneline master@{3.week.ago}..ea44c0a594 -- ci/
  # Nothing, as it is supposed to be, IMHO.

This is not specific to the 'ci/' directory, it seems that any
untouched directory does the trick:

  $ git log --oneline master..ea44c0a594 -- contrib/coccinelle/ t/lib-httpd/
  ea44c0a594 Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2
  $ git log --oneline master..ea44c0a594^1 -- contrib/coccinelle/ t/lib-httpd/
  # Nothing.
  $ git log --oneline master..ea44c0a594^2 -- contrib/coccinelle/ t/lib-httpd/
  # Nothing.
  $ git log --oneline master@{3.week.ago}..ea44c0a594 --
contrib/coccinelle/ t/lib-httpd/
  # Nothing, but this is what I would expect.

I get the same behavior with Git built from current master and from
past releases as well (tried it as far back as v2.0.0).

So...  what's going on here? :)
A bug?  Or am I missing something?  Some history simplification corner
case that I'm unaware of?
