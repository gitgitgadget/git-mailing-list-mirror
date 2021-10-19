Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4FEC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66636137C
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhJSLlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhJSLld (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BCC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1799268pjc.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcjdlnazJFixfNBZyGZFW8vyt2Ag975HFZiW7FqM/pg=;
        b=S1M70a63y4yxBoMvhj5h+tta0Lt2ziBJeE7uppr9FzZux0C03gavWqomdSPoHyA4iF
         9gcrmxwDY6bmInWyacDiBm4W6mzy9TJMMdvPNdCE+YE1PBDQoBEV+a9Bh/XR8bC+LwCt
         Yqe5Z8EcOIpb4o4M9iy1EfDt+g8qUQerel7v4WoohC4BRY9w+fanpIhcErShZVDjiDQ4
         y7NtF30fPHqCBWb1spv90DDv34pSXmB8zikkFkVgY/Z4W45+8zOyKEa1Tqs7rjetxBWE
         hOHL18SgmUJGYHlEX6GY/Emnt3WLJR98VClzonGdrR2hAovbqrAt9nmhd3bNcQgqBiXT
         UAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcjdlnazJFixfNBZyGZFW8vyt2Ag975HFZiW7FqM/pg=;
        b=nMrRJtldp3qTkLFKtnlY2huFdtpNPYmQBhuWcpuXxzdU8uVFp9+F/hfVN9nId579G3
         a6m7Tho7l12gUAepIW/goAmBQWRIeo+lJoKhb75R7mG2fo6ODKhpqY7sZ8h+r4c9srxI
         LqNf/oZZ7r6rws29jdODMd51N4LA5T1YqREsMJJU9lH7ehpV4gVZcJ3uXdWUujdYUqvS
         EHOht82ED3dTzrdoZ3cPh9A8XHVzQRYduWurdO2eplOlFITV5fnFiqf8fk4WbmMmel9z
         qCvQYz4d0PP5PcJzSTUe1LAM62UWXu9Xz2MrxIXvfnRv/N9ZITI2rAdf9b2qR88ZzYcI
         TcTQ==
X-Gm-Message-State: AOAM532DIZzOFK667HKM2awprRyZD0VvAKnoiUYtte5HVFY0B+k9z6Za
        OBGFyDK6HxTwWC0HDpf0DikiyUp+LlE=
X-Google-Smtp-Source: ABdhPJxdLF3heRUB5Yhukn2GZiGts2JeuauHg6DB0OFi+AyxB5IlLJFAM5RGzDtEhydqI8e3slBBnQ==
X-Received: by 2002:a17:902:6906:b0:13f:d2d1:6aff with SMTP id j6-20020a170902690600b0013fd2d16affmr3070354plk.39.1634643560372;
        Tue, 19 Oct 2021 04:39:20 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:20 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 04/12] Introduce `uploadpack.excludeobject` configuration
Date:   Tue, 19 Oct 2021 19:38:28 +0800
Message-Id: <b1d779b26a2f5d646b09131645b503d2e82a29ec.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Background:

The `uploadpack.blobpackfileuri` is made for the "packfile-uri" feature,
the feature is similar to a CDN cache, it supports the client to download
 pack file by a URI directly, without or reducing the server load when make
packing and transporting.

Reasons:

First reason, `uploadpack.blobpackfileuri` supports to exclude a single
object, but actually the object type can be not only a blob, so the name
is inaccurate currently.

Secondly, the name of the old configuration is not abstract enough, this
make the furthur extension difficult. If do not change its name, to let
different object types use different configuration names, the
configuration items will be bloated and difficult to maintain, so the
new configuration is more abstract in name.

Configuation format diff:

	old: uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>
	new: uploadpack.excludeobject=<object-hash> <level> <pack-hash> <uri>

The new configuration `uploadpack.excludeobject` not only supports to
exclude a single object itself, but also to exclude related objects with
it at once, the scope of exclusion is determined by the object type and
the specified `<level>` value in the entry.

-Compatibility:

Although a new configuration has been introduced, the old one is
available to use and compatible with the new configuration.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 33 ++++++++++++++++++++++++++++++++-
 upload-pack.c          |  7 +++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a41a0a3ea7..75461483c0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3061,6 +3061,36 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		ex->uri = xstrdup(pack_end + 1);
 		oidmap_put(&configured_exclusions, ex);
 	}
+	if (!strcmp(k, "uploadpack.excludeobject")) {
+		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
+		const char *oid_end, *pack_end, *type_end;
+		struct object_id pack_hash;
+		char type[2];
+		int level;
+
+		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
+		    *oid_end != ' ' ||
+		    !strlcpy(type, oid_end + 1, sizeof(type)) ||
+		    parse_oid_hex(oid_end + 3, &pack_hash, &pack_end) ||
+		    *pack_end != ' ')
+			die(_("value of uploadpack.excludeobject must be "
+			      "of the form '<object-hash> <level> <pack-hash> <uri>' (got '%s')"), v);
+		if (oidmap_get(&configured_exclusions, &ex->e.oid))
+			die(_("object already configured by an earlier "
+			      "uploadpack.excludeobject (got '%s')"), v);
+
+		level = atoi(type);
+		if (level < ET_SELF || level > ET_REACHABLE) {
+			die(_("value of <level> must be 0 or 1 or 2 (got '%s')"), v);
+		}
+		ex->level = level;
+		type_end = oid_end + 2;
+		ex->pack_hash_hex = xcalloc(1, pack_end - type_end);
+		memcpy(ex->pack_hash_hex, type_end + 1, pack_end - type_end - 1);
+		ex->uri = xstrdup(pack_end + 1);
+		oidmap_put(&configured_exclusions, ex);
+	}
+
 	return git_default_config(k, v, cb);
 }
 
@@ -3887,7 +3917,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("respect islands during delta compression")),
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
-				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+				N_("exclude any configured uploadpack.excludeobject or "
+					    "uploadpack.blobpackfileuri with this protocol")),
 		OPT_END(),
 	};
 
diff --git a/upload-pack.c b/upload-pack.c
index 5c1cd19612..d26fb351a3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1751,6 +1751,13 @@ int upload_pack_advertise(struct repository *r,
 			strbuf_addstr(value, " packfile-uris");
 			free(str);
 		}
+
+		if (!repo_config_get_string(the_repository,
+					    "uploadpack.excludeobject",
+					    &str) && str) {
+			strbuf_addstr(value, " packfile-uris");
+			free(str);
+		}
 	}
 
 	return 1;
-- 
2.31.1.453.g945ddc3a74.dirty

