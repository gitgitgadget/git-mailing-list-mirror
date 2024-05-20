Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BE1369B9
	for <git@vger.kernel.org>; Mon, 20 May 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225554; cv=none; b=U5AC5rEFWuUdHaYbj7rIOR24OnGrEW3YlMNyYof/4cYIL9HSVMf5zjCZFAH6BLNgy6pjAZbuOCxfLDIDGgES6CWvzVIyGKV+FzTvi4589W7fhdwzIn7WAKnBCJDurZSWep2Ilbdh4gl/HvLezCdNn3udq1ABPg2+svbLPtQKfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225554; c=relaxed/simple;
	bh=rtYnbWsWkS244Jhbozhpp7jRt/hchmeIWm3gFJNw0g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rPJJG3y66zjf8MsTkh5bJdrJMqOQl3Qp3+Ll7q1C+7TIkg7mZy7ZIN9FS5n4HuVo0h6IUbxztYzkiaasWS2luskDXB82nmwrsXLlesWM0eG5G2DbLgdIJf75CnyWVN/JhqYtqUXpG0m6j9Q348j/1y59eSbHzfyNMDWyn3MAih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t7z+Aj03; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t7z+Aj03"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C2C4827C12;
	Mon, 20 May 2024 13:19:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rtYnbWsWkS244Jhbozhpp7jRt/hchmeIWm3gFJ
	Nw0g4=; b=t7z+Aj033oe2/fcuPxnfv5yXj2WSzMSRNMAF+OyQBAc4PEJSv6Ue4+
	oI2jMG/M00ayp1ipSmw8oEX+weQfyCmZecibiyCD1baS6wA59i8orOIfPLtiCIlR
	WuHyjcKGDjgFRjMt8W5MUjnLqo598yzp1CM4umZLuvdePNRo5aMJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A1C2B27C11;
	Mon, 20 May 2024 13:19:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A728E27C0E;
	Mon, 20 May 2024 13:19:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin" <bupt_xingxin@163.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "blanet via GitGitGadget"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Xing Xin"
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] bundle-uri: refresh packed_git if unbundle succeed
In-Reply-To: <5e61daf6.ba64.18f95d49895.Coremail.bupt_xingxin@163.com> (Xing
	Xin's message of "Mon, 20 May 2024 19:48:08 +0800 (CST)")
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
	<ZkbkgT46mdNEhcf0@tanuki> <xmqqikzcl8js.fsf@gitster.g>
	<5e61daf6.ba64.18f95d49895.Coremail.bupt_xingxin@163.com>
Date: Mon, 20 May 2024 10:19:02 -0700
Message-ID: <xmqqh6esjta1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E5F65E4-16CD-11EF-BF84-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Xing Xin" <bupt_xingxin@163.com> writes:

> Personally I think data from bundles and data received via network
> should be treated equally.

Yup, that is not personal ;-) but is universally accepted as a good
discipline.  In the case of bundle-uri, the bundle came over the
network so it is even more true that they should be treated the
same.

> For "fetch-pack" we now have some configs
> such as  "fetch.fsckobjects" and "transfer.fsckobjects" to decide the
> behavior, these configs are invisible when we are fetching bundles.

When fetching over network, transport.c:fetch_refs_via_pack() calls
fetch_pack.c:fetch_pack(), which eventually calls get_pack() and the
configuration variables are honored there.  It appears that the
transport layer is unaware of the .fsckobjects configuration knobs.

When fetching from a bundle, transport.c:fetch_refs_from_bundle()
calls bundle.c:unbundle().  This function has three callers, i.e.
"git bundle unbundle", normal fetching from a bundle, and more
recently added bundle-uri codepaths.  

I think one reasonable approach to take is to add an extra parameter
that takes one of three values: (never, use-config, always), and
conditionally add "--fsck-objects" to the command line of the
index-pack.  Teach "git bundle unbundle" the "--fsck-objects" option
so that it can pass 'never' or 'always' from the command line, and
pass 'use-config' from the code paths for normal fetching from a
budnle and bundle-uri.

To implement use-config, you'd probably need to refactor a small
part of fetch-pack.c:get_pack()

	if (fetch_fsck_objects >= 0
	    ? fetch_fsck_objects
	    : transfer_fsck_objects >= 0
	    ? transfer_fsck_objects
	    : 0)
		fsck_objects = 1;

into a public function (to support a caller like unbundle() that
comes from sideways, the new function may also need to call
fetch_pack_setup() to prime them).

A patch series may take a structure like so:

 * define enum { UNBUNDLE_FSCK_NEVER, UNBUNDLE_FSCK_ALWAYS } in
   bundle.h, have bundle.c:unbundle() accept a new parameter of that
   type, and conditionally add "--fsck-objects" to its call to
   "index-pack".  "git bundle unbundle" can pass 'never' to its
   invocation to unbundle() as an easy way to test it.  For the
   other two callers, we can start by passing 'always'.

 * (optional) teach "git bundle unbundle" a new "--fsck-objects"
   option to allow passing 'always' to its call to unbundle().  With
   that, add tests to feed it a bundle with questionable objects in
   it and make sure that unbundling notices.

 * refactor fetch-pack.c:get_pack() to make the fetch-then-transfer
   configuration logic available to external callers.

 * Add UNBUNDLE_FSCK_USE_CONFIG to the enum, enhance unbundle() to
   react to the value by calling the helper function you introduced
   in the previous step.

Thanks.
