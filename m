Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D628F1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756307AbcHXSow (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756294AbcHXSov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A69E53841A;
        Wed, 24 Aug 2016 14:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AZ0SqL/EZ8H9XQlh3FYZG9UwWaA=; b=r0yKxz
        ONiKMHT5Cfq2Ahhv8WM/qN0MpsS4VRnCo7eHjCBOFwPzvz2quEEmsJCxOO2EIPEv
        U9JNCDDVP4duTCptYfSt3c2NaWi5jpg20pzx/UlVjIl4zDbgA/tDfORGMlIfibb8
        79HPqz3kVm4cDNUObYO5V3AiBdsJK2DafCy+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lOMUSF4XaSFKSfvEAPvE13YDXi+p3UWF
        sikvNEspzxyyA/m35RkLcGm6F8wbGOBeSQtfrFmY2e+rbcq/rABXsaMARgXn8UsH
        nzpRrEzcxTiBu7hskP/HscaUw2rpA/K/CETGNbYNOzRySzkkx1rYn1bUOr+WzZLO
        2GMzxef8dgI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F51F38419;
        Wed, 24 Aug 2016 14:38:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2708938418;
        Wed, 24 Aug 2016 14:38:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, Jens.Lehmann@web.de,
        iveqy@iveqy.com, leandro.lucarella@sociomantic.com
Subject: Re: [PATCHv2] push: change submodule default to check
References: <20160824173017.24782-1-sbeller@google.com>
Date:   Wed, 24 Aug 2016 11:38:10 -0700
In-Reply-To: <20160824173017.24782-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 24 Aug 2016 10:30:17 -0700")
Message-ID: <xmqqshtuovvx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E94D4652-6A29-11E6-9310-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When working with submodules, it is easy to forget to push the submodules.
> The setting 'check', which checks if any existing submodule is present on
> at least one remote of the submodule remotes, is designed to prevent this
> mistake.
>
> Flipping the default to check for submodules is safer than the current
> default of ignoring submodules while pushing.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Slightly reworded commit message than in v1,
> (https://public-inbox.org/git/20160817204848.8983-1-sbeller@google.com/)
> The patch itself is however the same.
>
> I just push it out now with a new commit message, such that we can easier
> pick it up later for Git 3.0, when changes that change default make more sense.
>
> As said in an earlier message, you could however also argue that this is
> fixing a bug in your workflow, so it might be worth fixing before 3.0
> as well. I dunno.

With this change suddenly landing on the version of Git a user just
updated, the only possible negative effect would be that somebody
who did not configure push.recurseSubmodules suddenly starts getting
an error.  What would the error message say?

What I want you to think about and explain in the justification is
if it gives the user enough information to decide the best course of
action to adjust to the new world order, when the user's expectation
has been that the superproject gets pushed independent from its
submodules.  If the existing error message gives enough information,
explains why Git suddenly started refusing the push is generally a
good thing for the user, tells some minority users (in whose
workflow it is perfectly safe to push out the toplevel independently
from the submodule) how to turn it back to the old behaviour clearly
enough, then this single-liner may be good enough.  Otherwise we may
need a new logic to allow us to see if recurse_submodules that is
set to RECURSE_SUBMODULES_CHECK is because the user explicitly
configured, or because the user did not have any configuration, and
issue a different message in the latter case.



>  builtin/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 3bb9d6b..479150a 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -22,7 +22,7 @@ static int deleterefs;
>  static const char *receivepack;
>  static int verbosity;
>  static int progress = -1;
> -static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules = RECURSE_SUBMODULES_CHECK;
>  static enum transport_family family;
>  
>  static struct push_cas_option cas;
