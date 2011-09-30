From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] refs: Remove duplicates after sorting with qsort
Date: Fri, 30 Sep 2011 18:56:57 +0100
Message-ID: <20110930175658.1220.11552.julian@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
 <20110929041811.5363.33396.julian@quantumfyre.co.uk>
 <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
 <20110929221143.23806.25666.julian@quantumfyre.co.uk>
 <7v62karjv3.fsf@alter.siamese.dyndns.org> <4E85E07C.5070402@alum.mit.edu>
 <7vk48qouht.fsf@alter.siamese.dyndns.org>
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 20:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9hRZ-0006Xh-8A
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 20:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab1I3SEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 14:04:12 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:40275 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757183Ab1I3SEK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 14:04:10 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 73826C060D;
	Fri, 30 Sep 2011 19:04:09 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 4B8AC36A925;
	Fri, 30 Sep 2011 19:04:09 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5T1eME6rnf3G; Fri, 30 Sep 2011 19:04:08 +0100 (BST)
Received: from [172.16.70.128] (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 2DE5D35F765;
	Fri, 30 Sep 2011 19:04:08 +0100 (BST)
X-git-sha1: 3c3b47317ef07f9030ace60495852861e06d1d61 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <7vk48qouht.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182495>

The previous custom merge sort would drop duplicate entries as part of
the sort.  It would also die if the duplicate entries had different
sha1 values.  The standard library qsort doesn't do this, so we have
to do it manually afterwards.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Fri, 30 Sep 2011 09:38:54 -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> On 09/30/2011 01:48 AM, Junio C Hamano wrote:
>>> This version looks sane, although I have a suspicion that it may 
>>> have
>>> some interaction with what Michael may be working on.
>>
>> Indeed, I have almost equivalent changes in the giant patch series 
>> that
>> I am working on [1].
>
> Good; that was the primary thing I wanted to know.  I want to take
> Julian's patch early but if the approach and data structures were
> drastically different from what you are cooking, that would force
> unnecessary reroll on your part, which I wanted to avoid.
>
> Thanks.

I had a quick look at Michael's code, and it reminded me that I had missed one
thing out.  If we want to keep the duplicate detection & removal from the
original merge sort then this patch is needed on top of v3 of the binary search.

Though I never could figure out how duplicate refs were supposed to appear ... I
tested by editing packed-refs, but I assume that isn't "supported".

 refs.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 4c01d79..cf080ee 100644
--- a/refs.c
+++ b/refs.c
@@ -77,7 +77,29 @@ static int ref_entry_cmp(const void *a, const void *b)
 
 static void sort_ref_array(struct ref_array *array)
 {
+	int i = 0, j = 1;
+
+	/* Nothing to sort unless there are at least two entries */
+	if (array->nr < 2)
+		return;
+
 	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+
+	/* Remove any duplicates from the ref_array */
+	for (; j < array->nr; j++) {
+		struct ref_entry *a = array->refs[i];
+		struct ref_entry *b = array->refs[j];
+		if (!strcmp(a->name, b->name)) {
+			if (hashcmp(a->sha1, b->sha1))
+				die("Duplicated ref, and SHA1s don't match: %s",
+				    a->name);
+			warning("Duplicated ref: %s", a->name);
+			continue;
+		}
+		i++;
+		array->refs[i] = array->refs[j];
+	}
+	array->nr = i + 1;
 }
 
 static struct ref_entry *search_ref_array(struct ref_array *array, const char *name)
-- 
1.7.6.1
