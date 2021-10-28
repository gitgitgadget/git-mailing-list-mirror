Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0691C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB98E61039
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJ1U2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJ1U2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:28:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B5C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:25:51 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f9so9669011ioo.11
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iov+rNvqjKeJHLycLiXW4kDd7HO3z5gPmvkO87z1SKM=;
        b=ZR5Ce1Sa7cPUdnWaxgHA8GewbQ0IdnT8D5sfbg376oL9Qqs1YSA0Dj7iygaZqvggxX
         U9mrPY1KVkkTJUlS9R15qYAJHh/Auhpt1e5U9XUYvQJ4ChwXt4fu8jdLvp4wAbDeOEWf
         0ad9WT3pRA0In+1Veu7knqRqiTY5ZebcEnLHHYlU4UqGsuvp1YrWn1WHoW7TvPV2WK08
         gXo/iywk/CwNaFLbJMV+6TV8MG7qhNjqgbfz03LAWPNC+9Lf4tf9rYwywPo/eV/LrHD/
         s3Hw6pNCC13/Jg4ynsIX43hJQxRrG59vAZJkswcR5GwE95x9AAd/t3etjgg64N1oBRAs
         oGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iov+rNvqjKeJHLycLiXW4kDd7HO3z5gPmvkO87z1SKM=;
        b=DCNT42EP7YtCeZfQSXqo7J085l7SyFd/SpixswllSaiTu8IusdjhkfzZfjMD5T1GhF
         TqraCqesqy5AIsTTL1nxSkdxwh/Azqtg07YYsn/ghAxslAR972I8GxhrR+wP3ofn9L/G
         xn4/2UN3QDn62EfbWd+tl4BucV6/BbKs5uSpA6dURW6QMjzQTmFqMkz8IOaNRrx5JjY7
         3MmkAoC7Ph+OHODzjTRm0xKCBG807DR88zdX4IWbMENeWJ7btTU18M2Tn4wqujjNTpJF
         wZzE5KLdWy4vmgEdX+/PiwzUSFRPbkFSM4tg2JzJTpzcJHmfhyrSDvf6DQYoZ07ICre0
         2vPw==
X-Gm-Message-State: AOAM530U4B1qAvuP1TsbPjOWKOxiXkUqzWQYraj016Z0pOtqBKVPLEMG
        WeDxwQ3o7xjHi2nsm9/51Nt1GA==
X-Google-Smtp-Source: ABdhPJzNsAKlr2WXZleEaq940yHdvm5kdPlpsX5qfs22wy+KqpJz1YdOyPSzB0ibfugfajlz6C3xZA==
X-Received: by 2002:a05:6638:1414:: with SMTP id k20mr4951243jad.50.1635452750152;
        Thu, 28 Oct 2021 13:25:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g13sm2066500ile.73.2021.10.28.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:25:49 -0700 (PDT)
Date:   Thu, 28 Oct 2021 16:25:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH v2 5/9] builtin/repack.c: avoid leaking child arguments
Message-ID: <YXsHTKGBYYeDsdhh@nand.local>
References: <cover.1635282024.git.me@ttaylorr.com>
 <bcd12ecab81029be825a646348cb7ae69970a819.1635282024.git.me@ttaylorr.com>
 <xmqqzgqut4lr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgqut4lr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 04:44:48PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -586,8 +588,10 @@ static int write_midx_included_packs(struct string_list *include,
> >  		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
> >
> >  	ret = start_command(&cmd);
> > -	if (ret)
> > +	if (ret) {
> > +		child_process_clear(&cmd);
> >  		return ret;
> > +	}
>
> This happens only when start_command() returns an error.  But the
> function always calls child_process_clear() before doing so.
>
> So I am not sure if this hunk is needed.  It didn't exist in v1, if
> I recall correctly.  Am I missing something obvious?

No, it was the person replying to you missing something obvious ;).

Any hunks like this that call child_process_clear() after
start_command() returns a non-zero value are unnecessary. But the one in
repack_promisor_objects() is good, and does prevent the leak that had
led me in this direction in the first place.

Here is a suitable replacement for this patch (I believe that everything
else in this version is fine as-is):

--- >8 ---

Subject: [PATCH] builtin/repack.c: avoid leaking child arguments

`git repack` invokes a handful of child processes: one to write the
actual pack, and optionally ones to repack promisor objects and update
the MIDX.

Most of these are freed automatically by calling `start_command()` (which
invokes it on error) and `finish_command()` which calls it
automatically.

But repack_promisor_objects() can initialize a child_process, populate
its array of arguments, and then return from the function before even
calling start_command().

Make sure that the prepared list of arguments is freed by calling
child_process_clear() ourselves to avoid leaking memory along this path.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82..9b74e0d468 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -258,9 +258,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	for_each_packed_object(write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);

-	if (cmd.in == -1)
+	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
+		child_process_clear(&cmd);
 		return;
+	}

 	close(cmd.in);

--
2.33.0.96.g73915697e6

