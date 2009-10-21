From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] receive-pack: run "gc --auto --quiet " and optionally
 "update-server-info"
Date: Wed, 21 Oct 2009 15:32:25 -0700
Message-ID: <7vbpk0z8cm.fsf_-_@alter.siamese.dyndns.org>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
 <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
 <7v63a9n5i6.fsf@alter.siamese.dyndns.org> <4ADEA93E.7060907@viscovery.net>
 <7vzl7l8b1y.fsf@alter.siamese.dyndns.org>
 <7vaazl8acd.fsf@alter.siamese.dyndns.org> <4ADEC0DB.4000104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:40:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jje-0004JE-E6
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbZJUWcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755734AbZJUWck
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:32:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbZJUWck (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:32:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 948F180394;
	Wed, 21 Oct 2009 18:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vWzyTTdRZmT78MIfdkvIRqS9Q44=; b=InVqrn
	LqJAt+ra2vbR6h0own7EWE338mxD5s3AQ+e5uCi1DGoQ6SFJhXLdwG8TKJPp4kzs
	QP9kvFEOvCMg6b7pZcSdQQvVuZDYL87oCUUR9yyJKfPiAtMaVFONwjKmgrvKCqdb
	Qt3sJtun425FLYjFWYhZ2DMc1zDpuI3q422WA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qsuR1HkvMCSifVek+MPXaWJXwUXqLuZ4
	zvMNv+4dcOKbEiKHqimOuXXss6OynN1WzXC8bM/PJu2FDAujcJqmPgGHUvrLVOx9
	YtnPeKAvX9cdL8I1wFfsiuqks3vwY2Lj8O4FMMaTA8/AUvcOZ2mdqoayuUpEmFKr
	zMI9E3M7ucA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D7D580391;
	Wed, 21 Oct 2009 18:32:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54B9C8038A; Wed, 21 Oct 2009
 18:32:26 -0400 (EDT)
In-Reply-To: <4ADEC0DB.4000104@viscovery.net> (Johannes Sixt's message of
 "Wed\, 21 Oct 2009 10\:05\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A265F996-BE91-11DE-B5F7-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130980>

Introduce two new configuration variables, receive.autogc (defaults to
true) and receive.updateserverinfo (defaults to false).  When these are
set, receive-pack runs "gc --auto --quiet" and "update-server-info"
respectively after it finishes receiving data from "git push" and updating
refs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 * third round; autogc is default (since v2) and runs "gc --auto"
   with "--quiet" (change in this round).

 Documentation/config.txt |    9 +++++++++
 builtin-receive-pack.c   |   20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd17814..ba6ed10 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1320,6 +1320,11 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
 
+receive.autogc::
+	By default, git-receive-pack will run "git-gc --auto" after
+	receiving data from git-push and updating refs.  You can stop
+	it by setting this variable to false.
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
@@ -1355,6 +1360,10 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+receive.updateserverinfo::
+	If set to true, git-receive-pack will run git-update-server-info
+	after receiving data from git-push and updating refs.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..e8bde02 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -28,6 +28,8 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int prefer_ofs_delta = 1;
+static int auto_update_server_info;
+static int auto_gc = 1;
 static const char *head_name;
 static char *capabilities_to_send;
 
@@ -88,6 +90,16 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.updateserverinfo") == 0) {
+		auto_update_server_info = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (strcmp(var, "receive.autogc") == 0) {
+		auto_gc = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -672,6 +684,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			report(unpack_status);
 		run_receive_hook(post_receive_hook);
 		run_update_post_hook(commands);
+		if (auto_gc) {
+			const char *argv_gc_auto[] = {
+				"gc", "--auto", "--quiet", NULL,
+			};
+			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		}
+		if (auto_update_server_info)
+			update_server_info(0);
 	}
 	return 0;
 }
-- 
1.6.5.1.107.gba912
