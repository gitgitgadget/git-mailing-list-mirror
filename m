Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C531F404
	for <e@80x24.org>; Thu, 19 Apr 2018 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeDSWsL (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 18:48:11 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:32888 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeDSWsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 18:48:10 -0400
Received: by mail-wr0-f170.google.com with SMTP id z73-v6so18089826wrb.0
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jH6g7ACByWIGrlHQ7afDRDGg98w/ZdjuT5DcSR9X+w8=;
        b=SeF5MWbPpxJrrw8lRjL+vyf6Viqn0xU7RoMsjpUHHv6wyITJICroqTnCPXKidW3SXi
         +6yI75x95Di4RJ79yBOwCMSoT0Dtu8l5aglAVT9bOWBywtmXY0gJbbI2T8Ect4atITrJ
         n3a2qBbdkxHJ2XCKdg7fy+DLMOXB8verKrO3iK+B219x45qCBTZ1wBWOREZgHtOUpeHV
         nuS/pgMKpTQ9b165+xiQlLSAMgrnPCj5GdqWTmQUjaFXF6RONAhGccJgRA76E7BvxtGq
         7SlSu/5ALIm5uVw1GxwfQzW3S1NGhSDlfUooksssoWM9e1ZVr5FfgfU/rYhWE+K5hvIT
         LZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jH6g7ACByWIGrlHQ7afDRDGg98w/ZdjuT5DcSR9X+w8=;
        b=OME4UY7vc1e+2bSrOu1vbRbUcP9jAMAo4Jq2pYEdSTjcxjnlJvTxj2AjmNNZcunr2L
         aNUdeSX68pwfV14OvMlipgQJLeziQDE1/yEQDljp76K2xL3x3C5k6mLZQhcSjMqEYB9S
         w6uw8/uVKG3t199yG7NwEEp531rkovN9BK94ekV8W42haSOQbfD5Pkq4RvDHr/Xc7zRe
         WUeWzcoQzP/4RfCIGHftHs0kvXIx8DBd9SgvQqASaOubzAtp+RUrq5PExkxOSGLOXERp
         xXYySa9j+AOWx+y3X/K3oYECvJ90o2I5l0eXW1R4ckTrO0oOK2B1inFTFlMs+BXkEqhu
         kq0w==
X-Gm-Message-State: ALQs6tBfOZVx5OdhVygJPyIib6bbV/NnyVotRORuDNDU59iIJvRe8QIA
        Tjsl76RQRunoNqIm1JLETQU=
X-Google-Smtp-Source: AIpwx48WrLC8yfA2g3q7jeYylGbZAqPaC3jL7JgFK6J8+iUpgNgN7S19SSNp/4w/FPy8BmzWevBG4Q==
X-Received: by 2002:adf:c088:: with SMTP id d8-v6mr5779726wrf.268.1524178088440;
        Thu, 19 Apr 2018 15:48:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c18sm253101wmd.13.2018.04.19.15.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 15:48:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isaac Chou <Isaac.Chou@microfocus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Git fast-export with import marks file omits merge commits
References: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
Date:   Fri, 20 Apr 2018 07:48:06 +0900
In-Reply-To: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
        (Isaac Chou's message of "Thu, 19 Apr 2018 21:46:38 +0000")
Message-ID: <xmqq604mertl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isaac Chou <Isaac.Chou@microfocus.com> writes:

> I inspected the source code (builtin/fast-export.c) for the
> fast-export issue I encountered, and it looks like the merge
> commit is discarded too early by the call to object_array_pop()
> after only one of the two UNSHOWN parents is processed in the
> method handle_tail().  The poped merge commit still has one
> UNSHOWN parent, therefore it is not processed and is lost in the
> output.  Can someone advise me on how to submit a code change or
> bug report in order to get the fix into the code base?
>
> Thanks,
>
> Isaac
>
> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Isaac Chou
> Sent: Monday, April 16, 2018 3:58 PM
> To: git@vger.kernel.org
> Subject: Git fast-export with import marks file omits merge commits
>
> Hello,
>
> I came across a change of behavior with Git version 2.15 and later
> where the fast-export command would omit the merge commits.  The
> same use case works correctly with Git version 2.14 and older.
> ...

There indeed are some differences between v2.14 and v2.15 around the
code that returns early when has_unshown_parent() says "yes" [*1*],
but the decision to return early when the function says "yes" hasn't
changed between that timeperiod---it dates back to f2dc849e ("Add
'git fast-export', the sister of 'git fast-import'", 2007-12-02),
i.e. the very beginning of the program's life.

I'll CC those who wrote the original and b3e8ca89 ("fast-export: do
not copy from modified file", 2017-09-20) and 71992039
("object_array: add and use `object_array_pop()`", 2017-09-23),
which are the only two commits that touch the surrounding area
during that timeperiod, to ask if something jumps at them.

Thanks.


[Footnotes]

*1* An excerpt from 'git diff v2.14.0 v2.15.0 builtin/fast-export.c'
    reads like so:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d412c0a8f3..2fb60d6d48 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
...
@@ -630,15 +645,15 @@ static void *anonymize_tag(const void *old, size_t *len)
 	return strbuf_detach(&out, len);
 }
 
-static void handle_tail(struct object_array *commits, struct rev_info *revs)
+static void handle_tail(struct object_array *commits, struct rev_info *revs,
+			struct string_list *paths_of_changed_objects)
 {
 	struct commit *commit;
 	while (commits->nr) {
-		commit = (struct commit *)commits->objects[commits->nr - 1].item;
+		commit = (struct commit *)object_array_pop(commits);
 		if (has_unshown_parent(commit))
 			return;
-		handle_commit(commit, revs);
-		commits->nr--;
+		handle_commit(commit, revs, paths_of_changed_objects);
 	}
 }
