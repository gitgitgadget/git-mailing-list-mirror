Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADB7D07F
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249810; cv=none; b=WWHB3Jvr25z+6g48wJ26nkzXFX4cZI2jqFGFS+n7/13wROwD5UZy/CSGu0diT+cbvoR+osP83+NEnGvIUJycoBo1NLbomcUV23U8LOqDHqet3VqSJW9OGqZUKGdxY0UfWE9Z/Qq9cgFkD/hHeSUvKH1XgjET7AX/RKq5j2u7IHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249810; c=relaxed/simple;
	bh=B8SAEqQOGzjHnNTqzTQNItYqk+TfL0iBhzz5ZFiPu40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VsVtoG/6iUzCWkhy9CVW/wcOfyOUW8/xaNiikYWx6Ep/C8WkqXbAtXptOoe1sl9MelysxGa90wivhH8Xq5VnYVEiSy0xug/cwvOh7UjvK23SGyqmN74yxno843bgaSRq8vfIv7o5U/N+bB1JJ1aS5FLNQ1gu1wgE2qkSiobIsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nieh1VkT; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nieh1VkT"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BF6C3789C;
	Thu, 29 Feb 2024 18:36:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=B8SAEqQOGzjH
	nNTqzTQNItYqk+TfL0iBhzz5ZFiPu40=; b=nieh1VkT/DEIzPbsOTmeo83za9pA
	Ty+PqIImzop/7C1rkTgd0hvYFC3axdz9+SrtHqTFRUvVK8pPJWTVagc4p9uTGgC9
	gzUkCdi17BBxRLR7t9r+tWng7D1B8LrnAES99rEwUg1eItIGewBnVcgrqeereFes
	eEUbMxglyHmd1r4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 045343789B;
	Thu, 29 Feb 2024 18:36:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9594937899;
	Thu, 29 Feb 2024 18:36:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Michal
 =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Aryan Gupta <garyan447@gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
In-Reply-To: <CAPig+cQ5m86=pLTpFrik0xS6XPyK4tZQx_wkc1xh2r9WDFkhuQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 29 Feb 2024 18:22:55 -0500")
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
	<pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
	<xmqqle72c17i.fsf@gitster.g>
	<CAPig+cQ5m86=pLTpFrik0xS6XPyK4tZQx_wkc1xh2r9WDFkhuQ@mail.gmail.com>
Date: Thu, 29 Feb 2024 15:36:42 -0800
Message-ID: <xmqqa5nic06t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 65E0E1FA-D75B-11EE-A589-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Feb 29, 2024 at 6:14=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> So, we may want to do it more like this, perhaps?
>>
>>         test_expect_success "Racy GIT trial #$trial part A" '
>>                 rm -f .git/index &&
>>                 echo frotz >infocom &&
>>                 git update-index --add infocom &&
>>                 echo xyzzy >infocom &&
>>
>>                 files=3D$(git diff-files -p) &&
>>                 test "" !=3D "$files"
>>         '
>
> If taking it to this extent, then the modernized version of the last
> couple lines would be:
>
>     git diff-files -p >out &&
>     test_file_not_empty out

Yes.  The modern style seems to prefer temporary files over
variables; the reason probably is because it tends to be easier to
remotely post-mortem?
