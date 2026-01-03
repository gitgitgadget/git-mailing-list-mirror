Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7692D63EF
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767443129; cv=none; b=eXSXETLQJKI5/ub1TFIVgmNqIAqeoQB7etn+Vxyo/Mm+URKj/k8aQXcW/ApnR9bU4LvKkm/cNvlK4Q3GsK1K1hXzclcDtwdvdQb/uRtnFTmNyG00dll2xwc8CtFkzVUU1qeoDTSNMYQ1yFo5RIKctqOFFYndgGi3UzrEtrTPkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767443129; c=relaxed/simple;
	bh=+9stMTbdfNnAMvBWCRcfZ84xt/UNJX9oeMU4ii/PHWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YGUqgJFxAIjh0Duo7p37Kao3ie1fctiQKSwb2NMmmwgAz+Q2gczFhfuBPRtcCRHuUnGVpBb2hVVLDLZI3ceXUqPM02brXrWipT+ZVZvEMakytBO9E58R8MzpI7RRRWW84qMo2cNfoI4WNHQ2rS7fTIe/U6lLDnonCMKaTEuiqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=t2Trq22p; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="t2Trq22p"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A1D1614C2D6;
	Sat,  3 Jan 2026 13:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1767443116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=wFtqBV8vOo3p7Ym3oi3fPNQ1YjVSdE5h9vRGxngK6fw=;
	b=t2Trq22pwI5FQRe07w5SLyQX8vcPWjZqSeqt2T0JH+Q1gmTchK6vGMNyOhyjiSpy4GsAob
	1KC/5UerhBKwCs+8O3x2Ra51loM5km2zahMnMvTlw7NZGXYUQPMhblQhZeBptC1gHuerS9
	4Mv8lRFTog55jqy+5A04zEZSIr0s+I6Hh4D8zLdVeaMPf18MAV8kqOsl+CVM4ntLcje7NY
	xiDvE9AWJAD/mZwm4h9WYuhj8OjgcdnbXNTQOIvyvIUczWCx+OwuBwfRkn5lAWS6F6O3Xl
	iTNo/pYHR8uxsrNx6S7nvHUqM8ogb4dUU02+nEIi0IhT7TD28G5Py7mRGEcPNg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d7dd4d05;
	Sat, 3 Jan 2026 12:25:12 +0000 (UTC)
Date: Sat, 3 Jan 2026 21:24:57 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Julien Moutinho <julm@sourcephile.fr>
Subject: Re: [RFC PATCH] builtin/format-patch: print a warning for skipped
 merge commits?
Message-ID: <aVkKmcER2K8D9U4T@codewreck.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260102073358.GC2581074@coredump.intra.peff.net>
 <xmqqo6nfdyl4.fsf@gitster.g>

Thank you both for taking the time to reply over new year

Junio C Hamano wrote on Wed, Dec 31, 2025 at 02:12:07PM +0900:
> Dominique Martinet <asmadeus@codewreck.org> writes:
> > This RFC patch illustrates how we could easily print a warning, but
> > perhaps the warning would only make sense if no other commit has been
> > formatted?
> 
> Yeah, when nothing is shown but the given range is not empty, it
> would not be too annoying to give an advice message.
> 
> On the other hand, I do not think it is a good idea to say anything
> extra when the user gave a range "trunk..mytopic" that has repeated
> back-merges from trunk into mytopic, to format what s/he worked on
> the mytopic branch.  They _expect_ these back-merges to be ignored,
> and it would be purely an unwanted noise.

Okay, I can see this being confusing to people not used to format-patch
even with a range, but I agree it'll be annoying more often than not in
general so I'm fine with this.

It makes it a bit cumbersome to print details about the commit(s) being
skipped though, so it's probably simpler to do a generic message like
"No patch generated. Note merge commits are skipped." like this?
-----
diff --git a/builtin/log.c b/builtin/log.c
index d4cf9c59c81a..1ff3c5a4c960 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1901,6 +1901,7 @@ int cmd_format_patch(int argc,
 	char *to_free = NULL;
 	struct setup_revision_opt s_r_opt;
 	size_t nr = 0, total, i;
+	int seen_merge = 0;
 	int use_stdout = 0;
 	int start_number = -1;
 	int just_numbers = 0;
@@ -2044,7 +2045,6 @@ int cmd_format_patch(int argc,
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.no_free = 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
@@ -2274,6 +2274,10 @@ int cmd_format_patch(int argc,
 		die(_("revision walk setup failed"));
 	rev.boundary = 1;
 	while ((commit = get_revision(&rev)) != NULL) {
+		if (commit->parent && commit->parents->next) {
+			seen_merge = 1;
+			continue;
+		}
 		if (commit->object.flags & BOUNDARY) {
 			boundary_count++;
 			origin = (boundary_count == 1) ? commit : NULL;
@@ -2287,9 +2291,12 @@ int cmd_format_patch(int argc,
 		REALLOC_ARRAY(list, nr);
 		list[nr - 1] = commit;
 	}
-	if (nr == 0)
+	if (nr == 0) {
+		if (seen_merge)
+			warning(_("No patch generated. Note merge commits are skipped."));
 		/* nothing to do */
 		goto done;
+	}
 	total = nr;
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
-----

I'll send that as v2 with tests fixed/added when time permits.


Jeff King wrote on Fri, Jan 02, 2026 at 02:33:58AM -0500:
> On Wed, Dec 31, 2025 at 12:42:17PM +0900, Dominique Martinet wrote:
> 
> > @@ -2274,6 +2273,11 @@ int cmd_format_patch(int argc,
> >  		die(_("revision walk setup failed"));
> >  	rev.boundary = 1;
> >  	while ((commit = get_revision(&rev)) != NULL) {
> > +		if (commit->parents->next) {
> > +			warning(_("skipped merge commit %s"),
> > +				oid_to_hex(&commit->object.oid));
> > +			continue;
> > +		}
> 
> I don't have any thoughts on whether the patch is overall a good
> direction or not, but I suspect this line will segfault if we ever see a
> root commit. You probably want:
> 
>   if (commit->parents && commit->parents->next)

Thank you for pointing that out!

-- 
Dominique Martinet | Asmadeus
