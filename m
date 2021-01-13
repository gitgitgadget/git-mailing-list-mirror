Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FFEC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264BF23382
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbhAMOC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbhAMOC4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jan 2021 09:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610546488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=HAErX0HUCslZWPjuV0w+qrlB2m/UI5W7MQi3GuJjyDI=;
        b=aAqOsyH3Wug5IEURBKYkL0vTJEzpq/Qrh+JjE0yi5BVHxHJcinGG/I9nBj1W2ySS8bhdam
        BDH4MzIXVt3mxL2vJR52OsrZwS90aGu9O1L9mk1RZt/5J3gJpR/RQ99LSSsmJhZm+yqmBH
        oRkR1noSZM6b8pKiw2R8VCNLERbbNEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-aHLDf3L8NrKThFGSJMmtcw-1; Wed, 13 Jan 2021 09:01:21 -0500
X-MC-Unique: aHLDf3L8NrKThFGSJMmtcw-1
Received: by mail-wm1-f69.google.com with SMTP id g82so867083wmg.6
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 06:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=HAErX0HUCslZWPjuV0w+qrlB2m/UI5W7MQi3GuJjyDI=;
        b=Jd26v7y521d/fQeK1M70vfHiuAhkGxfeOr7HKsYOZgC6Dh4MY4Oj7a/BDoS27qWiXj
         aBX/A2ay/OdsyFEI0ebDg4UUQ4uyfi+e0YsCKwOlJXAFAy3AxwuAn1kwQdBqmc8tpnm5
         ULdPh1jFngqEq3cnz9AwhXUzfOZii/tA87NJrpuZdBM47sXESoZGnx+0T+VN02GhaqaW
         pP3m+qufo8QYVi83GqH45OdBVqedtNqHLCLDKKkK1AmMpF5rnAQDiC9RJm7ZNFPIVvEs
         WXykLWLeaRRsvpfaik/FtzXTAu4xP44eoemJn9UKV2reVzGJlljv+f1QcnP6U4wmVAkt
         5sug==
X-Gm-Message-State: AOAM530GM+V3d3XF1FbKjhkBNVH0sxnd+AdeiJX9AWWpBESkGEmD+JZp
        DnSNeHtXg0sBCGCq+LX2KNZ50yXGLoV0xWBIe4RdBMAzprz3IeEHOR4W2EJIG9IyfTMAkiwX/Vk
        KS03OOfS3Q56tPsQtbXXgyX7tcaxFX5lCodGMAGYRCPE0xPgudpY1Db7gLQ==
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr2738507wrx.211.1610546479811;
        Wed, 13 Jan 2021 06:01:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuWJQcUGUXoSSnIpeO/YXf9UFCXlCXLzvOouWzHvmKRF9W8Y0HRjgrKAR41PRWxUR6WWBvvA==
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr2738486wrx.211.1610546479521;
        Wed, 13 Jan 2021 06:01:19 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
        by smtp.gmail.com with ESMTPSA id d2sm3353407wre.39.2021.01.13.06.01.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:01:18 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:01:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     git@vger.kernel.org
Subject: git am fails because of weird text in commit log
Message-ID: <20210113085846-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys!
So someone sends me a patch with --- in the commit log, like this below.
Result: git am gets confused and can't apply the patch.
Shouldn't git format-patch at least complain about commit log
like this, if not mangle it in some way?

Thanks!

----- Forwarded message from Jiahui Cen <cenjiahui@huawei.com> -----

Return-Path: cenjiahui@huawei.com
Received: from mail.corp.redhat.com [10.4.203.66]
	by tuck.redhat.com with IMAP (fetchmail-6.4.14 polling redhat account mtsirkin)
	for <mst@localhost> (single-drop); Thu, 07 Jan 2021 06:43:47 -0500 (EST)
Received: from zmta04.collab.prod.int.phx2.redhat.com (LHLO
	zmta04.collab.prod.int.phx2.redhat.com) (10.5.81.11) by
	zmail25.collab.prod.int.phx2.redhat.com with LMTP; Thu, 7 Jan 2021 06:43:30
	-0500 (EST)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	by zmta04.collab.prod.int.phx2.redhat.com (Postfix) with ESMTP id 29925D192E
	for <mtsirkin@mail.corp.redhat.com>; Thu,  7 Jan 2021 06:43:30 -0500 (EST)
Received: by smtp.corp.redhat.com (Postfix)
	id F329610FFE73; Thu,  7 Jan 2021 11:43:29 +0000 (UTC)
