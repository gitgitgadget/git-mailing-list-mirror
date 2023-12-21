Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67D7691D
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Vef+6wW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703200397; x=1703805197; i=l.s.r@web.de;
	bh=2zLetmXicq0i2JGreYXYW4ybSs2WLr8SfUsTc9ndOkg=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=Vef+6wW/bt4NNYbfMQqC/hrSzIOJ1rKyTdx8RSaKChgGGTjxS24LB5vqWP/6cIBN
	 bYrImJBNjVC79F96gXooNhf+JhHMyfSJiBJTh6DworXJFo7S1ZK0yOqccqixqJuuA
	 dO1jmD+p0cI0Ksdt4DZK4QtLL8/Igd0qTWjDPeFz8D8sxRE1uC2yrrXtrWBdKsWB7
	 p/J6+XxVDZSXeNdawCCL/npco7HLyQ5UjQpcwTy1r0a6RA70Xh+7mhJCeX6xxjdOE
	 S774PSrJZ+jgiNyvubi5nheF0DSj9LYSHnnCESUgGgZIOXPJfOL7tsKZFiC/M6srp
	 7B//4I1ZBt1nRKDOMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1rZdXH0ku6-00LvBz; Fri, 22
 Dec 2023 00:13:17 +0100
Message-ID: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
Date: Fri, 22 Dec 2023 00:13:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mem-pool: fix big allocations
Cc: Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5vaxK9jgSq6Dg2YAJerUpDueOxBaCrl1BsEr5/L7PrNmbBZYnAm
 1cxFGmh4xKe4hYaC8YsU0m1tn1aYaOtiZN41Amv7uVZSVp6w3QSIkNCq9Cl2mvZ91zHT73y
 /zFrGmHhAgcWnoAsoYcW+dUNXig49PSyb+ofFfTcLw/SxQ+NG3Oc1l6ONZJ8L9lDa/C6O/S
 zSsaT8LYsakdE21ZEMlzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5d68egDDhLM=;eK2n/MMFCCtkfguQFoFacV1jG0x
 YdWNT5Z4uVRhOJJikjapY8yItUnltHWOk7/JmlfV0EKg1ZESIfYi+zST9fr21BVCeYs56bhTZ
 YItQHsSbP0mtbIS55F8Q7q/33bG+4B6N11i6Jjpn2a7jI3h1wuEbCv6KnQ8aDnZ4muo8XaBEl
 iz4Xsubw3LTBo6+JZWfLIqlB0VlAR6y9SjkhDKqb4efj6+P5NJW4YCtF+3Ssz7fq3KUCHis9s
 DkF5gtb0xj05oME9fIfhHUNb9EWPzRRQeHMHpPZ6HKSP7rRRSAm4QZOXpZFek2JQ20GXL3n9g
 MRsb9BVJzbSUMq9TTcDs+DnJ2l4GryOCKkP6fBgndxJbuPFHmu6NyF+Ks9ULlXU3H9fKRp5PP
 lKvlzL6OYVawRHgZlizRSCrkyUd65YWlSw1+3TbSUEycRKzyRPQR+cB4bUYbu0U3ZKmxDIqEb
 7XB8LqZOFk1lshH63m9hMu2rZ/l+Kcp/LRLBzqlbBhBVA5mcBIjKhM5mXlY98xPzwFG/GqNuc
 xKszwBNuwC1beKqkOBy8XFWESR+qwzYAkvhjbqOPw30wHD9m61VszPnoV6d9bZ5R1i3IbCxC7
 0Cedv+jgoY/jAB15INGEvgm6+kMRqcqnqWEBuXdZDqbafRXA3LED0AbcpSzW6dbjqU0skplqX
 vKI5O+bWIXxuzOHvSK9JSiZ+Xkd7L/obe5kLgHeLk3ORnO256Gz1R02kaq6P1sjgsNBV75HlU
 WtR2LDgv36X9o0Ooi6AQMXbdq/I1MrHyeACTZEqBwDDaowGV+5aQWBUC6ovM/lmoJSOHlCAMY
 GDxT6o5CZfpJsOSN9kbx74CAAv3IjUD64t/F+iQ4hE9GGmVM6pmmAcfs8rRSLx7tL2cARU64x
 f+119+LA8/F4/V531YLRutpB7Ft5NGii8zL4e2mkYeWrnZ30Lkx7n1bK1EyRqrVz0xZfX+pXQ
 Okn+EA==

