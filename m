Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11021F859
	for <e@80x24.org>; Fri, 12 Aug 2016 21:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbcHLVP5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 17:15:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbcHLVP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 17:15:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76BE335370;
	Fri, 12 Aug 2016 17:15:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IPKiBYlf4Be1OGAhY/5I8/1IqGc=; b=x5c7YC
	Vmoekb540ob8fwHPWLy/64fQkPYjC26o5LXciULdnxc27WuX6qoUV07k9EvbKyTC
	aKTwrYBhmkpljWpkcfEkMKDMZneJT9ogGDdnRHjcWNaWFioLWukXbiWnIjkeP7zQ
	959D3zxVcK4thUYMABXLXWmEFxCTObkpfu7Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hzHocee1MUuRIBJUOjGWeSkAJLaDWzuU
	I9JkuBAYqMYAP0ZB7Hcfd7GJV5c5tJJRP9WSIWI/0LltgD3uDRNc0WIctbHGpNxR
	Gs6fmnfvBgcqzRGKsvll3jQ6IkFDbCdzhb7WQdFjhbsOx0YuIpGlzT999AFmnDRh
	8wb8smDlhJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F12C3536F;
	Fri, 12 Aug 2016 17:15:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0C1F3536E;
	Fri, 12 Aug 2016 17:15:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in a prefix
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
	<20160811225946.18381-2-jacob.e.keller@intel.com>
Date:	Fri, 12 Aug 2016 14:15:52 -0700
In-Reply-To: <20160811225946.18381-2-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Thu, 11 Aug 2016 15:59:45 -0700")
Message-ID: <xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F48C56D6-60D1-11E6-A104-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> The prefix shall come first prior to any other prefix associated with
> the --graph option or other source.
>
> Add tests for the same.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> - v5
> * Changed name to --diff-line-prefix since --line-prefix might indicate
>   for other commands such as log, when it only modifies diff output

As you are adding this to "diff.c", I think the option would be
visible to "git log" anyway, and more importantly

    git log --line-prefix='I I ' --graph --boundary -p HEAD^..HEAD

should honor the line-prefix for the log message part.  I'd expect
that its output would be like:

I I * commit 3c90ffd2f01e2d0d080c8e42df2ee89709b324de
I I | Author: Jacob Keller <jacob.keller@gmail.com>
I I | Date:   Thu Aug 11 15:59:45 2016 -0700
I I | 
I I |     diff: add --diff-line-prefix option for passing in a prefix
I I |     
I I |     Add an option to pass additional prefix to be displayed before diff
I I |     output. This feature will be used in a following patch to output correct
I I |     ...
I I |     Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
I I |     Signed-off-by: Junio C Hamano <gitster@pobox.com>
I I | 
I I | diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
I I | index 705a873..f924f57 100644
I I | --- a/Documentation/diff-options.txt
I I | +++ b/Documentation/diff-options.txt
I I | ...

Otherwise, a "git log --graph -p --submodule=log-with-diff", when
showing a commit in the superproject that changes submodule from
commit A to commit B, wouldn't be able to run "git log --graph -p A..B",
i.e. as if the command recursed beyond the module boundary, would
it?



