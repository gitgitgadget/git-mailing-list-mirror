Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1ED1AACC
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566709; cv=none; b=ULpxXjJ2R5+Pehe888mlxUn++MkiSJmCDsgtZHO1mOT4IDNpqhVR332ryp+oSCqrIudlEyPIUnws7VgoXPNLcqbsdxOoCvCpeVq4/VK3VdUlhjXiopfLdmVw5YVGXUNeEUVmaA5zVlSkVaSLhfRgguhJWm6JC48shDYGYK8CnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566709; c=relaxed/simple;
	bh=QIb6qLnEySQuI2RQq8pzCgjdXRwXS4FdAnvycMvDnng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ufB9AClJJ51XRPB6PJLsP2MQ8WrvdzhD8O+t6ubbUm4fG/VlNgPZShXw7Youwh9W1ZX6GYhzXrHZjPNnUh3/8avR+QAPVX9y/6jS8xvTXdFS6C+RbpSIrfUYc2SXkG8oph3QaiqjIpjWsFABRT9n5DTUi4uerKSDK/1JAFF0NGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cf55FHOf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cf55FHOf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AAB1F25E27;
	Fri, 24 May 2024 12:05:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QIb6qLnEySQuI2RQq8pzCgjdXRwXS4FdAnvycM
	vDnng=; b=cf55FHOfelucDgCSyaL2Ggd0qeTk96H14bLAKRsUfatLf8mJtFTsBU
	/esnTxUaVVUbS6vdnC4uI5uyg1giLrXnIPnsPqYTPS734WFwcWSCHvQQz/pyabEs
	FfjDxigFziCpKCQKpo7fPCO+U6KiXa7CXyL0qY+FvcvSkUTzJrfko=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A2DBE25E26;
	Fri, 24 May 2024 12:05:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B687925E23;
	Fri, 24 May 2024 12:05:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] t: mark a bunch of tests as leak-free
In-Reply-To: <ZlA6KHZtn4lvyFcI@tanuki> (Patrick Steinhardt's message of "Fri,
	24 May 2024 08:56:40 +0200")
References: <cover.1716465556.git.ps@pks.im>
	<0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
	<xmqqwmnktocp.fsf@gitster.g> <ZlA6KHZtn4lvyFcI@tanuki>
Date: Fri, 24 May 2024 09:05:03 -0700
Message-ID: <xmqqh6ennqkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 623648A0-19E7-11EF-9566-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hum. Both of these skip a bunch of tests due to a missing TTY prereq on
> my system. So I guess it's not a regression, just me missing test
> coverage. And seemingly, the same applies to our CI systems because the
> pipeline is green there.
>
> And indeed, the TTY prerequisite fails due a totally unrelated error:
>
>     Can't locate IO/Pty.pm in @INC
>
> I'll fix this locally and in our CI setup.

Do you mean that you'll make IO::Pty available locally and in the CI
setup, which will start revealing the existing leaks in these tests?

So do we expect this step to be adjusted, not to mark these two
tests as leak-free (yet)?

> Ideally, we'd also make this thing more robust going forward, but
> I'll leave that for a future iteraiton.

--- >8 ---
Subject: ci: make IO::Pty available

When t/test-terminal.perl, which requires IO::Pty (and File::Copy,
but that comes standard with perl-modules?), does not work, the
tests with TTY prerequisite are skipped.

Make sure it is available in the CI environment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/ci/install-dependencies.sh w/ci/install-dependencies.sh
index 2e7688ae8b..b24c91a30f 100755
--- c/ci/install-dependencies.sh
+++ w/ci/install-dependencies.sh
@@ -42,7 +42,7 @@ ubuntu-*)
 		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
-		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
+		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl libio-pty-perl \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	mkdir --parents "$CUSTOM_PATH"
