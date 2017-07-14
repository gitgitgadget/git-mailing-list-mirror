Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417FF20357
	for <e@80x24.org>; Fri, 14 Jul 2017 13:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbdGNN1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 09:27:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35515 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbdGNN1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 09:27:30 -0400
Received: by mail-qk0-f196.google.com with SMTP id c18so1924574qkb.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VrVeUzV5Wigl000jQPG/eLe97nFItY8xpZmVPi982XA=;
        b=fwZtsK9+A1uGOZj1WiQXxQJS5HMrvW0eEnP0JhMFdHekSvHajw9jYBpFu0hVx7q7zy
         WtlPURR+f2xqrArHo9gM57S5h+jpSZpxN0PJgCEONoQm1eiazUDICF+BcOSqSYWRjcrY
         /qPVK5PHTTSHq6tCgQsr69janCPdloNikf1eN3lvPShVOL3qChb4jmaNK4bDjBjyER3h
         pLOVAmcNj/LmXj0e5oS7cKTbF6vkz/ZXJ4J8Mis8hY12huBP6ej9cgY67hg7svae1zyJ
         Jve9A3Tl/9ZrDli3/dR5SKvxOCRXAPQYyJam2xYoiMYbRrpDMcxaXoi22f1nwFlpuGi4
         a1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VrVeUzV5Wigl000jQPG/eLe97nFItY8xpZmVPi982XA=;
        b=Rwq09EN4tj/add2xRfeHLVlLy4k9matJOxKBjyBiIAsxOaaxYaPl9N5JrqLfWPh4c2
         Y19Wo9osIVjIEv2z20vlQs+bz5X8i7vfig66HywpU4X+jTK1RzeG5ux4WjW4d8mhMU92
         UdAJiHKZMpRpYt5L/ztvjwNLlu28uK2t4RFRf2zWh4hG+JkV8r2gOKzScNia/XS9AmcN
         2Xw4zUZA+dwrQgmcjyYlUArUGpQJTBXuiB1rWwCfOzfbPsqFXcTYkLtgmjp2KdUuMbo8
         h5g2oL2cw7/QbP5QVSZisOGrkrFFZtVblyhvLpiPJn+dbMiI/elz/g8Dyl0DHzR9F6AD
         nNTQ==
X-Gm-Message-State: AIVw112YG82ROwMR/hZw9tvL3+EqPIpdQEYcrt+yClL5p4Qyrlvugiu5
        ocio7yD6idWjGsZ1Vzk=
X-Received: by 10.55.151.195 with SMTP id z186mr11258691qkd.100.1500038848391;
        Fri, 14 Jul 2017 06:27:28 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t43sm7044820qth.30.2017.07.14.06.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 06:27:27 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: [PATCH v2 1/1] sha1_file: Add support for downloading blobs on demand
Date:   Fri, 14 Jul 2017 09:26:51 -0400
Message-Id: <20170714132651.170708-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.2.windows.1
In-Reply-To: <20170714132651.170708-1-benpeart@microsoft.com>
References: <20170714132651.170708-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables git to request missing objects when they are
not found in the object store. This is a fault-in model where the
"read-object" sub-process will fetch the missing object and store it in
the object store as a loose, alternate, or pack file. On success, git
will retry the operation and find the requested object.

It utilizes the recent sub-process refactoring to spawn a "read-object"
hook as a sub-process on the first request and then all subsequent
requests are made to that existing sub-process. This significantly
reduces the cost of making multiple request within a single git command.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/technical/read-object-protocol.txt | 102 ++++++++++++
 cache.h                                          |   1 +
 config.c                                         |   5 +
 contrib/long-running-read-object/example.pl      | 114 +++++++++++++
 environment.c                                    |   1 +
 sha1_file.c                                      | 193 ++++++++++++++++++++++-
 t/t0410-read-object.sh                           |  27 ++++
 t/t0410/read-object                              | 114 +++++++++++++
 8 files changed, 550 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/technical/read-object-protocol.txt
 create mode 100755 contrib/long-running-read-object/example.pl
 create mode 100755 t/t0410-read-object.sh
 create mode 100755 t/t0410/read-object

