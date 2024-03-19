Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E77EF0F
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850196; cv=none; b=uXpgFrSb7KA6Xif0Qm8L+7oNZrP6yZcyE1P2Vg+EvFNSuMODp+/FAlfZ0KUfC2btaGinFYqTx7dYtTWrMnrlTRuMnNNi57uba4KV4HDkwA51QAb08qV1V8FCM3xKmtbrPmw03k+uwxPcZRHCBaruf8YVNRn7wx4e2XfS/5pGv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850196; c=relaxed/simple;
	bh=KznQKpIy0dBwhitgw7vcDhSfmApzWFHnSta7j/jS6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV06XAsJPjc9KcyW+Sg4I0nOMco2LRM5EJMvPuY0s1KJEzeOhSWU2vRoUkEDWGX7osFvDzIRBLX/EczUE/7NW5uIUX0I/lhJz9VRAvlxdR6TcbbCr0bHDhP3u+Vin9nz+d0yPJ335l1+WdDp7JnyA7oKIHKYCAXA6cYXKMRvCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=IzN/8609; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="IzN/8609"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:8af0:9e6:aa1:70f1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id CABCB60324;
	Tue, 19 Mar 2024 13:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710850174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoDBTpUzqA6j6rKsMEGHDAfqAsy5vECGqMuold8DaQE=;
	b=IzN/86099nAxbt32IJUMZvV7yEfwBJxkprsjtvF/bskuVMK0UN3fdPi6lRKMEGTzvKF33o
	yAI3h9ofb6zUoDirZN2gyDxc/mBq/FF/phIsQfuq0UZgnHIo8fGp+I1Q7M2TEer6a6kQae
	At+gbBhNettg881DiKCeQScjny/kMfBdbXs5gg4xPR3+KmLAc0cVKQ56BVGFGlIZvQSXj/
	2tXrydxMXe8Ga8e4iuT+xyYuepCNMPMwUP9pkMBJ84JUbvd5xUaFZ18hUQiMxYiANgDmnH
	IDYIvFvOs7Tgmyurelg19Ldv1TH1a3kXeoyuEsw0pHoHyYNQFX1143250DpV2Q==
Date: Tue, 19 Mar 2024 13:09:32 +0100
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/5] maintenance: use packaged systemd units
Message-ID: <ZfmAfIErHRZVbd49@framework>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-4-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318153257.27451-4-mg@max.gautier.name>

I'm working on updating the test in t7900-maintenance.sh, but I might be
missing something here:

>test_expect_success 'start and stop Linux/systemd maintenance' '
>   write_script print-args <<-\EOF &&
>   printf "%s\n" "$*" >>args
>   EOF
>   
>   XDG_CONFIG_HOME="$PWD" &&
>   export XDG_CONFIG_HOME &&
>   rm -f args &&
>   GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance start --scheduler=systemd-timer &&

Do I understand correctly that this means we're not actually running
systemctl here, just printing the arguments to our file ?

>	# start registers the repo
>	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>
>	for schedule in hourly daily weekly
>	do
>		test_path_is_file "systemd/user/git-maintenance@$schedule.timer" || return 1
>	done &&
>	test_path_is_file "systemd/user/git-maintenance@.service" &&
>
>	test_systemd_analyze_verify "systemd/user/git-maintenance@hourly.service" &&
>	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
>	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&
>
>	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>	test_cmp expect args &&
>
>	rm -f args &&
>	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance stop &&
>
>	# stop does not unregister the repo
>	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>
>	for schedule in hourly daily weekly
>	do
>		test_path_is_missing "systemd/user/git-maintenance@$schedule.timer" || return 1
>	done &&
>	test_path_is_missing "systemd/user/git-maintenance@.service" &&
>
>	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>	test_cmp expect args

The rest of the systemd tests only check that the service file are in
XDG_CONFIG_HOME, which should not be the case anymore.

However, the test does not actually check we have enabled and started
the timers as it is , right ?

Should I add that ? I'm not sure how, because it does not seem like the
tests run in a isolated env, so it would mess with the systemd user
manager of the developper running the tests...

Regarding systemd-analyze verify, do the tests have access to the source
directory in a special way, or is using '../..' enough ?

Thanks

-- 
Max Gautier