Delivered-To: mtsirkin@redhat.com
Received: from mimecast-mx02.redhat.com (mimecast02.extmail.prod.ext.rdu2.redhat.com [10.11.55.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EEF0A1008B7C
	for <mtsirkin@redhat.com>; Thu,  7 Jan 2021 11:43:29 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE23A8007D9
	for <mtsirkin@redhat.com>; Thu,  7 Jan 2021 11:43:29 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=dkim.mimecast.com; s=201903; t=1610019809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=7xCM6kqgaZVYVmLgjlhzpVio7ybFFGY+vI8JLzIs3vw=;
	b=JAZFv2+n3oG0ywJT4mRDovwnjEYv1xBJTtIr/86qaa9GJfLbwHn9eH+HMjcpiZa1Ayli1A
	9Z67hv85lHhczbEoqxWHkX4iQauDRYkI5IJuvGfld2nW6qxpAeQdCGOm8aRlZn4vSqn9AN
	qOWYmzHd5UnRVmATlnkidDCzFK4EH5G5ailMHwOseMD0MbPy7PzlLScsWL8pIiCIL8qYLn
	UPXYmOk/9s3Xba4w+Vwx0boLiDLN/Uz+rKEvYudsXmmZhE2iq42njp8NtCkvYRyzZ2UNzI
	36R/aAQiHdB4+6ydIcohWat/zIlrmKhOx8tY8ErwK1YJvxpT9SyRfaiDXH+saw==
ARC-Seal: i=1; s=201903; d=dkim.mimecast.com; t=1610019809; a=rsa-sha256;
	cv=none;
	b=IYWl2HjYEs9WxfpF0FSP4+0osN30yVCTxn8HwP4uOb/oQwH6Z2q3Be3GAzW1VlwcW+1RHg
	6XC28GjxS0FrcGUzAeMMKUnyApWcmjnpjs48oJP+5lFn199Vl3aiAV/SkA2J3j3F9+QxGF
	yfFtlWwrgRbXPQfwj42T+58bfmvSEFuOZzdskOit0ng9qgf9d9jFDLC3OlxoNFBU5Y88u+
	M587dKRSPZl81xG8aYIcbdXU+kfsdalC+hHC13CCbxvQnduKx5gHQxX0cxYTEhOfY4sare
	+yJFPrmgTdHrA3Wp9nb9p+zCimnVNH3NQjZoP6mEp4DJgTgTy21XyPqcGybjMA==
ARC-Authentication-Results: i=1;
	relay.mimecast.com;
	dkim=none;
	dmarc=none;
	spf=pass (relay.mimecast.com: domain of cenjiahui@huawei.com designates 45.249.212.191 as permitted sender)
	smtp.mailfrom=cenjiahui@huawei.com
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com
	[45.249.212.191]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-379-O4GKzptQMXyigWpxPtEsjA-1; Thu, 07 Jan 2021 06:43:23 -0500
X-MC-Unique: O4GKzptQMXyigWpxPtEsjA-1
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DBPV46PZlzj4Zx;
	Thu,  7 Jan 2021 19:42:20 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS407-HUB.china.huawei.com
	(10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
	19:43:06 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Paolo
	Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	xieyingtai@huawei.com, wu.wubin@huawei.com,
	Jiahui Cen <cenjiahui@huawei.com>
Subject: [PATCH v4 2/8] acpi: Fix unmatched expected DSDT.pxb file
Date: Thu, 7 Jan 2021 19:40:37 +0800
Message-ID: <20210107114043.9624-3-cenjiahui@huawei.com>
In-Reply-To: <20210107114043.9624-1-cenjiahui@huawei.com>
References: <20210107114043.9624-1-cenjiahui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Authentication-Results: relay.mimecast.com;
	dkim=none;
	dmarc=none;
	spf=pass (relay.mimecast.com: domain of cenjiahui@huawei.com designates 45.249.212.191 as permitted sender)
	smtp.mailfrom=cenjiahui@huawei.com
X-Mimecast-Spam-Score: 3
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection Definition;Similar Internal Domain=false;Similar Monitored
	External Domain=false;Custom External Domain=false;Mimecast External Domain=false;Newly Observed Domain=false;Internal User
	Name=false;Custom Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat
	Dictionary=false;Custom Threat Dictionary=false
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Status: RO
Content-Length: 7858
Lines: 189

Commit fe1127da11 ("unit-test: Add the binary file and clear diff.h") does not
use the up-to-date expected file for pxb for ARM virt.

Fix the expected DSDT.pxb file.

Full diff of changed file disassembly:

diff -ru /tmp/old/tests/data/acpi/virt/DSDT.pxb.dsl /tmp/new/tests/data/acpi/virt/DSDT.pxb.dsl
--- /tmp/old/tests/data/acpi/virt/DSDT.pxb.dsl  2021-01-07 17:04:51.246831080 +0800
+++ /tmp/new/tests/data/acpi/virt/DSDT.pxb.dsl  2021-01-07 17:11:59.566831080 +0800
@@ -9,9 +9,9 @@
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001E7A (7802)
+ *     Length           0x00001DF9 (7673)
  *     Revision         0x02
- *     Checksum         0x57
+ *     Checksum         0x42
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -45,32 +45,6 @@
             })
         }

