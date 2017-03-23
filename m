Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94D62095B
	for <e@80x24.org>; Thu, 23 Mar 2017 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbdCWIFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 04:05:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63338 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753881AbdCWID4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 04:03:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBADF812BD;
        Thu, 23 Mar 2017 02:09:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mVXKDZU6n7T73VYK0westEBXfF0=; b=w9OvMT
        tokqieHATg7dH408xy1qV2mxYQLshTGKKCww2JiV5XRvyGHYzUVvb+tLnl7VPGC1
        qmcNurRpp3q5ez5hatw/J4aN8u5hcOZ4dKWNxpNBj9u+CBafHGlo7F6g6JCqDqxF
        PWM4veiYkq+/Em5tMxc8vsBwEwNNHk7bOYDhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oo/UkZV2PFOy4cjqlTEnbKqSLhQpVgC2
        SufYUDF5x7LAOor0wW+qczaLh26poBO5G5px2pUGLLds5jCbj6ty4bOl1itxbEkQ
        ZWoN8SfaqUqdbqYgPC94iZ4jx96/jD+xsRuS29wRJpj712V6roYqicMZTyWdVhsy
        /oQCM2t7J5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D305C812BC;
        Thu, 23 Mar 2017 02:09:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A71C812BB;
        Thu, 23 Mar 2017 02:09:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] submodule.c: port is_submodule_modified to use porcelain 2
References: <20170323004329.15892-1-sbeller@google.com>
        <20170323004329.15892-2-sbeller@google.com>
        <20170323005341.GH26108@aiede.mtv.corp.google.com>
Date:   Wed, 22 Mar 2017 23:09:08 -0700
In-Reply-To: <20170323005341.GH26108@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 22 Mar 2017 17:53:41 -0700")
Message-ID: <xmqqo9wsfrsr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AFD4D5C-0F8F-11E7-A2EA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> Migrate 'is_submodule_modified' to the new porcelain format of
>> git-status.
>>
>> As the old porcelain only reported ' M' for submodules, no
>> matter what happened inside the submodule (untracked files,
>> changes to tracked files or move of HEAD), the new API
>> properly reports the different scenarios.
> [...]
>>  submodule.c | 53 ++++++++++++++++++++++++-----------------------------
>>  1 file changed, 24 insertions(+), 29 deletions(-)
>
> Neat.  Is this something that could be covered in tests, or should I
> be patient and rely on patch 3/3 for that?
>
> I think this would be easier to understand if it were two patches: one
> that switched to --porcelain=2 with no change in behavior, and another
> that took advantage of --porcelain=2 to return richer information.  

That sounds like a sensible organization.

> As is, I had trouble verifying that this isn't going to break
> anything --- there's not enough local information here and in
> submodule.h to tell what callers may rely on and I didn't audit
> callers.
