From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] commit: suppress status summary when no changes
 staged
Date: Wed, 11 Aug 2010 02:30:28 -0500
Message-ID: <20100811073028.GA5450@burratino>
References: <20100725005443.GA18370@burratino>
 <20100725010230.GI18420@burratino>
 <201008110911.40133.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 11 09:32:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj5nE-0006MK-9K
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 09:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab0HKHcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 03:32:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44557 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0HKHcA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 03:32:00 -0400
Received: by gwb20 with SMTP id 20so3968069gwb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u8GVxaBqzRbnXNy2HwBM+zMFvYN+VMPONjYrFL5y0mE=;
        b=uOesh3WJcbEpMO1UqEtWYCCyVd2dwCyN9QOmi28tV1rWxULA/SA5E+FUV19FLnP230
         7P0SiUaMAgi2EW/CnfF86r8EK1Ls1S1Ct/wwjGnJ8KEChqndKbj2y9ZLiYBf3M4QZPhF
         SiSeufLTZS85DdxfCBqPPzlTa4L5TEYk63Szs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CRYQmw2Wd/H/j6ikOWQCUect5sBwOSpQUcgUiyLQ/eddLC3/fxWAuqg1JINZNqWtaB
         irWjpsT6FcHLY7ZLq1WWAA2YlGImUgutEOQ7++bgksUbw2fGluRt8tm4pwTPBPqgDwq/
         3aZocTU0EH6nLuyL8HD8K0Xg2seNlpdynZnGU=
Received: by 10.151.102.17 with SMTP id e17mr16430844ybm.64.1281511919374;
        Wed, 11 Aug 2010 00:31:59 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v32sm5077190yba.18.2010.08.11.00.31.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 00:31:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008110911.40133.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153196>

Thomas Rast wrote:
> Jonathan Nieder wrote:

>> Example: before:
>>
>> 	$ git commit
>> 	# On branch master
>> 	# Changed but not updated:
>[...]
>> 	no changes added to commit (use "git add" and/or "git commit -a")
>> 	$
>>
>> After:
>>
>> 	$ git commit
>> 	no changes added to commit (use "git add" and/or "git commit -a")
>> 	$
>
> Either Junio just picked this up in the last push or I just never
> noticed before, but this breaks t6040 which tests for the "On branch
> ..." stuff

Yep, =C3=86var noticed the same.  That test is meant to check that
when git commit/status gives status information it reflects the
correct tracking info.  So maybe:

-- 8< --
Subject: t6040 (branch tracking): check =E2=80=9Cstatus=E2=80=9D instea=
d of =E2=80=9Ccommit=E2=80=9D

Among the tests for correct branch tracking output is one that
examines =E2=80=9Cgit commit=E2=80=9D output:

 $ git commit
 # Your branch and 'origin/maint' have diverged,
 # and have 9 and 69 different commit(s) each, respectively.
 [...]
 no changes added to commit (use "git add" and/or "git commit -a")
 $

But we are experimenting with changing that output.  So drop
that test for now and replace it with a test for =E2=80=9Cgit status=E2=
=80=9D
(which was not being checked yet and shares the same output
format and wt-status backend).

Reported-by: Thomas Rast <trast@student.ethz.ch>
Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..3bc91b1 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -64,7 +64,7 @@ test_expect_success 'checkout with local tracked bran=
ch' '
 	grep "is ahead of" actual
 '
=20
-test_expect_success 'status' '
+test_expect_failure 'status' '
 	(
 		cd test &&
 		git checkout b1 >/dev/null &&
--=20
