From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Mon, 16 Jun 2008 00:21:21 -0700
Message-ID: <7vy755c0b2.fsf@gitster.siamese.dyndns.org>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
 <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <200806142359.m5ENxsBI028758
  @mi0.bluebottle.com> <7vabhne15k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 09:22:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K892w-0006zQ-BL
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 09:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYFPHVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 03:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYFPHVg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 03:21:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbYFPHVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 03:21:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E36DD7E1C;
	Mon, 16 Jun 2008 03:21:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 36FCE7E1B; Mon, 16 Jun 2008 03:21:25 -0400 (EDT)
In-Reply-To: <7vabhne15k.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 14 Jun 2008 22:07:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8B85440-3B74-11DD-9BB5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85165>

Junio C Hamano <gitster@pobox.com> writes:

> I think the steps from here on would be:
>
>  - Apply the patch in your message I am responding to, so that a stash
>    that is kept forever will not pin the unnecessary history behind it in
>    the repository.  As you said there is no reason to make the base commit
>    (H) actually the same as the commit in the true history --- the only
>    thing we care about it is its tree object;
>
>  - Design and decide the way to tell git to make stash entries unexpirable
>    (or maybe have very long expiration period).  I am leaning toward a
>    configuration option that lets you specify expiration period per ref,
>    rather than marking individual reflog entries as I suggested earlier;
>
>  - Make the default for new repositories' stash reflog expiry period
>    "never", by setting the above configuration upon "git init".
>
> None of the above should obviously be in 1.5.6, but I think even the third
> step to the change the default would be acceptable in the next 1.6.0
> release.

So here is the second step from the above list.  I did not write any test
nor docs, but if people are so keen to see permanent stashes supported, I
am reasonably sure that they will contribute by filling the gap even if I
do not do anything further ;-)

Obviously this will _not_ come anywhere near 'master' nor 'next' until
1.5.6 ships.

-- >8 --

From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 15 Jun 2008 23:48:46 -0700
Subject: [PATCH] Per-ref reflog expiry configuration

In addition to gc.reflogexpireunreachable and gc.reflogexpire, this lets
you set gc.<pattern>.reflogexpireunreachable and gc.<pattern>.reflogexpire
variables.

When "git reflog expire" expires reflog entry for $ref, the expiry timers
are taken from the first <pattern> that matches $ref (and if there isn't
the global default value is used).

