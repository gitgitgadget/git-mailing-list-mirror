From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 04 Oct 2012 15:37:15 -0700
Message-ID: <7vmx01x3s4.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7v391ux7im.fsf@alter.siamese.dyndns.org>
 <7vvceqvses.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJu2s-0002ku-G4
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab2JDWhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 18:37:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055Ab2JDWhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 18:37:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67773955D;
	Thu,  4 Oct 2012 18:37:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lDe+sc2l1enHejaBcSGZ3VVVM64=; b=DcT9qs
	SjG0MurfngVrOGoUtoiFZE3FLxUBDm4pswu3ZVRyK+ccHg59enEIGMhgyP5bldT/
	K5+lrhqNdEa8fu0fq1825pVIKU57lD1MORc8aEJnUobTWhiT5akFh59Ei4c8bPoH
	1Oei/dwoYyCrBc8FygPueDLFPmdlT3X5JdVng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCywMnObKgpeCBeIteFmxdNr1U3dmroz
	UjvAnRFwmzlP4sn7mDpzAgSFlpkDWkxH0BLrKcyxFFyKYOe0///KrZUxcEdH+8TZ
	4FulIw4F9leXFtYEcHGiDoSxGX+YYA3J0VSq49GUlkFNsXdg+NKePRDayMz5wZbF
	42QCVK+ZkFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D30955C;
	Thu,  4 Oct 2012 18:37:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89682955B; Thu,  4 Oct 2012
 18:37:16 -0400 (EDT)
In-Reply-To: <7vvceqvses.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Oct 2012 14:28:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CA58CD8-0E74-11E2-909C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207035>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:
>>>
>>>> with current trunk I get the following on an up-to-date Linux tree:
>>>> 
>>>> markus@x4 linux % time git pull
>>>> Already up-to-date.
>>>> git pull  7.84s user 0.26s system 92% cpu 8.743 total
>>>> 
>>>> git version 1.7.12 is much quicker:
>>>> 
>>>> markus@x4 linux % time git pull
>>>> Already up-to-date.
>>>> git pull  0.10s user 0.02s system 16% cpu 0.740 total
>>>
>>> Yikes. I can easily reproduce here. Bisecting between master and
>>> v1.7.12 gives a curious result: the slowdown first occurs with the merge
>>> commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
>>> of its parents is slow. I don't see anything obviously suspect in the
>>> merge, though.
>>
>> I think the following is likely to be the correct solution to this.
>
> No, it is not.  Sorry for the noise.

Here is a tested (in the sense that it passes the test suite, and
also in the sense that an empty pull in the kernel history gives
quick turnaround) patch.  As I do not think we would want to revert
5802f81 (fmt-merge-msg: discard needless merge parents, 2012-04-18)
which was a correctness fix, I think we would rather want to do
something like this.

-- >8 --
Subject: paint_down_to_common(): parse commit before relying on its timestamp

When refactoring the merge-base computation to reduce the pairwise
O(n*(n-1)) traversals to parallel O(n) traversals, the code forgot
that timestamp based heuristics needs each commit to have been
parsed.  This caused an empty "git pull" to spend cycles, traversing
the history all the way down to 0 (because an unparsed commit object
has 0 timestamp, and any other commit object with positive timestamp
will be processed for its parents, all getting parsed), only to come
up with a merge message to be used.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git i/commit.c w/commit.c
index 0246767..213bc98 100644
--- i/commit.c
+++ w/commit.c
@@ -609,6 +609,7 @@ static struct commit *interesting(struct commit_list *list)
 	return NULL;
 }
 
+/* all input commits in one and twos[] must have been parsed! */
 static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
 {
 	struct commit_list *list = NULL;
@@ -617,6 +618,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 
 	one->object.flags |= PARENT1;
 	commit_list_insert_by_date(one, &list);
+	if (!n)
+		return list;
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
 		commit_list_insert_by_date(twos[i], &list);
@@ -737,6 +740,8 @@ static int remove_redundant(struct commit **array, int cnt)
 	redundant = xcalloc(cnt, 1);
 	filled_index = xmalloc(sizeof(*filled_index) * (cnt - 1));
 
+	for (i = 0; i < cnt; i++)
+		parse_commit(array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 
