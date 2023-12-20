Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477021D695
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NCEeQr4p"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 540BE1BD13D;
	Wed, 20 Dec 2023 13:30:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V7hcJ3k84z0YAqtr/atzTbA6/UjWx9lTxy+9Tz
	nrr6A=; b=NCEeQr4pLtNHrNVmKv6v14RPZKBVBINB1Z+VuDGoAfDVxKrO4bl18/
	MlejoJc7tIDkJmtxZ/Bp0WSbOJPzK0NvRA7u9EwyVeACCcOT14hpoeRdKSjWF0ej
	cpSwDy2MIzf1A+dmMC4zLvuCMx7jZa9kBvOY98k/BK3pb1nCchVT0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A2971BD13B;
	Wed, 20 Dec 2023 13:30:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABA4B1BD13A;
	Wed, 20 Dec 2023 13:30:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] setup: start tracking ref storage format when
In-Reply-To: <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 20 Dec 2023 11:55:07 +0100")
References: <cover.1703067989.git.ps@pks.im>
	<6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
Date: Wed, 20 Dec 2023 10:30:28 -0800
Message-ID: <xmqqv88ssp4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA3FBE64-9F65-11EE-8DC4-25B3960A682E-77302942!pb-smtp2.pobox.com

There is a topic in-flight that introduces the .compat_hash_algo
member to the repo_fmt structure.  Seeing a conflict resolution like
the attached (there are many others that are similar in spirit), I
have to wonder if we want to add repo_set_ref_storage_format()
helper function.  There are many assignments to .ref_storage_format
member after this series is applied.

Note that I haven't read the series in full, so take the above with
a grain of salt---it might turn out to be that direct assignment is
more desirable, I dunno.

Thanks.

diff --cc setup.c
index 2f4571c12a,5038e78cdd..0000000000
--- i/setup.c
+++ w/setup.c
@@@ ...
@@@ -1584,8 -1577,8 +1595,10 @@@ const char *setup_git_directory_gently(
  		}
  		if (startup_info->have_repository) {
  			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 +			repo_set_compat_hash_algo(the_repository,
 +						  repo_fmt.compat_hash_algo);
+ 			the_repository->ref_storage_format =
+ 				repo_fmt.ref_storage_format;
  			the_repository->repository_format_worktree_config =
  				repo_fmt.worktree_config;
  			/* take ownership of repo_fmt.partial_clone */

