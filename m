Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9908262FD0
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755017; cv=none; b=lIx5ODBE0IvggYTC2QBBaowBRGXnvNdwChzhGno+JuKPLdXU3+gAVJfSJxFaADqdakF4N5OrDmm9mRzDzJVEuDkKUqQaimINcqoSRps5N7D3Sef8X0bRp279ldQuXtzq8TQMkXW2ZzsI1vXy9u1rz6540jtXIeXpl3M0O2/bLLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755017; c=relaxed/simple;
	bh=pDohdceTDSrN4tFLfBM9CLsGKV05uOuMvkh1wYKuWiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=qSSV8J8vj92xr2BnUbr7lWhgBXjSOk4C0rTOIwDb1STUgk0GcBxtVD67haQXJ1efsS+CQkOdhTAV0SAu5APGyn8c6BFxCpC2RAkym4rMXH5wlpxIjrt9t+0MIt1MzqyCwgbvm3xMqW3zEgoeHMz3tZiY8gSlwVJ8N50Tufgd9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=nHA2F6fe; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="nHA2F6fe"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYp-00168F-53; Fri, 06 Mar 2026 00:56:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Cc:To:References:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From;
	bh=6zx/qcnqxgZ7cD8M5eQaHrpjNrc1nMHjU/MMsBpkXZM=; b=nHA2F6fetwHN8t2lpYDT0prPz3
	AgXhbGi1uvkg+tHjMn5MdC8qIRKsDJtlffmvocytpWftolD+iWtpqTgA+zSvsGLZhECoAFuLDqOZQ
	2ixsVEikwQTUncS4+IU902JC8ZK1S/1xInGNnLJlWoHBX0tggj60JtNoJWwc7sS74X9ajz7OqVi3k
	uClu7aH/4AQPjBsceRScghdV4TnhbNdPFbMBkRBQUXp+j2V8+n5dYtS1dpYMVM9+Hgk6LhgZQbxz1
	VvLxqP5LqCRDDtPyhG0LXzu47L+9DvasUH/CtwaZdRJBocaow4qNzw982uURktEqreFNZUSvRnqYA
	RXXXWYYg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYZ-00040H-Ls; Fri, 06 Mar 2026 00:56:39 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIYK-000JoT-DZ; Fri, 06 Mar 2026 00:56:24 +0100
From: Colin Stagner <ask+git@howdoi.land>
Subject: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
Date: Thu, 05 Mar 2026 17:55:46 -0600
Message-Id: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIYqmkC/yWOy3LCMAxFf4XxtojaDhjTVf+DycJxRCIeNiOZt
 B0m/94Ylke698x9KkEmFPW1eirGiYRyWsCuVyqOIQ0I1C+srLZON3oLUUAeXWFEkPuVCjDGB9c
 auLDXvomng3GNWgR3xhP9vuTH9s1L9YyxVGNNdEEQOg4pjvWUmQZKn7cgBbn+R5KS+e+1bjLV8
 x5izc5qs9/6jfcH7xwYCHL5GKh8j/mnz7S5htSrdp7nfwsuPXriAAAA
X-Change-ID: 20260304-cs-subtree-split-recursion-6a7083cf9163
In-Reply-To: <20260215201748.889866-1-ask+git@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
To: git@vger.kernel.org, Christian Heusel <christian@heusel.eu>, 
 george@mail.dietrich.pub
Cc: Christian Hesse <list@eworm.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

* cs/subtree-split-recursion: when processing large history
  graphs on Debian or Ubuntu, "git subtree" can die with a
  "recursion depth reached" error. Reduce recursion.

On Debian's POSIX sh, shell recursion is artificially limited
to 1000 calls. You can check if your sh has limited recursion
with:

    #!/bin/sh
    recurse() {
        r=$(( r + 1 ))
        test "$r" -le 1000 || { echo OK; exit; }
        recurse
    } && r=0 && recurse

Depending on the history graph, subtree split can recurse deeply
enough to encounter this limit. Rewrite the rejoin-deepening
algorithm to reduce recursive calls.

---
Changes in v2:
- Rebase on master

---
Colin Stagner (3):
      contrib/subtree: reduce function side-effects
      contrib/subtree: functionalize split traversal
      contrib/subtree: reduce recursion during split

 contrib/subtree/git-subtree.sh | 95 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 7 deletions(-)
---
base-commit: 628a66ccf68d141d57d06e100c3514a54b31d6b7
change-id: 20260304-cs-subtree-split-recursion-6a7083cf9163

Best regards,
--  
Colin Stagner <ask+git@howdoi.land>

