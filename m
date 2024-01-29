Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585213C463
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565982; cv=none; b=Bqdcqa8DNHgAJhO+KXx4RBgLowDmQB73U/SYDFOyYNNMB1mIlmmCIawJTQQoioFZyUrInhjZ+aKPhQgK5Zo4oFwaNHE2X8B+Hf9PfqP7AhhOZg8lK756+rnfL6lkw7eiSJetYxQfcyGxTiohzK/m6o47PJ+7my9wqYJf3wT5oIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565982; c=relaxed/simple;
	bh=3uyibJAkf32mPuZCu24SFM0FjHoJYfxoB5fvpTQRkQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhZfHvkQ56URRy9T5tP+Cz5Nhgb9I2G+LUMw19LcXDBf/N3noKeUVi567GY4sO/S0QDRAZdscCHOjGgElRiWTPD1cI2ZoLA7KoV7qh3NHmuZQGPynW7VvlTGgujALSbgfyx9WLi+0csaNat1ZmzHyWl0jt/2OTzBRgs56ajNP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TCEHF1LL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TCEHF1LL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 842162279C;
	Mon, 29 Jan 2024 17:06:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3uyibJAkf32m
	PuZCu24SFM0FjHoJYfxoB5fvpTQRkQk=; b=TCEHF1LLkHqB0nRP3ex/HKRLJq1V
	T2OyqVKAOa0p5uhNS6yRt0Qo2xM/GRjG95qNShEY9+gZzNQeKZM+NOI9VIcphies
	yLminW97s+7OsbB0gSoSbps83ZL6zr05TE033UsK0QlxGrpQpmCHQR80XzFAMMKz
	SS6q4A36mpcQPeo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C8072279B;
	Mon, 29 Jan 2024 17:06:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11C1F2279A;
	Mon, 29 Jan 2024 17:06:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] Makefile: use order-only prereq for UNIT_TEST_BIN
In-Reply-To: <20240129202201.GA9612@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Mon, 29 Jan 2024 21:22:01 +0100")
References: <20240129031540.GA2433764@coredump.intra.peff.net>
	<20240129031816.GA2433899@coredump.intra.peff.net>
	<20240129202201.GA9612@szeder.dev>
Date: Mon, 29 Jan 2024 14:06:15 -0800
Message-ID: <xmqqjznrhk14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A001ED7E-BEF2-11EE-836F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> A third alternative is to use $(call mkdir_p_parent_template) in the
> recipe and get rid of the thus unnecessary UNIT_TEST_BIN dependency
> and target.

Yeah, that sounds like a good approach in this case.

> On a related note, 'make clean' doesn't remove this 't/unit-tests/bin'
> directory.

Not a new problem, but I did notice this, too.

Thanks.

 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git c/Makefile w/Makefile
index 958f4cd0bf..7f035a1c9f 100644
--- c/Makefile
+++ w/Makefile
@@ -3676,7 +3676,7 @@ cocciclean:
 	$(RM) contrib/coccinelle/*.cocci.patch
=20
 clean: profile-clean coverage-clean cocciclean
-	$(RM) -r .build
+	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3863,10 +3863,8 @@ $(FUZZ_PROGRAMS): all
=20
 fuzz-all: $(FUZZ_PROGRAMS)
=20
-$(UNIT_TEST_BIN):
-	@mkdir -p $(UNIT_TEST_BIN)
-
-$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TE=
ST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS | $(UNIT_TEST_BIN)
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TE=
ST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
=20
