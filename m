Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E578C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbiCHJdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345360AbiCHJc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 04:32:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BF31906
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 01:31:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so28962272ejb.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Tjub0Dhw6n7p/eyiRQ65ZH/HzW0fsEe1+zjbAm+I8h0=;
        b=cfK5TIL4aJcse8Nyb6k+oxQAg/VQ9Hi1epdkd0NBsredOyDYtoZK0rruRXzs8LhmBd
         vx6uu6AynpG1Nl922DLHRBlAet5V8VkGYUAz8nMsIzaiYZbzk//nErAEYnxm5ANvY8hy
         KmLaaQRTEnS3psgsZv31QHNOSYKam+G6/f4Ll/+tRD7igSG1LhpAPL2KULo5no/LHXsx
         3KcHzThmViuSrfSUWVCstunibUKDZLPxxHgHsLIy80/2Kjg1+lCmHyUv3uE1vVkZLdFM
         oPiWxR7Crre+xlg1sx68VnSuJ4lyf13Lg0SXuRz5NYQXDnTt+o6x917aFAOMUsdU8JVC
         m7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Tjub0Dhw6n7p/eyiRQ65ZH/HzW0fsEe1+zjbAm+I8h0=;
        b=i+BO1ovrRtn81RcyVjfHaLEUtFs/VGqdQ6JmICTOI0iBcLdOYEgA/R7ZBfFGfIhNie
         Z8Lr+J0mrKlv62G4BkDoEU0C0WfSVIRM0k/xk3EL31rqqSaCq6XCtijytAYlsxYL/cdN
         3sehvu9qdLKLQomi+1BQqGubOsMPKTLG23ohehPJxGFU27i73DJ7HuSvnBcd57Y6dgFl
         hj1lk+YFbcWE3iO5sxHR1xrHTtOOUL3bU6/Knu27viRo3THrkwsXBjMNBOW1gKkYjEz1
         IKtFHSpacX7EVMgBjrz8CHWdjdfzO5UJIL5K1USx6SCJUj82elNr3njl7AwwViqLbkHH
         NYbA==
X-Gm-Message-State: AOAM533I8n6tZglB8obNF4zi51Ymi/2vPIXLn16iZeR+qgYKQIhaS3aQ
        fY1/7UDn5LfVQazqpXZUlzTj5ziwtaN5BA==
X-Google-Smtp-Source: ABdhPJwQGbyfmnzvQ3wv9PEt0JmMH3bOpwBLTUDpkymTPDqHbf8C3HLbt5Nk8qUQYWNOmd3tzntG3Q==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr12226661ejd.253.1646731917683;
        Tue, 08 Mar 2022 01:31:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i31-20020a0564020f1f00b00415a3351f06sm7240787eda.35.2022.03.08.01.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:31:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRWCC-001jaw-DN;
        Tue, 08 Mar 2022 10:31:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 08/12] bundle: parse filter capability
Date:   Tue, 08 Mar 2022 10:25:59 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <898a7d945131042c48f8e99acccf26378a4c8586.1646689840.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <898a7d945131042c48f8e99acccf26378a4c8586.1646689840.git.gitgitgadget@gmail.com>
Message-ID: <220308.86lexkyelv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The v3 bundle format has capabilities, allowing newer versions of Git to
> create bundles with newer features. Older versions that do not
> understand these new capabilities will fail with a helpful warning.
>
> Create a new capability allowing Git to understand that the contained
> pack-file is filtered according to some object filter. Typically, this
> filter will be "blob:none" for a blobless partial clone.
>
> This change teaches Git to parse this capability, place its value in the
> bundle header, and demonstrate this understanding by adding a message to
> 'git bundle verify'.
>
> Since we will use gently_parse_list_objects_filter() outside of
> list-objects-filter-options.c, make it an external method and move its
> API documentation to before its declaration.
> [...]
> --- a/bundle.c
> +++ b/bundle.c
> @@ -11,7 +11,7 @@
>  #include "run-command.h"
>  #include "refs.h"
>  #include "strvec.h"
> -
> +#include "list-objects-filter-options.h"
>  
>  static const char v2_bundle_signature[] = "# v2 git bundle\n";
>  static const char v3_bundle_signature[] = "# v3 git bundle\n";
> @@ -33,6 +33,8 @@ void bundle_header_release(struct bundle_header *header)
>  {
>  	string_list_clear(&header->prerequisites, 1);
>  	string_list_clear(&header->references, 1);
> +	list_objects_filter_release(header->filter);
> +	free(header->filter);
>  }
>  
>  static int parse_capability(struct bundle_header *header, const char *capability)
> @@ -45,6 +47,11 @@ static int parse_capability(struct bundle_header *header, const char *capability
>  		header->hash_algo = &hash_algos[algo];
>  		return 0;
>  	}
> +	if (skip_prefix(capability, "filter=", &arg)) {
> +		CALLOC_ARRAY(header->filter, 1);
> +		parse_list_objects_filter(header->filter, arg);
> +		return 0;
> +	}
>  	return error(_("unknown capability '%s'"), capability);
>  }
>  

