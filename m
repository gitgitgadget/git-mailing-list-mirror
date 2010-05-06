From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Thu, 6 May 2010 14:24:41 +0200
Message-ID: <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com> 
	<20100505050640.GC8779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 06 14:25:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA08k-0007NO-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 14:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab0EFMZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 08:25:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:60410 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab0EFMZC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 08:25:02 -0400
Received: by ey-out-2122.google.com with SMTP id d26so55455eyd.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=niUtMwqxftLAUDJhwhdY+Ah7QAjBLM4DoHemcahVhWM=;
        b=UfuzxYQSYsbSzdkxIXeGqFDY22a5qXq7MTyI08cgrrGAm82fA/IPWqGFeGmD6dkI2g
         50W2SZFL7E9byh+lvvcv3jvE0bid7OnCetYc0SiEcDli8k4Br+XDCPwL80yY6MJuM3x4
         FcOZ7wdYzttYTgqv1H9sh81VP9g95Mg18QSiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rr8nTfRhKvQ8eAyeF0zLsmFcKRlbhRDqPJauwqaTfyoE+Ji9LUdxgaVxlFIE4L/NJt
         ECF7tEBGXVj0n9L1MlW55Gxmo/MhTeQ4ZKW4QqUpGlMVmBwHUm8cf3e0yxqZ+Zy7G4yt
         w3EX5okcMIRZjprRRJz/xIrIRIB6cJlkgDda8=
Received: by 10.213.57.193 with SMTP id d1mr7899220ebh.51.1273148701166; Thu, 
	06 May 2010 05:25:01 -0700 (PDT)
Received: by 10.213.3.5 with HTTP; Thu, 6 May 2010 05:24:41 -0700 (PDT)
In-Reply-To: <20100505050640.GC8779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146477>

Hi jeff,

thank you for your response and your comments.

On Wed, May 5, 2010 at 7:06 AM, Jeff King <peff@peff.net> wrote:
> On Sun, May 02, 2010 at 11:13:41AM +0200, Knittl wrote:
>
>> This patch adds a first line in the output of `git status -s`, showi=
ng
>> which branch the user is currently on, and in case of tracking branc=
hes
>> the number of commits on each branch.
>
> I don't generally use "git status -s", so I don't have a strong opini=
on,
> but should this perhaps be optional?  I imagine people using it fall
> into one of two categories:
>
>  1. They want to waste less vertical screen real estate than "git
>     status" does.

it's one line ;) but i can understand your concern. would `git status
-s -v` or `git status -s --show-branch` make sense?

>  2. They prefer to see files in a single list with status marked,
>     rather than in separate lists based on status.
>
> Your patch will probably annoy people in group (1) unless they have s=
ome
> way to turn it off.
>
> A few other comments on the patch itself:
>
>> +     color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
>
> I thought the doubled '##' looked funny at first, but the more I look=
 at
> it, I think lining it up with the filenames looks good.

i had one hash and two spaces at first, but as you said, two hashes
look more lined up.

>> +     if(!s->branch) return;
>
> Style nits. This should be:
>
>  if (!s->branch)
>          return;

done =85

>> +     branch =3D branch_get(s->branch + 11);
>> +     if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
>> +
>> +             if(s->is_initial) {
>> +                     color_fprintf(s->fp,
>> +                             color(WT_STATUS_HEADER, s),
>> +                             "Initial commit ... ");
>> +             }
>> +             color_fprintf_ln(s->fp, branch_color,
>> +                     "%s", branch_name);
>> +             return;
>> +     }
>
> Why do we only mention it as an initial commit if there is no trackin=
g?
> We get if it is an initial commit and no tracking:

i don't think it's (easily, without messing around with the .git
directory) possible to create a branch without commits that tracks
another branch (without commits). or is it?

>  ## Initial commit ... master
>
> but if there is a tracking branch setup, we get no "Initial commit" a=
t
> all. And the use of "..." is confusing, as it usually implies symmetr=
ic
> difference, which doesn't really make sense here.

i used ... to make it look consistent with normal branch output, but i
guess you are right. i changed it to `Initial commit on <branchname>

>> +     base =3D branch->merge[0]->dst;
>> +     base =3D shorten_unambiguous_ref(base, 0);
>> +     color_fprintf_ln(s->fp, branch_color,
>> +                     "%s (%d) ... %s (%d)",
>> +                     branch_name, num_ours,
>> +                     base, num_theirs);
>> +}
>
> Here we get:
>
>  ## master (1) ... origin/master (1)
>
> which kind of makes sense. The "..." implies symmetric difference. Bu=
t
> in other spots, like "git fetch" and "git push" output, we usually tr=
y
> to make it cut-and-pastable in case one wants to view the actual
> history. So maybe something like:
>
>  ## master...origin/master [ahead 1, behind 1]
>
> The latter matches how "git branch -v" prints it. I dunno. I guess th=
is
> is just bikeshedding really, so maybe others will chime in with
> suggestions and you can pick the one you like best.

