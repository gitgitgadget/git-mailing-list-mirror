Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2B420A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbdK0BQx (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:16:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59757 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752192AbdK0BQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:16:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8F55BA28C;
        Sun, 26 Nov 2017 20:16:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qklww+UVyHdB/+g12C8/d22/cwE=; b=vZHp50
        4AjU4vtBXEeJzQ+ZkZjEQ8Purtcfu6UHNrLpRakALjtUfqbgTNgAk8rjTqz7Hm6F
        49qhwBrNZqvireuYBzjdBYshQ35SWsJsNrs9/jFgXanBRsknSn9cyuxnsbsluwwr
        LZFwMOnw9dH+ujXjupg3nj2TtrT7cHKVc4dEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JTLvmYl/Dqf/xduFDUiFZB3VXIfqn4cF
        orBS39VUY5MVFLpU2bWHc2MxBgRtOJHoeCzhZNCu9BciAeZ4wxS1+A+eeuXutOAk
        1J/yGTEmVx4ZR2KKGJx2JdpbdLFlqIr+g6kdpWaVAoJpQh9kVhJ43SPXpIGmEXew
        1Vg2+0kbMWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1CC4BA28B;
        Sun, 26 Nov 2017 20:16:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41E95BA28A;
        Sun, 26 Nov 2017 20:16:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Sloan <mgsloan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Problem with environment of hook execution when git is run with --work-tree / --git-dir
References: <CAEDDsWdXQ1+UukvbfRoTPzY3Y9sOaxQ7nh+qL_Mcuy3=XKKh7w@mail.gmail.com>
Date:   Mon, 27 Nov 2017 10:16:50 +0900
In-Reply-To: <CAEDDsWdXQ1+UukvbfRoTPzY3Y9sOaxQ7nh+qL_Mcuy3=XKKh7w@mail.gmail.com>
        (Michael Sloan's message of "Sat, 25 Nov 2017 23:19:25 -0800")
Message-ID: <xmqqtvxgfrlp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5CF13D2-D310-11E7-997A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Sloan <mgsloan@gmail.com> writes:

> So what's the problem with this choice of environment variables?
> Well, the problem is that if PWD is changed during the execution of
> the script, then GIT_WORK_TREE and GIT_DIR will no longer work
> properly. For example, if the pre-commit hook is
>
>     #!/bin/sh
>     cd some-dir
>     git status
>
> This will fail with
>
>     Not a git repository: '.dotfiles-git'

That is to be expected.  It's up to the script to make them absolute
if it cannot cope with relative paths.

> There is another detail here, which is that when --git-dir /
> --work-tree is not specified, the no GIT_WORK_TREE / GIT_DIR
> environment variable is set.  This means that in this case, changing
> PWD in the hook will work fine as long as the search for .git will
> find the right one.

That also is working as designed.
