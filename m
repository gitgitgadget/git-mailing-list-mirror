Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE8120248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDIP5A (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:57:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfDIP5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:57:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so9542031pgc.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IyRzfhjIPtRX5i+HK7htBxMcLl7O+HquThdC7G/Gdos=;
        b=GdoRCgDxCVhK3HxXxbj9pAevayMTEIEZNIP6ooxzOMGnDPSvE7gfkOLoNOm5Rd3ZC7
         68H3pylIdxcHl7e5lhF3NSWeIfXKbgOEX3oZNA7Op3GN6oAWN+g8gs8oLCnYrcVuhr4s
         IorGbMLH2Op7UhdnikHnyggwBOE9iMxyZht85tgmnr8uTMrFTAXLS6L0Y3JAj518f3yQ
         cf8OvSXlXSIQGZDISc6bGfTkfSn/oSkqzWY4zP0qI7z1Uxpjm9Z8tKdf2fJ90FdVU/Nj
         BQZ0uWq2iG2JpDrF22mqfqP0nkXwr/0slcQogtLVDCO/CDZ3YYIhCMwSXBmJaJ/vmrnN
         ny8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IyRzfhjIPtRX5i+HK7htBxMcLl7O+HquThdC7G/Gdos=;
        b=k3K2JdZ5avXxah40V3n1PfzUHSuNsJ9qe8wmww6f8cnOMMpyhlVAR+0bs+qlKl4zaq
         dhsWKkuOxhkrbEbCDeKJN8ROkAVWHSnbfR+Tfb/V/EWrF3jmUwRZEDX84rirgZ/iMwJx
         ji3QrPOtOVcD7CeyWNo3LNz04RWifCTipxxYDUBQtTr27n/zCTkju+DcXNx7sR8xQObR
         6O7WKAsoF97HQgjr7rqI25nNrgnpYJ8199sOSxgJiK6egGP3S+k+8E9Qr4zahFJh1N9n
         jkZOwlDLzCut3iAx2up/bGeBDpl/DJfxDQ/jD58hnlxvbYZ00GJ45bcyZhFKthXxuMXp
         JjGw==
X-Gm-Message-State: APjAAAXZo9jHnu9o8XM/4nOnSNASwzoWWB8+dy8ij1Gi5dQL7lK1QEXL
        eaIjok2D/bnA1nr3nWv6O29bXg==
X-Google-Smtp-Source: APXvYqzblbiPI5ZjaDnO9DdyVNeE7Q6Ju0GNsrmIGyjEBi7O6zvTy5d0AGt5T0GXavps7Gk9oS9D3Q==
X-Received: by 2002:a63:6b08:: with SMTP id g8mr28538560pgc.211.1554825418518;
        Tue, 09 Apr 2019 08:56:58 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id j6sm44286229pfe.107.2019.04.09.08.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:56:57 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines> <20190407214635.12984-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <2747b3b2-0447-0d03-dc7e-c7fa460a303b@google.com>
Date:   Tue, 9 Apr 2019 11:56:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190407214635.12984-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 4/7/19 5:46 PM, michael@platin.gs wrote:
> From: Michael Platings <michael@platin.gs>
> 
> Hi Barret,
> This is the updated fuzzy matching algorithm, sorry for the delay. It does
> highlight a bug in the calculation for the number of lines ("int nr_parent_lines
>   = e->num_lines - delta;") - if you apply the patch, build it, then try to
> ./git blame --ignore-rev <the patch commit ID> blame.c then you'll get a segfault
> because nr_parent_lines is a negative number. I haven't had time to investigate further
> but I have confirmed that the bug is not due to my patch.

Although I couldn't recreate this, I saw how it could happen.  I have an 
updated version that fixes it.  Short version: I just pass through 
parent_len instead of trying to recreate it with 'delta.'  Recreating 
can go awry because e->num_lines may be less than a chunk size.

> The matching algorithm might not be obvious so it could do with more commenting.
> In the mean time I hope the tests will make the intent clear. In particular I
> want to avoid lines being reordered, because for the interesting use cases
> usually sequences are unchanged even if they shift across different lines.

I thought you wanted to detect similarity across potentially reordered 
lines.  E.g.

commit a 10) #include <sys/a.h>
commit b 11) #include <foo/b.h>
commit c 12) #include <bar/c.h>
commit d 13) #include <dir/d.h>