diff --git a/Documentation/technical/read-object-protocol.txt b/Documentation/technical/read-object-protocol.txt
new file mode 100644
index 0000000000..a893b46e7c
--- /dev/null
+++ b/Documentation/technical/read-object-protocol.txt
@@ -0,0 +1,102 @@
+Read Object Process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The read-object process enables Git to read all missing blobs with a
+single process invocation for the entire life of a single Git command.
+This is achieved by using a packet format (pkt-line, see technical/
+protocol-common.txt) based protocol over standard input and standard
+output as follows. All packets, except for the "*CONTENT" packets and
+the "0000" flush packet, are considered text and therefore are
+terminated by a LF.
+
+Git starts the process when it encounters the first missing object that
+needs to be retrieved. After the process is started, Git sends a welcome
+message ("git-read-object-client"), a list of supported protocol version
+numbers, and a flush packet. Git expects to read a welcome response
+message ("git-read-object-server"), exactly one protocol version number
+from the previously sent list, and a flush packet. All further
+communication will be based on the selected version.
+
+The remaining protocol description below documents "version=1". Please
+note that "version=42" in the example below does not exist and is only
+there to illustrate how the protocol would look with more than one
+version.
+
+After the version negotiation Git sends a list of all capabilities that
+it supports and a flush packet. Git expects to read a list of desired
+capabilities, which must be a subset of the supported capabilities list,
+and a flush packet as response:
+------------------------
+packet: git> git-read-object-client
+packet: git> version=1
+packet: git> version=42
+packet: git> 0000
+packet: git< git-read-object-server
+packet: git< version=1
+packet: git< 0000
+packet: git> capability=get
+packet: git> capability=have
+packet: git> capability=put
+packet: git> capability=not-yet-invented
+packet: git> 0000
+packet: git< capability=get
+packet: git< 0000
+------------------------
+The only supported capability in version 1 is "get".
+
+Afterwards Git sends a list of "key=value" pairs terminated with a flush
+packet. The list will contain at least the command (based on the
+supported capabilities) and the sha1 of the object to retrieve. Please
+note, that the process must not send any response before it received the
+final flush packet.
+
+When the process receives the "get" command, it should make the requested
+object available in the git object store and then return success. Git will
+then check the object store again and this time find it and proceed.
+------------------------
+packet: git> command=get
+packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
+packet: git> 0000
+------------------------
+
+The process is expected to respond with a list of "key=value" pairs
+terminated with a flush packet. If the process does not experience
+problems then the list must contain a "success" status.
+------------------------
+packet: git< status=success
+packet: git< 0000
+------------------------
+
+In case the process cannot or does not want to process the content, it
+is expected to respond with an "error" status.
+------------------------
+packet: git< status=error
+packet: git< 0000
+------------------------
+
+In case the process cannot or does not want to process the content as
+well as any future content for the lifetime of the Git process, then it
+is expected to respond with an "abort" status at any point in the
+protocol.
+------------------------
+packet: git< status=abort
+packet: git< 0000
+------------------------
+
+Git neither stops nor restarts the process in case the "error"/"abort"
+status is set.
+
+If the process dies during the communication or does not adhere to the
+protocol then Git will stop the process and restart it with the next
+object that needs to be processed.
+
+After the read-object process has processed an object it is expected to
+wait for the next "key=value" list containing a command. Git will close
+the command pipe on exit. The process is expected to detect EOF and exit
+gracefully on its own. Git will wait until the process has stopped.
+
+A long running read-object process demo implementation can be found in
+`contrib/long-running-read-object/example.pl` located in the Git core
+repository. If you develop your own long running process then the
+`GIT_TRACE_PACKET` environment variables can be very helpful for
+debugging (see linkgit:git[1]).
diff --git a/cache.h b/cache.h
index 71fe092644..914379724f 100644
--- a/cache.h
+++ b/cache.h
@@ -804,6 +804,7 @@ enum log_refs_config {
 	LOG_REFS_ALWAYS
 };
 extern enum log_refs_config log_all_ref_updates;
