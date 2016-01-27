From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 10/20] mingw: disable mkfifo-based tests
Date: Wed, 27 Jan 2016 17:19:43 +0100 (CET)
Message-ID: <8d21d835151c2b8ce4d8897a3fffaddba411959b.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSp4-0002OW-IK
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750AbcA0QTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:63242 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933539AbcA0QTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:48 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MLj5z-1aPHtr23T1-000tPQ; Wed, 27 Jan 2016 17:19:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0AQo/s2PxwDAalFgKpL0yM9qIZqRKMkbLXtn3jXNsOKjw+zM+se
 QCj49mpiu92Cr6bag2iYStgVt2a1cOfFysX+rB3NhOg7WojFa8Ktx0slMsWL/gpC5pnP8tF
 E74i1WlyEP9drwQJ8pJ2+aKazxWFwMyf1XLuInCEvoKbqT9HPRqWNpfB0TBzd3a9t3Pz/ee
 g+ZQKuDOWiq3oQSW1NK7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1slmlK4y7w0=:bH2IB+xeELBrS0Ct9e2/kY
 3jcbH54G4nLDcUa/lMKTGAZxfXmXX8Tc/nvBj4FEk51v4sQiYiykkMs3UBKT6u974N48RQ10X
 wNm2qwApwfWcqmaZtzFv7y/uuKokDbaa3xG7HwCSxsLgh7tmzY4Q3wrVRmN8HKDSEZG+ceygf
 nDax0vzmNPwvENE5U0+QgFmgsjZOex4PeY9TIhm54DlDsVaKmsemnulQ3MI7aGLyw3CEj9rYG
 E6EMC7lV+FhygeUJjN7UBiLclsIf3kUw03x6CzhfoG/V3YSAEINDfSnCzme+loRMvKcA3yggU
 EPxMTeNLIRd/IHFRaXxhZrYiH+e6RggAa4ECusr+qqmIsCdmE9Iz1RnFEXC47HXz/vj9gz/Sg
 Ktoi4F4CTDiKnCCV2Zrx3SNEp30MFCjdgySFC7Vroaq1tExPS7v2LKf6lh9K9625THY5Lww4e
 wkrypJQrte81hKQsEP3w5konnhHG6ACHmgFrqnbxVOpcY3A8KsEqzpZ/x0lssu+E2kA0dkMlm
 HtAA016mK7CgMggq4IdwC1avAiaPuQhnliMhXxFzKQGdBIEn5Zqn3maf78S0BQWyfzxq+XDab
 8JBO54w0fx0VwuZ2R9qa5xoca4sFNyvUWb7H6D+o6YXuz0tRjq0igrXoaaEgWf2N3lClOdUxD
 Y7OLTaBYd4FODbiDZcbRqls4G1epmmxdquwUC/YfEjFLSA/C0wG69DwOkhm0k9VoNDaqjGUvd
 H18qH68DJ8PiJBhOHzQSQf43xKCOELrVHAIY0F9E9LuzwXzyVtyoAuV+JKE4eCi3EHBbZeQN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284930>

MSYS2 (the POSIX emulation layer used by Git for Windows' Bash) actually
has a working mkfifo. The only problem is that it is only emulating
named pipes through the MSYS2 runtime; The Win32 API has no idea about
named pipes, hence the Git executable cannot access those pipes either.

The symptom is that Git fails with a '<name>: No such file or directory'
because MSYS2 emulates named pipes through special-crafted '.lnk' files.

The solution is to tell the test suite explicitly that we cannot use
named pipes when we want to test on Windows.

This lets t4056-diff-order.sh, t9010-svn-fe.sh and t9300-fast-import.sh
pass.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd4b02e..1470c8d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -998,7 +998,7 @@ test_i18ngrep () {
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
 	case $(uname -s) in
-	CYGWIN*)
+	CYGWIN*|MINGW*)
 		false
 		;;
 	*)
-- 
2.7.0.windows.1.7.g55a05c8
