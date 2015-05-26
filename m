From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 07/11] fetch-pack: use the configured transport protocol
Date: Tue, 26 May 2015 15:01:11 -0700
Message-ID: <1432677675-5118-8-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMux-000208-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbbEZWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:41 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34554 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbEZWBi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:38 -0400
Received: by igbhj9 with SMTP id hj9so72105700igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJp6Gel4ymTt1GvovGQZAlsafaMIEXX5gp0S0+x9BPo=;
        b=gZ+h0oG0lxR5iXcpQf2dSBf3bemJtcQmoJHKd27DNnHtn4DUxnNtVqlTfxfgIi1gcR
         j4UY/LQHRE9b0rvAcoxtTMKr5dumT59BV93SFLTotX1amPkQEbjcy5cFtY+MvIQOWZM5
         WtK13fPKmcyDzAa7Wcw45JFlIrrSI19sr80SB+aEp3rFbqw9RPEYHo+j97mGPJy2xZDr
         j1P5sDWcdUY6kbGZlem5e2bZomPHMDueWMQ5+Uacc2LtM9ef/R0jsu8rXyhdSSeJ7NBz
         bXknpm/rA6GuOxZChyLqypELwGewL7iDpDXvVEZ65apC/KvCkOCtHYMegRy+7Sn4IBUh
         cjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJp6Gel4ymTt1GvovGQZAlsafaMIEXX5gp0S0+x9BPo=;
        b=G1stMU2oQYkrhcwIQQ8VkRxudH9ZV3o1AZJrDPs7FJQDeQNiSX8XM6LLSl3prVsLxo
         IrHzGoom1NXpnX1Hkr0+yAvoux+6CBDDVE746zzdwAsbJzNaqEZ81IZG6bCHWbviXl5j
         k6X62Iuyly0ltkNOQBC5cDKp0q2YgHGN4xV16REuhKITFTXwOAhFGPGvdl6SjvCeTsUk
         ginWm79Bgp/Gy+xjf4WsHiwLE6KhW9xSjvqEPtVZ2fkc8Jo58VQwzS56hB5bgRl+lHQJ
         yIrsOs5OAfbYE9ujme+QYiEMaEboK/dKgNr/Z3cXFH5hbP5/BjFKRZK5gzdF+lgns2HK
         Kk6A==
X-Gm-Message-State: ALoCoQmmNDonJhWZkH6fgR+BO1NdDB20Swn58oXdIWp60p7Y8PjbHWHva7L9vEDEPQaKteDI+Gfq
X-Received: by 10.42.144.131 with SMTP id b3mr32364340icv.35.1432677697855;
        Tue, 26 May 2015 15:01:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id d185sm11989454ioe.42.2015.05.26.15.01.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269991>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch-pack.c | 17 ++++++++++++++++-
 fetch-pack.h         |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4a6b340..32dc8b0 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -127,6 +127,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!strcmp("--transport-version", arg)) {
+			args.version = strtol(arg + strlen("--transport-version"), NULL, 0);
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 
@@ -175,7 +179,18 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+
+	switch (args.version) {
+	default:
+	case 2:
+		get_remote_capabilities(fd[0], NULL, 0);
+		request_capabilities(fd[1]);
+		break;
+	case 1: /* fall through */
+	case 0:
+		get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+		break;
+	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr);
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..b48b4f5 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	int version;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
-- 
2.4.1.345.gab207b6.dirty
