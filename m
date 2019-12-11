Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40174C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7DE21556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g8HY2Cez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfLKRLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:11:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53025 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbfLKRLG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:11:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB9282BA76;
        Wed, 11 Dec 2019 12:11:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xdlfqDbAn1Y3p6eSo3RBlMiunUQ=; b=g8HY2C
        ezQOjSllqwY92yYu+sii4sMStgTC6pahhz8q/6k+E9cO7Y47FLJNrk7Q4kLCtAdm
        AzEuAzDy1A8GugDvLLHKXGtkIXa1VcwZBFzK3aV87A9OVHvmAM0+9H+6HIUAD5vu
        AjUNYR1WGNmJtPR6h1i9PrF4Y5ieNWhoVF1Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LRWgS/GejBf22p0ZirEvnicDqZk6gaoG
        2s8HVwBcFEFdImyeOk/b40HEtc2pmzZSZmn3eQM9b82tqORHkoZsjM+SuF03hHCB
        mYM4J340z1oQUzFvqWKBIQwGIl6l/PySyXpGpmN+U33gfgKvHB0goRNA3qq87bTb
        9agDh4id2+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A2432BA75;
        Wed, 11 Dec 2019 12:11:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E98462BA73;
        Wed, 11 Dec 2019 12:11:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v5 07/15] git-p4: add new support function gitConfigSet()
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
        <bc7009541b3f03c3065a7be2b569cd4bf91f7c05.1575740863.git.gitgitgadget@gmail.com>
Date:   Wed, 11 Dec 2019 09:11:00 -0800
In-Reply-To: <bc7009541b3f03c3065a7be2b569cd4bf91f7c05.1575740863.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Sat, 07 Dec 2019 17:47:35
        +0000")
Message-ID: <xmqqsglqpz2z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3536B084-1C39-11EA-B3F1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> Add a new method gitConfigSet(). This method will set a value in the git
> configuration cache list.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index e7c24817ad..e020958083 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -860,6 +860,11 @@ def gitConfigList(key):
>              _gitConfig[key] = []
>      return _gitConfig[key]
>  
> +def gitConfigSet(key, value):
> +    """ Set the git configuration key 'key' to 'value' for this session
> +    """
> +    _gitConfig[key] = value
> +
>  def p4BranchesInGit(branchesAreInRemotes=True):
>      """Find all the branches whose names start with "p4/", looking
>         in remotes or heads as specified by the argument.  Return

I am not sure if we want to do this.  The function makes it look as
if we are not just updating the cached version but also is updating
the underlying configuration file, effective even for future use,
but that is not what is happening (and you do not want to touch the
configuration file with this helper anyway).  It is misleading.

This seems to be used only in one place in a later patch (14/15)
 
         depotPaths = args
 
+        # If we have an encoding provided, ignore what may already exist
+        # in the registry. This will ensure we show the displayed values
+        # using the correct encoding.
+        if self.setPathEncoding:
+            gitConfigSet("git-p4.pathEncoding", self.setPathEncoding)
+
+        # If more than 1 path element is supplied, the last element
+        # is the clone destination.
         if not self.cloneDestination and len(depotPaths) > 1:
             self.cloneDestination = depotPaths[-1]
             depotPaths = depotPaths[:-1]

and the reason why it is needed, I am guessing, is because pieces of
code that gets the control later in the flow will use "git-p4.pathEncoding"
configuration variable to determine how the path need to be encoded.

I think the right fix for that kind of problem is to make sure that
we clearly separate (1) what the configured value is, (2) what the
value used to override the configured value for this single shot
invocation is, and (3) which value is used.  Perhaps the existing
code is fuzzy about the distinction and without allowing the caller
to override, always uses the configured value, in which  case that
is what needs to be fixed, perhaps?

I see encodeWithUTF8(self, path) method of P4Sync class (I am
working this review on the version in 'master', not with any of the
previous steps in this series) unconditionally uses gitConfig() to
grab the configured value.  Probably the logical thing to do there
(i.e. before your step 05/15) would have been to store in the P4Sync
instance (i.e. 'self') to hold its preferred path encoding in a new
field (say 'self.pathEncoding'), and use that if exists before
consulting the config and finally fall back to utf-8.  Or perhaps
when the class is instantiated, populate that configured value to
the 'self.pathEncoding' field, and then override it by whatever
codepath you call gitConfigSet() in this series to instead override
that field.  That way, encodeWithUTF8(self, path) method (by the
way, that is a horrible name, as the function can use arbitrary
encoding and not just UTF-8) can always encode in self.pathEncoding
which would make the logic flow simpler, I would imagine.

