Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F127AC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C74222CAD
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pIyqtYWM";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="VjipY8iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgHCU6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:58:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56005 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCU6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:58:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78775794EA;
        Mon,  3 Aug 2020 16:58:43 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:date:message-id:mime-version:content-type;
         s=sasl; bh=RTziUEpPBDFgx3UCTo6BZjS/9ds=; b=pIyqtYWM9Ut6IyEwYm/7
        SOn8ZRBamNkV/+flfghX51FD3qKD464na8WmeNhwT12RrBzUXjFonpUkMfiPrI2V
        qFaQ2XHRpDxbpOKnby0lEE/9UrFPQu0sh8mheindMUO7lxh6cA1SIc3jcfVEv05W
        WyErpE5/nR3Y0Nuze3YzJiU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70AE7794E9;
        Mon,  3 Aug 2020 16:58:43 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:date:message-id:mime-version:content-type;
 s=mesmtp; bh=1dOJnsANKPNz82FZLX7TUBWisfiRlLK9h7SpQhfUQRU=;
 b=VjipY8ivuLEPtRk6ygCuYy29QhzErvLVpBTvfoIV3KVlewlG8bzhArQ1Tc0SeGvh1BCC0+N+kxVC+1VdPztUuEn++gW4tbgbupPoaabAvrHW5l//IYcxZY1Ao1WmFm93zKCNFJhbH0dYnDfZ/dXxaRMPBdvSGy1Zp9GMROoZDn4=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEF2D794E8;
        Mon,  3 Aug 2020 16:58:42 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Confused about git-config's description of escaping
In-Reply-To: <xmqqd047v62u.fsf@gitster.c.googlers.com>
Date:   Mon, 03 Aug 2020 16:58:42 -0400
Message-ID: <874kpjwinx.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D4EBEBA-D5CC-11EA-8CAE-2F5D23BA3BAF-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> Kyle Meyer <kyle@kyleam.com> writes:
[...]
>> What's gained by specifying "Inside double quotes"?  Are there any cases
>> where a value, whether enclosed in double quotes or not, doesn't need "
>> or \ characters escaped?
>
> Perhaps there is another description missing, either from the
> written docs or from your reading of it, that says that a value with
> these characters must be enclosed in double quotes pair?

Thanks for the reply.

I'm not spotting anything in the current git-config documentation that
says that.  And it would be an incorrect description of the syntax,
wouldn't it?  When entering a value containing a quote with 'git
config', enclosing double quotes aren't inserted:

    $ git config a.b 'c"d'
    $ tail -n2 .git/config
    [a]
    	b = c\"d
    $ git config a.b
    c"d

So, it seems valid for a value to have these characters escaped without
having them enclosed in a pair of double quotes.
