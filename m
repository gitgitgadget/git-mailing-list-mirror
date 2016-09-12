Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E97207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbcILXKN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:10:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53120 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751317AbcILXKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:10:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76DD83ED57;
        Mon, 12 Sep 2016 19:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EUxLCuN00e1q9G1M5OYYRHhgVso=; b=BKZCkB
        vKEkBM6Jw2cNV7wlYsPgips0WCVvv4Cg9cPzIEhRsEVmBYnqcPzkoG4NRHls8ivS
        o+xGZUH4DT85GIrO6WZ3FlrftW92tJlTHwzQ9Qz+Df+hQRp+pkyDtdRTc+U0jpc2
        UmCFLs1KiHddafop/+ndG/IYH3fWjkOGWs6dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nGgjiigv3d1EXEdK6SDGODGC06BbbEDo
        4h9Ka4+CaMMhUdPdXgm5V61te08nHCk39jbpw6yEIqgaNyNjQM20A9G5mgDkvHPp
        hFhe82ySIgzzF3e+o0iZ+F9bJhSyTBZ80hajcwzSUuhi4KESKIMKfZWdFp0WRjR2
        +hKjG6VOaAI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FE353ED56;
        Mon, 12 Sep 2016 19:10:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1D593ED55;
        Mon, 12 Sep 2016 19:10:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen & friends to build area
References: <20160910150512.19473-1-kirr@nexedi.com>
        <xmqqh99l2aqt.fsf@gitster.mtv.corp.google.com>
        <xmqqd1k92aif.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 12 Sep 2016 16:10:09 -0700
In-Reply-To: <xmqqd1k92aif.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 12 Sep 2016 12:17:28 -0700")
Message-ID: <xmqqpoo8yasu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DF84312-793E-11E6-ACEB-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In other words, something along this line, perhaps.
> ...

Not quite.  There is no guanratee that the user is using autoconf at
all.  It should be more like this, I think.

 t/perf/run | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index aa383c2..7ec3734 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -30,7 +30,13 @@ unpack_git_rev () {
 }
 build_git_rev () {
 	rev=$1
-	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}
+	for config in config.mak config.mak.autogen config.status
+	do
+		if test -f "../../$config"
+		then
+			cp "../../$config" "build/$rev/"
+		fi
+	done
 	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
 	die "failed to build revision '$mydir'"
 }


