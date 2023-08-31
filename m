Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE52C83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbjHaRTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbjHaRTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:19:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F464193
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:19:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A6F320C72;
        Thu, 31 Aug 2023 13:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=03icG63CsGEe
        jPNN5SMBG37EWQsPpEFVmhzNZfcsBqM=; b=vmwfbJIDDtz69E8a4e21uLtaDlfa
        GQs0D47K8ldTEARmu9bTQSLmpvFyqt3QKrjCeChr0zogjxh6WkxdN8fLLWVeGrpr
        8vhJE+WuqIWEF+jrA/+lKnr/EhkEes0xF98cmo3LZ+BRVc1eEtFXEUaPa96FIcCZ
        +HExlkWdruv4dHs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3418720C71;
        Thu, 31 Aug 2023 13:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BED3B20C6E;
        Thu, 31 Aug 2023 13:19:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Is there a way to get the "format-patch" formatted file name?
In-Reply-To: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 (=?utf-8?Q?=22V=C3=ADt?=
        Ondruch"'s message of "Thu, 31 Aug 2023 11:49:10 +0200")
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
Date:   Thu, 31 Aug 2023 10:19:21 -0700
Message-ID: <xmqqo7inw2na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 871CDEC8-4822-11EE-80F5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V=C3=ADt Ondruch <vondruch@redhat.com> writes:

> My typical use case is to download patches from GH, e.g.:
>
> ~~~
>
> $ curl -OL https://github.com/rails/sprockets/pull/791.patch
...
> The problem with this is that I end up with the "791.patch" file,
> while I'd like have a file with similar name as if I have used the git
> command:
>
>
> ~~~
>
> $ git format-patch -1 6554b6d
> 0001-Fix-Minitest-constant-name-in-tests.patch
>
> ~~~
>
>
> So I wonder, is there a way to get such file name?

Do you mean: GitHub should let me run this command instead

  $ curl -OL https://github.com/rails/sprockets/pull/0001-Fix-Minitest-co=
nstant-name-in-tests.patch

It may be nice for them to give a more meaningful name to their pull
request (not just the output file name) than just an integer.  But
that is not a question/request we can answer here (this is not a
help forum for GitHub users).

Something along the lines of

    sed -ne '/^Subject: /{
            s/^Subject: *\[PATCH[^]]*\] *//;
            s/[^a-zA-Z0-9]/-/g;
            s/--*/-/g;
            s/$/\.patch/;
	    p;
	    q;
    }' 791.patch

should be doable, but I am not sure what the benefit is.  Once you
get it in Git, you'd park it on a branch with a useful name and we
can forget about "791", so the "The files we get from GitHub are
named in a way that makes it hard to identify them" does not sound
like a Git issue, at least to me.



