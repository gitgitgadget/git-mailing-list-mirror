Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8725D202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 06:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdJTGRP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 02:17:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750773AbdJTGRO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 02:17:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0F97A8912;
        Fri, 20 Oct 2017 02:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d1sWyKjVHDppx6BBof0c4dtKZXk=; b=kh/j4b
        yWAm+9QTZ4i/tBy6mENaqkuHyhu7Lm9qIftdDYxTrbi8cyFIzvWGZw/jfgM0phdC
        QPmBwBBVsJOa7ie7Ug83q/m/sgM1r9Ald5qWh+Y15rCPEWTF8/DDn++wm5TrTeEu
        uzCFMQUbLnoIp0KXac6Pmx4CKVfb8k0HouHUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nt1C/hUcmw9G6FQydmavKXZUpmBazfqI
        CT5c0eh86CxVyO22YmSrCtWuH1ozfOOZnE37+D9ick2ZSPngjsJkjAPoTxaWrQB4
        fU4vtFaIE2favVUg+TxFFwEDqNV+V2llGTjdj2qEqHMGNy4P2B3KU5BaogAterEb
        1bZCVxq6sng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D783BA8911;
        Fri, 20 Oct 2017 02:17:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35701A8910;
        Fri, 20 Oct 2017 02:17:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marius Paliga <marius.paliga@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
        <20171019174715.6577-1-marius.paliga@gmail.com>
        <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
        <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 20 Oct 2017 15:17:07 +0900
In-Reply-To: <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 20 Oct 2017 11:19:44 +0900")
Message-ID: <xmqq376eibrw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D16E870-B55E-11E7-A85D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> We'd also want to document how push.pushOption works in
>> Documentation/config.txt (that contains all the configs)
>
> Perhaps.

Here is my attempt.  I have a feeling that the way http.extraheaders
is described may be much easier to read and we may want to mimick
its style.  I dunno.

 Documentation/config.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb..631ed1172e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2621,6 +2621,16 @@ push.gpgSign::
 	override a value from a lower-priority config file. An explicit
 	command-line flag always overrides this config option.
 
+push.pushOption::
+	When no `--push-option=<option>` argument is given from the
+	command line, `git push` behaves as if each <value> of
+	this variable is given as `--push-option=<value>`.
++
+This is a multi-valued variable, and an empty value can be used in a
+higher priority cofiguration file (e.g. `.git/config` in a
+repository) to clear the values inherited from a lower priority
+configuration files (e.g. `$HOME/.gitconfig`).
+
 push.recurseSubmodules::
 	Make sure all submodule commits used by the revisions to be pushed
 	are available on a remote-tracking branch. If the value is 'check'
