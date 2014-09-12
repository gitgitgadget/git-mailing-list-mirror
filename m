From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch
 series overview)
Date: Fri, 12 Sep 2014 12:18:12 -0700
Message-ID: <20140912191812.GZ18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
 <20140912004717.GY18279@google.com>
 <xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:18:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSWMO-0002wI-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbaILTSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 15:18:16 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62084 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaILTSP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:18:15 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so1848514pdb.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1Si1prYxp4MU6MvulMwZJgJNT78g8K7gzwRFMdKemHc=;
        b=py2iO+tGztL3W7MAemh2B9adTuVYRuVETkf/O6F/7YSD1lVXOmzFpYUkXiUGfDpCM0
         GVFfRs9X54JW4RLcQkamElw2Frl7BF8DH2V0pddlPCSX0/ZEQBZ5GS4JXVSKnrDeDCID
         LDelFI1uyLpawDNPSb/Re3vQYRgxuywwK8sf+sOcjOpaoyV+BfYuLv4dIJ2HSAR8i4nN
         9m2zvOA1tnwK39gpmiP5H366R6tBl3/x+Y9TrgpAYQLmTE/hbeREXYxxvsR/BiTkZOdZ
         ldVKFhc0ZF6XegQ/DveMrItQHdo4VUxOHE7m22x3yh2aD7zGxWWnuLUa0vUiT8XVq36i
         shYg==
X-Received: by 10.70.128.195 with SMTP id nq3mr17022425pdb.158.1410549494986;
        Fri, 12 Sep 2014 12:18:14 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ez8sm4592033pdb.63.2014.09.12.12.18.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Sep 2014 12:18:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256945>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > Junio C Hamano wrote:

>>> The tag fetched and built as-is seems to break 5514 among other
>>> things ("git remote rm" segfaults).
>>
>> Yeah, I noticed that right after sending the series out. :/
>>
>> The patch below fixes it[1].
>
> Is this meant to replace anything, or is it "Oops, the previous ones
> are broken, and this is to patch it up on top"?

It's "Oops, the next one (refs.c: do not permit err == NULL) is broken,
and this is to patch it up in advance". :)

But it should apply on top, too.

There were a few other minor changes, and I think with them the series
should be ready for "next".  My "send and hope that more reviewers
appear" strategy didn't really work, so I'll send a reroll of the
series as-is in an hour or so.

Here's an interdiff as a preview.

diff --git a/builtin/branch.c b/builtin/branch.c
index 5d5bc56..4bf931e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -238,9 +238,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					    RESOLVE_REF_READING
 					    | RESOLVE_REF_NODEREF
 					    | RESOLVE_REF_ALLOW_BAD_NAME);
-		if (!target ||
-		    (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
-		     is_null_sha1(sha1))) {
+		if (!target) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
 			      : _("branch '%s' not found."), bname.buf);
@@ -268,8 +266,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			       ? _("Deleted remote branch %s (was %s).\n")
 			       : _("Deleted branch %s (was %s).\n"),
 			       bname.buf,
-			       (flags & REF_ISSYMREF)
-			       ? target
+			       (flags & REF_ISBROKEN) ? "broken"
+			       : (flags & REF_ISSYMREF) ? target
 			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
diff --git a/builtin/remote.c b/builtin/remote.c
index 6eaeee7..ef1ffc3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,13 +750,16 @@ static int mv(int argc, const char **argv)
 
 static int remove_branches(struct string_list *branches)
 {
+	struct strbuf err = STRBUF_INIT;
 	const char **branch_names;
 	int i, result = 0;
 
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
-	result |= repack_without_refs(branch_names, branches->nr, NULL);
+	if (repack_without_refs(branch_names, branches->nr, &err))
+		result |= error("%s", err.buf);
+	strbuf_release(&err);
 	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
@@ -1333,9 +1336,13 @@ static int prune_remote(const char *remote, int dry_run)
 		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
 		for (i = 0; i < states.stale.nr; i++)
 			delete_refs[i] = states.stale.items[i].util;
-		if (!dry_run)
-			result |= repack_without_refs(delete_refs,
-						      states.stale.nr, NULL);
+		if (!dry_run) {
+			struct strbuf err = STRBUF_INIT;
+			if (repack_without_refs(delete_refs, states.stale.nr,
+						&err))
+				result |= error("%s", err.buf);
+			strbuf_release(&err);
+		}
 		free(delete_refs);
 	}
 
