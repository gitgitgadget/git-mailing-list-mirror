Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254A2E3FE
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425538; cv=none; b=YSj9+SsQn03PX0FoI/jE8nrV+M86qabVu7fgILUsDsfXFAd+ZXNRzF+4cuiftnJ4C2OBrHpRlr2wSU7qiPrsmAbxVnEfKLQ/jUWyPVSKoqNRJy7wN0tzIEAuZSGyd7FQceDCHkvcbaSbTY4YtoSA7bvdKkc9pRb7Z9WW7GgGGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425538; c=relaxed/simple;
	bh=GG1de4VUKGUNxKMMGGVZgxJuwWPeDyodrvckK25TkF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b36W6/0jijMhPIxDVvfzBcOT6/sowORWFRu2lnbOCrsf7aXCCeYe3LQHExSIfjlCMWGKiOLFFPmELASrOp/qmLBAFkMa1/nVQFRcuB6c9VsDrp0uzdN3GvbdVIthCJtjgliVQDfoWATkwakobSQhH0ygK9mOX/V+KquFpcDj2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BbW/+jrM; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BbW/+jrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712425518; x=1713030318; i=l.s.r@web.de;
	bh=HDEd3EQ4aW4JJprxYVRpb0Nz9xxWW5XRzt+tfC7dbfQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=BbW/+jrMm3uX1n+wBDTnxuV2Pt3p0T5EEzYa+MUUJmfBdHZr88catI3CEUm5tYY8
	 +PGjJjoUZ1EIV1rYLv7JeStuJe1Bzbl4BWgYy2tAyryATQg4NniWjike82d64yvfe
	 +KwZqjDOfXkc0ex5XEcjCT5r+ZplWNCQ1iT0GbIXcB09qfaPexCn/HFiDxSF+qRMt
	 Bdu3kXQom1zlDuKo+0GF6wa8sHptNaoGKj7ke6oVmz5/wEwJewarJLAHLsdFTNuue
	 11iZK7miU7xHmOCGH/JhHmibVcV88erNNTdebJESkW/ItstfUzUMyur8tXzUOlwwW
	 8se7lWgctnI4M8+VQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4bYy-1ruoWm0eUY-001yoy; Sat, 06
 Apr 2024 19:45:18 +0200
Message-ID: <0fc77134-94fb-4d60-95b4-509c3582e20f@web.de>
Date: Sat, 6 Apr 2024 19:45:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
 <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
 <20240405173517.GA2529133@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240405173517.GA2529133@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jSZqnuuddncZjHQSqEk/qLAhhcMiQlIZWdfpi6S8DyrbQxuIP0M
 9/U8XRvqP/mL1wS31AF33q+0+HdXVEjeV92YMLhXZ3vHSh27PYoh9x3CqOxl5hG1rDTr2Dx
 Fy51J2MGPfWzC/6lGDMKVyRKCTsNm5VOelcsB+RzjAVNbiQIg1XCrXtzhcNXZD0IZTfheN4
 00f136/3Qq0+z733Zi1Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jFF9D4kBAmo=;SR6fppgjRN4cxz+ad7dRfbL05lb
 kXHxEtFvQQ/lz4wEBzawq9AoAv2JNfAOZkkMMQCe9ImQA49JR3sCHj7cwANrBvJjMv/noMsRH
 nnazsGGk+4q6g7EdPXUB20hrulFpxTmma4AAibuxo/+ryxW/4jhl/yfZT/Rj3a4+R83JrmwlH
 0H0W+xVnIFfzMnhbdY1kvJxuqZCrkbm0TxBZbT2hX4b0edI1MTh0BxChNq/qGkn8irXG4NLvC
 Lw/F1waz+UM+vyqZA0dn0aBGkLizDKGcw/4QAvd91uPGHlJdRb1KF7krpaRan/z7nhngd2THc
 Sz0Gp0F8JRPJRUcQWQrHS1AVqiiYWkDipOGSQyQzzOS1AaJaeQ8U0GW4dmIdo0z0JxmfCFrjS
 xBN8mi7X4s1zGMzWcxJCjCIDFkIidHZVlkTiuPwJQnasTfQW0a2Eo0qh6IJKfXOmfT63AUbMm
 odpKhLR7CEkNdSTHduQKVOK05JkiAteCChCALBQuAAvLcw/6VpEfVtvzVM+7bc3gKP/MnjcXr
 8MGYQxCGXPzJPVK78JzLwpwctHCfWA0L6lC6EAVkO5Bn843otke+0Ml9qynHW6o4sOJ3ej+tv
 6hpBfoJJgCgI/5N1lthVnNNu2F3Jt5TGK5m00B/kCqJajSOVNZzYJJ2XktKb+4MBkOstClOa/
 4O6oWMQZvFW+lKu73BU5iIPR83QOkmNV/8g4xgnDXsQCyXDhbTa+RHaWyJw+qWRMZ8LqZ+zMs
 Zagu0VJ6EJqPbrGiBLS8cZUBMKNqOxpjh7isg1/s3aY8zvcGiLuIbAH0NkX1W/WFANXJlI5pX
 XkwtV80A4CaT66Tow1PZvLWjv7UOYpOFA42u43xG7j6gY=

