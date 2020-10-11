Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA75C433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CFB20776
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OA8nLPEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgJKQDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:03:31 -0400
Received: from mout.web.de ([217.72.192.78]:48113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbgJKQD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 12:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602432200;
        bh=qslxWM1NtzWQ+BN/JsTwYcx0sxWeP9nhjM4ZnRQFyCg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OA8nLPEvCevy0pATkVZywt5UvB1GmAPb9Qm34246YGROQNRZ1XCiRdiTsgkDq3C1I
         gRs6LNexiKhsiQl2q0HyZI3FK3qyz2AOsU0bmU5GK52owu6NCxsR+dyMn8E6EWoI85
         hvJ/srjfx3vCR9JN+WmK87coBBdUqouM/E5b4Hb4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1kTHhy2n1O-002nxv; Sun, 11
 Oct 2020 18:03:20 +0200
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
To:     Barret Rhoden <brho@google.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200925055954.1111389-1-gitster@pobox.com>
 <20200925055954.1111389-3-gitster@pobox.com>
 <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
 <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
 <32370477-c6e4-5378-fedc-c86b9ddf96bd@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.de>
Date:   Sun, 11 Oct 2020 18:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <32370477-c6e4-5378-fedc-c86b9ddf96bd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:43+vXBkUE0/mQ2Sc//oJMaYASOdA83xplF/U6EGzFEgJJad1RbQ
 R+WL32LJaKhM0xIoiHiiovMkSNQ7hnsxXEDNmPDC8VTw8tJhYB9HAmZas5VMFuxj2cKe6qD
 3N+Xzm4Khhs1EPHvXWF3U23gJH59wN/d3p7ARaBHiiXyBc524Kbq11e/+TY32v8QRid7nPN
 8AKNFu1HL2TKEV8kbhxCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wFpPeDdvjBA=:RHEhMAeU/n0hGfjzJKG6wa
 J1ADLbp14DAE/X6dB3FUFqstk0jP9N/v27nx9VKLuRGGq/jlxvxpcVefY0mpPOcrrIVb04WUh
 QcRGJzyQYuf3mI18E2tPHgwS2oSjT2B8JTHUmQcPWJxHy9CQDtUkzn/Yc5MbdaZZx0Jxp9iAg
 lQdpFa0rvghOvzkICalSj8v7rRt6thJY+YWX62GzH3rDqAxSrTUN0ZK1hDJHROEbOvhlHgEZS
 PTG0pkw+xsPWn4x0Dqxt5KBEChvR9FXE6f0F5HZmuHnr+oTzwLJ0k56FI4yFIaDzPX/kyYIbY
 N7ck5F1do3ergCNZutOVDeaBMPEAUxAQ7R9YE8r1TH8y/6lRFaFBMYdJS/pWyVFnIMX/gS/gS
 DVt8JTYCY6lz1anx2vC6+YJRx4kJA7Luoz4M6LFIXCR7DVI5JWkQn8bYoAaHkyCoBSpQSyxa/
 +kyg8KxqznSdRsMxdd3Tv58i39ovxeGH+nPZDPd8uPoo8ZTZmaFBHuDpJ1Kdckr2rIeK5B7lM
 NNNprdG8MtfyII7abSwhEMbcqNM4kM7b4BXC3s487xfzPKGn0t3XuIFeIbFqZy1YIqZFoAgw7
 0s3bZddH93jNxgNxyv/MEJ/gKKc+0Pd+E21Ur3bBPO+meTPW0dN8GL8p0crySNxxUpSzFDIOP
 b6ZuL6+KofapmAmrs1MNr0Uxp9JzP+GEU+wYdEasA1g53kXfpCElbcJHK/0XGoUpxV+2aVKlW
 vmdMtBz5TdjoSPYMTazdXuMWhQYbRxSkexC52i4VUA8kKzEMTfEUbaw4Bjs8zQgjrc5WeTExZ
 Q5eoqjwbuHm4BPV31iRx5GzYPuuq0ENKsvt5+KzCvZc+1sS8XQIis++YXTNZfG0xLs653wYlw
 yVz1XWrcVQNJDLVtCXVZleaR7w5/DHLMXv8JV2VAeyVu8Wmh0iuMzq7uglwDkuNVjZb5smB0/
 9I7Q2VcNQNAkJIuRWb8ylfvlloLXQg7JqjWoqbm/2TyL8xi9uZveOwpb6gd2Ru7dfqbjoVkqD
 2TxnXyuM/wqqkndIFqqVm5tNMv/xr8+/T2GiNrYBrVTYze5uYDwAikVNaMKH21kIPOXwo5/Op
 iutrbrijSVgbsS/n01Ph0+waRxrGvMTs40N0IH01NC9VhpkUBKqKthp4VQLhu4LFZxUqFVGAY
 5T54Az0LJWXgy6suxQLKVq0HffN6TPaURnB9oJjj4v6lPIvoXULDWa0Dq5WS+VSNaGpwu1W+3
 tQqrg/4q3zI9NCTCL
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.09.20 um 15:26 schrieb Barret Rhoden:
> On 9/26/20 1:06 PM, Junio C Hamano wrote:
>> A user who says "ignore v2.3", sees that the commit pointed at by
>> that release tag is not ignored, comes here to complain, and is
>> told to write v2.3^0 instead, would not be happy.  It is a mistake
>> easy to catch to help users, so I am more for than against that
>> part of the change.
>
> That sounds like a nice change.

I agree -- peeling down to the commit is good.

>> I am completely neutral about "you told me to ignore this, but as
>> far as I can tell it does not even exist---did you screw up when
>> you prepared the list of stuff to ignore?" part.  I do not mind
>> seeing it removed.
>
> Part of my reasoning for "fail if you can't find it" was that it was
> highly likely to be a user error.  Especially because it will fail
> for a short hash from a file.  If you do have a list of commits to
> ignore (.git-blame-ignore-revs), that list is probably under version
> control in the same git repo, so it should change as you change
> branches.
>
> But all in all, I'm fine with skipping unknown objects.  Or for
> warning or having a git-config option, like we do for a couple other
> aspects of blame-ignore, since one size doesn't fit all.

I would expect user errors to be more likely with --ignore-rev and
interactive use (command line typos).  I see how aborting if the
referenced commit doesn't exists can help, and it's consistent with
other options that require a revision name.

I don't know how most people use --ignore-revs-file, but can imagine
a big bin of boring commits that is just appended to.  Having to
keep that file clean by removing commits from abandoned and garbage-
collected branches sounds like unnecessary busy-work to me.  (What
can I say -- I'm lazy.)

> Any performance improvement would be welcome.  I haven't looked at
> the code in a while, but I don't recall any reasons why this wouldn't
> work.

Using a commit flag instead of an oidset would only improve
performance noticeably if the product of the number of suspects and
ignored commits was huge, I guess.

I get weird timings for an ignore file containing basically all commits
(created with "git log --format=3D%H").  With Git's own repo and rc1:

Benchmark #1: ./git-blame --ignore-revs-file hashes Makefile
  Time (mean =C2=B1 =CF=83):      8.470 s =C2=B1  0.049 s    [User: 7.923 =
s, System: 0.547 s]
  Range (min =E2=80=A6 max):    8.434 s =E2=80=A6  8.605 s    10 runs

And with the patch at the bottom:

Benchmark #1: ./git-blame --ignore-revs-file hashes Makefile
  Time (mean =C2=B1 =CF=83):      8.048 s =C2=B1  0.061 s    [User: 7.899 =
s, System: 0.146 s]
  Range (min =E2=80=A6 max):    7.987 s =E2=80=A6  8.175 s    10 runs

That looks like a nice speedup, but why for system time alone?  Malloc
overhead perhaps?  And when I get rid of the intermediate oidset by
partially duplicating oidset_parse_file_carefully() it takes longer than
nine seconds.  Weird.  Perhaps a silly bug.

>>> This preexisting feature is curious.  It's even documented ('An
>>> empty file name, "", will clear the list of revs from previously
>>> processed files.') and covered by t8013.6.  Why would we need
>>> such magic in addition to the standard negation
>>> (--no-ignore-revs-file) for clearing the list?  The latter
>>> counters blame.ignoreRevsFile as well. *puzzled*
>>
>> I shared the puzzlement when I saw it, but ditto.
>
> I don't recall exactly.  Someone on the list might have wanted to
> both counter the blame.ignoreRevsFile and specify another file.  Or
> maybe they just wanted to counter the ignoreRevsFile, and I didn't
> know that --no- would already do that.  I'm certainly not wed to it.

The first step would be to show a deprecation warning, wait a few
releases and then remove that feature.  Not sure the effort and
potential user irritation is worth the saved conditional, doc lines
and test.  (We already established that I'm lazy.)

Anyway, here's the patch:
=2D--
 blame.c         |  2 +-
 blame.h         |  5 +++--
 builtin/blame.c | 16 ++++++++++++----
 object.h        |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/blame.c b/blame.c
index 686845b2b4..6e8c8fec9b 100644
=2D-- a/blame.c
+++ b/blame.c
@@ -2487,7 +2487,7 @@ static void pass_blame(struct blame_scoreboard *sb, =
struct blame_origin *origin,
 	/*
 	 * Pass remaining suspects for ignored commits to their parents.
 	 */
-	if (oidset_contains(&sb->ignore_list, &commit->object.oid)) {
+	if (commit->object.flags & BLAME_IGNORE) {
 		for (i =3D 0, sg =3D first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg =3D sg->next, i++) {
diff --git a/blame.h b/blame.h
index b6bbee4147..d35167e8bd 100644
=2D-- a/blame.h
+++ b/blame.h
@@ -16,6 +16,9 @@
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40

+/* Remember to update object flag allocation in object.h */
+#define BLAME_IGNORE	(1u<<14)
+
 struct fingerprint;

 /*
@@ -125,8 +128,6 @@ struct blame_scoreboard {
 	/* linked list of blames */
 	struct blame_entry *ent;

-	struct oidset ignore_list;
-
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
diff --git a/builtin/blame.c b/builtin/blame.c
index bb0f29300e..1c6721b5d5 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -830,21 +830,29 @@ static void build_ignorelist(struct blame_scoreboard=
 *sb,
 {
 	struct string_list_item *i;
 	struct object_id oid;
+	const struct object_id *o;
+	struct oidset_iter iter;
+	struct oidset ignore_list =3D OIDSET_INIT;

-	oidset_init(&sb->ignore_list, 0);
 	for_each_string_list_item(i, ignore_revs_file_list) {
 		if (!strcmp(i->string, ""))
-			oidset_clear(&sb->ignore_list);
+			oidset_clear(&ignore_list);
 		else
-			oidset_parse_file_carefully(&sb->ignore_list, i->string,
+			oidset_parse_file_carefully(&ignore_list, i->string,
 						    peel_to_commit_oid, sb);
 	}
 	for_each_string_list_item(i, ignore_rev_list) {
 		if (get_oid_committish(i->string, &oid) ||
 		    peel_to_commit_oid(&oid, sb))
 			die(_("cannot find revision %s to ignore"), i->string);
-		oidset_insert(&sb->ignore_list, &oid);
+		oidset_insert(&ignore_list, &oid);
 	}
+	oidset_iter_init(&ignore_list, &iter);
+	while ((o =3D oidset_iter_next(&iter))) {
+		struct commit *commit =3D lookup_commit(sb->repo, o);
+		commit->object.flags |=3D BLAME_IGNORE;
+	}
+	oidset_clear(&ignore_list);
 }

 int cmd_blame(int argc, const char **argv, const char *prefix)
diff --git a/object.h b/object.h
index 20b18805f0..6818c9296b 100644
=2D-- a/object.h
+++ b/object.h
@@ -64,7 +64,8 @@ struct object_array {
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
  * upload-pack.c:                4       11-----14  16-----19
- * builtin/blame.c:                        12-13
+ * blame.c:                                     14
+ * builtin/blame.c:                        12---14
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
=2D-
2.28.0

