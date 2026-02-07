Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8B33C19C
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494706; cv=none; b=NWrkLpoeECo/+cLFR9a2AEZtNMu9XFKBjn/973K0SbqU4+n00zE8PLcVXZSdsI6wnjwzNHejDwbzcDdF0YGt56U/h+P1siXq6lvJ+MMlcyxptlm6Av0/J4eVBTyGqk3up7omg5Det6Nm8O6KfX6zo18ZytWopG5P/Luc8dZrIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494706; c=relaxed/simple;
	bh=kg41+dqjOzuXFZWYaLWiR0bhM8dISTlb+UAzLYeybg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFnh1oXzsKKjHJUKbM4jQJ/Bxsp+DIpOKneC99aJtLsGPthnr6Vav5WQweYsv2GlfcJOqdqMZ9ksmVT+zsKeoT8c9jY+C7+Vic9EHxkZwM9NOLN5MIHvnCQWeedTGCpkL5gy31IBiPCi6VveLOmb+UBrEulAo2AWJvBxbbl7Sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=m5Ck7Oy1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m5Ck7Oy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494698;
	bh=kg41+dqjOzuXFZWYaLWiR0bhM8dISTlb+UAzLYeybg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=m5Ck7Oy1sv+m1RcYIUXqVehRkr9fh16grMioMo4IcKdWqP3K0Nofe1ZhhReihAlU4
	 iCCgeW+I4g8ejyA7vtqmnB8I0IKCndekuVCg+nC9VjO+smyu3bsJR+W0O16ofFS38X
	 sk18V3SQzv9jcZwcGVej5G7HM5SuAyCyy0xcqsMwpggAnpjlegSgdAYza40evjvwaa
	 k3Ww6OR72G/2msxX32oSrEAwEW8O66v96/A2h2SMKRNkJ9338slc13qQNQ7WZf6ug4
	 Ooqirkm8rFdEwGEJ4q6nJOOiTHXcbvN21GexqXo9/cBGZOxmUGpwuZ8UV/2WdrfliM
	 rtpLz4W2IzMGBh/FWMWd2JB9o+mJEOgkqE1IobQZYdsuRIIaFSb9jc4Nbn7Z5bsnOW
	 oU1kKl2nUI5n/e8rHqYfpo+GDVzeLJJGJJ0sdkjVDRX0urS5tdWhBkeTyXyjOOOb9R
	 XUXTPIs4/onlbtYzVcBo9Bxm+arUtUKj5hFiiae91wpmTba5Nch
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F2ED3243EC;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 16/16] object-file-convert: always make sure object ID algo is valid
Date: Sat,  7 Feb 2026 20:04:46 +0000
Message-ID: <20260207200446.2837699-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, we zero-initialize our object IDs, which sets the algo
member to zero as well, which is not a valid algorithm number.  This is
a bad practice, but we typically paper over it in many cases by simply
substituting the repository's hash algorithm.

However, our new Rust loose object map code doesn't handle this
gracefully and can't find object IDs when the algorithm is zero because
they don't compare equal to those with the correct algo field.  In
addition, the comparison code doesn't have any knowledge of what the
main algorithm is because that's global state, so we can't adjust the
comparison.

To make our code function properly and to avoid propagating these bad
entries, if we get a source object ID with a zero algo, just make a copy
of it with the fixed algorithm.  This has the benefit of also fixing the
object IDs if we're in a single algorithm mode as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file-convert.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index e44c821084..f8dce94811 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -13,7 +13,7 @@
 #include "gpg-interface.h"
 #include "object-file-convert.h"
 
-int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 		      const struct git_hash_algo *to, struct object_id *dest)
 {
 	/*
@@ -21,7 +21,15 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	 * default hash algorithm for that object.
 	 */
 	const struct git_hash_algo *from =
-		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
+		srcoid->algo ? &hash_algos[srcoid->algo] : repo->hash_algo;
+	struct object_id temp;
+	const struct object_id *src = srcoid;
+
+	if (!srcoid->algo) {
+		oidcpy(&temp, srcoid);
+		temp.algo = hash_algo_by_ptr(repo->hash_algo);
+		src = &temp;
+	}
 
 	if (from == to || !to) {
 		if (src != dest)
