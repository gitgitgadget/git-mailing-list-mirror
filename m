Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071CEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 09:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjF2JZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjF2JYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 05:24:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145E2134
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 02:24:45 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57040e313c5so7154347b3.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688030685; x=1690622685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9Jv1/9KpfwqbkZKiYo9krh7uVwlyxu0hLUxRl+AH7c=;
        b=m08ipdsF+scEajP5/yoWepJ+xv6qWueqhNZsejoI6n2tGh/6NhPu0a3muV24uOr6FA
         f/14RXChA4Ivj7hMIwQrM/czeivAjo8K1lOAmgz2TBd+Y3cWhSp9tN7ZSIIcwKhJpYYu
         AEIwHraC+3zMRe1Ai66yWerRJJtVP1p5h2bOT8S6Dc99hp9hj443HbpR7WEzlYOdPfhA
         FGfpvuMG1mBKWeqHWfkHTtj129fTqTBwlRoVGmE08CvV6qkHWn+lJaeIn6k5ckjuJ4Tb
         ehFe04CGuMiaOz2t2tb0ox8hUrOvEu5JqfR2j5lT7SUZg4rRHRkwUzAz72a3rVMUqfAt
         uz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030685; x=1690622685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9Jv1/9KpfwqbkZKiYo9krh7uVwlyxu0hLUxRl+AH7c=;
        b=PxHkGxcTrKQhUUG8Cup2wYzCB+1xtALMM5gQU0MCYS0xixEgUyb6I762MRE0hdgQ9w
         dbEjcIaHFGqA1gDfyr3qbtOQIJqhdYbQPI/14CmkaU7+rNu1W/ZAP3Xow1ggCMihpSBy
         bxUTmpt7rt6xuKT1rRZWD5Faeo/RMiFnuW9Dhu5HKDrt8CDJgf8/cXk5Lg4HVxD2mF6e
         42v6qb5sA1NTpPlEhfRyU4bv4Vk5jn4fJmxDIOh72t32hPx71qPwIZZNJbeDCKGFPb8r
         f6IEmCoOoboJ5hRWK+ILP6uxTYj+2HoyVjcZJmStpXs6tUBgewCVBoA4kl2t2UGemh73
         cp+Q==
X-Gm-Message-State: ABy/qLYbt/bQaV/fGD6FdcFYhKDBU/g9ptROepiugFEkpfSyZ+90YvQ7
        LuwVwIGQ+nyj449UEOGdqj6B7HVJCLg4UaYzafDvMyU1
X-Google-Smtp-Source: APBJJlHnka4biV4/k4PwM6Sik/EGfLFmz8Aizk8gIpnNK1y25WsuRSgEQK3PUd+PeCZkjHQYBV2rqQ==
X-Received: by 2002:a81:928d:0:b0:56f:f83f:618 with SMTP id j135-20020a81928d000000b0056ff83f0618mr4793333ywg.19.1688030685013;
        Thu, 29 Jun 2023 02:24:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x185-20020a814ac2000000b005771bb5a25dsm466004ywa.61.2023.06.29.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:24:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 05:24:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] repack: only repack .packs that exist
Message-ID: <ZJ1N2I6sDfxhrJo8@nand.local>
References: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
 <20230627075427.GE1226768@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627075427.GE1226768@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 03:54:27AM -0400, Jeff King wrote:
> > In other cases, Git prepares its list of packfiles by scanning .idx
> > files and then only adds it to the packfile list if the corresponding
> > .pack file exists. It even does so without a warning! (See
> > add_packed_git() in packfile.c for details.)
>
> Interesting. I'd have expected a warning. ;)

Reading this all over, I was incorrect in my original suggestion that
not checking for the existence of the matching ".pack" file was the
expected thing to do.

We don't try to open the ".pack" file itself in add_packed_git(), that
happens later in open_packed_git() if we end up actually needing to read
objects from the pack, or want to retain a handle on it for later if
we're worried that the ".pack" file itself might get deleted.

But that add_packed_git() silently ignores a pack which has its ".idx"
file and not its ".pack" file is behavior that I wasn't aware of, and
had somehow missed when I reread the function last week.

Stolee: I apologize for having missed this important detail. I think in
that sense matching the behavior of add_packed_git() here is the right
thing to do, and that this patch makes sense to me.

> I also kind of wonder if this repack code should simply be loading and
> iterating the packed_git list, but that is a much bigger change.

I have wanted to do this for a while ;-). The minimal patch is less
invasive than I had thought:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index 1e21a21ea8..e854c832fd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -104,46 +104,33 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 				   struct string_list *fname_kept_list,
 				   const struct string_list *extra_keep)
 {
-	DIR *dir;
-	struct dirent *e;
-	char *fname;
+	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;

-	if (!(dir = opendir(packdir)))
-		return;
-
-	while ((e = readdir(dir)) != NULL) {
-		size_t len;
+	for (p = get_all_packs(the_repository); p; p = p->next) {
 		int i;
-
-		if (!strip_suffix(e->d_name, ".idx", &len))
-			continue;
-
-		strbuf_reset(&buf);
-		strbuf_add(&buf, e->d_name, len);
-		strbuf_addstr(&buf, ".pack");
+		const char *base = basename(p->pack_name);

 		for (i = 0; i < extra_keep->nr; i++)
-			if (!fspathcmp(buf.buf, extra_keep->items[i].string))
+			if (!fspathcmp(base, extra_keep->items[i].string))
 				break;

-		fname = xmemdupz(e->d_name, len);
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, base);
+		strbuf_strip_suffix(&buf, ".pack");

-		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
-		    (file_exists(mkpath("%s/%s.keep", packdir, fname)))) {
-			string_list_append_nodup(fname_kept_list, fname);
-		} else {
+		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
+			string_list_append(fname_kept_list, buf.buf);
+		else {
 			struct string_list_item *item;
-			item = string_list_append_nodup(fname_nonkept_list,
-							fname);
-			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
+			item = string_list_append(fname_nonkept_list, buf.buf);
+			if (p->is_cruft)
 				item->util = (void*)(uintptr_t)CRUFT_PACK;
 		}
 	}
-	closedir(dir);
-	strbuf_release(&buf);

 	string_list_sort(fname_kept_list);
+	strbuf_release(&buf);
 }

 static void remove_redundant_pack(const char *dir_name, const char *base_name)
--- >8 ---

I think you could probably go further than this, since having to store
the suffix-less pack names in the fname_kept and fname_nonkept lists is
kind of weird.

It would be nice if we could store pointers to the actual packed_git
structs themselves in place of those lists instead, but I'm not
immediately sure how feasible it would be to do since we re-prepare the
object store between enumerating and then removing these packs.

Thanks,
Taylor