For example, you could:

	[gc "refs/stash"]
		reflogexpire = never
		reflogexpireunreachable = never

	[gc "refs/remotes/*"]
		reflogexpire = 7 days
		reflogexpireunreachable = 3 days

	[gc]
		reflogexpire = 90 days
		reflogexpireunreachable = 30 days

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-reflog.c |  145 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 126 insertions(+), 19 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index b151e24..eec14c7 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -269,7 +269,9 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
-	/* we take the lock for the ref itself to prevent it from
+
+	/*
+	 * we take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
 	lock = lock_any_ref_for_update(ref, sha1, 0);
@@ -331,21 +333,119 @@ static int collect_reflog(const char *ref, const unsigned char *sha1, int unused
 	return 0;
 }
 
-static int reflog_expire_config(const char *var, const char *value, void *cb)
+static struct reflog_expire_cfg {
+	struct reflog_expire_cfg *next;
+	unsigned long expire_total;
+	unsigned long expire_unreachable;
+	size_t len;
+	char pattern[FLEX_ARRAY];
+} *reflog_expire_cfg, **reflog_expire_cfg_tail;
+
+static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 {
-	if (!strcmp(var, "gc.reflogexpire")) {
-		if (!value)
-			config_error_nonbool(var);
-		default_reflog_expire = approxidate(value);
+	struct reflog_expire_cfg *ent;
+
+	if (!reflog_expire_cfg_tail)
+		reflog_expire_cfg_tail = &reflog_expire_cfg;
+
+	for (ent = reflog_expire_cfg; ent; ent = ent->next)
+		if (ent->len == len &&
+		    !memcmp(ent->pattern, pattern, len))
+			return ent;
+
+	ent = xcalloc(1, (sizeof(*ent) + len));
+	memcpy(ent->pattern, pattern, len);
+	ent->len = len;
+	*reflog_expire_cfg_tail = ent;
+	reflog_expire_cfg_tail = &(ent->next);
+	return ent;
+}
+
+static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (!strcmp(value, "never") || !strcmp(value, "false")) {
+		*expire = 0;
 		return 0;
 	}
-	if (!strcmp(var, "gc.reflogexpireunreachable")) {
-		if (!value)
-			config_error_nonbool(var);
-		default_reflog_expire_unreachable = approxidate(value);
+	*expire = approxidate(value);
+	return 0;
+}
+
+/* expiry timer slot */
+#define EXPIRE_TOTAL   01
+#define EXPIRE_UNREACH 02
+
+static int reflog_expire_config(const char *var, const char *value, void *cb)
+{
+	const char *lastdot = strrchr(var, '.');
+	unsigned long expire;
+	int slot;
+	struct reflog_expire_cfg *ent;
+
+	if (!lastdot || prefixcmp(var, "gc."))
+		return git_default_config(var, value, cb);
+
+	if (!strcmp(lastdot, ".reflogexpire")) {
+		slot = EXPIRE_TOTAL;
+		if (parse_expire_cfg_value(var, value, &expire))
+			return -1;
+	} else if (!strcmp(lastdot, ".reflogexpireunreachable")) {
+		slot = EXPIRE_UNREACH;
+		if (parse_expire_cfg_value(var, value, &expire))
+			return -1;
+	} else
+		return git_default_config(var, value, cb);
+
+	if (lastdot == var + 2) {
+		switch (slot) {
+		case EXPIRE_TOTAL:
+			default_reflog_expire = expire;
+			break;
+		case EXPIRE_UNREACH:
+			default_reflog_expire_unreachable = expire;
+			break;
+		}
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+
+	ent = find_cfg_ent(var + 3, lastdot - (var+3));
+	if (!ent)
+		return -1;
+	switch (slot) {
+	case EXPIRE_TOTAL:
+		ent->expire_total = expire;
+		break;
+	case EXPIRE_UNREACH:
+		ent->expire_unreachable = expire;
+		break;
+	}
+	return 0;
+}
+
+static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, const char *ref)
+{
+	struct reflog_expire_cfg *ent;
+
+	if (slot == (EXPIRE_TOTAL|EXPIRE_UNREACH))
+		return; /* both given explicitly -- nothing to tweak */
+
+	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
+		if (!fnmatch(ent->pattern, ref, 0)) {
+			if (!(slot & EXPIRE_TOTAL))
+				cb->expire_total = ent->expire_total;
+			if (!(slot & EXPIRE_UNREACH))
+				cb->expire_unreachable = ent->expire_unreachable;
+			return;
+		}
+	}
+
+	/* Nothing matched -- set the default value */
+	if (!(slot & EXPIRE_TOTAL))
+		cb->expire_total = default_reflog_expire;
+	if (!(slot & EXPIRE_UNREACH))
+		cb->expire_unreachable = default_reflog_expire_unreachable;
 }
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
@@ -353,6 +453,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	struct cmd_reflog_expire_cb cb;
 	unsigned long now = time(NULL);
 	int i, status, do_all;
+	int explicit_expiry = 0;
 
 	git_config(reflog_expire_config, NULL);
 
@@ -367,20 +468,18 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	cb.expire_total = default_reflog_expire;
 	cb.expire_unreachable = default_reflog_expire_unreachable;
 
-	/*
-	 * We can trust the commits and objects reachable from refs
-	 * even in older repository.  We cannot trust what's reachable
-	 * from reflog if the repository was pruned with older git.
-	 */
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
-		else if (!prefixcmp(arg, "--expire="))
+		else if (!prefixcmp(arg, "--expire=")) {
 			cb.expire_total = approxidate(arg + 9);
-		else if (!prefixcmp(arg, "--expire-unreachable="))
+			explicit_expiry |= EXPIRE_TOTAL;
+		}
+		else if (!prefixcmp(arg, "--expire-unreachable=")) {
 			cb.expire_unreachable = approxidate(arg + 21);
+			explicit_expiry |= EXPIRE_UNREACH;
+		}
 		else if (!strcmp(arg, "--stale-fix"))
 			cb.stalefix = 1;
 		else if (!strcmp(arg, "--rewrite"))
@@ -400,6 +499,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else
 			break;
 	}
+
+	/*
+	 * We can trust the commits and objects reachable from refs
+	 * even in older repository.  We cannot trust what's reachable
+	 * from reflog if the repository was pruned with older git.
+	 */
 	if (cb.stalefix) {
 		init_revisions(&cb.revs, prefix);
 		if (cb.verbose)
@@ -417,6 +522,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for_each_reflog(collect_reflog, &collected);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
+			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
 			status |= expire_reflog(e->reflog, e->sha1, 0, &cb);
 			free(e);
 		}
@@ -430,6 +536,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			status |= error("%s points nowhere!", ref);
 			continue;
 		}
+		set_reflog_expiry_param(&cb, explicit_expiry, ref);
 		status |= expire_reflog(ref, sha1, 0, &cb);
 	}
 	return status;
-- 
1.5.6.rc3.7.g336d0
