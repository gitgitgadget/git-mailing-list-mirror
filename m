Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E13FC7
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711192046; cv=none; b=o3oAcVQwXLYf4J1cqmnN+u2E08St7/JuYKdXBJK5vcV8BPaT/znsteWTEYpb1WGIt5JjDWU6FxrLjcwp47ss1oUaCZZiGTkn4gyyVLFpNxwaSBNdkR1WBAnYADS1tpsf4JQ8xf/GsSJFSmkiW8K2Nlr984T1Rq6xCDPGv75MPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711192046; c=relaxed/simple;
	bh=v+NbIWDlQtBhoav1T8KWqQk480MFJXzJmBCMdjmY6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsxliNeLv+9Y1xbX50pljZnlFYxHd0D4wEcMHV6r360sWm8NgYv1LFXXcbafykSI+R74KsnQet6y72Diump+ejXpukQLosP8+rYJT6u22xKyv2CgwlVndS2R9EcSiqLkqMBzezmVQoo+cXvfid/pcixL4hMVVn9aOWZ16ocEcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=NpuFKDtL; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="NpuFKDtL"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 0C50A6038B;
	Sat, 23 Mar 2024 12:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711192042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjxpZp0CXCdlqL9xWU2w6WlvGqJo+ct+GQW0MELDiXE=;
	b=NpuFKDtLW4dm/AL2q3MGZaRGvLwpfVscH6jzWR0a6qLKXbtHoxNE2npBtd8GzmCOyU5eKK
	q49QjIYqkHFNstltyBIivlmhFqZ35VeqkF/P9c395nAKunLEpNs/5v50AS97ULsObPHqEH
	BWtAGb/JszJzbL3gJ2Thu0ExgFP5YPtgZIxZoV5j5ihhLpzrbRQ9oVdckobL6xePRXeiMC
	+ztCpJg6KNTyXwqs091OKPJJ441xG3Rrd2TsQnz995P9eF6ebVv4fgqTFI71Y41UYGbLQb
	l2+o1k6ue07v7K2SXSbrSnY0QX7Feli1cqvidUv3djkeNpEorMu7EzN+jEOzgg==
Date: Sat, 23 Mar 2024 12:07:21 +0100
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
Message-ID: <Zf636bsHs9woXRAS@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-5-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322221327.12204-5-mg@max.gautier.name>

On Fri, Mar 22, 2024 at 11:11:09PM +0100, Max Gautier wrote:
>  
> +/*
> + * TODO: in the future (~2026 ?) remove this cleanup code
> + */
> +static void systemd_delete_user_unit(char const *unit)
> +{
> +	char const	file_start_stale[] =	"# This file was created and is"
> +						" maintained by Git.";
> +	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
> +
> +	char *filename = xdg_config_home_for("systemd/user", unit);
> +	int handle = open(filename, O_RDONLY);
> +
> +	/*
> +	 * Check this is actually our file and we're not removing a legitimate
> +	 * user override.
> +	 */
> +	if (handle == -1 && !is_missing_file_error(errno))
> +		warning(_("failed to delete '%s'"), filename);
> +	else {
> +		read(handle, file_start_user, sizeof(file_start_stale) - 1);

Actually that fails -Werror because I don't check read return.
Alternative below (on top of this one), with one question:
Are VLA using size_t const OK ? It's folded to a constant array by gcc
but I don't know if that causes portability problem with other platforms
? I can always repeat the sizeof expr if it's a problematic construct.

-- >8 --

diff --git a/builtin/gc.c b/builtin/gc.c
index 99b158e481..7fb25ea2b1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2332,11 +2332,14 @@ static int systemd_set_units_state(int enable)
 /*
  * TODO: in the future (~2026 ?) remove this cleanup code
  */
+
 static void systemd_delete_user_unit(char const *unit)
 {
 	char const	file_start_stale[] =	"# This file was created and is"
 						" maintained by Git.";
-	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
+	size_t const	length = sizeof(file_start_stale);
+	char		file_start_user[length] = {'\0'};
+
 
 	char *filename = xdg_config_home_for("systemd/user", unit);
 	int handle = open(filename, O_RDONLY);
@@ -2348,14 +2351,14 @@ static void systemd_delete_user_unit(char const *unit)
 	if (handle == -1 && !is_missing_file_error(errno))
 		warning(_("failed to delete '%s'"), filename);
 	else {
-		read(handle, file_start_user, sizeof(file_start_stale) - 1);
-		close(handle);
-		if (strcmp(file_start_stale, file_start_user) == 0) {
+		if (length - 1 == read(handle, file_start_user, length - 1) &&
+				strcmp(file_start_stale, file_start_user) == 0) {
 			if (unlink(filename) == 0)
 				warning(_("deleted stale unit file '%s'"), filename);
 			else if (!is_missing_file_error(errno))
 				warning(_("failed to delete '%s'"), filename);
 		}
+		close(handle);
 	}
 
 	free(filename);

-- 
Max Gautier
