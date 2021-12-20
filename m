Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E0C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhLTTjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:39:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56578 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhLTTil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:38:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E194D10F448;
        Mon, 20 Dec 2021 14:38:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FF7z3qiX16JVAQoBnv/wvH3M2N1Jcu/0YSU5g3
        L515Y=; b=vlWmTjk5wh68QHwxRaBOdyLQk9PH3dlfW/okR8llPagYuytaDPhGfG
        Hqt/5Sl4AG3d4BhZRE/leENH8LQPJZMm4hR0xqot9WlCoS9/PI1XphkOUySOJml/
        cRqr9t5GlwukPi4TAeAGJMhMF1jKlv27Jn+hFgwStXRpohFinvQ/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D885E10F447;
        Mon, 20 Dec 2021 14:38:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A95B10F446;
        Mon, 20 Dec 2021 14:38:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 1/2] git-p4: remove "delete" verb
References: <20211217140547.2115095-1-jholdsworth@nvidia.com>
        <20211217140547.2115095-2-jholdsworth@nvidia.com>
Date:   Mon, 20 Dec 2021 11:38:30 -0800
In-Reply-To: <20211217140547.2115095-2-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Fri, 17 Dec 2021 14:05:46 +0000")
Message-ID: <xmqqh7b3vzgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6ED951C2-61CC-11EC-902B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> The git-p4 "delete" verb is described as "A tool to debug the output of
> p4 -G". However, the implementation provided is of no useful benefit to
> either users or developers.

The same comment as 2/2 applies here, too.  This time, however, I
think it would be much easier to give a proper analysis of what it
is designed to do and what it does, to convince readers why it is
too trivial to be worth having the code (compared to the PATCH 2/2).

Also, this is not about the "delete" verb, but the "debug" verb, no?


> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
> Adds Signed-off-by tag
>
>  git-p4.py | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 2b4500226a..b7ed8e41ff 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1532,21 +1532,6 @@ def loadUserMapFromCache(self):
>          except IOError:
>              self.getUserMapFromPerforceServer()
>  
> -class P4Debug(Command):
> -    def __init__(self):
> -        Command.__init__(self)
> -        self.options = []
> -        self.description = "A tool to debug the output of p4 -G."
> -        self.needsGit = False
> -
> -    def run(self, args):
> -        j = 0
> -        for output in p4CmdList(args):
> -            print('Element: %d' % j)
> -            j += 1
> -            print(output)
> -        return True
> -
>  class P4RollBack(Command):
>      def __init__(self):
>          Command.__init__(self)
> @@ -4363,7 +4348,6 @@ def printUsage(commands):
>      print("")
>  
>  commands = {
> -    "debug" : P4Debug,
>      "submit" : P4Submit,
>      "commit" : P4Submit,
>      "sync" : P4Sync,
