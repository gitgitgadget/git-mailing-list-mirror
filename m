From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 8/8] push: pass --progress down to git-pack-objects
Date: Sun, 17 Oct 2010 02:37:03 +0800
Message-ID: <1287254223-4496-9-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
 <1287254223-4496-6-git-send-email-rctay89@gmail.com>
 <1287254223-4496-7-git-send-email-rctay89@gmail.com>
 <1287254223-4496-8-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bdx-0002rt-26
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab0JPShx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:53 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42381 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0JPShw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:52 -0400
Received: by mail-pv0-f174.google.com with SMTP id 18so130001pva.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6HV0daWPTycywRrY3knq3Qk3gOdrWdBagvI4v6Ajps0=;
        b=s3CBqej2QO3RqTEeT84ulXrirExFDKSlbZKEIdOBHeke/oJeTXY675QIxtHLX0t2zu
         174M1lfYca67YBwdVH9s+leKpvZP4wlTwjAw6cVFWpbTwVijKNqXo3P6wvvxD+OKDPK4
         mC/OzRzQIrut6rfkjiyddNn+6VxhDoBhP1oF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OzFtiMHRbcdPZwWmYilsJUIPAHlKz1j2KL9kwFN7FVIQK8U1kBfy6pepC9S4C4JUTV
         cgRHQZ7viFScSOTdMQ6l4cU3GpEBY4BicedyC03c3LV2lZAn45YejdEThShx6xRdUKlU
         /TPtueS/3nFoEDtGeMSiRiS7KDWsrCokJiOec=
Received: by 10.143.16.8 with SMTP id t8mr1843203wfi.207.1287254272196;
        Sat, 16 Oct 2010 11:37:52 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-8-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159177>

From: Jeff King <peff@peff.net>

When pushing via builtin transports (like file://, git://), the
underlying transport helper (in this case, git-pack-objects) did not get
the --progress option, even if it was passed to git push.

Fix this, and update the tests to reflect this.

Note that according to the git-pack-objects documentation, we can safely
apply the usual --progress semantics for the transport commands like
clone and fetch (and for pushing over other smart transports).

Reported-by: Chase Brammer <cbrammer@gmail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  No significant changes other than those incurred while rebasing on
  top of Jeff's patches.

 builtin/send-pack.c      |    3 +++
 send-pack.h              |    1 +
 t/t5523-push-upstream.sh |    4 ++--
 transport.c              |    1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..efd9be6 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -48,6 +48,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -59,6 +60,8 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "--delta-base-offset";
 	if (args->quiet)
 		argv[i++] = "-q";
+	if (args->progress)
+		argv[i++] = "--progress";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/send-pack.h b/send-pack.h
index 60b4ba6..05d7ab1 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -5,6 +5,7 @@ struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
+		progress:1,
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index f43d760..c229fe6 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -78,7 +78,7 @@ test_expect_success TTY 'progress messages go to tty' '
 	grep "Writing objects" err
 '
 
-test_expect_failure 'progress messages do not go to non-tty' '
+test_expect_success 'progress messages do not go to non-tty' '
 	ensure_fresh_upstream &&
 
 	# skip progress messages, since stderr is non-tty
@@ -86,7 +86,7 @@ test_expect_failure 'progress messages do not go to non-tty' '
 	! grep "Writing objects" err
 '
 
-test_expect_failure 'progress messages go to non-tty (forced)' '
+test_expect_success 'progress messages go to non-tty (forced)' '
 	ensure_fresh_upstream &&
 
 	# force progress messages to stderr, even though it is non-tty
diff --git a/transport.c b/transport.c
index 4dba6f8..0078660 100644
--- a/transport.c
+++ b/transport.c
@@ -789,6 +789,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.use_thin_pack = data->options.thin;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
+	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
-- 
1.7.2.2.513.ge1ef3