Memory pool allocations that require a new block and would fill at
least half of it are handled specially.  Before 158dfeff3d (mem-pool:
add life cycle management functions, 2018-07-02) they used to be
allocated outside of the pool.  This patch made mem_pool_alloc() create
a bespoke block instead, to allow releasing it when the pool gets
discarded.

Unfortunately mem_pool_alloc() returns a pointer to the start of such a
bespoke block, i.e. to the struct mp_block at its top.  When the caller
writes to it, the management information gets corrupted.  This affects
mem_pool_discard() and -- if there are no other blocks in the pool --
also mem_pool_alloc().

Return the payload pointer of bespoke blocks, just like for smaller
allocations, to protect the management struct.

Also update next_free to mark the block as full.  This is only strictly
necessary for the first allocated block, because subsequent ones are
inserted after the current block and never considered for further
allocations, but it's easier to just do it in all cases.

Add a basic unit test to demonstate the issue by using mem_pool_calloc()
with a tiny block size, which forces the creation of a bespoke block.
Without the mem_pool_alloc() fix it reports zeroed pointers:

   ok 1 - mem_pool_calloc returns 100 zeroed bytes with big block
   # check "((pool->mp_block->next_free) !=3D (((void*)0))) =3D=3D 1" fail=
ed at t/unit-tests/t-mem-pool.c:22
   #    left: 0
   #   right: 1
   # check "((pool->mp_block->end) !=3D (((void*)0))) =3D=3D 1" failed at =
t/unit-tests/t-mem-pool.c:23
   #    left: 0
   #   right: 1
   not ok 2 - mem_pool_calloc returns 100 zeroed bytes with tiny block
   1..2

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile                  |  1 +
 mem-pool.c                |  6 +++---
 t/unit-tests/t-mem-pool.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 t/unit-tests/t-mem-pool.c

diff --git a/Makefile b/Makefile
index 88ba7a3c51..15990ff312 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
 THIRD_PARTY_SOURCES +=3D sha1dc/%

 UNIT_TEST_PROGRAMS +=3D t-basic
+UNIT_TEST_PROGRAMS +=3D t-mem-pool
 UNIT_TEST_PROGRAMS +=3D t-strbuf
 UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAM=
S))
 UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS=
))
diff --git a/mem-pool.c b/mem-pool.c
index c34846d176..e8d976c3ee 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -99,9 +99,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)

 	if (!p) {
 		if (len >=3D (pool->block_alloc / 2))
-			return mem_pool_alloc_block(pool, len, pool->mp_block);
-
-		p =3D mem_pool_alloc_block(pool, pool->block_alloc, NULL);
+			p =3D mem_pool_alloc_block(pool, len, pool->mp_block);
+		else
+			p =3D mem_pool_alloc_block(pool, pool->block_alloc, NULL);
 	}

 	r =3D p->next_free;
diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
new file mode 100644
index 0000000000..2295779b0b
=2D-- /dev/null
+++ b/t/unit-tests/t-mem-pool.c
@@ -0,0 +1,34 @@
+#include "test-lib.h"
+#include "mem-pool.h"
+
+#define check_ptr(a, op, b) check_int(((a) op (b)), =3D=3D, 1)
+
+static void setup_static(void (*f)(struct mem_pool *), size_t block_alloc=
)
+{
+	struct mem_pool pool =3D { .block_alloc =3D block_alloc };
+	f(&pool);
+	mem_pool_discard(&pool, 0);
+}
+
+static void t_calloc_100(struct mem_pool *pool)
+{
+	size_t size =3D 100;
+	char *buffer =3D mem_pool_calloc(pool, 1, size);
+	for (size_t i =3D 0; i < size; i++)
+		check_int(buffer[i], =3D=3D, 0);
+	if (!check_ptr(pool->mp_block, !=3D, NULL))
+		return;
+	check_ptr(pool->mp_block->next_free, <=3D, pool->mp_block->end);
+	check_ptr(pool->mp_block->next_free, !=3D, NULL);
+	check_ptr(pool->mp_block->end, !=3D, NULL);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(setup_static(t_calloc_100, 1024 * 1024),
+	     "mem_pool_calloc returns 100 zeroed bytes with big block");
+	TEST(setup_static(t_calloc_100, 1),
+	     "mem_pool_calloc returns 100 zeroed bytes with tiny block");
+
+	return test_done();
+}
=2D-
2.43.0