+extern int core_virtualize_objects;
 
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
diff --git a/config.c b/config.c
index a9356c1383..cc6e8f3237 100644
--- a/config.c
+++ b/config.c
@@ -1241,6 +1241,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.virtualizeobjects")) {
+		core_virtualize_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/contrib/long-running-read-object/example.pl b/contrib/long-running-read-object/example.pl
new file mode 100755
index 0000000000..b8f37f836a
--- /dev/null
+++ b/contrib/long-running-read-object/example.pl
@@ -0,0 +1,114 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git read-object protocol version 1
+# See Documentation/technical/read-object-protocol.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# A lazy clone can be simulated via the following commands from the host repo
+# you wish to create a lazy clone of:
+#
+# cd /host_repo
+# git rev-parse HEAD
+# git init /guest_repo
+# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
+#	cut -d' ' -f1 | git pack-objects /guest_repo/.git/objects/pack/noblobs
+# cd /guest_repo
+# git config core.virtualizeobjects true
+# git reset --hard <sha from rev-parse call above>
+#
+# Please note, this sample is a minimal skeleton. No proper error handling
+# was implemented.
+#
+
+use strict;
+use warnings;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = "/host_repo/.git/";
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+
+		# EOF - Git stopped talking to us!
+		exit();
+	}
+	elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	}
+	elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	}
+	else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.";
+	}
+	return ( $res, $buf );
+}
+
+sub packet_bin_write {
+	my $buf = shift;
+	print STDOUT sprintf( "%04x", length($buf) + 4 );
+	print STDOUT $buf;
+	STDOUT->flush();
+}
+
+sub packet_txt_write {
+	packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+	print STDOUT sprintf( "%04x", 0 );
+	STDOUT->flush();
+}
+
+( packet_txt_read() eq ( 0, "git-read-object-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=1" ) )				 || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                       || die "bad version end";
+
+packet_txt_write("git-read-object-server");
+packet_txt_write("version=1");
+packet_flush();
+
+( packet_txt_read() eq ( 0, "capability=get" ) )    || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+
+packet_txt_write("capability=get");
+packet_flush();
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | git -c core.virtualizeobjects=false hash-object -w --stdin >/dev/null 2>&1');
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
diff --git a/environment.c b/environment.c
index 3fd4b10845..ad9403ed6c 100644
--- a/environment.c
+++ b/environment.c
@@ -66,6 +66,7 @@ int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
+int core_virtualize_objects;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/sha1_file.c b/sha1_file.c
index 5862386cd0..06290f8647 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -28,6 +28,9 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "sigchain.h"
+#include "sub-process.h"
+#include "pkt-line.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -647,6 +650,162 @@ void prepare_alt_odb(void)
 	read_info_alternates(get_object_directory(), 0);
 }
 