Re the comment I had on the v1 about embedding this data in the struct
instead:
https://lore.kernel.org/git/220307.86y21lycne.gmgdl@evledraar.gmail.com/

The below diff passes all your tests, i.e. re using NULL as a marker I
think you may have missed that the API already has a LOFC_DISABLED for
this (and grepping reveals similar API use of it).

I'm not 100% sure it's correct, but if it isn't that's also going to
suggest missing test coverage in this series.

In any case you want the BUNDLE_HEADER_INIT change, your version is
buggy in making that header use NODUP strings by hardcoding { 0 }.

diff --git a/builtin/clone.c b/builtin/clone.c
index 52e50f17baf..000379eea7f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1172,9 +1172,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport->cloning = 1;
 
 	if (is_bundle) {
-		struct bundle_header header = { 0 };
+		struct bundle_header header = BUNDLE_HEADER_INIT;
 		int fd = read_bundle_header(path, &header);
-		int has_filter = !!header.filter;
+		int has_filter = header.filter.choice != LOFC_DISABLED;
 
 		if (fd > 0)
 			close(fd);
diff --git a/bundle.c b/bundle.c
index 9ca6a7eb1c2..3846108f7a6 100644
--- a/bundle.c
+++ b/bundle.c
@@ -33,8 +33,7 @@ void bundle_header_release(struct bundle_header *header)
 {
 	string_list_clear(&header->prerequisites, 1);
 	string_list_clear(&header->references, 1);
-	list_objects_filter_release(header->filter);
-	free(header->filter);
+	list_objects_filter_release(&header->filter);
 }
 
 static int parse_capability(struct bundle_header *header, const char *capability)
@@ -48,8 +47,7 @@ static int parse_capability(struct bundle_header *header, const char *capability
 		return 0;
 	}
 	if (skip_prefix(capability, "filter=", &arg)) {
-		CALLOC_ARRAY(header->filter, 1);
-		parse_list_objects_filter(header->filter, arg);
+		parse_list_objects_filter(&header->filter, arg);
 		return 0;
 	}
 	return error(_("unknown capability '%s'"), capability);
@@ -227,7 +225,7 @@ int verify_bundle(struct repository *r,
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
-	revs.filter = header->filter;
+	revs.filter = &header->filter;
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -269,9 +267,9 @@ int verify_bundle(struct repository *r,
 			  r->nr);
 		list_refs(r, 0, NULL);
 
-		if (header->filter) {
+		if (header->filter.choice != LOFC_DISABLED) {
 			printf_ln("The bundle uses this filter: %s",
-				  list_objects_filter_spec(header->filter));
+				  list_objects_filter_spec(&header->filter));
 		}
 
 		r = &header->prerequisites;
@@ -631,7 +629,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
-	if (header->filter)
+	if (header->filter.choice != LOFC_DISABLED)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
 	if (extra_index_pack_args) {
diff --git a/bundle.h b/bundle.h
index eb026153d56..7fef2108f43 100644
--- a/bundle.h
+++ b/bundle.h
@@ -4,15 +4,14 @@
 #include "strvec.h"
 #include "cache.h"
 #include "string-list.h"
-
-struct list_objects_filter_options;
+#include "list-objects-filter-options.h"
 
 struct bundle_header {
 	unsigned version;
 	struct string_list prerequisites;
 	struct string_list references;
 	const struct git_hash_algo *hash_algo;
-	struct list_objects_filter_options *filter;
+	struct list_objects_filter_options filter;
 };
 
 #define BUNDLE_HEADER_INIT \
