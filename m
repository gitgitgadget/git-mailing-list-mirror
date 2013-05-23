From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 00:22:07 -0500
Message-ID: <CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 07:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfNyt-0005L3-1j
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 07:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab3EWFWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 01:22:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:58812 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab3EWFWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 01:22:10 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so2804166lab.33
        for <git@vger.kernel.org>; Wed, 22 May 2013 22:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kwZWN+uKCRfZS0aBySpIcIeqKW0z5yLdNgA4lQVNrog=;
        b=PpXGDH0Vq9GBoMrxOY04VMgowUGROcmu994MQ8MQfILqrlx8dZYO60w1BfCyj4mvy3
         SCnLrk7Ui1gD5KpTCIs0uwmC0C2ed7c/211Cf5dod+ygp0qoVXpg/IGatp/NgdenFN/L
         EqBCp14G0LnPzl6ktd2n6qPRU7nN9ha6DnRsHnQyOmaCvO+7wELJ/CPSk62NoLPAVBx4
         rQbRUSVBrJvkd7+lpEyN/Tq8WEqIzsO6u1Dj/2Q/UZb1ipZt1AATDvdqX+vwn3aAP6mz
         5/mgGyXtZzizsMNxVFlngJcYg5xaE2isAChOLhenSFtdFNZnl3O1W3NRcfDCtPhHe6Rd
         7tzA==
X-Received: by 10.112.142.8 with SMTP id rs8mr4894603lbb.8.1369286528419; Wed,
 22 May 2013 22:22:08 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 22:22:07 -0700 (PDT)
In-Reply-To: <CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225213>

On Wed, May 22, 2013 at 11:07 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 22, 2013 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> IIRC, git-gui runs two blames, one without any -C and one with (I do
>>>> not offhand recall how many -C it uses) to show both.
>>>
>>> 'git blame' is a very expensive operation, perhaps we should add
>>> another option so users don't need to run two blames to find this.
>>
>> Yes, you could add a "struct origin *suspect_in_the_same_file" next
>> to the current "struct origin *suspect" to the blame_entry in order
>> to represent the origin you would get if you were to stop at a "move
>> across files" event, and keep digging, when you are operating under
>> "-C -C" or higher mode.
>
> No, this is what I meant:

But that would not print the right line numbers, so perhaps:

--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1500,25 +1500,16 @@ static int emit_one_suspect_detail(struct
origin *suspect, int repeat)
 	return 1;
 }

-/*
- * The blame_entry is found to be guilty for the range.  Mark it
- * as such, and show it in incremental output.
- */
-static void found_guilty_entry(struct blame_entry *ent)
+static void print_guilty_entry(struct blame_entry *ent)
 {
-	if (ent->guilty)
-		return;
-	ent->guilty = 1;
-	if (incremental) {
-		struct origin *suspect = ent->suspect;
-
-		printf("%s %d %d %d\n",
-		       sha1_to_hex(suspect->commit->object.sha1),
-		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		emit_one_suspect_detail(suspect, 0);
-		write_filename_info(suspect->path);
-		maybe_flush_or_die(stdout, "stdout");
-	}
+	struct origin *suspect = ent->suspect;
+
+	printf("%s %d %d %d\n",
+			sha1_to_hex(suspect->commit->object.sha1),
+			ent->s_lno + 1, ent->lno + 1, ent->num_lines);
+	emit_one_suspect_detail(suspect, 0);
+	write_filename_info(suspect->path);
+	maybe_flush_or_die(stdout, "stdout");
 }

 /*
@@ -1531,14 +1522,19 @@ static void assign_blame(struct scoreboard *sb, int opt)
 	struct rev_info *revs = sb->revs;

 	while (1) {
-		struct blame_entry *ent;
+		struct blame_entry *ent, tmp_ent;
 		struct commit *commit;
 		struct origin *suspect = NULL;
+		int found_guilty = 0;

 		/* find one suspect to break down */
-		for (ent = sb->ent; !suspect && ent; ent = ent->next)
-			if (!ent->guilty)
+		for (ent = sb->ent; ent; ent = ent->next)
+			if (!ent->guilty) {
+				tmp_ent = *ent;
 				suspect = ent->suspect;
+				break;
+			}
+
 		if (!suspect)
 			return; /* all done */

@@ -1564,9 +1560,20 @@ static void assign_blame(struct scoreboard *sb, int opt)
 			commit->object.flags |= UNINTERESTING;

 		/* Take responsibility for the remaining entries */
-		for (ent = sb->ent; ent; ent = ent->next)
-			if (same_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+		for (ent = sb->ent; ent; ent = ent->next) {
+			if (same_suspect(ent->suspect, suspect)) {
+				if (ent->guilty)
+					continue;
+				found_guilty = ent->guilty = 1;
+				if (incremental)
+					print_guilty_entry(ent);
+			}
+		}
+
+		if (incremental && !found_guilty &&
+				!is_null_sha1(suspect->commit->object.sha1))
+			print_guilty_entry(&tmp_ent);
+
 		origin_decref(suspect);

 		if (DEBUG) /* sanity */

-- 
Felipe Contreras
