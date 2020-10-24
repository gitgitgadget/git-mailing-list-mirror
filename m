Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1583AC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE9C21D81
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="P6Ql7OSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760427AbgJXRHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 13:07:04 -0400
Received: from mout.web.de ([212.227.15.4]:55645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760048AbgJXRHD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 13:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1603559218;
        bh=mTkhNQgNloX1cByRtapwlHQPY72y4Ak72JrjkNwch1E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=P6Ql7OSReGcta4X1ZrmYLheM73M0uUbK1XR910kcW0MEHHwZYUgB/rqLPKo3k3DA9
         HxRTEer/Y/Ezd1WXu9IjabGWu1un61szX64BmMgTrgYTsVYmewZttjA3v+EjqGtj2q
         1U0PQX65OTN1zo3k3czI81tPUORFKR3GUDNBMWCo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZims-1kpXFn45ks-00LWlH; Sat, 24
 Oct 2020 19:06:58 +0200
Subject: Re: [bug] Stashes lost after out-of-memory situation
To:     Marek Mrva <mrva@eof-studios.com>, git@vger.kernel.org
References: <65a3061a-47ef-9ca6-2468-5449cfc5b37c@eof-studios.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <618d66a8-e2c1-241c-5200-2298bfe24ac0@web.de>
Date:   Sat, 24 Oct 2020 19:06:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <65a3061a-47ef-9ca6-2468-5449cfc5b37c@eof-studios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BUstU8USyusiLV4OeEnCZwvVDl0IJVeGvo9sWATSPvBtE0Wx73Q
 2YruYyf57rBQfM2Op7b1/6vGhM3mz1YGy93F1DxAvje43zI2wNwJ+l4vk1N+0Phx+hrdszR
 qBn523kG/HjWC+qm6+lGKzQlPV46ON2kqkm0GLdDRuB0vOHoXIamlYpaXwdBWdAqEQBHzGJ
 FjHsZ+59vlIo6rY0x69xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+CfyyMCNKiI=:NBlS+rRHw5oP3tTKh6M7hO
 uC5qP/bG+KeYWU+cS+O2c9H3NA2rAcEFMxXk20MqHqXOqhtj1IyVN2x3nHY7F5O4Jro5aYHNJ
 BAc0oDeDLSWddtQzR0kaYKCiThJEltd2O8Z+vr+d5TSvYfg8OSr5dhqQqzHKXCgSKDCjjlVVu
 Eb4wy1EYAKsD4gLssX0ZuaB0f4d5GQr6mdBLmfnqFGTSOz48+TI4m6xL1TWmaYMm5AjTxf4b9
 xgM41MaJ9TK4wubCUhX5tg05LpYttVoIAPk+LUBcs4tG70XBdjiHHp8HBlddM1GDc1M68gzBl
 M+X4AuvBxXegqn+OXzvuU0vihVdDDwod5h9BLoqLJ1XA3Zk4PNb1n/adVHlEIPUD+CB7IsfXk
 qgNGNDgcSfBV8RNTrAf0048XBN2wfe0eMCM4lSKhXVEx8sB79PFPoCFP2wJ0GpjJptJtaKDIK
 ncn1W1/RmT7+OomQD7bCVgNkA7eqqmLTTcLNWkRTj2kdGsRxZN9drKkMlHNI/ABWY9/bAICyh
 PDb+3DcsxNaWZfK+wgTPXTmdkQr2TwGFzGcjsGn17oIFEzbShptICtBnaOBtRQAdfCDbnKLB0
 yrq+1Jk0ZIoYgCFzZD/y2thD1FZ7W6la2tqSXrGMY1Shp5PFDCe5blBZah4h0yZ/IVRygaS9R
 ZZ9zzvY/WRvJ2oLE+eccbUA40WBDa1dfp8R4IqKTHDycOSIarLV+ZLbeQ26HHGinovcwnejSa
 CMoEP+xO8zJ2aRheSwT7ZI7MfUHrC3DpqxApuQ1ZGIS2x5Kc6uK1KMdwQYvQzgQzuGisKwKxi
 mdpFwKK3v/A+V2Ch2cnfGYaB+i4wipIdFXO0zbYZUz4RrcMfE03+mA+tdv+7EVIi+jrjkM7bb
 ccNrGdDYCe4vBBO3o1ig==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.20 um 16:53 schrieb Marek Mrva:
> Hello, hopefully this is the correct mailing list - apologies if it is n=
ot.

You came to the right place.

> After issuing "git stash pop" while being low on memory, the following w=
as printed to the console:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 [main] git 2061 fhandler_disk_file::fix=
up_mmap_after_fork: requested 0x6FFFC1550000 !=3D 0x0 mem alloc base 0x0, =
state 0x10000,
> size 17545957736448, Win32 error 1455
> =C2=A0 36836 [main] git 2061 C:\cygwin64\bin\git.exe: *** fatal error in=
 forked process - recreate_mmaps_after_fork_failed
> =C2=A0 37523 [main] git 2061 cygwin_exception::open_stackdumpfile: Dumpi=
ng stack trace to git.exe.stackdump
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 [main] git 2056 dofork: child -1 - fork=
ed process 12100 died unexpectedly, retry 0, exit code 0x100, errno 11
> error: cannot fork() for status: Resource temporarily unavailable
> Dropped refs/stash@{0} (06d44ccc5ed2ac93b370100f481147ae4f0065db)
> error: cannot fork() for rev-parse: Resource temporarily unavailable
>
> Afterwards, the result of "git stash list" is empty, even though there u=
sed to be more than 10+ stashes saved.

How horrible!

> Obviously while being low on memory, one should not expect commands
> to run properly. Losing all the *other* stashes could hopefully be
> somehow avoided, if possible.

Of course.

> It is worth mentioning this happened in a cygwin environment on Windows.
>
> Any help would be greatly appreciated! :)

