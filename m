Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA1E1FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbcJXRqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 13:46:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63564 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932634AbcJXRqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 13:46:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B88648F2F;
        Mon, 24 Oct 2016 13:46:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mN8alGL9o6TJICr3zmnMaglaXM=; b=iVNfmm
        /nh2bHmSYaJKHxU4DnlkquP1D6vfV5IWpebRYUALt7stQ6rMbo4AEaSFV7csN73p
        lHRLOfSljStx16czWURLGMpZBLgqAOPb1DXek/m24tMlM/2PCir7au5za3qNJpHP
        q6WFkR7yaugCERWDm9pH4Fyy4wAKyIti1/TXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MGt6IzPWRpH/2nNdxtrbmoWqbvPO7GJK
        fXQ/ag5/mxsd2sZ1fOwVcpG5ks7Z6JJqE/2NnEpL91oav8IJw9waBXDVyuFOqLL5
        HVEPUoCT4RWm80MXfRpkt5svmEQBnkLWfMDRs35/om2Ebx7SMpVFT/HLnDUHHoc7
        yQjjH/JxMUc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AB7748F2E;
        Mon, 24 Oct 2016 13:46:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1D6948F2D;
        Mon, 24 Oct 2016 13:46:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
References: <20161021235939.20792-1-sbeller@google.com>
        <20161021235939.20792-3-sbeller@google.com>
        <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org>
        <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaukGh2ynkOQcF=skzxTMYr8CFRyGJw6FEmNsTAcaG_VQ@mail.gmail.com>
        <61637cd9-8f83-c988-15c0-54f948153c07@kdbg.org>
Date:   Mon, 24 Oct 2016 10:46:33 -0700
In-Reply-To: <61637cd9-8f83-c988-15c0-54f948153c07@kdbg.org> (Johannes Sixt's
        message of "Sun, 23 Oct 2016 12:14:26 +0200")
Message-ID: <xmqqinsh7i86.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEFC1298-9A11-11E6-AF1D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.10.2016 um 22:46 schrieb Stefan Beller:
>> I have looked into it again, and by now I think the bug is a feature,
>> actually.
>>
>> Consider this:
>>
>>     git clone . super
>>     git -C super submodule add ../submodule
>>     # we thought the previous line is buggy
>>     git clone super super-clone
>
> At this point, we *should* have this if there were no bugs (at least
> that is my assumption):
>
>   /tmp
>   !
>   + submodule     <- submodule's remote repo
>   !
>   + foo           <- we are here (.), super's remote repo
>     !
>     + super       <- remote.origin.url=/tmp/foo/.
>       !
>       + submodule <- remote.origin.url=/tmp/foo/./../submodule
>                      submodule.submodule.url=../submodule
>
> When I test this, 'git submodule add' fails:
>
> foo@master> git -C super submodule add ../submodule
> fatal: repository '/tmp/foo/submodule' does not exist
> fatal: clone of '/tmp/foo/submodule' into submodule path
> '/tmp/foo/super/submodule' failed
>
>> Now in the super-clone the ../submodule is the correct
>> relative url, because the url where we cloned from doesn't
>> end in /.
>
> I do not understand why this would be relevant. The question is not
> how the submodule's remote URL ends, but how the submodule's remote
> URL is constructed from the super-project's URL and the relative path
> specified for 'git submodule add'.

FWIW, that matches my understanding.

> Whether ../submodule or ./submodule is the correct relative URL
> depends on where the origin of the submodule is located relative to
> the origin of the super-project. In the above example, it is
> ../submodule. However, the error message tells us that git looked in
> /tmp/foo/submodule, which looks like the /. bug!
>
> I do not understand where you see a feature here. What am I missing?
>
> -- Hannes
