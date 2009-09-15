From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git crashes on pull
Date: Tue, 15 Sep 2009 12:22:55 -0700
Message-ID: <7vljkg57xs.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MndcW-0000x2-Um
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 21:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758573AbZIOTXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758515AbZIOTXE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 15:23:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbZIOTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 15:23:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F4143322E;
	Tue, 15 Sep 2009 15:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGmly+R+MOWxI6HMSKxzZyIRrJM=; b=Ofgx5u
	a9zjPmVAyDJsvOsl8msvrEjKrULky3Ype7APfX1hirRB2J37H6Wmc4x+4zrxDklt
	LG2hkKdwVLjCQhdA2pc+l7zxL+li8UOgufO0BOWgiSgTQo7GaVwQpU7aEzDhIuMq
	iB7fctyVqsui/eun2dummqTOu+JJoaBuJaLiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBEfaJ2HkqMxu3z5nwqzc0W4KXLBkerd
	1khH2fD/JNduW84Z9xuRLL3lR+E/eyzhMRekcxpJEYW2fp0/2icPb/9C/h+grPdM
	9SlAy2MrWavWnkAAD3n3Ad8FB301KcwN0mnsG3GfAO68QhseicGdTc3wy+I7IpAP
	wiZ7mf0gNl8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 537E53322C;
	Tue, 15 Sep 2009 15:23:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B13AA3322B; Tue, 15 Sep
 2009 15:22:57 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de>
 (Guido Ostkamp's message of "Tue\, 15 Sep 2009 20\:47\:41 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E62494E-A22D-11DE-84D6-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128583>

Guido Ostkamp <git@ostkamp.fastmail.fm> writes:

> I have a clone of http://git.postgresql.org/git/postgresql.git where
> head is at commit 167501570c74390dfb7a5dd71e260ab3d4fd9904.
>
> I'm using Git version 1.6.5.rc1.10.g20f34 (should be at commit
> 20f34902d154f390ebaa7eed7f42ad14140b8acb from Mon Sep 14 10:49:01 2009
> +0200)
>
> Now when I 'git pull' then Git crashes with
>
> git pull 2>&1 > /tmp/git-error
> *** glibc detected *** git-remote-curl: free(): invalid pointer:

Please try this patch, which I have been preparing for later pushout.

From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 14 Sep 2009 14:48:15 -0700
Subject: [PATCH] http.c: avoid freeing an uninitialized pointer

An earlier 59b8d38 (http.c: remove verification of remote packs) left
the variable "url" uninitialized; "goto cleanup" codepath can free it
which is not very nice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index d0cc1b3..15926d8 100644
--- a/http.c
+++ b/http.c
@@ -866,7 +866,7 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	int ret = 0;
 	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
-	char *url;
+	char *url = NULL;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (has_pack_index(sha1)) {
-- 
1.6.5.rc1
