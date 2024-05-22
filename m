Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE615B3
	for <git@vger.kernel.org>; Wed, 22 May 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341743; cv=none; b=hDS1HkUzUO7zv2S/I6Xtp0eFgKAOBFe+wlxUTNlWJnTM0Dv/E/4+MDo1lhuT1WgNZcbJIkbOwcN7eJEw1777qbd5X257NiiiDkMewr/giH9ZIyir0P4rcUvT31BI4XrFpBCr6D5SiZFzoLqmWvytlhTiRW02PCk8GVDwK9uYcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341743; c=relaxed/simple;
	bh=olI2RmThwQcsfZJMNbsgzImPSM+LdautHl081R81Htk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Seb3BdOE9DkI/8WDtydGsKzLUsiT3X2hP+wiSF0c3fSZm3b7lY6q5ybXIv+pRSA44tuFSH7zIyrCW4FO/6UGA1YeVm5gw53sx33ObrnV5ZkkbiqAlbXvzNLEJ3OEW0GsKVmFUXhvGMZkrM/Y3eq33pqbyzBJ4ywjyewx83eoDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fyD7D3NC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyD7D3NC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D0C9331DB;
	Tue, 21 May 2024 21:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=olI2RmThwQcsfZJMNbsgzImPSM+LdautHl081R
	81Htk=; b=fyD7D3NC8BASrSwyzGo4kANeS6OKr/6CuROfk/aYiALquxAv9iwP0R
	8IJKxKz3ZHRIbGGbzJJKI5CWo41yIU+MR84QTU+ZH1sRdiaunIgc8UDOcPJSpTre
	IdGHK6ZLc8oXTQJOx990ihaLn20u0K1v6BgX4ByugQbyiR+yzFP1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75496331DA;
	Tue, 21 May 2024 21:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF902331D9;
	Tue, 21 May 2024 21:35:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Nathan Faulkner <natedogith1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff: document what --name-only shows
In-Reply-To: <4c4049e9-f5fa-41c3-8a6a-df4fca2f07f1@gmail.com> (Nathan
	Faulkner's message of "Sat, 18 May 2024 15:10:01 -0400")
References: <xmqqeda0jr7d.fsf@gitster.g>
	<4c4049e9-f5fa-41c3-8a6a-df4fca2f07f1@gmail.com>
Date: Tue, 21 May 2024 18:35:38 -0700
Message-ID: <xmqq7cfmiq6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98B8F688-17DB-11EF-8414-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Nathan Faulkner <natedogith1@gmail.com> writes:

> This new description sounds to me like it only shows files that exist
> in the to-commit, not any files that were deleted.

True.  

The thing is "diff" works on pair of files from old side and new
side, so a removed path still conceptually exists on both sides as a
change from

    <old path name, old state (has certain contents)>

to

    <new path name, new state (no longer exists)>

It is the same story for a created path.

Having learned that, a proposal to rephrase the updated
documentation is very much welcomed.

Thanks.

