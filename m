Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9515250D
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076636; cv=none; b=IX1HnFbZZnnSVn4IAijtDKemb7QUyw7hAQ9pa/5CUR6ETMrRrGlschXm3k6h/3sTuHaptSOFeXruLngFvru+VUXXawKGm1/jbbuXWMhVugWfcLv1tskrtCtQjjNBQNeUt/kblelp6sU+kXrDL/6xx6NTuPezaYxmH7A4M4wlvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076636; c=relaxed/simple;
	bh=wq6mpeaPYWR35EVS+BV7kT5RBEC3j43DKbK4fWrTPXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oueiwYXu7Dm37JNAUlRcxlSk0EA4T5YnHd55Zn40QpRCX42yOmsE2SEtW6YV3lUhj+IVqKZvnLwY7WjgbzCJDPsW8MRJ5jjMEuMjM1v1oX6wSbylp5LtPOQgPro2q0vWRrYTSlYb2loSorwdvn8BMaNSA569lhsNUfvOfAbjox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sio1jGgE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sio1jGgE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF4333E91A;
	Thu, 25 Apr 2024 16:23:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wq6mpeaPYWR35EVS+BV7kT5RBEC3j43DKbK4fW
	rTPXs=; b=Sio1jGgEVuC9TS4SHGvi7Sy0WdL+Q7oSEOgD8XSJZviRUfd8h7poqN
	CJuLFzBxwqJgV0X4ABqiWiXTKnAMoX3QVodAtsDd6XFSFF3WH7Za6uspPMCuO2W2
	1sIxZFo14VFFx7DrIeL2Ub3TTQd8njTnYRGI2OGUY6LkQA9pt+zTc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A667C3E919;
	Thu, 25 Apr 2024 16:23:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE8753E918;
	Thu, 25 Apr 2024 16:23:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 24 Apr 2024 22:15:25 -0400")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<20240425014432.GA1768914@coredump.intra.peff.net>
	<CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
Date: Thu, 25 Apr 2024 13:23:48 -0700
Message-ID: <xmqqedatfay3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9FDC174-0341-11EF-9465-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> That's very reminiscent of [1]. Although, unlike [1], the output
> presented to the user in this case is (I suppose) less likely to be
> messed up; only the combined captured output is probably affected. So,
> capturing stdout and stderr separately would indeed be a good idea.

Hmph, something along this line?

It loses to capture how the output should be intermixed, which is
essential to validate what the end-user should see.  As we can see
in the attached patch, we cannot express that "Unknown ..." should
come in between two "Stage addition?" questions, which is a downside.

Between adding fflush() before err() writes, and updating err() to
write to the standard output stream, I am in favor of the latter for
its simplicity (of the mental model of the resulting code, not of
the patch that is required to do so).

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ed7e414649..a8dfebd8d7 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -64,11 +64,12 @@ test_expect_success 'unknown command' '
 	git add -N command &&
 	git diff command >expect &&
 	cat >>expect <<-EOF &&
-	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
-	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
 	EOF
-	git add -p -- command <command >actual 2>&1 &&
-	test_cmp expect actual
+	echo "Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)" >expect.error &&
+	git add -p -- command <command >actual 2>actual.error &&
+	test_cmp expect actual &&
+	test_cmp expect.error actual.error
 '
 
 test_expect_success 'setup (initial)' '
