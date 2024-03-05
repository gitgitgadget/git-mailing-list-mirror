Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B43C2D6
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675079; cv=none; b=sw0ju/FC3NORzHeDpnEHLU+Iw7aD/TGa6aBHxvnj+H1W6QISKKBX2Duj71Rx+VNfUhG4T6ez7OM5GsX0JjfkhO406HllxgMqmJGb9aylHnUwwrl0z6yIyrxbotkeKEjB6dy1qIp6HR5z4V2g5W5Rs+H/JOLVytaq2ZxMvyrLKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675079; c=relaxed/simple;
	bh=OMQt3zMiqkk9caLrHkY2HiO37L+3QNKAF9hs8UKtSF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bmf5idGF7I+jegRlOaIF1/q3wAhZKbjRfKvGHqM4TUUu2D2zfjJ2wVr1X2tmsVJ9+6dnbfUPgJXM+L8oba+tZYrygSCSckydddvHQjIHUcvXsyaQ4Z0zVf4SFQgHNfq1jmOWTkUJZ34KcSBZcfGMxFlxrUG4wgNEGnncqscqglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e9fv49rC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e9fv49rC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 106091DC04A;
	Tue,  5 Mar 2024 16:44:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OMQt3zMiqkk9caLrHkY2HiO37L+3QNKAF9hs8U
	KtSF0=; b=e9fv49rCVCWtmzL/UjibI/zJzrj/SNMzGJ/UO4SIxTApqLbccUKy0S
	VeTCy9PWUcJTrI3vt6nws3n6PJMLsU8A+8dcQGVg1v8Ynn5rMuqeux5qnhspolYH
	a0v5/iV/ZzabuILOc2ctrzQ+Dazumtxf7BRC4n5gVGikVwzDku/IU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 084701DC049;
	Tue,  5 Mar 2024 16:44:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 509391DC048;
	Tue,  5 Mar 2024 16:44:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] fuzz: link fuzz programs with `make all` on Linux
In-Reply-To: <eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 5 Mar 2024 13:12:00 -0800")
References: <cover.1709673020.git.steadmon@google.com>
	<eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
Date: Tue, 05 Mar 2024 13:44:33 -0800
Message-ID: <xmqqplw8z73y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8E620B72-DB39-11EE-BDF9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Since 5e47215080 (fuzz: add basic fuzz testing target., 2018-10-12), we
> have compiled object files for the fuzz tests as part of the default
> 'make all' target. This helps prevent bit-rot in lesser-used parts of
> the codebase, by making sure that incompatible changes are caught at
> build time.
>
> However, since we never linked the fuzzer executables, this did not
> protect us from link-time errors. As of 8b9a42bf48 (fuzz: fix fuzz test
> build rules, 2024-01-19), it's now possible to link the fuzzer
> executables without using a fuzzing engine and a variety of
> compiler-specific (and compiler-version-specific) flags, at least on
> Linux. So let's add a platform-specific option in config.mak.uname to
> link the executables as part of the default `make all` target.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Makefile         | 14 +++++++++++---
>  config.mak.uname |  1 +
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4e255c81f2..f74e96d7c2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -409,6 +409,9 @@ include shared.mak
>  # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
>  # that implements the `fsm_os_settings__*()` routines.
>  #
> +# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
> +# programs in oss-fuzz/.
> +#
>  # === Optional library: libintl ===
>  #
>  # Define NO_GETTEXT if you don't want Git output to be translated.
> @@ -763,9 +766,6 @@ FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
>  .PHONY: fuzz-objs
>  fuzz-objs: $(FUZZ_OBJS)
>  
> -# Always build fuzz objects even if not testing, to prevent bit-rot.
> -all:: $(FUZZ_OBJS)
> -
>  FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
>  
>  # Empty...
> @@ -2368,6 +2368,14 @@ ifndef NO_TCLTK
>  endif
>  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
>  
> +# Build fuzz programs if possible, or at least compile the object files; even
> +# without the necessary fuzzing support, this prevents bit-rot.
> +ifdef LINK_FUZZ_PROGRAMS
> +all:: $(FUZZ_PROGRAMS)
> +else
> +all:: $(FUZZ_OBJS)
> +endif

It would have been easier on the eyes if we had the fuzz things
together, perhaps like this simplified version?  We build FUZZ_OBJS
either way, and when the LINK_FUZZ_PROGRAMS is requested, we follow
the fuzz-all recipe, too.

diff --git c/Makefile w/Makefile
index 4e255c81f2..46e457a7a8 100644
--- c/Makefile
+++ w/Makefile
@@ -409,6 +409,9 @@ include shared.mak
 # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
 # that implements the `fsm_os_settings__*()` routines.
 #
+# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
+# programs in oss-fuzz/.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -766,6 +769,12 @@ fuzz-objs: $(FUZZ_OBJS)
 # Always build fuzz objects even if not testing, to prevent bit-rot.
 all:: $(FUZZ_OBJS)
 
+# Build fuzz programs, even without the necessary fuzzing support,
+# this prevents bit-rot.
+ifdef LINK_FUZZ_PROGRAMS
+all:: fuzz-all
+endif
+
 FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
 
 # Empty...
