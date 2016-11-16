Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5F12042F
	for <e@80x24.org>; Wed, 16 Nov 2016 19:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbcKPTIv (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 14:08:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64015 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753625AbcKPTIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 14:08:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A3B94EE24;
        Wed, 16 Nov 2016 14:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T6mFh8ArN/mk20j5MOPbjYWDllY=; b=EEGTyi
        ep8tcPEJqeAQPfJg3eaA64WP+xD/cJ6pf1kkpl0jqeEiuFfVzimi0CWXvr/zlXkI
        kjdKphNgrraosSpYTpsxBNVOp+WjkMf2N9ppZbLkvPEEY+EkghloqjqWXqj0KtU8
        EnkAEQwxidKECN3dLRG0dONzPU0KTxgXUYWbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OYGe9M08uwA9iNXiczXyfILn3B6sbbsj
        oNg0zXwXCXsWpvxp3PgBfZ/TnVvqLqCcBqSPz6XYospypr+imOwLvVoALBReWjVg
        ZavnY5OldDBXT/vU4K/Q54E/4Nl+lK9pPC5+AaIfccCj+ldQdb+QRRWrTOwBXCNF
        hkvll46Tayk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DF754EE22;
        Wed, 16 Nov 2016 14:08:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8272F4EE21;
        Wed, 16 Nov 2016 14:08:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        bmwill@google.com, jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH 01/16] submodule.h: add extern keyword to functions, break line before 80
References: <20161115230651.23953-1-sbeller@google.com>
        <20161115230651.23953-2-sbeller@google.com>
Date:   Wed, 16 Nov 2016 11:08:47 -0800
In-Reply-To: <20161115230651.23953-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 15 Nov 2016 15:06:36 -0800")
Message-ID: <xmqqshqrp7i8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A9A49E2-AC30-11E6-9606-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> submodule.h: add extern keyword to functions, break line before 80

The former is probably a good change for consistency.  As the latter
change breaks a workflow around quickly checking the output from
"git grep funcname \*.h", I am not sure if it is a good idea.

Especially things like this look like a usability regression:

-void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
+extern void handle_ignore_submodules_arg(struct diff_options *diffopt,
+					 const char *);

Perhaps the name "diffopt" can be dropped from there if we want it
to be shorter.  Names in prototypes are valuable for parameters of
more generic types like "char *", especially when there are more
than one parameters of the same type, but in this case the typename
is specific enough for readers to tell what it is.

