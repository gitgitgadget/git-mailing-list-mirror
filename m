Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C936B
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725667768; cv=none; b=j2Posb44cjKlMsAB1hJL2YCLaJ2VNouB0mAPzjpqaOAP6BYQweTm02i/Sd7l7n/eqhlXj9ScLEhx8I4OxfPZ/E3yzQj9PSEQhtiVwEJZ12RaA2cB8nyjH4cVEQaCIoPn2OKlzD8QH0U3Z2z/Z+eysr+SSJ4a2aEsZ79VSOkh0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725667768; c=relaxed/simple;
	bh=Cera1sGCZFn7AyAaQ4AG5H2mETQ2Vwg+WUNXV3BpDec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YvzqYEVj2cGb1p4ED37/drB1vTD4qjluMSHHjJ8VvIxC67BixFSsrrzZMUj0NsdIRfQN2yClTZXdSNoChugutqdC4rrUhm4iYU95bKtvRB1sniCeWuAJ1qCGz5zjn9VAfjUQNm+SD/YTrDuRGvase6YWpeGru5KD6jt1C6gj0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DEYA8PEW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DEYA8PEW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D364F3BF9F;
	Fri,  6 Sep 2024 20:09:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Cera1sGCZFn7AyAaQ4AG5H2mETQ2Vwg+WUNXV3
	BpDec=; b=DEYA8PEWpSNmLKld0rydcSmwUM35ZzHDOvGau08kKbsmk09kNyPdTZ
	Bh7+S4gZB4UpP62PE4tQrzTaIH5qGUxx9resicWYBtf7SYpBGG8BWE0z82sE0TUR
	+TL9lRvT14k6ZaRF16lutOPkxAsCHrq6TQWkbBCSuhNx8ldD4mg58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9F7E3BF9E;
	Fri,  6 Sep 2024 20:09:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F8683BF9D;
	Fri,  6 Sep 2024 20:09:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net,  Jason@zx2c4.com,
  dsimic@manjaro.org
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
In-Reply-To: <20240906222116.270196-5-calvinwan@google.com> (Calvin Wan's
	message of "Fri, 6 Sep 2024 22:21:15 +0000")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-5-calvinwan@google.com>
Date: Fri, 06 Sep 2024 17:09:24 -0700
Message-ID: <xmqqv7z8tjd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 710073A6-6CAD-11EF-919F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> index 65d1620d28..07d6bfdd84 100644
> --- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> +++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> @@ -33,6 +33,36 @@ int libgit_parse_maybe_bool(const char *val)
>  	return git_parse_maybe_bool(val);
>  }
>  
> +struct libgit_config_set *libgit_configset_alloc(void)
> +{
> +	return git_configset_alloc();
> +}

git_configset_alloc() returns "struct config_set *" while this thing
returns an incompatible pointer.  

Sent out an outdated version or something?  This wouldn't have
passed even a compile test, I suspect.



$ make contrib/libgit-rs/libgit-sys/public_symbol_export.o
    CC contrib/libgit-rs/libgit-sys/public_symbol_export.o
contrib/libgit-rs/libgit-sys/public_symbol_export.c: In function 'libgit_configset_alloc':
contrib/libgit-rs/libgit-sys/public_symbol_export.c:38:16: error: returning 'struct config_set *' from a function with incompatible return type 'struct libgit_config_set *' [-Werror=incompatible-pointer-types]
   38 |         return git_configset_alloc();
      |                ^~~~~~~~~~~~~~~~~~~~~
contrib/libgit-rs/libgit-sys/public_symbol_export.c: In function 'libgit_configset_clear_and_free':
contrib/libgit-rs/libgit-sys/public_symbol_export.c:43:38: error: passing argument 1 of 'git_configset_clear_and_free' from incompatible pointer type [-Werror=incompatible-pointer-types]
   43 |         git_configset_clear_and_free(cs);
      |                                      ^~
      |                                      |
      |                                      struct libgit_config_set *
In file included from contrib/libgit-rs/libgit-sys/public_symbol_export.c:8:
./config.h:543:54: note: expected 'struct config_set *' but argument is of type 'struct libgit_config_set *'
  543 | void git_configset_clear_and_free(struct config_set *cs);
      |                                   ~~~~~~~~~~~~~~~~~~~^~
contrib/libgit-rs/libgit-sys/public_symbol_export.c: In function 'libgit_configset_init':
contrib/libgit-rs/libgit-sys/public_symbol_export.c:48:28: error: passing argument 1 of 'git_configset_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
   48 |         git_configset_init(cs);
      |                            ^~
      |                            |
      |                            struct libgit_config_set *
./config.h:495:44: note: expected 'struct config_set *' but argument is of type 'struct libgit_config_set *'
  495 | void git_configset_init(struct config_set *cs);
      |                         ~~~~~~~~~~~~~~~~~~~^~
contrib/libgit-rs/libgit-sys/public_symbol_export.c: In function 'libgit_configset_add_file':
contrib/libgit-rs/libgit-sys/public_symbol_export.c:53:39: error: passing argument 1 of 'git_configset_add_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
   53 |         return git_configset_add_file(cs, filename);
      |                                       ^~
      |                                       |
      |                                       struct libgit_config_set *
./config.h:504:47: note: expected 'struct config_set *' but argument is of type 'struct libgit_config_set *'
  504 | int git_configset_add_file(struct config_set *cs, const char *filename);
      |                            ~~~~~~~~~~~~~~~~~~~^~
contrib/libgit-rs/libgit-sys/public_symbol_export.c: In function 'libgit_configset_get_int':
contrib/libgit-rs/libgit-sys/public_symbol_export.c:58:38: error: passing argument 1 of 'git_configset_get_int' from incompatible pointer type [-Werror=incompatible-pointer-types]
   58 |         return git_configset_get_int(cs, key, dest);
      |                                      ^~
      |                                      |
      |                                      struct libgit_config_set *
./config.h:568:46: note: expected 'struct config_set *' but argument is of type 'struct libgit_config_set *'
  568 | int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
      |                           ~~~~~~~~~~~~~~~~~~~^~
contrib/libgit-rs/libgit-sys/public_symbol_export.c: In function 'libgit_configset_get_string':
contrib/libgit-rs/libgit-sys/public_symbol_export.c:63:41: error: passing argument 1 of 'git_configset_get_string' from incompatible pointer type [-Werror=incompatible-pointer-types]
   63 |         return git_configset_get_string(cs, key, dest);
      |                                         ^~
      |                                         |
      |                                         struct libgit_config_set *
./config.h:567:49: note: expected 'struct config_set *' but argument is of type 'struct libgit_config_set *'
  567 | int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
      |                              ~~~~~~~~~~~~~~~~~~~^~
cc1: all warnings being treated as errors
gmake: *** [Makefile:2802: contrib/libgit-rs/libgit-sys/public_symbol_export.o] Error 1
