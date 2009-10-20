From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 14:02:25 -0700
Message-ID: <7v63a9n5i6.fsf@alter.siamese.dyndns.org>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
 <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Lqy-0005HF-LY
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbZJTVCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZJTVCg
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:02:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZJTVCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:02:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D019560252;
	Tue, 20 Oct 2009 17:02:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RercJnKTn315KkNttt/qfP/4lek=; b=FZOhsO
	Jdblkh9mvxiIjwaIqGkUNpcnZ5g83pxWvGqAWU2k3okb9pvXrfmEQ0L47S6p3Wxx
	pLVL2vQ/0mq/Cs7d6qMAr0KEmMUb66IaYGJrq6+5vABc/gQpT2Shpx8BeIgeWtW/
	YhXWbS2kIAzOfFChSBg6viK3SQpMC5Ge+vvVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jLux4Cy8wll/R0oL0IwOUzFQFVM1DEgR
	y/bwD2LNGKxPo1YpJJy97o2BnNPQM9culwtLMk+qy5aNBD5nV8pAeENDo1b9kuPC
	RTFKBngUDnTKZ/bt2JwUEa/bfXZrjM6tJpn9FBqrdctitjDARfeAHdQcNSBpEkja
	DkEnqinxjyc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8807E6024C;
	Tue, 20 Oct 2009 17:02:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EE6160246; Tue, 20 Oct
 2009 17:02:27 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910201442480.21460@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 20 Oct 2009 14\:46\:02 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E324D38E-BDBB-11DE-8B4B-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130848>

Nicolas Pitre <nico@fluxnic.net> writes:

> Still... Hopefully this is going to become redundant information in the 
> future with the eventual deployment of smart protocol over HTTP.  So I 
> think that as a config option being off by default this is a good 
> compromize.  Site administrators can turn it on by default in 
> /etc/gitconfig.

Ok, something like this?


 Documentation/config.txt |    8 ++++++++
 builtin-receive-pack.c   |   18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd17814..2d3b4f5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1320,6 +1320,10 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
 
+receive.autogc::
+	If set to true, git-receive-pack will run "git-gc --auto"
+	after receiving data from git-push and updating refs.
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
@@ -1355,6 +1359,10 @@ receive.denyNonFastForwards::
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
index b771fe9..6573226 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -28,6 +28,8 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 static int prefer_ofs_delta = 1;
+static int auto_update_server_info;
+static int auto_gc;
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
 
@@ -672,6 +684,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			report(unpack_status);
 		run_receive_hook(post_receive_hook);
 		run_update_post_hook(commands);
+		if (auto_update_server_info)
+			update_server_info(0);
+		if (auto_gc) {
+			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		}
 	}
 	return 0;
 }
