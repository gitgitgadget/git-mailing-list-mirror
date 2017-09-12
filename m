Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CFA1FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 17:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdILRbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:31:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36347 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdILRbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:31:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so6478791pgt.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74RWprR0TFBJK3qPVVIpqUnUXSy1+5vcCTXB1J7/PDQ=;
        b=nmVEqDxye1uLJco6djKjDjRQQ/gR8oDWkIJw5m+uE/az1Z8mkyR2R2+gSl6ehj0uHU
         BmfMuHJjM2TBWn8ujGgQa26p8a8umkZa3PE8WYk14OLppycyGclRoq/qcj4cBZE1kb4x
         Tk3fam8x+TMDHpEB4mz3gV0RD8ET3lgRjVX8P/GPlV3Fv2pk2tVvPHEAihz3LaSklQEU
         Rk9ZtNWc2n7sjtuOZU8avk/ir1yR4DNSHuoNZlo2MHQm2cS10UwCtYI+1GmrGxYsfeDf
         Zf0H55OZhPxnGNnMff2a+saOpsLRLWjU6aegCMmtD88qrIfFJX33wDn9bGVHVjcIPA7N
         fCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74RWprR0TFBJK3qPVVIpqUnUXSy1+5vcCTXB1J7/PDQ=;
        b=X33VjBp+mE2rkgpN8UBMgY5HnWBIdZPWydetfKdPX2A/IKMNF4sSf3SF+9fp1GXV8X
         E8AgWxoeccYbx8IcdpMNYThx2XcskBVb44+7bouva1labnyFqNUCGPKbyag3SB8IuKz6
         Pg54KT/eouX/MqK5EmKIb4ZyrIHPirAgTBVHFz033tkkp8EfZ9YUkLBeecy4d0MMbKv/
         XA3bWQsovCjsC80kesEpqYGE0I+11fzrK3ednegXgdgP2NRC4opm7KKQGsRtS144Ra5Z
         qr5w+jko6tmvJJ00dfQxpiDDc8ZUHGf2uDrvK83NZyHHvpsUnWqfMhtsXZ0MLwzycviM
         INGA==
X-Gm-Message-State: AHPjjUjhLULvXmvGPh4ArfbSJP8KSB+6BILdWjdbr1WKPIcxPXmYUo8x
        xcT/B/C7Q5Q5G+kQ7+s=
X-Google-Smtp-Source: ADKCNb70wy1uHXvvGRhrcClIJoftbrnLCzLgBgjtRJLy8tp1IbE5J8BNZRJ0/DGb8y6vkkqsZvOGfw==
X-Received: by 10.84.160.204 with SMTP id v12mr17691677plg.382.1505237502941;
        Tue, 12 Sep 2017 10:31:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9def:8161:22df:85ca])
        by smtp.gmail.com with ESMTPSA id o30sm19284818pgc.83.2017.09.12.10.31.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 10:31:42 -0700 (PDT)
Date:   Tue, 12 Sep 2017 10:31:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/4] replace-objects: evaluate replacement refs without using
 the object store
Message-ID: <20170912173140.GD144745@aiede.mtv.corp.google.com>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912172330.GA144745@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Pass DO_FOR_EACH_INCLUDE_BROKEN when iterating over replacement refs
so that the iteration does not require opening the named objects from
the object store. This avoids a dependency cycle between object access
and replace ref iteration.

Moreover the ref subsystem has not been migrated yet to access the
object store via passed in repository objects.  As a result, without
this patch, iterating over replace refs in a repository other than
the_repository it produces errors:

   error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!

Noticed while adapting the object store (and in particular its
evaluation of replace refs) to handle arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b0106b8162..cd84ed9710 100644
--- a/refs.c
+++ b/refs.c
@@ -1394,7 +1394,7 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(get_main_ref_store(),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
-			       0, cb_data);
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
-- 
2.14.1.690.gbb1197296e

