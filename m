From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Fri, 28 Aug 2009 23:17:27 -0700
Message-ID: <7vljl3p2iw.fsf@alter.siamese.dyndns.org>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
 <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
 <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
 <9e0f31700908270509o1031a027y1b49efe7ea9a4fd3@mail.gmail.com>
 <m3ws4pl6x7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Sorensen <johan@johansorensen.com>,
	Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 08:22:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhHKN-0000F2-PA
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 08:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZH2GRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 02:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZH2GRo
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 02:17:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZH2GRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 02:17:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B8AA3BD2C;
	Sat, 29 Aug 2009 02:17:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hqGaHiK80dPl89XM3n5KDPEaeq8=; b=dvdVWeSg+qwSs116SjzdS7i
	SHEy4CdQDxz03LR+QIG1XE8FkDiWSa71lBMTY8k0dKxR5u74vK8TOmi5Xu0+eEkV
	hhWS2z2u+A4vqDa/ha2KAX3l0EPvIeumQxQYdaSParGxSV2embfmu3ukOTHysF97
	2V+uS4Dyh972rXZVwgmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=R1erH0YW0p75LxATq181iRAW9tSs815fnFpIY9da+sa2qhDNu
	xu6/bKjbLnD6h69xe/6/4undgRgofkqzJeKUT++GENhKcYlahc6vwTYRyM0UwXyS
	iyfvYVa1TXAIEN85Kdx7kyKfajXsUxQvrSvEyVcI2caM/1Tqe9nlKl24Lc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B98E13BD2A;
	Sat, 29 Aug 2009 02:17:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21AC83BD22; Sat, 29 Aug 2009
 02:17:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6B35384-9463-11DE-B32C-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127372>

Jakub Narebski <jnareb@gmail.com> writes:

>> I'd like to suggest the following line from the original patch:
>> 
>>    full-pack integer::
>>         1 if the request was considered a full clone, 0 if it was a
>> partial update (fetch)
>  
> If it is all "want" and no "have", it is clone or fetch into empty
> repository.  If additionaly "want"s cover all refs, it is a clone.
> No need to pass this information: it can be derived.

Well, not exactly.

Here is an iffy RFC patch.  Iffy not in the sense that its implementation
is questionable, but in the sense that I am not really convinced if the
distinction between fetching some (or in the worst case, most) but not all
refs, and fetching full set of refs, into an empty repository is something
worth making.

Does anybody from GitHub have any input?  Is there something that can
still improved to suit GitHub's needs?

-- >8 --
Subject: [PATCH] upload-pack: feed "kind [clone|fetch]" to post-upload-pack hook

A request to clone the repository does not give any "have" but asks for
all the refs we offer with "want".  When a request does not ask to clone
the repository fully, but asks to fetch some refs into an empty
repository, it will not give any "have" but its "want" won't ask for all
the refs we offer.

If we suppose (and I would say this is a rather big if) that it makes
sense to distinguish these two cases, a hook cannot reliably do this
alone.  The hook can detect lack of "have" and bunch of "want", but there
is no direct way to tell if the other end asked for all refs we offered,
or merely most of them.

Between the time we talked with the other end and the time the hook got
called, we may have acquired more refs or lost some refs in the repository
by concurrent operations.  Given that we plan to introduce selective
advertisement of refs with a protocol extension, it would become even more
difficult for hooks to guess between these two cases.

This adds "kind [clone|fetch]" to hook's input, as a stable interface to
allow the hooks to tell these cases apart.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/githooks.txt  |    4 ++++
 t/t5501-post-upload-pack.sh |   24 ++++++++++++++++++++++--
 upload-pack.c               |    4 ++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 036f6c7..c308d29 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -332,6 +332,10 @@ time float::
 size decimal::
     Size of the resulting packfile in bytes.
 
+kind string:
+    Either "clone" (when the client did not give us any "have", and asked
+    for all our refs with "want"), or "fetch" (otherwise).
+
 pre-auto-gc
 -----------
 
diff --git a/t/t5501-post-upload-pack.sh b/t/t5501-post-upload-pack.sh
index 47ee7b5..d89fb51 100755
--- a/t/t5501-post-upload-pack.sh
+++ b/t/t5501-post-upload-pack.sh
@@ -29,7 +29,9 @@ test_expect_success initial '
 	) &&
 	want=$(sed -n "s/^want //p" "$LOGFILE") &&
 	test "$want" = "$(git rev-parse --verify B)" &&
-	! grep "^have " "$LOGFILE"
+	! grep "^have " "$LOGFILE" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = fetch
 '
 
 test_expect_success second '
@@ -43,7 +45,25 @@ test_expect_success second '
 	want=$(sed -n "s/^want //p" "$LOGFILE") &&
 	test "$want" = "$(git rev-parse --verify C)" &&
 	have=$(sed -n "s/^have //p" "$LOGFILE") &&
-	test "$have" = "$(git rev-parse --verify B)"
+	test "$have" = "$(git rev-parse --verify B)" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = fetch
+'
+
+test_expect_success all '
+	rm -fr sub &&
+	HERE=$(pwd) &&
+	git init sub &&
+	(
+		cd sub &&
+		git clone "file://$HERE/.git" new
+	) &&
+	sed -n "s/^want //p" "$LOGFILE" | sort >actual &&
+	git rev-parse A B C | sort >expect &&
+	test_cmp expect actual &&
+	! grep "^have " "$LOGFILE" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = clone
 '
 
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 857440d..8e82179 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -187,6 +187,10 @@ static int run_post_upload_pack_hook(size_t total, struct timeval *tv)
 					(long)tv->tv_sec, (long)tv->tv_usec);
 	if (!err)
 		err |= feed_msg_to_hook(proc.in, "size %ld\n", (long)total);
+	if (!err)
+		err |= feed_msg_to_hook(proc.in, "kind %s\n",
+					(nr_our_refs == want_obj.nr && !have_obj.nr)
+					? "clone" : "fetch");
 	if (close(proc.in))
 		err = 1;
 	if (finish_command(&proc))
-- 
1.6.4.1.307.g70e9f
