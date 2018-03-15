Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B521F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeCORck (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:40 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:37929 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCORcd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:33 -0400
Received: by mail-vk0-f73.google.com with SMTP id w188so4735411vkg.5
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=08SwcEMrvkIVtzdtJtJ5eqfC7p6M1sTGWXKj07Fg41g=;
        b=AbxBdDcyluH7HMCOVkPFX9IwxXy+CIeIAHRn8IkGjWzMxtBi6JiSQU0TpEX4FB07/b
         ihCNFd3I449fHiEzz8fqJ+LbB4BAkH+aNpYAFRhNX1ILv84hdka9rHbFmftdX17nAzpU
         gM1se3PLos5VPMCfBjTMoeckdTjRRbGBVWx6Be0tN8o2KrV3d2F7xh98eRYuAgrxwuwQ
         oO7cclxkg1PsqQFhRGCa7owcSsj0OgLH/FOaMZeRH6NVlHJEQ8BQDTbJ51JEOYglVogI
         RW13DJ0qbxCMd67+aT6ZeO+kq08zk8i6HJaSvRnvdMVAAdrpgJGxu7OZQUMs3i8ijpNa
         XgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=08SwcEMrvkIVtzdtJtJ5eqfC7p6M1sTGWXKj07Fg41g=;
        b=NGDWHzsE8e7N2tgeAKsSGBQDZ856/Ibhx239BTdxot/NRyZjI/gxN7KGYDYldt9SRm
         easAbZrm1H0p3tTP+TGkD/oS6kDDMfEPDCRHldhAviYtQd+9dC4peXauSQYT5bQMszy5
         pbWt3pKSrph6kvIXFpZQWQo86am3JrmXYQrFQAST+GQv14/zTAorzP3c1l9Sucwc0YGk
         CpCrkkx6gvATj+HYac2gDyElFEMDH4EqgzA45m7pT0jNPY1ipv3ncTrNgwt3/JaJHGBN
         F4JU+XQQUwksIoca26xPUGe+hcySy2rrJCH1hjTASqkdXA0Rg0Ro+x1CJAgbo7Z0yf4v
         2i9g==
X-Gm-Message-State: AElRT7HsTOsTh+qNzAIcaq371cTLwsSR9NuWiB+B7EjdPSFB96IFba3X
        l3j9urPdL08Zb68ydxmm8XKuYtUyw+1S9x6SRkFJ6l/HHUPPmNLrVJY1HokCveJYEELCuf5hEMW
        /vrzZqDCB6BkA7YTGxGV9byVOgO7VhHU8t1p2pozfMVQejrCMTbjjbEvazg==
X-Google-Smtp-Source: AG47ELu4AKZeKFslinWnUzPvznYzMjQSV9d0tluAKidmRoKJlberuO54j+fwgX8Ta4K3EGtJsjuzOctBoJM=
MIME-Version: 1.0
X-Received: by 10.31.158.197 with SMTP id h188mr3984947vke.109.1521135152482;
 Thu, 15 Mar 2018 10:32:32 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:26 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-20-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 19/35] push: pass ref prefixes when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref prefixes to be passed to 'get_refs_list()' from
the refspec to be used during the push.  This list of ref prefixes will
be used to allow the server to filter the ref advertisement when
communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 3f130518d2..57bdbb59bc 100644
--- a/transport.c
+++ b/transport.c
@@ -1028,11 +1028,38 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
+		struct refspec *tmp_rs;
+		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
+		tmp_rs = parse_push_refspec(refspec_nr, refspec);
+		for (i = 0; i < refspec_nr; i++) {
+			const char *prefix = NULL;
+
+			if (tmp_rs[i].dst)
+				prefix = tmp_rs[i].dst;
+			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
+				prefix = tmp_rs[i].src;
+
+			if (prefix) {
+				const char *glob = strchr(prefix, '*');
+				if (glob)
+					argv_array_pushf(&ref_prefixes, "%.*s",
+							 (int)(glob - prefix),
+							 prefix);
+				else
+					expand_ref_prefix(&ref_prefixes, prefix);
+			}
+		}
+
+		remote_refs = transport->vtable->get_refs_list(transport, 1,
+							       &ref_prefixes);
+
+		argv_array_clear(&ref_prefixes);
+		free_refspec(refspec_nr, tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.16.2.804.g6dcf76e118-goog

