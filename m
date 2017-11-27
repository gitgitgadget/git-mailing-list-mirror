Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0840120A40
	for <e@80x24.org>; Mon, 27 Nov 2017 03:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdK0DZ2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 22:25:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54624 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750844AbdK0DZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 22:25:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A0D6BB52C;
        Sun, 26 Nov 2017 22:25:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mSyjjfoBq5sZTGzdMuldncvhAz4=; b=YQnDZb
        yvDppjbQGsXLUOFirQ8Xy5YKNi6W0UHU2NPRI+8dsbAS6ebZmi8y+YKCPA3bfOhj
        cVCfMbzuwnl7hYv7ylbNKvUPBinNX0fH1LW9QFTwkY016ZCLP+GwqdhuaS45u2ZI
        GbNLxoRyn6CD9hf5s4WRyCVBIm/N8E3BzQv28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A7WRBs8iIj+4XRMm5YBq1VjCi5REBCh0
        jLRaSOrvBwVbYbqLJcye/tQRf0/PjILDqqScug8saCnR7FB0l17nz71xUylgs9UF
        j2I51po6sR8/+bzYSg7sxbuhZTS0fCwtM/cJnvEZjnLCc6WFriT3LjvANJsdFRDi
        zeBbqbfUTKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 028FBBB52B;
        Sun, 26 Nov 2017 22:25:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7EC61BB52A;
        Sun, 26 Nov 2017 22:25:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     gennady.kupava@gmail.com
Cc:     git@vger.kernel.org, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH 2/2] trace: improve performance while category is disabled
References: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
        <20171126201119.24313-1-gennady.kupava@gmail.com>
        <20171126201119.24313-2-gennady.kupava@gmail.com>
        <xmqqpo84fre1.fsf@gitster.mtv.corp.google.com>
        <xmqqlgisfquy.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 27 Nov 2017 12:25:25 +0900
In-Reply-To: <xmqqlgisfquy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 27 Nov 2017 10:32:53 +0900")
Message-ID: <xmqq8tesflne.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C74C90A-D322-11E7-A71E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Just in case others notice style and whitespace issues, I've applied
> the following to fix them, so there is no need to reroll only to fix
> these.
> ...
> -inline int trace_pass_fl(struct trace_key *key) {
> +inline int trace_pass_fl(struct trace_key *key)
> +{
>  	return key->fd || !key->initialized;
>  }

Spotted yet another.  This function in a header file, that is
included by many source files, must be made "static inline" (which I
already did as without the fix I couldn't get 'pu' to compile).



