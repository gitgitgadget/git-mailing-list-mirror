Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58721F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbcIIR0W (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:26:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53245 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751817AbcIIR0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:26:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 897263A6D0;
        Fri,  9 Sep 2016 13:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jMCFWOe6SzaZOGr2WE4t0YcnkX8=; b=Y3kdna
        3c/xdLaQyRDsMIKALnu3V1MWryIwrenTLXFShFvfCoteihejrK77oCS8v+tmBojz
        hANZ2VG6v1yTHZD7CPowwnPdc7x+Ju+icAHgRfjQuD3oqLH0TW3gMXK71uI7lEJb
        J3NWISRmnQdgdvGIcHnN1L3IAzOHQtO05Ml3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BW8zFKEaano2jOw8EOzizY271auNc5I0
        Anx8FHj/GZFJuGr63eMHonmFUGKteMJPSnBBLymxF185RGX9B0tcewDRXOa1zQF5
        3su8fb8xmMen8GAWzl4tJL3LpnFwKTYdfazA4CgVy+ux86Y2eB7jw7rRisPc8gkx
        dfH2BaugUCU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FE1D3A6CF;
        Fri,  9 Sep 2016 13:26:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 090FB3A6BB;
        Fri,  9 Sep 2016 13:26:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] cat-file: introduce the --filters option
References: <cover.1472041389.git.johannes.schindelin@gmx.de>
        <cover.1473415827.git.johannes.schindelin@gmx.de>
        <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
        <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091800020.129229@virtualbox>
        <xmqqbmzxdpjp.fsf@gitster.mtv.corp.google.com>
        <xmqqvay5c7t3.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 09 Sep 2016 10:26:18 -0700
In-Reply-To: <xmqqvay5c7t3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 09 Sep 2016 10:16:40 -0700")
Message-ID: <xmqqr38tc7d1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85AF59B0-76B2-11E6-8529-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So I would not mind if we define the semantics of "--filters" as
> such (as long as it is clearly documented, of course).  AFAICS, the
> batch interface does not call filter_object() for non-blobs, and by
> returning successfully without doing anything special for a symbolic
> link from filter_object() automatically gives us the "by default
> return as-is, but give processed output only for regular file blobs"
> semantics to the batch mode.
>
> But for a non-batch mode, it feels somewhat funny to be giving the
> as-is output without saying anything to symbolic links; we can argue
> that it is being consistent with what we do in the batch mode,
> though.

In other words, instead of trying to be consistent by erroring out
in non-regular blob case, I think the attached change on top would
make more sense, by consistently passing the object contents as-is
for all "not filtered" cases, whether it is run from the batch mode
or from the command line.

 builtin/cat-file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8a3a08..99cb525 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -33,12 +33,7 @@ static int filter_object(const char *path, unsigned mode,
 	if (!*buf)
 		return error(_("cannot read object %s '%s'"),
 			sha1_to_hex(sha1), path);
-	if (type != OBJ_BLOB) {
-		free(*buf);
-		return error(_("blob expected for %s '%s'"),
-			sha1_to_hex(sha1), path);
-	}
-	if (S_ISREG(mode)) {
+	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
 		struct strbuf strbuf = STRBUF_INIT;
 		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
 			free(*buf);
