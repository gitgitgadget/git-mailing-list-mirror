Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5518FC433E6
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 11:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B1520720
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 11:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQQ7nOnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgGLLgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgGLLgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 07:36:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0201C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 04:36:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so8291651edy.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MgNmNNFGkQ7kM+bCELoK3YekcUdBOas55NE9mVS+xeU=;
        b=cQQ7nOnE9A0UIQoVWgCeLSSX2G7dyWhldqRe5fvjWt3MrR905YZ17uYCXXLjrwUiNd
         3BNr7a97UPdnIkqdcUP+YDXlFSMu/8iCjlLFp8Cs+cxMinqGOvxsg58S+/bbD4d2n5Br
         0l7uDViPazXZPsVdOfFDCfm74X1ds7LvtC8SrrTWtj+5w9epcIgcGD5qEytkfX6iIsaq
         W6yNgE/AKeIuODKKUAg1u9uyYK+Jq9MVZuODerrYLGQa242ZHTQHZpPrbwu3TVun4tep
         cGgz95kXplQ6FgVFKe2PuxYbS/tU48hgv5pzBatM1+OmesO8UOe8ptHYCKPxD5IgCQXF
         wF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MgNmNNFGkQ7kM+bCELoK3YekcUdBOas55NE9mVS+xeU=;
        b=toGIN8e284BnuyJakvy9EnObrOLVyF7drS9MHnNUETDTuj0z1xaW2MnWQ9hTRe/Jij
         nmnzB/k1HU1IKqDsGUcVRC2FRrSnWO+dn/U2SAR4UGF75ruhdHHOUpFFBbfnJk8d+ewp
         0UcIioysr/thBWo4QA5yWSBdj0Ws9KrGHM/3900ge0y5KotVzM+RJ2rEsRMfN0p/9BUU
         95rFGnOlIe5imQPopOFQjSKpQL+Gpb6GHLOsdddh7drrHg4MVmpBMVji7/IjD23iz630
         9qBFYzUWC8NqAiNEiNCghKuc5pxuixg++Lv6xTivXtghAK9EzHcCac166nF+hbdX3t1U
         rg4A==
X-Gm-Message-State: AOAM531IyrBrTlPqXyyBU8mJ0G3May7ef0CElOovlnaZI+FQy+eemq5o
        JsRF7BhxDvDftff5pIEZKMI=
X-Google-Smtp-Source: ABdhPJwTTEpIqtqrX/eFfHTb/zE7ViI3kiW+BxbouWcFRkhMA/9E5CvZPu0xYbe+xNeHZl6VT+yR8w==
X-Received: by 2002:a05:6402:1c07:: with SMTP id ck7mr74623445edb.297.1594553803522;
        Sun, 12 Jul 2020 04:36:43 -0700 (PDT)
Received: from andromeda.lan ([80.215.156.54])
        by smtp.gmail.com with ESMTPSA id sd15sm7424527ejb.66.2020.07.12.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 04:36:42 -0700 (PDT)
Date:   Sun, 12 Jul 2020 13:36:37 +0200 (CEST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v1 06/17] merge-index: libify merge_one_path() and
 merge_all()
In-Reply-To: <0e20fa12-4628-d1fe-fc6e-df83d26edda3@gmail.com>
Message-ID: <alpine.LFD.2.21.2007121330130.17922@andromeda.lan>
References: <20200625121953.16991-1-alban.gruin@gmail.com> <20200625121953.16991-7-alban.gruin@gmail.com> <0e20fa12-4628-d1fe-fc6e-df83d26edda3@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood (phillip.wood123@gmail.com) a écrit :

> Hi Alban
> 
> On 25/06/2020 13:19, Alban Gruin wrote:
> -%<-
> > diff --git a/merge-strategies.c b/merge-strategies.c
> > index 3a9fce9f22..f4c0b4acd6 100644
> > --- a/merge-strategies.c
> > +++ b/merge-strategies.c
> > @@ -1,6 +1,7 @@
> >  #include "cache.h"
> >  #include "dir.h"
> >  #include "merge-strategies.h"
> > +#include "run-command.h"
> >  #include "xdiff-interface.h"
> >  
> >  static int add_to_index_cacheinfo(struct index_state *istate,
> > @@ -189,3 +190,101 @@ int merge_strategies_one_file(struct repository *r,
> >  
> >  	return 0;
> >  }
> > +
> > +int merge_program_cb(const struct object_id *orig_blob,
> > +		     const struct object_id *our_blob,
> > +		     const struct object_id *their_blob, const char *path,
> > +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> > +		     void *data)
> 
> Using void* is slightly unfortunate but it's needed later.
> 
> It would be nice to check if the program to run is git-merge-one-file
> and call the appropriate function instead in that case so all users of
> merge-index get the benefit of it being builtin. That probably wants to
> be done in cmd_merge_index() rather than here though.
> 

Dunno, I am not completely comfortable with changing a parameter that 
specifically describe a program, to a parameter that may be a program, 
except in one case where `merge-index' should lock the index, setup the 
worktree, and call a function instead.

Well, I say that, but implementing that behaviour is not that hard:

-- snip --
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 6cb666cc78..19fff9a113 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,11 +1,15 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
 	const char *pgm;
+	void *data;
+	merge_cb merge_action;
+	struct lock_file lock = LOCK_INIT;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -26,7 +30,19 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		quiet = 1;
 		i++;
 	}
+
 	pgm = argv[i++];
+	if (!strcmp(pgm, "git-merge-one-file")) {
+		merge_action = merge_one_file_cb;
+		data = (void *)the_repository;
+
+		setup_work_tree();
+		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	} else {
+		merge_action = merge_program_cb;
+		data = (void *)pgm;
+	}
+
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -36,13 +52,22 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "-a")) {
 				err |= merge_all(&the_index, one_shot, quiet,
-						 merge_program_cb, (void *)pgm);
+						 merge_action, data);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
 		err |= merge_one_path(&the_index, one_shot, quiet, arg,
-				      merge_program_cb, (void *)pgm);
+				      merge_action, data);
+	}
+
+	if (merge_action == merge_one_file_cb) {
+		if (err) {
+			rollback_lock_file(&lock);
+			return err;
+		}
+
+		return write_locked_index(&the_index, &lock, COMMIT_LOCK);
 	}
 	return err;
 }
-- snap --

> > +{
> > +	char ownbuf[3][60] = {{0}};
> 
> I know this is copied from above but it would be better to use
> GIT_MAX_HEXSZ rather than 60
> 

Cheers,
Alban

