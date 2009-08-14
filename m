From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Linus' sha1 is much faster!
Date: Sat, 15 Aug 2009 00:25:36 +0100
Message-ID: <4A85F270.20703@draigBrady.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010502090801070300010206"
Cc: Git Mailing List <git@vger.kernel.org>
To: Bug-coreutils@gnu.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-From: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org Sat Aug 15 01:29:30 2009
Return-path: <bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org>
Envelope-to: gcgcb-bug-coreutils-616@gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc6DB-0001HP-SR
	for gcgcb-bug-coreutils-616@gmane.org; Sat, 15 Aug 2009 01:29:30 +0200
Received: from localhost ([127.0.0.1]:39794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Mc6DB-000473-4x
	for gcgcb-bug-coreutils-616@gmane.org; Fri, 14 Aug 2009 19:29:29 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Mc6D6-00042L-Dv
	for bug-coreutils@gnu.org; Fri, 14 Aug 2009 19:29:24 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Mc6D1-0003uQ-Cm
	for Bug-coreutils@gnu.org; Fri, 14 Aug 2009 19:29:23 -0400
Received: from [199.232.76.173] (port=60824 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Mc6D1-0003u2-1r
	for Bug-coreutils@gnu.org; Fri, 14 Aug 2009 19:29:19 -0400
Received: from mail120.emailantidote.com ([80.169.59.120]:61809
	helo=SC-MTA-01.mxsweep.com)
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <P@draigBrady.com>) id 1Mc6D0-0004fC-Dy
	for Bug-coreutils@gnu.org; Fri, 14 Aug 2009 19:29:18 -0400
Received: from tombstone.lincor.com ([84.203.137.218]) by
	SC-MTA-01.mxsweep.com with Microsoft SMTPSVC(7.0.6001.18000); 
	Sat, 15 Aug 2009 00:29:15 +0100
Received: from [192.168.2.25] (crom.labs.lincor.com [192.168.2.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tombstone.lincor.com (Postfix) with ESMTP id E5ABD6105239;
	Sat, 15 Aug 2009 00:29:13 +0100 (IST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071008)
X-Enigmail-Version: 0.95.0
X-OriginalArrivalTime: 14 Aug 2009 23:29:15.0228 (UTC)
	FILETIME=[0970E1C0:01CA1D37]
x-MXSweep-CtasdSpam: Unknown
x-MXSweep-CtasdVirus: Unknown
x-Ctasd-RefID: str=0001.0A090205.4A85F34C.0023,ss=1,fgs=0
x-MXSweep-KeywordsCount: 0
x-MXSweep-MetaScanResult: Clean
x-MXSweep-MetaScanThreat: 
x-MXSweep-VirusScanned: 14/08/2009 23:29:16
x-MXPurifier-SpamScore: 0
x-MXPurifier-VirusScore: 0
x-MXSweep-Threat: Clean
X-MXUniqueID: 28651ecf-d32b-4a5c-9d6c-34493eea381c
X-detected-operating-system: by monty-python.gnu.org: Windows 2000 SP2+,
	XP SP1+ (seldom 98)
X-BeenThere: bug-coreutils@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "GNU Core Utilities: bug reports and discussion"
	<bug-coreutils.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-coreutils>
List-Post: <mailto:bug-coreutils@gnu.org>
List-Help: <mailto:bug-coreutils-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=subscribe>
Sender: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Errors-To: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125967>

--------------010502090801070300010206
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've noticed before that coreutils hashing utils
were a little behind in performance, but was prompted
to look at it again when I noticed the recently
updated sha1 implementation in git:
http://git.kernel.org/?p=3Dgit/git.git;a=3Dhistory;f=3Dblock-sha1;h=3Dd31=
21f7;hb=3Dpu

Testing that with the attached program which I wrote
in a couple of mins to try and match sha1sum's system calls
shows that it's around 33% faster, as shown below:

$ gcc $(rpm -q --qf=3D"%{OPTFLAGS}\n" coreutils) linus-sha1.c sha1.c -o l=
inus-sha1

$ time ./linus-sha1 300MB_file
df1e19e245fee4f53087b50ef953ca2c8d1644d7  300MB_file
real    0m2.742s
user    0m2.516s
sys     0m0.206s

$ time ~/git/coreutils/src/sha1sum 300MB_file
df1e19e245fee4f53087b50ef953ca2c8d1644d7  300MB_file

real    0m4.166s
user    0m3.846s
sys     0m0.298s

So, could we use that code in coreutils?
Think of all the dead fish it would save.

I've also attached a trivial block-sha1 patch which doesn't
affect performance, but does suppress a signed unsigned
comparison warning which occurs with -Wextra for example.

cheers,
P=C3=A1draig.

--------------010502090801070300010206
Content-Type: text/x-csrc; name="linus-sha1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="linus-sha1.c"

/* gcc -O2 -Wall linus-sha1.c sha1.c -o linus-sha1 */
#include <stdio.h>
#include <stdlib.h>
#include "sha1.h"

int main(int argc, char** argv)
{
    if (argc != 2) return 1;
    const char* filename = argv[1];
    FILE *fp = fopen (filename, "r");
    if (!fp) return 1;

    #define BS 4096 /* match coreutils */

    blk_SHA_CTX ctx;
    blk_SHA1_Init(&ctx);
    size_t nr;
    char buf[BS];
    while ((nr=fread_unlocked(buf, 1, sizeof(buf), fp)))
        blk_SHA1_Update(&ctx, buf, nr);
    unsigned char hash[20];
    blk_SHA1_Final(hash, &ctx);
    int i;
    for (i=0; i<sizeof(hash); i++)
        printf("%02x",*(hash+i));
    printf("  %s\n", filename);

    return 0;
}

--------------010502090801070300010206
Content-Type: text/x-patch; name="block-sha1-signed-warning.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="block-sha1-signed-warning.diff"

>From fa75e818836f763357ff9b7bbde3327e1aabbe47 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?P=C3=A1draig=20Brady?= <P@draigBrady.com>
Date: Sat, 15 Aug 2009 00:17:30 +0100
Subject: [PATCH] block-sha1: suppress signed unsigned comparison warning

* block-sha1/sha1.c: Use unsigned ints as the values
will never go negative.
---
 block-sha1/sha1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index d3121f7..be763d8 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -231,13 +231,13 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 {
-	int lenW = ctx->size & 63;
+	unsigned int lenW = ctx->size & 63;
 
 	ctx->size += len;
 
 	/* Read the data into W and process blocks as they get full */
 	if (lenW) {
-		int left = 64 - lenW;
+		unsigned int left = 64 - lenW;
 		if (len < left)
 			left = len;
 		memcpy(lenW + (char *)ctx->W, data, left);
-- 
1.6.2.5


--------------010502090801070300010206--
