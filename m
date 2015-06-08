From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/13] delete_refs(): improve error message
Date: Mon,  8 Jun 2015 13:45:39 +0200
Message-ID: <9f6f3432467c2b12329c16a46c52670f772993e5.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVm-0005aa-3T
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbbFHLqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62370 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbbFHLqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:09 -0400
X-AuditID: 1207440c-f79df6d000000d2d-0d-5575807795a3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 21.B6.03373.77085755; Mon,  8 Jun 2015 07:45:59 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop2017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqFveUBpq0HuDw6LrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGcv+fGYt6GKruHVjI2MD4yOWLkZODgkBE4n+S4uZIGwxiQv31rN1MXJxCAlcZpQ4OW8X
	M4Rzgkni/NntYB1sAroSi3qawTpEBNQkJrYdYgEpYhboYJS4sHwbO0hCWMBaYsaHH2BFLAKq
	EtvWtIHFeQWiJHb8uMgGsU5O4vzxn8wgNqeAhcTd/xfA4kIC5hIft7UzTmDkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJKh4djB+WydziFGAg1GJh/fAopJQIdbE
	suLK3EOMkhxMSqK8XWWloUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJksgHK8KYmVValF+TAp
	aQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQneuHqgRsGi1PTUirTMnBKENBMHJ8hwLimR
	4tS8lNSixNKSjHhQdMQXA+MDJMUDtHc6SDtvcUFiLlAUovUUoy7HnSn/FzEJseTl56VKifNG
	gBQJgBRllObBrYClkFeM4kAfC/Nmg1TxANMP3KRXQEuYgJZ8/1oMsqQkESEl1cDYIsXz68yh
	daebrztKrJhWcz7h3+Xb5gz8smo5ou8/3gyw5W2b82/qesln4g84K6vjnqfYGz+yvr6MqfJN
	48mm3TfUu7IOchpvvZGY/uTXofh5Mh9e5ahEHBTpNNI8rpZ8IV4gcMfUicwFBpzy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271022>

Change the error message from

    Could not remove branch %s

to

    Could not remove reference %s

This change makes sense even for the existing caller, which uses the
function to delete remote-tracking branches.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index c413282..2a2a06d 100644
--- a/refs.c
+++ b/refs.c
@@ -2827,7 +2827,7 @@ int delete_refs(struct string_list *refnames)
 		const char *refname = refnames->items[i].string;
 
 		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
+			result |= error(_("Could not remove reference %s"), refname);
 	}
 
 	return result;
-- 
2.1.4