Where commit X (to be ignored) alphabetized them (or something):

commit X 10) #include <bar/c.h>
commit X 11) #include <dir/d.h>
commit X 12) #include <foo/b.h>
commit X 13) #include <sys/a.h>

In this case, you want to find the line number in the parent that 
corresponds to each line in the target (X is the target, in the relevant 
blame code).  The mapping is: (target -> parent)

10 -> 12
11 -> 13
12 -> 11
13 -> 10

And the parent's line numbers are out of order.  But that's fine - at 
least with the infrastructure from my patch, since it sorts the ignored 
queue at the end of blame_chunk().  The rule in blame.c is that blame 
entries attached to a suspect need to be sorted by s_lno.  (At least 
based on a comment, and my reading of the code).

Maybe we have a different definition of reordering or are having 
different issues regarding line numbers?  TBH, I didn't follow the 
recursion and partitioning strategy too closely.

> Regarding the existing implementation I've got to say I find it unhelpful
> marking "unblameable" lines with a 000000 commit ID. That commit ID already has
> a meaning - lines that aren't yet committed. Further, the purpose of ignoring
> commits should be to avoid obscuring other useful information, not to absolutely
> refuse to show that commit at all. If there's no other commit to show then it's
> harmless to show the commit that would otherwise be ignored.

For me, if I tell git blame to not tell me about a commit, then I don't 
want to hear about it.  My typical blame session involves running blame, 
then digging up the commit it pointed to.  If it points to the commit I 
already told it to not show, then it'll just annoy me.   All 0s made 
sense to me as in "don't bother looking this up."

If you *did* want to see the ignored commit, then I'd run it with 
--ignore-revs-file="", to disable ignore.

That being said, I realize this is a preference of mine, and I can make 
a blame config option to control this.  Probably 
blame.maskIgnoredCommits or something.

> - How about matching *outside* the parent's diff hunk?
> I'd like to know what the use case would be for that. For the use case of
> looking "through" a reformatting or renaming commit I think it would be unhelpful.

I noticed that I have some commits where a hunk in a diff is broken up 
into multiple calls to blame_chunk.  So a better way to prhase it would 
be "looking outside a blame_chunk()'s chunk."

For example, I have a hunk like this (modified to show the contiguous 
lines of context, subtraction, addition):

@@ -256,99 +260,99 @@
   3 context
-83 subtract
+23 addition
   1 context
- 2 sub
+16 add
   1 context
- 5 sub
+ 6 add
   1 context
+45 add
   3 context

blame_chunk() sees that as four separate calls, broken up by the lines 
of context:

	blame_chunk tlno 262 off -4 same 285 plen 83 enl 23
	blame_chunk tlno 286 off 56 same 302 plen 2 enl 16
	blame_chunk tlno 303 off 42 same 309 plen 5 enl 6
	blame_chunk tlno 310 off 41 same 355 plen 0 enl 45

For a lot of those lines, the source of the change was in another diff 
hunk - especially that 45 line addition with nothing from the parent.

Part of the reason for that large diff is whitespace changes, so I can 
run blame with -w.  But there are other scenarios.  Here's another one: 
the header file alphabetizing case:

@@ -4,9 +4,9 @@
   3 context
- 1 #include <header.h>
   2 context (other headers)
+ 1 #include <header.h>
   3 context

That shows up as two blame chunks:
	blame_chunk tlno 6 off 0 same 6 plen 1 enl 0
	blame_chunk tlno 8 off 1 same 9 plen 0 enl 1

What's funny about it is that if the commit we're ignoring did more 
damage to the file (changed every line, for instance), it'd be easier to 
find the right line in the parent, since we'd have the entire diff hunk.

Anyway, being able to look outside the current blame_chunk would help in 
those scenarios.  Specifically, I'm talking about letting blame_chunk() 
point anywhere in the parent.  Right now, it can only look in the 
parent's part of the chunk passed to blame_chunk, which can be 
relatively small.

Barret

