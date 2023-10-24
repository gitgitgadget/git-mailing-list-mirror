Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF53B7A8
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RLQlgw4i"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0A10C9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:58:03 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EFC7A5B091;
	Tue, 24 Oct 2023 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698177483;
	bh=CL1fZ38J4sXlyeGiAZT6FyPP9MS+s+Wu/Q37IM9iWkA=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RLQlgw4icZQVWeH6JDIaSse9IFrwZEjRavG/yYKHDqvHoXYMbznTwXfif3GAOs49K
	 5B+aNyju/OFjD0w/Gu7g7ERAb8h80SPhMvWJwKhPObXf6YEFS+3atHJdZTQvH3u77q
	 6+EPrejU5FBYaWul6Y6Q7lg41jzAicyveN8KeEz/04g0L3ile3VyOo/ijfpE4tA2r/
	 MUqCFcnnwLAVmBG0Vt/bB6a2r6dc0SuI++AzZtgzln0B8N24BIuYouoNEpBUwY+ISJ
	 tnyS6Lc80mt8Se1+v52h89mxdpo+0jUU3+2zC6dy4/Gmhis/A/Ezo+0YMRO0xFCbr4
	 Ab7jJD1rqoRLfS/ZDlDCfV0S1mp7yplzVammjNyr7ngyP6TdrVYCOBNqq/HWtrC6ZO
	 D2wWAW/8tk0G1yjriX3xF6N5CsmyIJYRNukVqBVB3qAr050D39O5/YqQx57FMDmDeI
	 /PjTLaTcraSnx9D6xw2Mm5LWvdyhsMlTMNnESn5PeokLbUIbsXa
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/1] Object ID support for git merge-file
Date: Tue, 24 Oct 2023 19:56:54 +0000
Message-ID: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

This series introduces an --object-id option to git merge-file such
that, instead of reading and writing from files on the system, it reads
from and writes to the object store using blobs.  This is in use at
GitHub to produce conflict diffs when a merge fails, and it seems
generally useful, so I'm sending it here.

The only tricky piece is the fact that we have to special-case the empty
blob since otherwise it isn't handled correctly.

brian m. carlson (1):
  merge-file: add an option to process object IDs

 Documentation/git-merge-file.txt | 20 +++++++++++
 builtin/merge-file.c             | 58 +++++++++++++++++++++++---------
 t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 16 deletions(-)

