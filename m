From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] fetch: add a config option to always use the depth argument
Date: Mon,  1 Dec 2014 11:07:03 -0800
Message-ID: <1417460823-17295-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 20:07:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvWJi-00042E-C7
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 20:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbaLATHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 14:07:12 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61847 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbaLATHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 14:07:10 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so9427494igb.9
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 11:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xEnbQit19v3HVLr1ALQnnXdbDQf00CpzHkXUG9MNK0o=;
        b=oxQIyDuhTanvWCksMXUPsIMMi2lMMVCcaDTFFLtI8YjcU9AeGWxEe9GAdIDLAefNQU
         29p+V11GyVUY8pqxudQYm2BZAG+scsVid4v4dMnZv2fe0xp4ZVBeZrDqAIERBMUJlOA8
         REJu7nHkKWzDiKPoQXS+OmF6AFfH4avEIu/YI9NsbYOcWM2fGqs/4VFRQUamw65Oy6hS
         Xcd6jaf/kvJk9/1coe5eDTeKPQUNB5JKFdfqL+PhgGoYhrmJKVK4vCcV3cJAyT7HxwKm
         w7Z6K3RmjictpRHVP9I+pdnsgeb7/bS1dBmPVVf/M4JGcSeVpkvTRMjFIBxPyapPfVkU
         2yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xEnbQit19v3HVLr1ALQnnXdbDQf00CpzHkXUG9MNK0o=;
        b=gH1K57COe6/3NufOMSYzypuAwLzfjWyL+BsCcA1WTcD6OlwmYPrasG5Z4UAadSCWNJ
         2bCveAFxizVLykHRLu/18dEnq/k97K2tVkfxRJK2ET8UCQETrX4m5nzbM8wvya+mg9Rh
         edxBEhJzKfI3m/r/2h80mL3T0KRjipKolRIka89fqtFo+jZciqW6M0F6Ibo2tlBHhT7q
         vY82It3KRoselKauWNFsHOkyTDjCfLxvFuEqlP66BbPpsZPFXpfp94WLTunPM5I1/2mx
         vhE6RcE3DVNnGhERtBFai2S8PL0HrJRmdrSoFUpoj98592U8l+OWtZQOUzZl8RdpOxOf
         E2mw==
X-Gm-Message-State: ALoCoQlGFZTPyWaH/TFSqY8d1eeO0eDUIOPciqcwyYKlAaOHtFdzn3A44bsKoDauJAtULFbZTiyd
X-Received: by 10.107.3.7 with SMTP id 7mr10150514iod.8.1417460829879;
        Mon, 01 Dec 2014 11:07:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:31ca:60a8:c4a7:77eb])
        by mx.google.com with ESMTPSA id vf6sm10689590igb.6.2014.12.01.11.07.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 11:07:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260505>

When having a repository, which deals with large amounts of data, i.e.
graphics, music, films, you may want to keep the git directory at
the smallest size possible.

The depth option helped us in achieving this goal by removing the sizable
history and just keep recent history around. In the case of having large
amounts of data around, you probably want to use the depth option at any
fetch you do, so it would be convenient to have an option for this.

Change-Id: I45a569239639f20e24fbae32fb2046bc478c5f07
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt        | 6 ++++++
 Documentation/fetch-options.txt | 2 ++
 builtin/fetch.c                 | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..418e21f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1106,6 +1106,12 @@ fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`.
 
+fetch.depth::
+	If set, fetch will automatically behave as if the `--depth`
+	option was given on the command line.  This allows users to keep
+	the git directory at low space requirements, and thus comes in handy
+	for users with large binary files in the repository.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index b09a783..81131d0 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -12,6 +12,8 @@
 	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
+	You can configure git to always use the depth option, see
+	`fetch.depth` in linkgit:git-config[1]
 
 --unshallow::
 	If the source repository is complete, convert a shallow
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b84d35..30fa15b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -68,6 +68,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		fetch_prune_config = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "fetch.depth")) {
+		if (git_config_string(&depth, k, v))
+			return -1;
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
-- 
2.1.2
