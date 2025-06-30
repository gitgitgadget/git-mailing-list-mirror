Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D6292918
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299679; cv=none; b=oc1oijV6o1WTwTLmjhhsZyj9oaBseld85Uda+QXJKX7ZDGGpEb3QA58/AMVgtdWXqSXaDSfml22S5IvdjfyUwf+biDWtppQQqEQXVB0B53DIxUNtuA8ywtRg+SioIIGk1mBirVxqvrRNQSpGP8FlZgplTf/ydnN/scGxiDas1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299679; c=relaxed/simple;
	bh=zGhgftaZcpsluZDsVCkaDB1xaLf0SuFpTigmkDy0Wdc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uAuCUqLYM+/GWLeSOmwGzADew55So2irI+2yHplyCv55C2ncdWuPd13H0wOL9yNr2kmwEVZCV8v/WawMMIKonEY28JOiCljCB31z3/vkVlnzh9pwj+skW7tI8g7uzOPo6nTer4nMC7T2lBDhuZRlY+ZFoyuyXwUiPu9U1T+Sx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fork.dev; spf=pass smtp.mailfrom=fork.dev; dkim=pass (1024-bit key) header.d=fork.dev header.i=@fork.dev header.b=UKRdGD6L; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fork.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fork.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fork.dev header.i=@fork.dev header.b="UKRdGD6L"
Message-ID: <6eb10e33-4001-95a7-d2ad-3dd2a5c830ab@fork.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fork.dev; s=default;
	t=1751299674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z8FXIpURTWx1lzKCZDG2OLKBIHQY0yQMof7meKascT8=;
	b=UKRdGD6Lfw6XRqHOtp1Nf4uNAicNlHIFFdwfUMZ+TEDhoIoP1UFdlqWsrWwAGdGejEhcZC
	sO8AtUYGi//xtrG3yRBQJRtZ507kWYfeMURY0npX4wbGZkP/9YsK1Zdal82gNJ8fBHF7ST
	1rwYaCHwGWMIlcVTl7LdkgfjsVd0nWM=
Date: Mon, 30 Jun 2025 18:07:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: git@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dan Pristupov <dan@fork.dev>
Subject: `cat-file --filter` is broken in 2.50?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

`cat-file --filter` stopped working in git 2.50.

```
$ git version
git version 2.47.1.windows.2

$ git cat-file --filter "HEAD:changelog.md"
<content>
```

```
$ git version
git version 2.50.0.windows.1

$ git cat-file --filter "HEAD:changelog.md"
fatal: invalid filter-spec 'HEAD:changelog.md'
```

The problem was introduced at eb83e4c64b5a3458569593c2ab0c29365f10a82f.

Then it was merged into the main branch by 
a271b05066a1fd2c3a62508d9908d6c5df14a1cb.

This seems like a bug.

