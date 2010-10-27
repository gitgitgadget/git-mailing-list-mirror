From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests
 with TAP
Date: Tue, 26 Oct 2010 17:18:22 -0700
Message-ID: <7vmxq0ebe9.fsf@alter.siamese.dyndns.org>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net> <20101014172301.GA2770@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 02:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAtiy-0005AM-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 02:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196Ab0J0ASf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 20:18:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0J0ASe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 20:18:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A2B2E2683;
	Tue, 26 Oct 2010 20:18:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=lez5AHjO/y+LJwGqyIV048SRR6I=; b=lJ6pYNJYssCVF8IL0a5VGK7
	3KuojAFC5YMi4KM+CdCwwLW+291MW+cpcClecfWW6Te8KTuwlKD5SVQT8yRBj7Qh
	W9LO/jHdyfApArXE9x6A0YlDvD7rtBPctp5qLDBZqh+GzOnntOkmDART5kazYvky
	u+L0e497k7P7rHPaoeg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JBS76sqW2IVDJ0Hcq5aDl4EVdvhwiu9g1Oa0otcbHTDHhp9+b
	ncda7u21iSbzYn/L4WrTP/BQRQ0/9S9qfKhbU0yXWrDDvod+CnimTOl7U974KSs6
	fAuD3t0b6HZqwDg/5jitG9745wgdxLTjHClNfFr2Wx3i5eM1v/9PVEmNwE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B45FCE267B;
	Tue, 26 Oct 2010 20:18:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8384E267A; Tue, 26 Oct
 2010 20:18:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B90B36C4-E15F-11DF-A1FE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160014>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 14, 2010 at 10:53:36AM +0200, Michael J Gruber wrote:
>
>> +prove: pre-clean
>> +	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
>> +	$(MAKE) clean
>> +
>
> I like the idea. I think the prove output is a little nicer for things
> like -j16, but it's a pain to construct the command line (especially as
> I use --root in GIT_TEST_OPTS to get a significant speedup).
>
> I wonder if anybody is really interested in switching between the
> "prove" and regular test targets, though. I would think you either like
> to use prove or not. So perhaps it makes more sense to put a
> configurable switch for the default target, like the patch below. Then
> you can just "make test" (or "make" in the test directory) as usual.

I kind of like this.  Perhaps with something like this squashed in?

-- >8 --
test: allow "prove" to be used as the main test harness

The prove output is a little easier to read for things like -j16.

---
 t/README |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index a1eb7c8..c548bf1 100644
--- a/t/README
+++ b/t/README
@@ -50,6 +50,12 @@ prove and other harnesses come with a lot of useful options. The
     # Repeat until no more failures
     $ prove -j 15 --state=failed,save ./t[0-9]*.sh
 
+You can give DEFAULT_TEST_TARGET=prove on the make command (or define it
+in config.mak) to cause "make test" to run tests under prove.
+GIT_PROVE_OPTS can be used to pass additional options, e.g.
+
+    $ make DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS='--timer --jobs 16' test
+
 You can also run each test individually from command line, like this:
 
     $ sh ./t3010-ls-files-killed-modified.sh
