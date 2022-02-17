Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE30C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiBQGjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:39:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBQGjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 01:39:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895822A520E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:38:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so3215641wmq.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HjmcCP/sSE2aj5Hc4yNPIsNTLCDYHodyrqOukPq8+8E=;
        b=cPE1om1v9fE4wz/jCkrinfAnLQpLTKHnAYMmI/oq+V4Ow/qm+hu0c+lLs6WrY439k9
         s6GgHbMeil7nt/2og4Hn1EsVQDbWP04x7KnBLGVl3DSYO3l7yDRunmElNtTz76tVSSJH
         60yl8qXWlBlkAkyHTVeunvq54BdewEyea7nZB/LflbTtmgSnexQNJKmcJqanw/aQ2emU
         LCuexyCZELhDRS5XyPJTrdFgbJ1HSoRz8kD+oLnLE/tpjPFXYWzw85RiKq41f601AxkP
         bG/JLfNFJP+KeZORIZsEdNThkdbfEnjPxfqKCxkU5ZQn7e3br5srv5UwQMU0xRd3a4sZ
         cEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HjmcCP/sSE2aj5Hc4yNPIsNTLCDYHodyrqOukPq8+8E=;
        b=rnrYNrwyP/K8w23ia3J+UOzXe6S9kD4GiDCnpb3inJP896hGVvmTCCZKOrYtpnmCL6
         CjnGomI+sQlfwWCZMlZPFaGAG2TxryNjoB8CQbcya0yaYQPOJzmwTZu7fRlNq1x4vDBK
         RSpIwy4jakfVBNTxRi1m8vsiKMCU1B+J6VnA9+Mas7qYnAf0xJ7MzhRb6kcNly1wYgzm
         ZqQXUlP0+xBYOj2/bpl1iuZfLiqLGZEluIM/uq/WXjInUlgsOuU+xNfIW9m/UE4xJbUm
         /qK26jqlDFiXbCzhW6tbmMNIHeUtscPyicc9eiCpNXGfQ2weScF/DNZU+aSgZM557j6i
         8e/Q==
X-Gm-Message-State: AOAM531jbjt3aSq5Rxja/dRLlQdptDZfc0ZXgE+KxRa/NIFji4GrZQGE
        T292eaFb5Vw1+EZTi7uFM6PSR9moD/E=
X-Google-Smtp-Source: ABdhPJwAgfjt/8fvCHWtB5FG/kriAKynsvQo/9RbMtuQW1vV5f7V+9o7dg1RsbaW4bY25ijPLgwyuQ==
X-Received: by 2002:a05:600c:4f03:b0:37c:b58:9c35 with SMTP id l3-20020a05600c4f0300b0037c0b589c35mr4524264wmq.118.1645079924782;
        Wed, 16 Feb 2022 22:38:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g22sm183650wmh.12.2022.02.16.22.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:38:44 -0800 (PST)
Message-Id: <pull.1121.git.1645079923090.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 06:38:42 +0000
Subject: [PATCH] merge-ort: make informational messages from recursive merges
 clearer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is another simple change with a long explanation...

merge-recursive and merge-ort are both based on the same recursive idea:
if there is more than one merge base, merge the merge bases (which may
require first merging the merge bases of the merges bases, etc.).  The
depth of the inner merge is recorded via a variable called "call_depth",
which we'll bring up again later.  Naturally, the inner merges
themselves can have conflicts and various messages generated about those
files.

merge-recursive immediately prints to stdout as it goes, at the risk of
printing multiple conflict notices for the same path separated far apart
from each other with many intervenining conflict notices for other paths
between them.  And this is true even if there are no inner merges
involved.  An example of this was given in [1] and apparently caused
some confusion:

    CONFLICT (rename/add): Rename A->B in HEAD. B added in otherbranch
    ...dozens of conflicts for OTHER paths...
    CONFLICT (content): Merge conflicts in B

In contrast, merge-ort collects messages and stores them by path so that
it can print them grouped by path.  Thus, the same case handled by
merge-ort would have output of the form:

    CONFLICT (rename/add): Rename A->B in HEAD. B added in otherbranch
    CONFLICT (content): Merge conflicts in B
    ...dozens of conflicts for OTHER paths...

This is generally helpful, but does make a separate bug more
problematic.  In particular, while merge-recursive might report the
following for a recursive merge:

      Auto-merging dir.c
      Auto-merging midx.c
      CONFLICT (content): Merge conflict in midx.c
    Auto-merging diff.c
    Auto-merging dir.c
    CONFLICT (content): Merge conflict in dir.c

merge-ort would instead report:

    Auto-merging diff.c
    Auto-merging dir.c
    Auto-merging dir.c
    CONFLICT (content): Merge conflict in dir.c
    Auto-merging midx.c
    CONFLICT (content): Merge conflict in midx.c

The fact that messages for the same file are together is probably
helpful in general, but with the indentation missing for the inner
merge it unfortunately serves to confuse.  This probably would lead
users to wonder:

  * Why is Git reporting that "dir.c" is being merged twice?
  * If midx.c has conflicts, why do I not see any when I open up the
    file and why are no conflicts shown in the index?

Fix this output confusion by changing the output to clearly
differentiate the messages for outer merges from the ones for inner
merges, changing the above output from merge-ort to:

    Auto-merging diff.c
      From inner merge:  Auto-merging dir.c
    Auto-merging dir.c
    CONFLICT (content): Merge conflict in dir.c
      From inner merge:  Auto-merging midx.c
      From inner merge:  CONFLICT (content): Merge conflict in midx.c

(Note: the number of spaces after the 'From inner merge:' is
2*call_depth).

One other thing to note here, that I didn't notice until typing up this
commit message, is that merge-recursive does not print any messages from
the inner merges by default; the extra verbosity has to be requested.
merge-ort currently has no verbosity controls and always prints these.
We may also want to change that, but for now, just make the output
clearer with these extra markings and indentation.

[1] https://lore.kernel.org/git/CAGyf7-He4in8JWUh9dpAwvoPkQz9hr8nCBpxOxhZEd8+jtqTpg@mail.gmail.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: make informational messages from recursive merges clearer
    
    Sorry for any confusion caused by this bug (though I'm surprised no one
    else reported it).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1121%2Fnewren%2Fmerge-ort-clearer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1121/newren/merge-ort-clearer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1121

 merge-ort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index d85b1cd99e9..55decb2587e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -651,6 +651,11 @@ static void path_msg(struct merge_options *opt,
 	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
 
 	va_start(ap, fmt);
+	if (opt->priv->call_depth) {
+		strbuf_addchars(dest, ' ', 2);
+		strbuf_addstr(dest, "From inner merge:");
+		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
+	}
 	strbuf_vaddf(dest, fmt, ap);
 	va_end(ap);
 

base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
-- 
gitgitgadget
