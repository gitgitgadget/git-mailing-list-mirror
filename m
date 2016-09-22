Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68BDF1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033990AbcIVS1T (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:27:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57867 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966179AbcIVS1D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:27:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5BE03D2C9;
        Thu, 22 Sep 2016 14:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cfzdCFl20co/IcU0W/n2UJvg7fE=; b=egOAwz
        vQGIGQO+8NSsqrEkguL0HWNUt9KoYWvDpbfovUF+oUr51apiCsr6NCygUq6Gze64
        bP/5xYAQz5CQD75tVPrb34JzoLJ+f5/U9DqzAzYnyq084zydYeflf+7EWT/BS3Wj
        3LuPDuBnGfot+XomGw3OFgjvj6WhWxV3MmyH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d41qkFZMscYOw0b1VhTbfqXvFGBT8+ft
        IOZt0YtUo0jb5fkqyJMCxTCu+Ntc/G5wtxttIJSa+UkPxzW8lZFS2Vcu3MkxwXYA
        vLcyvefmwAnONCmitmqQFhxwjp9jojFLwY3a7WZufwIdxhISnBoDRiVoom8o4wWj
        9Wx8dRAOPs8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B711A3D2C7;
        Thu, 22 Sep 2016 14:27:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0DF53D2C3;
        Thu, 22 Sep 2016 14:27:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Timur Tabi <timur@codeaurora.org>, git <git@vger.kernel.org>
Subject: Re: .gitignore does not ignore Makefile
References: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
        <20160922154421.GA6641@ikke.info>
Date:   Thu, 22 Sep 2016 11:26:58 -0700
In-Reply-To: <20160922154421.GA6641@ikke.info> (Kevin Daudt's message of "Thu,
        22 Sep 2016 17:44:21 +0200")
Message-ID: <xmqqy42j4wp9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 273B9160-80F2-11E6-BF11-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Often people advise tricks like `git update-index --assume-unchanges
> <file>`, but this does not work as expected. It's merely a promise to
> git that this file does not change (and hence, git will not check if
> this file has changed when doing git status), but command that try to
> change this file will abort saying that the file has changed.

It actually is even worse.  As the user promised Git that the <file>
will not be modified and will be kept the same as the version in the
index, Git reserves the right to _overwrite_ it with the version in
the index anytime when it is convenient to do so, removing whatever
local change the user had despite the promise to Git.  The "abort
saying that the file has changed" is merely various codepaths in the
current implementation trying to be extra nice.



