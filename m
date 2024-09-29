Received: from ci74p00im-qukt09082702.me.com (ci74p00im-qukt09082702.me.com [17.57.156.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF013A878
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592796; cv=none; b=qXc5/eddYQAE4rT2QrQK9/h25JILI/KcOVX7qC7Ye7r7v+OCq4dUa+7/xB5jifJpfrCXB1PPTix9TjwcnumaTCU7vn+IpqDkJsTrGb/z4R04RyLIhCmjyZBGR2/9aCHgwAgfUfW5Ypjqh0lCt2VqDvIOHHxxmwTdHTg7lTujQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592796; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=eO/6dJAfRbb86vNy7f2yGOH4LQNpTC5HN+TMUEDTr+ObIWy+bTgeAYIZLqmMf14cnqMVrBvarBdNjREBSxubNGs9A0/xROhMcGRwaMSww+MVzH7UYuuHeouSg2ZvNjsA0Kjam0IIoW91Y/Wz0Qz1u7xLOdXSi/SBKF6k6g6KVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WKkYZR1N; arc=none smtp.client-ip=17.57.156.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WKkYZR1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727592794;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=WKkYZR1NXCx4pNsIq9dvEZXmuvxN7zUs/9xlipiHhi4dT1y7qAqjjhU1RCTvAN4RA
	 D+8ml673wVe4pMG3ojHygHiISDn2K2OQ6Jb5Of9NuqGkbAHgYcwfYe7QDH2+Y8TU6w
	 TmX04K/fWtg2F9yq5YW2LBe0nj7sqi3EW6me2JQdoubEYmwCkVg5hDA1kTEBnQu2aX
	 fdkgOveLIXz4QavOeL+JDxL3gEmJWL9/xQEpmSENy59SMEdxQyuZJXvswQdr7AODh3
	 Wb7HqYOXCq2r14xXNTKHQVEmRRGQ6/A11ftTneM9sK61rhkePsL1pphi8o2kAOj9xD
	 sJe0DGKtGJ3Dw==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082702.me.com (Postfix) with ESMTPSA id 2428A15400B3;
	Sun, 29 Sep 2024 06:53:12 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 02:53:00 -0400
Subject: Re: [PATCH v2 05/22] reftable/basics: handle allocation failures in `parse_names()`
Message-Id: <660423A8-B769-4CF9-BADE-5D4FB9D24FF0@icloud.com>
Cc: ethomson@edwardthomson.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
To: l.s.r@web.de
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-GUID: _Fv7pt_MGiauvEOv9gH2wNcE1_ydIR5c
X-Proofpoint-ORIG-GUID: _Fv7pt_MGiauvEOv9gH2wNcE1_ydIR5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=671 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290050


Sent from my iPhone
