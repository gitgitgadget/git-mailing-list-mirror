From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/3] for-each-ref: utilize core.warnambiguousrefs for strict refname:short format
Date: Mon, 22 Sep 2008 11:09:49 +0200
Message-ID: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhRl-0008Ll-95
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYIVJJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbYIVJJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:09:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:40802 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbYIVJJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:09:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1299170fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6C2eF35nldYrSkMaUFM83kyR+smnwHUiDZ9HVljiojM=;
        b=Pex1n8DRz6Ysb1qvNkncjxgBYjDRdY3zMp41EVciZATfNGXQH8xk9Saiuoads2ZO9L
         L+Hifgux9WdTnVkRC1e/Hg0iu4o0NFiQXpFRgQRpTz1fEuh2rwhPdTFqtuZD8RixZyRz
         roJ83aftiZ2uLYxgok9TxsEK5VqvcVZgeSyLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BjsbBRU0KkaHgFKZxi7d1HkS54bxjli3KZ64avA5PrjfgYtJ85BaQDf0coYvi3r9X6
         joO+Kp9egzC/fCIf07n82hdRfqKZ99fa7h81NCYjdFfyRaZbMvvQgUJIruEMoIiyU3SE
         U2Pei+iOTTwFe7wGWYt2owTeCXNmbtWxTgdfI=
Received: by 10.86.26.11 with SMTP id 11mr4526088fgz.71.1222074595119;
        Mon, 22 Sep 2008 02:09:55 -0700 (PDT)
Received: from localhost (p5B0F5781.dip.t-dialin.net [91.15.87.129])
        by mx.google.com with ESMTPS id l19sm5149671fgb.7.2008.09.22.02.09.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 02:09:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96464>

core.warnambiguousrefs is used to enable strict mode for the
abbreviation.

In strict mode, the abbreviated ref will never trigger the
'warn_ambiguous_refs' warning. I.e. for these refs:

  refs/heads/xyzzy
  refs/tags/xyzzy

the abbreviated forms are:

  heads/xyzzy
  tags/xyzzy


Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

On Tue, Sep 9, 2008 at 10:05, Junio C Hamano <gitster@pobox.com> wrote:
> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
>
>> Any opinions, whether we want the 'strict' mode? i.e.:
>>
>> for refs/heads/xyzzy and refs/tags/xyzzy:
>>
>> loose mode (current implementation):
>>
>>   refs/heads/xyzzy => heads/xyzzy
>>   refs/tags/xyzzy  => xyzzy
>>
>> there would be a ambiguous warning (if enabled) if you use xyzzy as a
>> tag, but it resolves correctly to the tag.
>>
>> strict mode:
>>
>>   refs/heads/xyzzy => heads/xyzzy
>>   refs/tags/xyzzy  => tags/xyzzy
>>
>> will always produce a non-ambiguous short forms.
>
> I have no strong opinions either way, but if we want to pick only one, I
> suspect that the loose mode would be more appropriate for bash completion
> purposes exactly because:
>
>  (1) the shorter form would match the users' expectations, and;
>
>  (2) if it triggers ambiguity warning to use that result that matches
>     users' expectations, it is a *good thing* --- it reminds the user
>     that s/he is playing with fire _if_ the user is of careful type who
>     enables the ambiguity warning.
>
> Thinking about it from a different angle, it would make more sense to use
> loose mode if the user does not have ambiguity warning configured, and use
> strict mode if the warning is enabled.  Then people who will get warnings
> from ambiguity will not get an ambiguous completion, and people who won't
> will get shorter but still unambiguous completion.

Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: "Shawn O. Pearce" <spearce@spearce.org>

 Documentation/git-for-each-ref.txt |    2 +
 builtin-for-each-ref.c             |   43 ++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 5061d3e..265bbf3 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -75,6 +75,8 @@ For all objects, the following names can be used:
 refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
+	The option core.warnambiguousrefs is used to enable the strict mode
+	for the abbretiation.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 9b44092..e7b7712 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -571,7 +571,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
 /*
  * Shorten the refname to an non-ambiguous form
  */
-static char *get_short_ref(struct refinfo *ref)
+static void get_short_ref(struct refinfo *ref, int strict, char **short_ref)
 {
 	int i;
 	static char **scanf_fmts;
@@ -598,16 +598,16 @@ static char *get_short_ref(struct refinfo *ref)
 		}
 	}
 
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return ref->refname;
-
 	/* buffer for scanf result, at most ref->refname must fit */
 	short_name = xstrdup(ref->refname);
+	*short_ref = short_name;
 
-	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
-		int j;
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return;
+
+	for (i = nr_rules - 1; i >= 0 ; --i) {
+		int j, rules_to_fail = i;
 		int short_name_len;
 
 		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
@@ -616,13 +616,23 @@ static char *get_short_ref(struct refinfo *ref)
 		short_name_len = strlen(short_name);
 
 		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+		/*
 		 * check if the short name resolves to a valid ref,
 		 * but use only rules prior to the matched one
 		 */
-		for (j = 0; j < i; j++) {
+		for (j = 0; j < rules_to_fail; j++) {
 			const char *rule = ref_rev_parse_rules[j];
 			unsigned char short_objectname[20];
 
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
 			/*
 			 * the short name is ambiguous, if it resolves
 			 * (with this previous rule) to a valid ref
@@ -635,14 +645,14 @@ static char *get_short_ref(struct refinfo *ref)
 
 		/*
 		 * short name is non-ambiguous if all previous rules
-		 * haven't resolved to a valid ref
+		 * doesn't resolved to a valid ref
 		 */
-		if (j == i)
-			return short_name;
+		if (j == rules_to_fail)
+			return;
 	}
 
-	free(short_name);
-	return ref->refname;
+	/* can't abbreviate refname, return full name */
+	strcpy(short_name, ref->refname);
 }
 
 
@@ -678,13 +688,14 @@ static void populate_value(struct refinfo *ref)
 		}
 		if (!prefixcmp(name, "refname")) {
 			const char *formatp = strchr(name, ':');
-			const char *refname = ref->refname;
+			char *refname = ref->refname;
 
 			/* look for "short" refname format */
 			if (formatp) {
 				formatp++;
 				if (!strcmp(formatp, "short"))
-					refname = get_short_ref(ref);
+					get_short_ref(ref, warn_ambiguous_refs,
+						      &refname);
 				else
 					die("unknown refname format %s",
 					    formatp);
-- 
1.6.0.1
