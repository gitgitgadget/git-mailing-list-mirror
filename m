Received: from send278.i.mail.ru (send278.i.mail.ru [95.163.59.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244823BBFB6
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030456; cv=none; b=eXdZiD2Kifjug6uQ5KCLKDuBup4eoB8Jh+hqUbIPYG3D4sJ82aAJYP/VhKAv7GXYjCWSnNzPosoR9SkxZFvBi6fHw+vUmWjqv6ZbppxS+ITRZlL1N1zMTRSMJT/X7Y8ept4Z59JpssCDwZ7G13d4+Foulpg9/8UWnfvx9AeRJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030456; c=relaxed/simple;
	bh=NG2xA7AGjOCrwU/GNd524hd9co46fAR1BLTS225E0Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7rZIw4aSCd34eLQcoH6K+ChWy9VKIEv1XzbDYRAjxS+2ssiWZkl1qaIaJhCtVrn8LDJHB69LlLlEiMhhnSjAmz7rEimjzj/68GDZdbaSpwbiqpocROUcUhtJsY4t2X4m0+y+zaANCgvYhFGWLOPnlm6wse75ZPaZCc4inWbRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=jq8HTiEQ; arc=none smtp.client-ip=95.163.59.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="jq8HTiEQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=cGh9GL3tVSZqtx1S6FLoki0b6sgkrAP3qrakWtFB/c0=; t=1789030454; x=1789120454; 
	b=jq8HTiEQC+/AxKJqawrSInf3d9uRZTxZ8AZDB+35cR47OUdaGiXoctmtWfNcZ8z/hV8LHkGw+8l
	rh8QaiYxlu+LQCeWDkTi3cHceibcP1mi+qajI4rYRgZDE64vxck0Al3ZctcL2fhLetzQ/izzVsbTb
	8XMVCXFKrcJvTte5FWs0LVXcKa8ZatGtcKLWcv01qwcpwbFINNz990hg8Tx/Z5ELltPEPOpXZXSTl
	P3Pz3BLs2qJ9QkgUdIvlcJ/qsgmTRtfbRl55ttGO/RGd7N0atyrRyl0/BBvZSdj9XNvPDfp+KApC3
	yGZr2fDoF5TwrHjSxuiA+q2KWUN1KSgdbpiA==;
Received: by exim-smtp-569b45c49c-x2xss with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4aXl-000000004md-1S4N; Thu, 10 Sep 2026 11:54:05 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 983859F63C;
	Thu, 10 Sep 2026 11:54:04 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: git@vger.kernel.org
Cc: ub4nal@mail.ru,
	ben.knoble@gmail.org,
	gitster@pobox.me,
	peff@peff.net
Subject: [PATCH v4 3/3] advice: use global config for default branch name
Date: Thu, 10 Sep 2026 11:53:53 +0300
Message-ID: <20260910085353.109373-4-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260910085353.109373-1-ub4nal@mail.ru>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-569b45c49c-x2xss; auth=pass smtp.auth=ub4nal@mail.ru smtp.mailfrom=ub4nal@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95F11291660A1073B43A89698C6F880AE9AF33B346D4B27B3182A05F5380850403668BD675A7704903DE06ABAFEAF6705A8AE4ABA305A59751964E60332344D73333BECB3000124C7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B96787714ECCE2DBEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D964761FC95C20C4B10D18A8C3FD2095EA085CF957CF6E3DF0A1BE68EEF46B7454FC60B9742502CCDD46D0DB2DECCBDF547A305117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC8883BAB8B32E402CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10F618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA99F804269016115C9D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE362B3BD3CC35DA588302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006372BF47D31460A3964EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A54F6D729F0984AB275002B1117B3ED696C1B313CEADC7B7A569995D676B7B4CBE823CB91A9FED034534781492E4B8EEAD619183A7BD6BC6F1F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D54AF47762AB4810619
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34CAB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6590AC17ACB2000827090EBB6EB952447A6CFF18EA41C58D4FCEB618F0B31511C2080A52CB350098E18B8341EE9D5BE9A0A81BFE6447CA6A83A0D3591796D348C514128F2AE12760732C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWFpuP5d0Zh5am5/lFOSIJYM=
X-Mailru-Sender: 288943BA7BCC8BBA2C509D5366AED3E5B676C78F813EF362CFE9FA76EDA5B4B7F5194E9BB34B37C50A706A47B3F94AC53B7E521F6A5800A996940349D467AF430D26F6DE3BAD3FFE4DFFA654C60F801316CD019DBEDFC45331DC91172AC7F52EF91D4A7208CD43CE3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok

The advice for setting the default branch name currently suggests
disabling it with a local configuration value.

This makes the advice appear again when a new repository is initialized.
Suggest using the global configuration scope instead, so that disabling
the advice applies to future repositories as well.

Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 12a68ea716..6964a6e2ba 100644
--- a/advice.c
+++ b/advice.c
@@ -54,7 +54,7 @@ static struct advice_setting advice_setting[] = {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
-	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", CONFIG_SCOPE_GLOBAL },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
-- 
2.50.1