Am 05.04.24 um 19:35 schrieb Jeff King:
> On Fri, Apr 05, 2024 at 12:52:35PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> So would it be that unreasonable to assume the modern, desired behavio=
r,
>>> and mostly shrug our shoulders for other platforms? We could even
>>> provide:
>>>
>>>   #ifdef FREE_CLOBBERS_ERRNO
>>>   void git_free(void *ptr)
>>>   {
>>>         int saved_errno =3D errno;
>>>         free(ptr);
>>>         errno =3D saved_errno;
>>>   }
>>>   #define free(ptr) git_free(ptr)
>>>   #endif
>>>
>>> if we really wanted to be careful, though it's hard to know which
>>> platforms even need it (and again, it's so rare to come up in practice
>>> that I'd suspect people could go for a long time before realizing thei=
r
>>> platform was a problem). I guess the flip side is that we could use th=
e
>>> function above by default, and disable it selectively (the advantage o=
f
>>> disabling it being that it's slightly more efficient; maybe that's not
>>> even measurable?).
>>
>> I think performing this ritual automatically every time on all platform=
s
>> (i.e. to use git_free() unconditionally) to provide sane errno values
>> around free(3) calls is better than having to worry about attacks from
>> the deep.  But then again I'm easily scared and still a bit in shock, s=
o
>> perhaps I'm overreacting.

I calmed down a bit now.  And ask myself how widespread the issue actually
is.  Used the following silly Coccinelle rule to find functions that use
errno after a free(3) call:

@@
@@
- free(...);
  ...
  errno

Found only a handful of places, and they all set errno explicitly, so
they are fine.

No idea how to match any use of errno except assignment.  And no idea how
to find indirect callers of free(3) that use errno with no potential
assignment in between.

> You may be right. The main reason not to do it is the extra assignments
> (and call to errno, which I think can be a function hidden behind a
> macro these days). But I kind of doubt it is measurable, and we expect
> malloc/free to be a bit heavyweight (compared to regular instructions)
> anyway. So it is probably me being overly cautious about the performance
> side.
>
> The other reason is that macros (especially of system names) can create
> their own headaches.  We could require xfree() everywhere as a
> complement to xmalloc (or maybe even just places where the errno
> preservation seems useful), but that's one more thing to remember.

An xfree() to go along with xmalloc()/xrealloc()/xcalloc()/xstrdup() would
fit in nicely and might be easier to remember than free() after a while.
Having to convert thousands of calls is unappealing, though.

> With the patch below you can see both in action:
>
>   - hyperfine seems to show the git_free() version as ~1% slower to run
>     "git log" (which I picked as something that probably does a
>     reasonable number of mallocs). Frankly, I'm still suspicious that it
>     could have such an impact. Maybe inlining git_free() would help?

I get a slowdown of ca. 0.5%:

Benchmark 1: ./git_2.44.0 log v2.44.0
  Time (mean =C2=B1 =CF=83):     705.8 ms =C2=B1   1.7 ms    [User: 674.0 =
ms, System: 28.3 ms]
  Range (min =E2=80=A6 max):   702.3 ms =E2=80=A6 709.2 ms    10 runs