+#define CAP_GET    (1u<<0)
+
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
+
+struct read_object_process {
+	struct subprocess_entry subprocess;
+	unsigned int supported_capabilities;
+};
+
+int start_read_object_fn(struct subprocess_entry *subprocess)
+{
+	int err;
+	struct read_object_process *entry = (struct read_object_process *)subprocess;
+	struct child_process *process;
+	struct string_list cap_list = STRING_LIST_INIT_NODUP;
+	char *cap_buf;
+	const char *cap_name;
+
+	process = subprocess_get_child_process(&entry->subprocess);
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_writel(process->in, "git-read-object-client", "version=1", NULL);
+	if (err)
+		goto done;
+
+	err = strcmp(packet_read_line(process->out, NULL), "git-read-object-server");
+	if (err) {
+		error("external process '%s' does not support read-object protocol version 1", subprocess->cmd);
+		goto done;
+	}
+	err = strcmp(packet_read_line(process->out, NULL), "version=1");
+	if (err)
+		goto done;
+	err = packet_read_line(process->out, NULL) != NULL;
+	if (err)
+		goto done;
+
+	err = packet_writel(process->in, "capability=get", NULL);
+	if (err)
+		goto done;
+
+	for (;;) {
+		cap_buf = packet_read_line(process->out, NULL);
+		if (!cap_buf)
+			break;
+		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
+
+		if (cap_list.nr != 2 || strcmp(cap_list.items[0].string, "capability"))
+			continue;
+
+		cap_name = cap_list.items[1].string;
+		if (!strcmp(cap_name, "get")) {
+			entry->supported_capabilities |= CAP_GET;
+		}
+		else {
+			warning(
+				"external process '%s' requested unsupported read-object capability '%s'",
+				subprocess->cmd, cap_name
+			);
+		}
+
+		string_list_clear(&cap_list, 0);
+	}
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE)
+		return err ? err : errno;
+
+	return 0;
+}
+
+static int read_object_process(const unsigned char *sha1)
+{
+	int err;
+	struct read_object_process *entry;
+	struct child_process *process;
+	struct strbuf status = STRBUF_INIT;
+	const char *cmd = find_hook("read-object");
+	uint64_t start;
+
+	start = getnanotime();
+
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+		entry = NULL;
+	} else {
+		entry = (struct cmd2process *)subprocess_find_entry(&subprocess_map, cmd);
+	}
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (subprocess_start(&subprocess_map, &entry->subprocess, cmd, start_read_object_fn)) {
+			free(entry);
+			return -1;
+		}
+	}
+	process = subprocess_get_child_process(&entry->subprocess);
+
+	if (!(CAP_GET & entry->supported_capabilities))
+		return -1;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_fmt_gently(process->in, "command=get\n");
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	err = subprocess_read_status(process->out, &status);
+	err = err ? err : strcmp(status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
+		err = err ? err : errno;
+		if (!strcmp(status.buf, "error")) {
+			/* The process signaled a problem with the file. */
+		}
+		else if (!strcmp(status.buf, "abort")) {
+			/*
+			 * The process signaled a permanent problem. Don't try to read
+			 * objects with the same command for the lifetime of the current
+			 * Git process.
+			 */
+			entry->supported_capabilities &= ~CAP_GET;
+		}
+		else {
+			/*
+			 * Something went wrong with the read-object process.
+			 * Force shutdown and restart if needed.
+			 */
+			error("external process '%s' failed", cmd);
+			subprocess_stop(&subprocess_map, (struct subprocess_entry *)entry);
+			free(entry);
+		}
+	}
+
+	trace_performance_since(start, "read_object_process");
+
+	return err;
+}
+
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn)
 {
@@ -690,8 +849,19 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 
 static int check_and_freshen(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_local(sha1, freshen) ||
-	       check_and_freshen_nonlocal(sha1, freshen);
+	int ret;
+	int already_retried = 0;
+
+retry:
+	ret = check_and_freshen_local(sha1, freshen) ||
+		check_and_freshen_nonlocal(sha1, freshen);
+	if (!ret && core_virtualize_objects && !already_retried) {
+		already_retried = 1;
+		if (!read_object_process(sha1))
+			goto retry;
+	}
+
+	return ret;
 }
 
 int has_loose_object_nonlocal(const unsigned char *sha1)
@@ -2983,6 +3153,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (!oi)
 		oi = &blank_oi;
@@ -3007,6 +3178,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
+retry:
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi, flags)) {
@@ -3015,13 +3187,19 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
-		if (flags & OBJECT_INFO_QUICK) {
-			return -1;
-		} else {
+		if (!(flags & OBJECT_INFO_QUICK)) {
 			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
-				return -1;
+			if (find_pack_entry(real, &e))
+				goto found_packed;
+		}
+
+		/* Request the object be retrieved */
+		if (core_virtualize_objects && !already_retried) {
+			already_retried = 1;
+			if (!read_object_process(sha1))
+				goto retry;
 		}
+		return -1;
 	}
 
 	if (oi == &blank_oi)
@@ -3031,6 +3209,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		 */
 		return 0;
 
+found_packed:
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
diff --git a/t/t0410-read-object.sh b/t/t0410-read-object.sh
new file mode 100755
index 0000000000..b8d7521c2c
--- /dev/null
+++ b/t/t0410-read-object.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process'
+
+. ./test-lib.sh
+
+test_expect_success 'setup host repo with a root commit' '
+	test_commit zero &&
+	hash1=$(git ls-tree HEAD | grep zero.t | cut -f1 | cut -d\  -f3)
+'
+
+test_expect_success 'blobs can be retrieved from the host repo' '
+	git init guest-repo &&
+	(cd guest-repo &&
+	 mkdir -p .git/hooks &&
+	 cp $TEST_DIRECTORY/t0410/read-object .git/hooks/ &&
+	 git config core.virtualizeobjects true &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'invalid blobs generate errors' '
+	(cd guest-repo &&
+	 test_must_fail git cat-file blob "invalid")
+'
+
+
+test_done
diff --git a/t/t0410/read-object b/t/t0410/read-object
new file mode 100755
index 0000000000..85e997c930
--- /dev/null
+++ b/t/t0410/read-object
@@ -0,0 +1,114 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git read-object protocol version 1
+# See Documentation/technical/read-object-protocol.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# A lazy clone can be simulated via the following commands from the host repo
+# you wish to create a lazy clone of:
+#
+# cd /host_repo
+# git rev-parse HEAD
+# git init /guest_repo
+# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
+#	cut -d' ' -f1 | git pack-objects /guest_repo/.git/objects/pack/noblobs
+# cd /guest_repo
+# git config core.virtualizeobjects true
+# git reset --hard <sha from rev-parse call above>
+#
+# Please note, this sample is a minimal skeleton. No proper error handling
+# was implemented.
+#
+
+use strict;
+use warnings;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = "../.git/";
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+
+		# EOF - Git stopped talking to us!
+		exit();
+	}
+	elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	}
+	elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	}
+	else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.";
+	}
+	return ( $res, $buf );
+}
+
+sub packet_bin_write {
+	my $buf = shift;
+	print STDOUT sprintf( "%04x", length($buf) + 4 );
+	print STDOUT $buf;
+	STDOUT->flush();
+}
+
+sub packet_txt_write {
+	packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+	print STDOUT sprintf( "%04x", 0 );
+	STDOUT->flush();
+}
+
+( packet_txt_read() eq ( 0, "git-read-object-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=1" ) )				 || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                       || die "bad version end";
+
+packet_txt_write("git-read-object-server");
+packet_txt_write("version=1");
+packet_flush();
+
+( packet_txt_read() eq ( 0, "capability=get" ) )    || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+
+packet_txt_write("capability=get");
+packet_flush();
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | git -c core.virtualizeobjects=false hash-object -w --stdin >/dev/null 2>&1');
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.13.2.windows.1

