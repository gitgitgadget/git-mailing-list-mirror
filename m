Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0F1DFE8
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675230; cv=none; b=d9tSfjsUMq/ucDZA42T9GZOspk2XS32KIRR/khuIgkqzQBf78FYimYvXqX04t9J+iX5nRXHaor7fCpDr6HGsq4nPjb8fcYvXtzxXqwR3V2/EQS/GxwkfErf9IZQa5RsxCXxeM4V12E9b8Qn2GgM6Wwm9TqDtGpKy6r9aEluOhEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675230; c=relaxed/simple;
	bh=NVNt39qZ/lf6Cqt7t7MKzjd3XHUtm8o8yKlbc9VL7pw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Hb7ekewQOFUsjbLeZek9xCfjCz8JMJtW/Sdgd5kjI1x/iSHEYYkDn/0AQJ5wfUue/U4NWokZSCBxOgbMISkSS+MDXMnrvj83pLBWg3et4Yk59qMK0TUqOqOavS3ALU7M/SL4rpR/669ugJWefsSoeS4Ck0XlsXrVD8CPev9v/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=E2SZ9fvV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="E2SZ9fvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719675219; x=1720280019; i=l.s.r@web.de;
	bh=TvKyHmEzdglhxvZ4p6Fzp9zExpen7/EWdU9doJmaepQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E2SZ9fvVOykyfbUit6Vz+gzhRJwKDMfWH2PYuz0a92auTL6Vy21+812uEUYykVLm
	 VUoxxamMpt4Q3A9K9jt+34KFBi8YRtNeS54+7SBoPVElJ854PuCk12NRBmapcfrFp
	 hESEHVpMTiFKQypH9lhppdretZpY19R0FEqIqNGSlfhzNzR/W4kbb/ahTNIUFOFDl
	 XoNABAcbHAaE2R7XZyHOvPoNEK83Mr63BifkrQl88vfpdAZirvTtsmVXUGlON1OHN
	 TqqR1WpgRKD6MGHfgZyYpF9UJEYYrohqVIHZ1GMX87QJHXaX/ZuzqxQo4Dzal0W6d
	 WZvLewCRezCfOAJmZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1slJzh11Dq-00USyU; Sat, 29
 Jun 2024 17:33:39 +0200
Message-ID: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Date: Sat, 29 Jun 2024 17:33:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/6] unit-tests: add and use TEST_RUN to simplify tests
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e4XmrukoAapP378nwIcj0y9tbQPuhsUV2aZtia2lyA+hENNmqOn
 Dt50c2xD6boyE9HGQYQcT1ICWZD1Hqccg8n1GPt0cMkNW2SgKoZJ/gtc5FsuqHmnK3PPzW3
 seh2+ZqznuXIsRUMD8ufbFvHcsfA1jrlBNOkEdx6XM9TKImnU34DuAgfbjfAB4CKQ3U+Z5e
 3PpJiAJ11ek/AyBMCDW1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YaDkEzN8i+M=;7g7lHEDFEJm7FtJfSLYMxQHr21C
 OLEXVqufowd95CQDpKWH2rDdqoGvV3nXDHmvnlp9mrM6uTjgxAvvL5Sa4rIbOyiu+4NKwu4nU
 3QASwEwuLjzOfgjuS870ElFba/WNUSwAicTNlzqQ9NOjsUTJvdWqgOybyVAcAMhV1nKj1Crdt
 bKOEnT9xMDffaUdwO7IU/Rhw8KqFeR+64QSQn4mE/thXigoHbqNkguTyvjsG7iQwwcQnO4BgF
 VR1qd8N5LbKuVw4umh2j4+IUyftJUUQhcXwxy1lTGkBo914Tc9nVLtkuw4/g8S3RsEPQeeptO
 WJjH2wgKyec2ZvzW/rBSLMTo1XEFZepf0hEeNLIPRtTHmVXX+hHhpVfOARKvu262DELl4CLhe
 QLciGlvqbiwrJKqAP9AwO7LIKnDoMmGGFw/NKI6sDMIL2PTptlA5oyhLXo9qZ9/tZzEyDECzE
 ecnoa7j4+xmOv/Ys8dpwXClXjwpMKB55E2uqKsJpj91tXvrHJFkaoF80BilzTuN8Xvde0mmVw
 pvCnzOz2FpZfdE6OxcWG7BS1E2upXOxL+0/XYUZ/32+UsIwG5I2K/zCA4jQPAAX/yzn68gHiD
 sqQxo62lfIhwxzWptl+swaggVDVX6DyFP3evXXT3VhlX5JBfFOF0KGGmo+6i7OFiljh2xmx1V
 gTkiq7UcksODat0VYT8b8iiemjiwZ5YqddQfAzsb9520KvjIsFoCk5pqbsL+tl+eMTlmxQxhe
 5+y1o8zYAHj/v/slE38DFsqqSjYsvW15IsRuTq7u+dtuh37ofndQCi49TCotAs73/YXvByrDu
 EuWVkdKJu9UXelfDCmp0xRUR/3Ddzlm3iejciWIq53TX4=

The macro TEST only allows defining a test that consists of a single
expression.  This requires wrapping tests made up of one or more
statements in a function, which is a small, but avoidable hurdle.  This
series provides a new macro, TEST_RUN, that provides a way to define
tests without requiring to declare a function.

  t0080: move expected output to a file
  unit-tests: add TEST_RUN
  t-ctype: use TEST_RUN
  t-reftable-basics: use TEST_RUN
  t-strvec: use TEST_RUN
  t-strbuf: use TEST_RUN

 t/helper/test-example-tap.c      |  33 +++
 t/t0080-unit-test-output.sh      |  48 +----
 t/t0080/expect                   |  76 +++++++
 t/unit-tests/t-ctype.c           |   4 +-
 t/unit-tests/t-reftable-basics.c | 228 +++++++++-----------
 t/unit-tests/t-strbuf.c          |  79 +++----
 t/unit-tests/t-strvec.c          | 356 ++++++++++++++-----------------
 t/unit-tests/test-lib.c          |  42 +++-
 t/unit-tests/test-lib.h          |   8 +
 9 files changed, 462 insertions(+), 412 deletions(-)
 create mode 100644 t/t0080/expect

=2D-
2.45.2