Benchmark 2: ./git log v2.44.0
  Time (mean =C2=B1 =CF=83):     708.1 ms =C2=B1   2.0 ms    [User: 676.4 =
ms, System: 28.7 ms]
  Range (min =E2=80=A6 max):   705.0 ms =E2=80=A6 710.9 ms    10 runs

Hmm.

What if we do the opposite and poison errno in git_free() instead of
carrying over the original value?  That's only half the work.

Benchmark 1: ./git_2.44.0 log v2.44.0
  Time (mean =C2=B1 =CF=83):     704.2 ms =C2=B1   1.3 ms    [User: 674.2 =
ms, System: 27.6 ms]
  Range (min =E2=80=A6 max):   702.2 ms =E2=80=A6 705.8 ms    10 runs

Benchmark 2: ./git log v2.44.0
  Time (mean =C2=B1 =CF=83):     706.3 ms =C2=B1   0.9 ms    [User: 676.3 =
ms, System: 27.5 ms]
  Range (min =E2=80=A6 max):   704.8 ms =E2=80=A6 708.2 ms    10 runs

So that's slightly better.  But the measurements are quite noisy.

Found four places that did not expect free(3) to mess up their errno by
running the test suite with that.  Patch below.

>   - usually #defining free(ptr) with an argument will avoid confusion
>     with the word "free" as a token. But in this case there's a function
>     pointer which is then called as struct->free(ptr), causing
>     confusion.

In other contexts we use "clear" or "release" to name functions like that.

Ren=C3=A9


 compat/precompose_utf8.c | 2 ++
 git.c                    | 3 +++
 lockfile.c               | 3 +++
 tempfile.c               | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 0bd5c24250..4da80b40ce 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -114,8 +114,10 @@ PREC_DIR *precompose_utf8_opendir(const char *dirname=
)

 	prec_dir->dirp =3D opendir(dirname);
 	if (!prec_dir->dirp) {
+		int save_errno =3D errno;
 		free(prec_dir->dirent_nfc);
 		free(prec_dir);
+		errno =3D save_errno;
 		return NULL;
 	} else {
 		int ret_errno =3D errno;
diff --git a/git.c b/git.c
index 654d615a18..275674f873 100644
=2D-- a/git.c
+++ b/git.c
@@ -773,6 +773,7 @@ static int run_argv(int *argcp, const char ***argv)
 	int done_alias =3D 0;
 	struct string_list cmd_list =3D STRING_LIST_INIT_NODUP;
 	struct string_list_item *seen;
+	int save_errno;

 	while (1) {
 		/*
@@ -853,7 +854,9 @@ static int run_argv(int *argcp, const char ***argv)
 		done_alias =3D 1;
 	}

+	save_errno =3D errno;
 	string_list_clear(&cmd_list, 0);
+	errno =3D save_errno;

 	return done_alias;
 }
diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..b8401f5059 100644
=2D-- a/lockfile.c
+++ b/lockfile.c
@@ -76,6 +76,7 @@ static int lock_file(struct lock_file *lk, const char *p=
ath, int flags,
 		     int mode)
 {
 	struct strbuf filename =3D STRBUF_INIT;
+	int save_errno;

 	strbuf_addstr(&filename, path);
 	if (!(flags & LOCK_NO_DEREF))
@@ -83,7 +84,9 @@ static int lock_file(struct lock_file *lk, const char *p=
ath, int flags,

 	strbuf_addstr(&filename, LOCK_SUFFIX);
 	lk->tempfile =3D create_tempfile_mode(filename.buf, mode);
+	save_errno =3D errno;
 	strbuf_release(&filename);
+	errno =3D save_errno;
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }

diff --git a/tempfile.c b/tempfile.c
index ed88cf8431..029b760fa9 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -144,7 +144,9 @@ struct tempfile *create_tempfile_mode(const char *path=
, int mode)
 		tempfile->fd =3D open(tempfile->filename.buf,
 				    O_RDWR | O_CREAT | O_EXCL, mode);
 	if (tempfile->fd < 0) {
+		int save_errno =3D errno;
 		deactivate_tempfile(tempfile);
+		errno =3D save_errno;
 		return NULL;
 	}
 	activate_tempfile(tempfile);
