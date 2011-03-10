From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2+ 6/9] revision.c: introduce --cherry-mark
Date: Thu, 10 Mar 2011 09:23:34 +0100
Message-ID: <49bfbea68bc42fa3e2903dbc8e63cf152b153d03.1299745278.git.git@drmicha.warpmail.net>
References: <7vy64o7zki.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 09:27:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxbDE-0001fJ-Og
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 09:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab1CJI1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 03:27:08 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51393 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223Ab1CJI1F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 03:27:05 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 70A3B209F5;
	Thu, 10 Mar 2011 03:27:04 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 10 Mar 2011 03:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=PQgDwPeMkdpsWZ4Vkncd0If6A6Y=; b=lN4+u0xtDEvoqPJ5cN3N/mbFAlav04ZE54wgoKhfvtV4U6tBJppwL10PwCyocg3ATDaD+AjpwnMd87xZvvyHur0S0jpakNOdVN1QIQC3iNalZwP7BRsMWbct/a1XJldMghA304EwNIL3TtMliPHEryEwwRerDKcECXPZ50AN+o8=
X-Sasl-enc: 9u0Hj7aQyeOAc8QvM75HZ0EVYGB6h8gxQqaIsuwuyvL5 1299745623
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C478F44B75B;
	Thu, 10 Mar 2011 03:27:03 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <7vy64o7zki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168797>

Introduce --cherry-mark for marking those commits which "--cherry-pick"
would drop.  The marker for those commits is '=' because '-' denotes a
boundary commit already, even though 'git cherry' uses it.

Nonequivalent commits are denoted '+' unless '--left-right' is used.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Junio C Hamano venit, vidit, dixit 09.03.2011 22:29:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> for marking those commits which "--cherry-pick" would drop.
>
> Please do not start your second paragraph with a half-sentence.

I try to get rid of that acquired habit!

>> The marker for those commits is '=' because '-' denotes a boundary
>> commit already, even though 'git cherry' uses it.
>>
>> Nonequivalent commits are denoted '+' unless '--left-right' is used.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  revision.c |   21 ++++++++++++++++++---
>>  revision.h |    4 +++-
>>  2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 49d9ba8..3da403e 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -535,6 +535,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
>>  	int left_count = 0, right_count = 0;
>>  	int left_first;
>>  	struct patch_ids ids;
>> +	unsigned cherryflag;
>
> s/cherryflag/cherry_flag/;

OK.

>> diff --git a/revision.h b/revision.h
>> index 0e4b35e..ee380ad 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -14,7 +14,8 @@
>>  #define CHILD_SHOWN	(1u<<6)
>>  #define ADDED		(1u<<7)	/* Parents already parsed and added? */
>>  #define SYMMETRIC_LEFT	(1u<<8)
>> -#define ALL_REV_FLAGS	((1u<<9)-1)
>> +#define PATCHSAME	(1u<<10)
>> +#define ALL_REV_FLAGS	((1u<<10)-1)
>
> I think you meant (1u<<9) so that ALL can cover that bit with
> ((1u<<10)-1).

Thanks for reading so carefully. What a blunder, and who knows when we would
have noticed (not with the current users of ALL_REV_FLAGS).

Oh wait, my v3 is patch-equivalent to what you have in pu already. How did I
find out? "git log1 --cherry origin/pu...", of course :) At least I changed the
message.

Michael

In case someone wonders:
git help log1
`git log1' is aliased to `log --abbrev-commit --pretty=oneline --decorate'

 revision.c |   21 ++++++++++++++++++---
 revision.h |    4 +++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 0de1608..36022a6 100644
--- a/revision.c
+++ b/revision.c
@@ -535,6 +535,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	int left_count = 0, right_count = 0;
 	int left_first;
 	struct patch_ids ids;
+	unsigned cherry_flag;
 
 	/* First count the commits on the left and on the right */
 	for (p = list; p; p = p->next) {
@@ -576,6 +577,9 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		commit->util = add_commit_patch_id(commit, &ids);
 	}
 
+	/* either cherry_mark or cherry_pick are true */
+	cherry_flag = revs->cherry_mark ? PATCHSAME : SHOWN;
+
 	/* Check the other side */
 	for (p = list; p; p = p->next) {
 		struct commit *commit = p->item;
@@ -598,7 +602,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		if (!id)
 			continue;
 		id->seen = 1;
-		commit->object.flags |= SHOWN;
+		commit->object.flags |= cherry_flag;
 	}
 
 	/* Now check the original side for seen ones */
@@ -610,7 +614,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		if (!ent)
 			continue;
 		if (ent->seen)
-			commit->object.flags |= SHOWN;
+			commit->object.flags |= cherry_flag;
 		commit->util = NULL;
 	}
 
@@ -802,7 +806,7 @@ static int limit_list(struct rev_info *revs)
 		show(revs, newlist);
 		show_early_output = NULL;
 	}
-	if (revs->cherry_pick)
+	if (revs->cherry_pick || revs->cherry_mark)
 		cherry_pick_list(newlist, revs);
 
 	if (revs->left_only || revs->right_only)
@@ -1293,7 +1297,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
+	} else if (!strcmp(arg, "--cherry-mark")) {
+		if (revs->cherry_pick)
+			die("--cherry-mark is incompatible with --cherry-pick");
+		revs->cherry_mark = 1;
+		revs->limited = 1; /* needs limit_list() */
 	} else if (!strcmp(arg, "--cherry-pick")) {
+		if (revs->cherry_mark)
+			die("--cherry-pick is incompatible with --cherry-mark");
 		revs->cherry_pick = 1;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--objects")) {
@@ -2270,6 +2281,8 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 		return "-";
 	else if (commit->object.flags & UNINTERESTING)
 		return "^";
+	else if (commit->object.flags & PATCHSAME)
+		return "=";
 	else if (!revs || revs->left_right) {
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			return "<";
@@ -2277,5 +2290,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 			return ">";
 	} else if (revs->graph)
 		return "*";
+	else if (revs->cherry_mark)
+		return "+";
 	return "";
 }
diff --git a/revision.h b/revision.h
index 0e4b35e..d38f135 100644
--- a/revision.h
+++ b/revision.h
@@ -14,7 +14,8 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define ALL_REV_FLAGS	((1u<<9)-1)
+#define PATCHSAME	(1u<<9)
+#define ALL_REV_FLAGS	((1u<<10)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -68,6 +69,7 @@ struct rev_info {
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
+			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1;
-- 
1.7.4.1.317.gf445f
