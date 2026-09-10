Received: from send217.i.mail.ru (send217.i.mail.ru [95.163.59.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB513B47E1
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062872; cv=none; b=O84VletjNg8lzuvQmsYGfbukAWaoTBw6hdYasTadI4EzhJ1ymSscXroLm6EUGlF4I/XDyvbhFKUucs37no0ElNiw1iz3QVY6aFi/nEmfGXKg0mKyFm3SG+XGgjbg6YmMyoGemgqaUTcmpadBaNyiqv0YLMDEKVb1HeKQKupivjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062872; c=relaxed/simple;
	bh=zHMyw3+DI4mC8Umt/ObFQUvZatbaOqjaylvNqPx/bUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3pptS4ZD5RorlJyLCZIBFUCz4uMkyKwEq4W++I8eliBR6USpvXDXJVHFLdxW38T4GeARYx0YDaSUlZmB0tXwBIr6WQCMok77SFhcCNOSM3TWJH/1j3xr1ICNobjkYe9H5MYaCcqGFyK40/1IUY+X7eUIWL4sYGpEY2HUKB79e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=x3PPPtEF; arc=none smtp.client-ip=95.163.59.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="x3PPPtEF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=zHMyw3+DI4mC8Umt/ObFQUvZatbaOqjaylvNqPx/bUU=; t=1789062867; x=1789152867; 
	b=x3PPPtEFLQFqAY11RxOf4u7QALZmCnTL9LqUdNP+IVIFd0QFFDeiunX2Iy0JXYJMm9baTCXHn75
	EVCJdHKk05TuFt0e3qLzf6cNXMbDHU0QsyXnFf8QrQ27d9CzLQ01b+jOKcv5YkU3Mg4+4HuiDshfM
	PnrX1YueAOfok/Cx+BX9QkQcSTjxGV4XYyf56OtkxWX9Xo/FFjTQS036LT5lkLS5rdogyRpLJx7bH
	Kch6mG1U8X9vALKnv4fD/qGsnroeGPqVLh5BoJhbpo7ODELTkFPBxfXWIt9hZ3+fw6437Vy6NWM35
	vGvhO29TXueQdS3id0MIFuNPLJSSvtNzYEDg==;
Received: by exim-smtp-569b45c49c-9ks7p with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4iya-000000000ME-30cE; Thu, 10 Sep 2026 20:54:21 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 158819F633;
	Thu, 10 Sep 2026 20:54:17 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: peff@peff.net
Cc: ben.knoble@gmail.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	gitster@pobox.me,
	ub4nal@mail.ru
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Date: Thu, 10 Sep 2026 20:54:15 +0300
Message-ID: <20260910175416.115280-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260910155247.GA251185@coredump.intra.peff.net>
References: <20260910155247.GA251185@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-569b45c49c-9ks7p; auth=pass smtp.auth=ub4nal@mail.ru smtp.mailfrom=ub4nal@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9344F665CF1C84C2981A1698E91343846DA5D2C916BDB6FA9182A05F53808504017264B994300604B3DE06ABAFEAF6705C0727B65EC3C99DBC87861116BD789A3AF1470CB4BE18E90
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77633BACAB33B9508C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7370F4F695FFFC24BEA1F7E6F0F101C67CDEEF6D7F21E0D1D9295C2E9FA3191EE1B59CA4C82EFA6588F2CE5D204F6F28A2E070BE324C7D3C434645AAEB45A13646F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE715C5AF61602698339FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD1828451B159A507268D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BAE9A1BBD95851C5BA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC1A9DEC5B19A4C7AE3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F79006379E759133251BCD1BD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FD2A95C73FD1EFF456D8C47C27EEC5E9FB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5C8C580008EF525095002B1117B3ED696149AAA05E4ED1B05E772F934B9BCD185823CB91A9FED034534781492E4B8EEADB05233B9BC4759D3
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65973B96C3F0B6404A73C1C556D31CC29ECFEA0F6680C5FBE969A98B5B6FFEDFCB5FDC5B11A8028E3EAB8341EE9D5BE9A0A7F623429F7A07E0CFDD5435D9FFC9554AAE3218006BB9C129350E1BD188BD56E4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWKMy/SrMZ/BUe+eya20PhEY=
X-Mailru-Sender: AAD8E2226B689FDAECD2CED6BF24A7DE786AB488EA76031FF46189D161B61A0163295D2B0DBB5919B184EB62A9F5F47C54E226A98846702133E8FD7590A32A2E63BD3AF61A418D9396323D2A0E59D4D41AED8EA1FEF7CCBBE2C5234E33BCAA240EACFF33BD5939F7C77752E0C033A69E3453F38A29522196
X-Mras: Ok

Hi, Jeff!

> I'm really not sure why anybody would use those other flags, though (or
> even --system, for that matter). After reading the thread again, I get
> why we want "--global" for advice that only affects new repository
> creation (like defaultBranchName), since otherwise it could never have
> any effect. But why would you ever want --system?

I initially looked at Junio's suggestion and, based on his experience, didn't argue with it, and then I didn't come back to that message. I think the patch should contain not + enum config_scope scope_hint; but + bool is_global_hint;, since I myself can't find any scenarios where advice should be disabled at the system level.
