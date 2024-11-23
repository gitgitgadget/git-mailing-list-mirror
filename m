Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9917F505
	for <git@vger.kernel.org>; Sat, 23 Nov 2024 04:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335077; cv=none; b=ruT71Ul18PGu9kfOrWKjva5dNiN0l+sG2Lgq3HMvTSugj+oMzvvQ7y06cWcRg9Gl1rjRg1wUXY5MQ1FzzHcmkshs4dX0YXgcox3CQP+p7NucIk8zg5zJOw01Sa/jww5GtTcWMF54oCcSzGBZEnrJ+ABk1Yh8FzCrHx+oQ0n6HH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335077; c=relaxed/simple;
	bh=nBoNhUI7ql7vGasGb2qLxwqx8AhR/cr7Ge3JTCRJ4io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb2Av3Hgu4tK1qrdnWXT0emN5EN4YphgwVW2VHUpj74K/cdAE7KSQx/RB0VuE0hnf2szOH5XM1BckZObbv+zIybtqxXSaB17kNK8TNQI+ZwOyiEleAGgDZQ4veLIxlm9Br2j5ssS8+G5tXfFBPpkRumXSw83wth4bGOb/qPUFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EM08pDQz; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EM08pDQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732335067; x=1732594267;
	bh=nBoNhUI7ql7vGasGb2qLxwqx8AhR/cr7Ge3JTCRJ4io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EM08pDQz1HloaoSaqJ2OCRfBrfAdxuEY3XN41SPb1iqTYMeMVZ3Oe2TnzCYqmOuZg
	 5eOnUVtbQ+Zu3FvWnmacTALhB33dI2ZopJgpPg8fOFxhFrYrZ17iXoY5cUxvfpf5vK
	 mY6wWQ+ixvMW9eDlgwXsSctPNlQ8qUCXIl953rMNSZu7u2vZNzmfeU2ouJgY7CZhKN
	 rwSn7Lzl5cBkD0gPE3ShdeaD0ulTOINRdvW2ZXfEgJapkcuQm5WX9W+Ucx4rhVjAxf
	 nFhabULkhVrwGWoNzaBpn1gc+h2/hw3kVrBR7SI2dxL8T0MzIh6xw9ZqzNyohi/pVi
	 crlyrP2JS95nA==
Date: Sat, 23 Nov 2024 04:11:02 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 6/8] worktree: add relative cli/config options to `move` command
Message-ID: <D5T9IZ3CT3KB.9QNSOHHW7VYL@pm.me>
In-Reply-To: <75b4023a-4005-49ff-a06d-e50fcd1c2b50@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-6-07a3dc0f02a3@pm.me> <75b4023a-4005-49ff-a06d-e50fcd1c2b50@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 6e88ce5c9af5f756f3b5b0eaf28f47ccf9e12a7b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 22, 2024 at 9:55 AM CST, Phillip Wood wrote:
> On 01/11/2024 04:38, Caleb White wrote:
>> [...]
>> +test_expect_success 'move worktree with absolute path to relative path'=
 '
>> +=09git config worktree.useRelativePaths false &&
>> +=09git worktree add ./absolute &&
>> +=09git worktree move --relative-paths absolute relative &&
>> +=09cat relative/.git >actual &&
>> +=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
>> +=09test_cmp expect actual &&
>> +=09git config worktree.useRelativePaths true &&
>> +=09git worktree move relative relative2 &&
>> +=09cat relative2/.git >actual &&
>> +=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
>> +=09test_cmp expect actual
>> +'
>
> As with the last patch we should use test_config and stop copying files
> just to compare them. It's probably worth checking the gitdir file as
> well as .git here as well.

Updated, thanks for pointing that out.

Best,

Caleb

