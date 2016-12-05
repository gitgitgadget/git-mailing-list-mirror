Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278EF1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbcLEUxR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:53:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61157 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752305AbcLEUxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:53:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 573DF556C9;
        Mon,  5 Dec 2016 15:53:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wF7LGCsGACC3uHe2u8vtxDXk8qI=; b=vlVldy
        8I1UWHJMbckNY0omXRNjSvbtdngf4Y6c+9+3aA4Spt5wtfU+LwtAqjMlQlR2p2Wy
        k4et0sbgnjSFZCg8vyCncS0+120r8Iq/uNdcZpnqZzJ7AG5fR0BhiE8+W4stPfjb
        3q2lBPcNmnwp2I7MkT+bDMHo8axLq5uEkZzX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K8S3TiHqvHCMuaOXc6XAN6XPFEU4rLVl
        LubdAFW3Oq3OL10eUbUD5t7kUc1fX3poNi0hYXzhPK46YUFcGGezF7H2l183eX5j
        Tv+n6PzT7x2EiKZBF/uwEPce+J88fx/SoJTjaZe0lzpI9pbGXr0wQ10DUYGUB8C6
        FQcSCGr21iQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E97F556C8;
        Mon,  5 Dec 2016 15:53:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2F93556C7;
        Mon,  5 Dec 2016 15:53:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com
Subject: Re: [PATCHv1 1/2] git-p4: support git-workspaces
References: <20161202224319.5385-1-luke@diamand.org>
        <20161202224319.5385-2-luke@diamand.org>
Date:   Mon, 05 Dec 2016 12:53:13 -0800
In-Reply-To: <20161202224319.5385-2-luke@diamand.org> (Luke Diamand's message
        of "Fri, 2 Dec 2016 22:43:18 +0000")
Message-ID: <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D75C29BE-BB2C-11E6-97E9-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> Teach git-p4 about git-workspaces.

Is this what we call "git worktree", or something else?

>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 0c4f2afd2..5e2db1919 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -566,6 +566,12 @@ def isValidGitDir(path):
>      if (os.path.exists(path + "/HEAD")
>          and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
>          return True;
> +
> +    # git workspace directory?
> +    if (os.path.exists(path + "/HEAD")
> +        and os.path.exists(path + "/gitdir")):
> +        return True
> +
>      return False
>  
>  def parseRevision(ref):