Before any repair attempt please make a backup of the whole repository.

You may be able to recover the lost stacks using git fsck, which can
show dangling commits, i.e. commits that are no longer referenced.
They will be cleaned up eventually by git gc, so avoid running that
until you recovered as many of them as possible.

The manpage of git stash says:

  Recovering stash entries that were cleared/dropped erroneously::

  If you mistakenly drop or clear stash entries, they cannot be recovered
  through the normal safety mechanisms.  However, you can try the
  following incantation to get a list of stash entries that are still in
  your repository, but not reachable any more:

  ----------------------------------------------------------------
  git fsck --unreachable |
  grep commit | cut -d\  -f3 |
  xargs git log --merges --no-walk --grep=3DWIP
  ----------------------------------------------------------------

You are basically looking for merges with two parents and your stash
message as commit message.  See the manpage for some more details.

You could use them to rebuild .git/logs/refs/stash manually, or to
apply them with git cherry-pick -m1.

Good luck!

So why did this happen?  Looks like stash calls rev-parse to see if a
stash pop removed the last stash and in that case proceeds to delete the
stash ref and its reflog.  A failure of rev-parse is interpreted as no
stashes being left.  This can be triggered by other reasons (like OOM),
so this is dangerously fragile.  Let's make that check more precise.

=2D- >8 --
Subject: [PATCH] stash: simplify reflog emptiness check

Calling rev-parse to check if the drop subcommand removed the last stash
and treating its failure as confirmation is fragile, as the command can
fail for other reasons, e.g. because the system is out of memory.
Directly check if the reflog is empty instead, which is more robust.

Reported-by: Marek Mrva <mrva@eof-studios.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/stash.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3f811f3050..24ddb1bffa 100644
=2D-- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -534,11 +534,22 @@ static int apply_stash(int argc, const char **argv, =
const char *prefix)
 	return ret;
 }

+static int reject_reflog_ent(struct object_id *ooid, struct object_id *no=
id,
+			     const char *email, timestamp_t timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	return 1;
+}
+
+static int reflog_is_empty(const char *refname)
+{
+	return !for_each_reflog_ent(refname, reject_reflog_ent, NULL);
+}
+
 static int do_drop_stash(struct stash_info *info, int quiet)
 {
 	int ret;
 	struct child_process cp_reflog =3D CHILD_PROCESS_INIT;
-	struct child_process cp =3D CHILD_PROCESS_INIT;

 	/*
 	 * reflog does not provide a simple function for deleting refs. One will
@@ -559,19 +570,7 @@ static int do_drop_stash(struct stash_info *info, int=
 quiet)
 			     info->revision.buf);
 	}

-	/*
-	 * This could easily be replaced by get_oid, but currently it will throw
-	 * a fatal error when a reflog is empty, which we can not recover from.
-	 */
-	cp.git_cmd =3D 1;
-	/* Even though --quiet is specified, rev-parse still outputs the hash */
-	cp.no_stdout =3D 1;
-	strvec_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
-	strvec_pushf(&cp.args, "%s@{0}", ref_stash);
-	ret =3D run_command(&cp);
-
-	/* do_clear_stash if we just dropped the last stash entry */
-	if (ret)
+	if (reflog_is_empty(ref_stash))
 		do_clear_stash();

 	return 0;
=2D-
2.28.0
