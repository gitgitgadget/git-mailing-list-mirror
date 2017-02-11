Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF1B1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbdBKSCe (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 13:02:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36664 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdBKSCd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 13:02:33 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so5477304pgf.3
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 10:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Feci6EpM4VL3S/7Lol/OpGF3B+XOhzek3MmkFbeR7oQ=;
        b=viB/XWi5MY4gagkw8KMDP0RWVvDtTcZmS6dkze0D7iftdLLOZcK8hT0yQF3cj0/R44
         5LbM/4Q+C5MFUnOQJNXoTRfmgX2RlN9Ld4fZe7eAGyLhd9rTasOV+TZyPHu8z1IrbD4J
         bWggVqSS0AA0p2swDHhHShqc2slwL2AVIiJIxfpt+nVCvdXkqRSEH303NO/OdgRBWE44
         F71ZTZ93Qh7jL2NR1nkiaRJ05GC0MAl4Ukx60uErm8Y5jMJ8b7vZ5G0SV/PwXw0wwRzi
         0Vy7tbEJun9ceb//TS69lGGZ7upwYc6onORXHLR0SM8BQT7ng03XmV1jirg7DzOc53Y5
         AoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=Feci6EpM4VL3S/7Lol/OpGF3B+XOhzek3MmkFbeR7oQ=;
        b=N+YyBscciBv8yfUnmh0sT9MYayCX9XdkBzBr+G6q2N1jSKtY20iVTahOcFBCmHmObZ
         0uFuD8Pu9pb7ux5SWeksm0j5/gMmvvcR6wiw9SJpcGw4oeMioX5bGCiMEEWWvBAZuMrs
         EzDZ3c42pIHifcNSlFRHXjDj4c6blGWTDcgSVv1mPOGwdMLvb7g3loX+g5Kjxj0B+Mde
         luiDFO0M7KzRYb8LLswTKg+6glDGXaSzP8nlHpAsAaPawSgCh0JPpmL0TeNS9vka5OIj
         4XcX9aQ5e/TEccbW5L0U1+v0r9VAiM4aBWeKFXafAgEBHk/L9QtRZwsAZIKZf4Xuhv+8
         JCoA==
X-Gm-Message-State: AMke39kbiXn8hD+u9Xj60mLXFI91WRItLV71MqkaXdfGXA+bZQasRurynAdbUwz+DEeoGw==
X-Received: by 10.99.5.15 with SMTP id 15mr17545041pgf.109.1486836152300;
        Sat, 11 Feb 2017 10:02:32 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id s84sm5881497pfg.128.2017.02.11.10.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Feb 2017 10:02:31 -0800 (PST)
Date:   Sat, 11 Feb 2017 10:02:30 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [RFC PATCH] show decorations at the end of the line
Message-ID: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


So I use "--show-decorations" all the time because I find it very useful 
to see where the origin branch is, where tags are etc. In fact, my global 
git config file has

    [log]
        decorate = auto

in it, so that I don't have to type it out all the time when I just do my 
usual 'git log". It's lovely.

However, it does make one particular case uglier: with commit decorations, 
the "oneline" commit format ends up being not very pretty:

    [torvalds@i7 git]$ git log --oneline -10
    3f07dac29 (HEAD -> master) pathspec: don't error out on  all-exclusionary pathspec patterns
    ca4a562f2 pathspec magic: add '^' as alias for '!'
    02555c1b2 ls-remote: add "--diff" option to show only refs that differ
    6e3a7b339 (tag: v2.12.0-rc0, origin/master, origin/HEAD) Git 2.12-rc0
    fafca0f72 Merge branch 'cw/log-updates-for-all-refs-really'
    74dee5cfa Merge branch 'pl/complete-diff-submodule-diff'
    36acf4123 Merge branch 'rs/object-id'
    ecc486b1f Merge branch 'js/re-running-failed-tests'
    4ba6bb2d1 Merge branch 'sb/submodule-update-initial-runs-custom-script'
    5348021c6 Merge branch 'sb/submodule-recursive-absorb'

and note how the decoration comes right after the shortened commit hash, 
breaking up the alignment of the messages. 

The above doesn't show it with the colorization: I also have

    [color]
        ui=auto

so on my terminal the decoration is also nicely colorized which makes it 
much more obvious, it's not as obvious in this message.

The oneline message handling is already pretty special, this makes it even 
more special by putting the decorations at the end of the line:

    3f07dac29 pathspec: don't error out on all-exclusionary pathspec patterns (HEAD -> master)
    ca4a562f2 pathspec magic: add '^' as alias for '!'
    02555c1b2 ls-remote: add "--diff" option to show only refs that differ
    6e3a7b339 Git 2.12-rc0 (tag: v2.12.0-rc0, origin/master, origin/HEAD)
    fafca0f72 Merge branch 'cw/log-updates-for-all-refs-really'
    74dee5cfa Merge branch 'pl/complete-diff-submodule-diff'
    36acf4123 Merge branch 'rs/object-id'
    ecc486b1f Merge branch 'js/re-running-failed-tests'
    4ba6bb2d1 Merge branch 'sb/submodule-update-initial-runs-custom-script'
    5348021c6 Merge branch 'sb/submodule-recursive-absorb'

which looks a lot better (again, this is all particularly noticeable with 
colorization).

NOTE! There's a very special case for "git log --oneline -g" that shows 
the reflogs as oneliners, and this does *not* fix that special case. It's 
a lot more involved and relies on the exact show_reflog_message() 
implementation, so I left the format for that alone, along with a comment 
about how it's not at the end of line.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I've signed off on this, because I think it's an "obvious" improvement, 
but I'm putting the "RFC" in the subject line because this is clearly a 
subjective thing.

"oneline" really is special: the other commit formats will just put the 
commit SHA1 at the end of the line anyway. And with manual formats, the 
placement of decorations is also manual, so this doesn't affect that 
case.

Comments?

 log-tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 8c2415747..3bf88182e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -622,10 +622,13 @@ void show_log(struct rev_info *opt)
 			       find_unique_abbrev(parent->object.oid.hash,
 						  abbrev_commit));
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
-		show_decorations(opt, commit);
 		if (opt->commit_format == CMIT_FMT_ONELINE) {
+			/* Not at end of line, but.. */
+			if (opt->reflog_info)
+				show_decorations(opt, commit);
 			putc(' ', opt->diffopt.file);
 		} else {
+			show_decorations(opt, commit);
 			putc('\n', opt->diffopt.file);
 			graph_show_oneline(opt->graph);
 		}
@@ -716,6 +719,8 @@ void show_log(struct rev_info *opt)
 		opt->missing_newline = 0;
 
 	graph_show_commit_msg(opt->graph, opt->diffopt.file, &msgbuf);
+	if (ctx.fmt == CMIT_FMT_ONELINE)
+		show_decorations(opt, commit);
 	if (opt->use_terminator && !commit_format_is_empty(opt->commit_format)) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