-        Device (FLS0)
-        {
-            Name (_HID, "LNRO0015")  // _HID: Hardware ID
-            Name (_UID, Zero)  // _UID: Unique ID
-            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
-            {
-                Memory32Fixed (ReadWrite,
-                    0x00000000,         // Address Base
-                    0x04000000,         // Address Length
-                    )
-            })
-        }
-
-        Device (FLS1)
-        {
-            Name (_HID, "LNRO0015")  // _HID: Hardware ID
-            Name (_UID, One)  // _UID: Unique ID
-            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
-            {
-                Memory32Fixed (ReadWrite,
-                    0x04000000,         // Address Base
-                    0x04000000,         // Address Length
-                    )
-            })
-        }
-
         Device (FWCF)
         {
             Name (_HID, "QEMU0002")  // _HID: Hardware ID
@@ -665,9 +639,6 @@
         {
             Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
-            Name (_ADR, Zero)  // _ADR: Address
-            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
-            Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, 0x80)  // _BBN: BIOS Bus Number
             Name (_UID, 0x80)  // _UID: Unique ID
             Name (_STR, Unicode ("pxb Device"))  // _STR: Description String
@@ -1857,7 +1828,7 @@
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
             Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
-            Name (_UID, "PCI0")  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
             Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
@@ -2983,41 +2954,37 @@
                 Return (0x0000004010000000)
             }

-            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
-                Return (ResourceTemplate ()
-                {
-                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
-                        0x0000,             // Granularity
-                        0x0000,             // Range Minimum
-                        0x007F,             // Range Maximum
-                        0x0000,             // Translation Offset
-                        0x0080,             // Length
-                        ,, )
-                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
-                        0x00000000,         // Granularity
-                        0x10000000,         // Range Minimum
-                        0x3EFEFFFF,         // Range Maximum
-                        0x00000000,         // Translation Offset
-                        0x2EFF0000,         // Length
-                        ,, , AddressRangeMemory, TypeStatic)
-                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
-                        0x00000000,         // Granularity
-                        0x00000000,         // Range Minimum
-                        0x0000FFFF,         // Range Maximum
-                        0x3EFF0000,         // Translation Offset
-                        0x00010000,         // Length
-                        ,, , TypeStatic, DenseTranslation)
-                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
-                        0x0000000000000000, // Granularity
-                        0x0000008000000000, // Range Minimum
-                        0x000000FFFFFFFFFF, // Range Maximum
-                        0x0000000000000000, // Translation Offset
-                        0x0000008000000000, // Length
-                        ,, , AddressRangeMemory, TypeStatic)
-                })
-            }
-
+                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
+                    0x0000,             // Granularity
+                    0x0000,             // Range Minimum
+                    0x007F,             // Range Maximum
+                    0x0000,             // Translation Offset
+                    0x0080,             // Length
+                    ,, )
+                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+                    0x00000000,         // Granularity
+                    0x10000000,         // Range Minimum
+                    0x3EFEFFFF,         // Range Maximum
+                    0x00000000,         // Translation Offset
+                    0x2EFF0000,         // Length
+                    ,, , AddressRangeMemory, TypeStatic)
+                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
+                    0x00000000,         // Granularity
+                    0x00000000,         // Range Minimum
+                    0x0000FFFF,         // Range Maximum
+                    0x3EFF0000,         // Translation Offset
+                    0x00010000,         // Length
+                    ,, , TypeStatic, DenseTranslation)
+                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+                    0x0000000000000000, // Granularity
+                    0x0000008000000000, // Range Minimum
+                    0x000000FFFFFFFFFF, // Range Maximum
+                    0x0000000000000000, // Translation Offset
+                    0x0000008000000000, // Length
+                    ,, , AddressRangeMemory, TypeStatic)
+            })
             Name (SUPP, Zero)
             Name (CTRL, Zero)
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities

Fixes: fe1127da11 ("unit-test: Add the binary file and clear diff.h")
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 tests/data/acpi/virt/DSDT.pxb | Bin 7802 -> 7673 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.pxb
index d5f0533a02d62bc2ae2db9b9de9484e5c06652fe..76f5f1c2fd487644c6b4f827a70ad770edb9fdc9 100644
GIT binary patch
delta 70
zcmV-M0J;DAJo!5cL{mgm`5gcN0z#1r8v=ygktblW?YIa6OPZ6X2_m!G35f{>PNz^q
cNt3DxACrg^53`&Ttq27OUqez;vr-%=0*oRUFaQ7m

delta 217
zcmexq{mX{SCD<jTN{)enDSRTAG*j!-iRuaUhHgH=1|0Doo-VvTenI{Q28N~#9Py!^
zE<n;bC|FRCi?5B7fsp|MSSlH!n?PC&v1wsM*TMqS1=eEW7Vhi@(GuwD8){%+U<5Qj
zIK*+|g83XwzOyGgaw_pVx&(nNb#?@r6YT1~If1i>lgWL><aa`bth@ovo(7xch1YU$
Qia3I;VOX;HqO=AR0CN5_Pyhe`

-- 
2.29.2

----- End forwarded message -----