oh, i didn't know `git branch -v`. the cut&paste argument is really
strong, so i totally agree with you and changed my code.

branch names and ahead/behind numbers appear now in green and red to
match the output of `git branch -l`

here is the updated patch:

 - initial commit is also printed when there is tracking information
(i still haven't managed to create a situation like that. `git branch
oldmaster; rm .git/refs/heads/master; git branch master --set-upstream
oldmaster` will reset branch master to oldmaster (a bug?))
 - colors to match output of `git branch` (green: current, red: remote)
 - output format is copy-pasteable, ahead/behind information is in the
same format as in `git branch -v`
 - branch information is still printed by default, i have to look into
commandline option parsing first. i was thinking of `git status -v -b`
(as in `git checkout -b` to mean branch)

cheers, daniel

(i forgot to send my reply to the mailing list too =85)

---------8<----------------
=46rom 82b4481d38ae0cd62030aeea67160656b7c763e2 Mon Sep 17 00:00:00 200=
1
=46rom: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Tue, 20 Apr 2010 22:40:54 +0200
Subject: [PATCH] Show branch information in short output of git status

This patch adds a first line in the output of `git status -s`, showing
which branch the user is currently on, and in case of tracking branches
the number of commits on each branch.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 wt-status.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 wt-status.h |    4 ++-
 2 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..f7f1269 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "refs.h"

 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -17,6 +18,8 @@ static char default_wt_status_colors[][COLOR_MAXLEN] =
=3D {
 	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
 	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
+	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
+	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 };

 static const char *color(int slot, struct wt_status *s)
@@ -721,9 +724,69 @@ static void wt_shortstatus_untracked(int
null_termination, struct string_list_it
 	}
 }

+static void wt_shortstatus_print_tracking(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *header_color =3D color(WT_STATUS_HEADER, s);
+	const char *branch_color_local =3D color(WT_STATUS_LOCAL_BRANCH, s);
+	const char *branch_color_remote =3D color(WT_STATUS_REMOTE_BRANCH, s)=
;
+
+	const char *base;
+	const char *branch_name;
+	int num_ours, num_theirs;
+
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
+
+	if(!s->branch)
+		return;
+	branch_name =3D s->branch;
+
+	if (!prefixcmp(branch_name, "refs/heads/"))
+		branch_name +=3D 11;
+	else if (!strcmp(branch_name, "HEAD")) {
+		branch_name =3D "HEAD (no branch)";
+		branch_color_local =3D color(WT_STATUS_NOBRANCH, s);
+	}
+
+	branch =3D branch_get(s->branch + 11);
+	if(s->is_initial) {
+		color_fprintf(s->fp, header_color, "Initial commit on ");
+	}
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
+		color_fprintf_ln(s->fp, branch_color_local,
+			"%s", branch_name);
+		return;
+	}
+
+	base =3D branch->merge[0]->dst;
+	base =3D shorten_unambiguous_ref(base, 0);
+	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+	color_fprintf(s->fp, header_color, "...");
+	color_fprintf(s->fp, branch_color_remote, "%s", base);
+
+	color_fprintf(s->fp, header_color, " [");
+	if (!num_ours) {
+		color_fprintf(s->fp, header_color, "behind ");
+		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
+	} else if (!num_theirs) {
+		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
+	} else {
+		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
+		color_fprintf(s->fp, header_color, ", behind ");
+		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
+	}
+
+	color_fprintf_ln(s->fp, header_color, "]");
+}
+
 void wt_shortstatus_print(struct wt_status *s, int null_termination)
 {
 	int i;
+
+	wt_shortstatus_print_tracking(s);
+
 	for (i =3D 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
diff --git a/wt-status.h b/wt-status.h
index 9120673..ca5db99 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -12,6 +12,8 @@ enum color_wt_status {
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
 	WT_STATUS_UNMERGED,
+	WT_STATUS_LOCAL_BRANCH,
+	WT_STATUS_REMOTE_BRANCH,
 };

 enum untracked_status_type {
@@ -42,7 +44,7 @@ struct wt_status {
 	int relative_paths;
 	int submodule_summary;
 	enum untracked_status_type show_untracked_files;
-	char color_palette[WT_STATUS_UNMERGED+1][COLOR_MAXLEN];
+	char color_palette[WT_STATUS_REMOTE_BRANCH+1][COLOR_MAXLEN];

 	/* These are computed during processing of the individual sections */
 	int commitable;
--=20
1.7.1.13.g5cd87

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
