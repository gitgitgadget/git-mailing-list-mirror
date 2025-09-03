Received: from mail.niir.ru (mail.niir.ru [178.177.28.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B92F7449
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.177.28.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904938; cv=none; b=uPaaFiHsxmyjTRnh2Czz18dM4MiubfpBV6eYHQi22Oc2kmlBf+o8LIPanNeQYN7ADjPZcSoyJFi4jwL6Rbwdtx5Gs0gLS4PXNmjrCtQBE1LKHyf6lNgwR9Ui5/qlSVHDNgZFdHbWwiCFKRASbOtUB0R8m28GzkAqg9JMWiOIiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904938; c=relaxed/simple;
	bh=oouJWaIkWPbKA7TBJVw6xV4420kv5HruQ0GtS8w4mTw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IfPKrmeNexo6/qw9gvtRKYX3bXWHnxg1n4jNuZ/6HbKyUaBDj4ydwNTNVeYGqRjQFaA8i9X/goEbD9Id4pQJbINmvqKln0C8in82jS2HaTvzvM9hb9hK3lgiG9R61hpucYOycdn+oca91fTyxXKLQBi9a3RVFs2v30bfRgLS2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nic-t.ru; spf=pass smtp.mailfrom=nic-t.ru; dkim=pass (1024-bit key) header.d=nic-t.ru header.i=@nic-t.ru header.b=naKGKJyt; arc=none smtp.client-ip=178.177.28.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nic-t.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic-t.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic-t.ru header.i=@nic-t.ru header.b="naKGKJyt"
Received: from localhost (localhost [127.0.0.1])
	by mail.niir.ru (MailServer) with ESMTP id 47511220B18;
	Wed,  3 Sep 2025 15:59:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic-t.ru; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:list-unsubscribe:content-language:user-agent
	:mime-version:date:date:message-id:received:received; s=dkim; t=
	1756904384; x=1757768385; bh=oouJWaIkWPbKA7TBJVw6xV4420kv5HruQ0G
	tS8w4mTw=; b=naKGKJytk0YFAEkYsiBOKNBi3+W5DEn/eZ9dm4rQOjOiYroRRFk
	2JX15Gsb1VV20JH75g/vlcTSTmGAeM3QRYB0XRQSqkbNRJyUNQElKtVJBrvqqoZM
	xEXGhvDKCPtlLiBmaBdenPAdQBt6zL95SDpBino0Wx5lzLmooeFZe8Bo=
X-Virus-Scanned: Debian amavisd-new at mail.niir.ru
Received: from mail.niir.ru ([127.0.0.1])
	by localhost (mail.niir.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cPpfoCbzhUWY; Wed,  3 Sep 2025 15:59:44 +0300 (MSK)
Received: from [192.168.100.143] (mail.loniir.ru [93.153.183.166])
	by mail.niir.ru (MailServer) with ESMTPSA id D59DE2203C2;
	Wed,  3 Sep 2025 15:59:44 +0300 (MSK)
Message-ID: <9e0ae524-096f-4629-b3bd-5a100f6790ef@nic-t.ru>
Date: Wed, 3 Sep 2025 15:59:33 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
To: linux@roeck-us.net
Cc: git@vger.kernel.org
From: =?UTF-8?B?0JvQsNGC0YvRiNC10LIg0KHQtdGA0LPQtdC5INCQ0LvQtdC60YHQsNC90LQ=?=
 =?UTF-8?B?0YDQvtCy0LjRhw==?= <latyshevsa@nic-t.ru>
Subject: Error in nct7802.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
An error was found in the code of the drivers/hwmon/nct7802.c file.
A macro mismatch on line 49
#define SMARTFI_EN_SHIFT(x) ((x) %2 *4)
of the chip documentation dated 02.2020 in Table No. 7.2.95 "Temperature 
to Fan mapping Relationships Register".

I suggest this simple variant:
#define SMARTFI_EN_SHIFT(x) (((x)==0)?0:(((x)==1)?5:2))
