Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F216BE0D
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540001; cv=none; b=Q/VrVgb9XWtHmxEQZbqDRl+QUQNyS/5clyB967opJE2DZXiNWiMa+sdvQmaQ/6x7a/2M8y79F/3UraXOxlHcJhg78UZ6pg1waINns5QofpOE5rRdnQSmmMHFuAklkW2W/5KxtAS+J/9RUgY+Zwqe7ao8NOFeGyJI7ijDloRqBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540001; c=relaxed/simple;
	bh=PXFtO/+eGpcSbvbxIoqsA2mbAtaTOd+Fi2MACJpCBsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6USjTf+g5+vsXw6RH0h2diZ/tSoaZ3QvMT6GJ+CMO2wgmLGi6uzdbBNX8lNiSiE32zn4h6B4E8t5yOZev5AIvBA4EQm9m4chJfbp2hlt9A9D0CjkbkmFvzrFhxB9M2kfmRMkQasbvYHZcPVJYEOcXley9B/kpmmVMA33aO728Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=LfQ7GKQL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="LfQ7GKQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723539992; x=1724144792;
	i=oswald.buddenhagen@gmx.de;
	bh=jJCqv4oyIjZRb+dc9YQR3YcusUNb2d+XXXGNkIg1Ums=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LfQ7GKQLJjLL57uurNxIX8sh1xp9hHLi/LiaDjcYoIYnDH4kGalQAFtHH5l9Gz/U
	 roDLvcIHuvw4xodZLV4vZ55/NIKlhUU2ufDvYFDeGKWDTNMEMr/e4mrOuju1a1HxZ
	 KcOkSNOiXOXmqZ1JbaelK4EpgkW+UNeqPp2r/TPT9iM0IFBLpxPajje0ZWobaSz/Y
	 wNpOJXggdgpNmzWnRzAynyyDPqA99/ZSPQxE+Ilm7wUaS2bDyIvTpIgCmal12QvYe
	 I/CK2hNFn/fD4aiNianbcfzgY+1Me4VKAFX0JNT7EOwS6Gij/G2A9LUfP67jypHFS
	 fVZ07nyvvXuAqeh8kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1s054w3jWr-00gbnN; Tue, 13
 Aug 2024 11:06:31 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1sdnU7-klA-00; Tue, 13 Aug 2024 11:06:31 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Brian Lyles <brianmlyles@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sean Allred <allred.sean@gmail.com>
Subject: [PATCH 0/2] Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
Date: Tue, 13 Aug 2024 11:06:29 +0200
Message-ID: <20240813090631.1133049-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.46.0.180.gb23db42a00
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C/rLlxTUp47RIhYVYoFO+z/0qcvpUzNlAc8FKmLEHTDXgZ4K6yW
 bBsip4rWoybvzv1DpuGQfzmupWd82HUpQm1GkPyy6hCBaPO84yrmjwfpy3Qsrx0M8QypNYS
 A4VL/ZVDcei5h+0y51H4DM9ycJHnr6SMBAeNtfvSWZHO/isBukHeEST0q8dgTl1NzpDlHcL
 oAbwnEI6Cla6J/mOSB3sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EqFx/W2rl0Y=;QgB3EnIGab49H2N40x5ZMwMjPKs
 WB6iRbn+9S1OsfLmVA04lHzwns5v8E98zkvboKhAZXAstBeW1WRF48d/wrMmb8ACiDQB1EQZJ
 j3G3u89a2bXspyXoSINAwUA318q1gauWjIQcv9ks8JmG3FwcSPO8ItLd/HlfN8aVkRqkNTPkJ
 pKLLSZ0jWzp1wiUTbRmwC6ALFOsvOT70jkO75I17+TNFMOx1FT+BhDiR7Q3VgeWsEx+NNxRfM
 uRJLuddx/nR52UKzsohzj66nwDGY4WlCt/g8g9jzW+0stQUhk08/cvaAi6JppeLQZOw66iEWU
 uOtFPCjBwAiCTc1Plf2N+H17qTy0eq0kvEf6h0jo5QvoMCoeF4RFI2s7LuqniZjXidBrOD/Xx
 Z1dQ/QxZLELVhfwoQjeXrPUvzEIEqyEugKc3Bx4odDESqPxakszjHUAzv3BrZIT6NSYj56Q8x
 ygZjm1mqi+vmwan5uYgzbT8WtiN2Ixwes6wHwDumfjBQiQ8d9nhFKZFdyPly/G8g1lQq0qsaQ
 uALtw3yzhONZWW+iu54kczmSyYuQXu27fQxZg1ez10gVGAXVA01FyViOjHarDqSV3fTl7Ibjl
 rOowSfhEspQKbPwmL/zI9/UB7Esi9gfrZxdvpsOoYKtBdOkbIG+TP9FuVBm5cKkvZW/JndiRM
 erYvnVVI95wNfZij7IjuLuud8GYSoKNINFCTuwWGLzWrk66R5noNwO9SG41SCsl4tvFbDG3I+
 btUGp16JX0GnMm2ZUOSKbkifQx+lLLm6u+Wj8fSPvkxMSV23kvdvReA3CSZ0BBalIP6SFSi0k
 Y1FOQ0B1ZVut/YsA6Os3TTjcETDRw018nMcf+IUCoeRLo=

> >> So it still seems like we have two real options:
> >>
> >> - Start washing the message, allowing the prepare-commit-msg hook to
> >>   provide template-like guidance to the user regardless of if they are
> >>   using git-gui or some other editor, or
> >> - Pass the "message" argument along to the prepare-commit-msg hook so
> >>   that it can at least avoid adding template-like content (but of cour=
se
> >>   then lose the value added by that template).
> >
> i'm strongly in favor of the first option.
> it also seems to be the much easier one to implement.
>
so i thought i'd just give it a shot ...

fwiw, it's debatable whether it (stil) makes sense that git-gui reimplements
git-commit - maybe it should just call it. then the patch would boil down to
adding --cleanup=3Dstrip to the command line.

---

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Brian Lyles <brianmlyles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sean Allred <allred.sean@gmail.com>

Oswald Buddenhagen (2):
  git-gui: strip comments and consecutive empty lines from commit
    messages
  git-gui: strip commit messages less aggressively

 git-gui/lib/commit.tcl | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--=20
2.46.0.180.gb23db42a00

