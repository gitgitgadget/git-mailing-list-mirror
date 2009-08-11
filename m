From: Geoffrey Irving <irving@naml.us>
Subject: Re: bug with .git file and aliases
Date: Mon, 10 Aug 2009 23:37:54 -0400
Message-ID: <7f9d599f0908102037s51f0380te56463706f794c8a@mail.gmail.com>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> 
	<20090720152117.GB5347@coredump.intra.peff.net> <7f9d599f0908101322i46384247m303e28955f88bbb@mail.gmail.com> 
	<alpine.DEB.1.00.0908110101110.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:15:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGT-0000RC-Dv
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbZHKMGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 08:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbZHKMGh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:06:37 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:46067 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbZHKMGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:06:35 -0400
Received: by vws2 with SMTP id 2so3300464vws.4
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=CwY9GJ9fInzcYNQPA/YYQTx85qcfDnoKLfwt5epk1VA=;
        b=OmTdk0jEsrulq2JgFpjYpUGvbNqU0/X9jHvS2bvzj494Q1aK7+1EB1QKVqd8NxLzBz
         bsWHbSpLCtiww+3WKzevJcKiv90gsKvpxGiHBk7Xpvr0AiHLNptkuJrZ217frha4ymVl
         7UKPBVI+HHCRSav0TzDTCTzmlr4aBOYUo9rF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=bFES6MaRgUX3coWEgWzOmCQ9ozt7wlY5ZbRhCIEVsyBdXObdIRcVSfBfZClO55u8Pq
         9Q+464WUfISaOn9DpVPHfi4tp8d+XvbsCb8riWWi7yYPFVc0BgLYWPyX/xGYG2K/8lrH
         1bWTg/T9MfNPF5DppKetO4cjy0Q4IQ2wuR4as=
Received: by 10.220.94.84 with SMTP id y20mr5858428vcm.112.1249961906023; Mon, 
	10 Aug 2009 20:38:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908110101110.8306@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 79f0de6622a5c648
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125526>

On Mon, Aug 10, 2009 at 7:05 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 10 Aug 2009, Geoffrey Irving wrote:
>
>> On Mon, Jul 20, 2009 at 11:21 AM, Jeff King<peff@peff.net> wrote:
>> > On Mon, Jul 20, 2009 at 09:54:12AM -0400, Geoffrey Irving wrote:
>> >
>> >> git 1.6.3.3 has a bug related to .git file support and aliases.
>> >> Specifically, if you make an alias for status and call it from a
>> >> subdirectory, git status chdirs into the true .git dir but then
>> >> chdir's back to the wrong place in order to run the lstats for st=
atus.
>> >> =A0The result is that git status thinks all files have disappeare=
d.
>> >
>> > Yeah, this is a known problem. The problem is that the 'git' wrapp=
er
>> > sets up the environment only partially when running aliases, and t=
hen
>> > the resulting command ends up confused about where the worktree is=
=2E I
>> > really don't remember the specifics, but you can probably find som=
e
>> > discussion in the list archives. =A0Fixing it, IIRC, required some
>> > refactoring of the setup code (which I had hoped to get to at some
>> > point, but I am way behind on my git todo list).
>>
>> The attached patch fixes the bug for me. =A0I'll leave it to others =
to
>> determine whether this is a good way to fix the problem.
>
> Note that you made it particularly hard to comment on your patch by n=
ot
> granting us the wish stated in Documentation/SubmittingPatches, namel=
y to
> inline your patch.
>
> I'll just forego inlining it myself, as I am way past my bed-time and
> cannot be bothered.

Oops.  Here's the inlined patch with offset fixed, for others:

=46rom ec47aa09e5bc8d9a8c07cca9f8ef17a9898819c1 Mon Sep 17 00:00:00 200=
1
=46rom: Geoffrey Irving <irving@naml.us>
Date: Mon, 10 Aug 2009 15:59:21 -0400
Subject: [PATCH] setup.c: fix work tree setup for .git-files and aliase=
s

When .git-files and aliases are used together, the setup machinery
gets confused and ends up with the wrong work_tree.  Specifically,
git_work_tree_cfg is set to the correct value first, but set_work_tree
resets git_work_tree_cfg to the current directory, which (at least in
this case) is incorrect.

set_work_tree now detects this case by checking to see if
git_work_tree_cfg is already set.  If so, it leaves git_work_tree_cfg
unchanged and instead uses the current directory to compute and return
the correct prefix (where we are relative to the work tree).

Signed-off-by: Geoffrey Irving <irving@naml.us>
---
 setup.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index e3781b6..97f7eb1 100644
--- a/setup.c
+++ b/setup.c
@@ -198,13 +198,24 @@ int is_inside_work_tree(void)
 static const char *set_work_tree(const char *dir)
 {
 	char buffer[PATH_MAX + 1];

 	if (!getcwd(buffer, sizeof(buffer)))
 		die ("Could not get the current working directory");
-	git_work_tree_cfg =3D xstrdup(buffer);
 	inside_work_tree =3D 1;

-	return NULL;
+	if (!git_work_tree_cfg) {
+		git_work_tree_cfg =3D xstrdup(buffer);
+		return NULL;
+	} else {
+		size_t offset =3D strlen(git_work_tree_cfg);
+		if (memcmp(git_work_tree_cfg, buffer, offset)
+			|| (buffer[offset] && buffer[offset] !=3D '/'))
+			die ("fatal: not inside work tree (should not happen)");
+		if (!buffer[offset] || !buffer[offset+1])
+			return NULL;
+		return xstrdup(strcat(buffer + offset + 1, "/"));
+	}
 }

 void setup_work_tree(void)
--=20
1.6.3.3

> However, I think that it is necessary to comment on your patch.
>
> There is a few style issues, such as declaring offset outside of the
> block that is the only user, and there is the issue that you go out o=
f
> your way to append a slash if you're resetting the work tree, but not=
 when
> not resetting it.
>
> But the bigger issue is that you now broke overriding the work tree v=
ia
> the command line.
>
> The proper fix, of course, is to avoid calling the function with the =
wrong
> path to begin with.

I'm happy that the correct fix is obvious, and apologize for missing it=
=2E

Geoffrey
