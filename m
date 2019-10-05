Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF351F4BE
	for <e@80x24.org>; Sat,  5 Oct 2019 08:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfJEIdI (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 04:33:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62543 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJEIdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 04:33:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47A473152C;
        Sat,  5 Oct 2019 04:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LmZPPOAgTGd9Ly1r5eblAvbfKUY=; b=aaCxA5
        DVNanrLGDSasWbKtJlyTl1X9Gro+khbOgpJsxhwVt/mi4wxXSGhISYZvLUy6vwan
        IK522W/RrugqNMG4e+lprMO8TFhUyNSxCJ/8VEfZHAMvBir8GVSbiCDKUJDQzCHY
        s2WSsKdovtmf2ZSHLJrl5WbcGVgTa244GRWNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DMUYcOvIv0MpKG3R6k1A8Jby55iurj6y
        8rRu3hDbfrcUdJ6h7msfwFWcuBzl0ufpEtlnrylnUepgH2z+G7rWvKwWRLmT2RwW
        rm01n3Qj1QqueFu7Enp6RUYSGT1j1MNcos9DLR/TBxuozo0S1f/1Vjr8k6a8QLUA
        aiKxuKk7T9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D8173152B;
        Sat,  5 Oct 2019 04:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 354C031529;
        Sat,  5 Oct 2019 04:33:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] apply: tell user location of corrupted patch file
References: <20191002184546.GA22174@generichostname>
        <ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com>
Date:   Sat, 05 Oct 2019 17:33:03 +0900
In-Reply-To: <ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 4 Oct 2019 14:59:03 -0700")
Message-ID: <xmqqv9t37fsw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C05C45EE-E74A-11E9-BCE4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When `git am` runs into a corrupt patch, it'll error out and give a
> message such as,
>
> 	error: corrupt patch at line 87
>
> Casual users of am may assume that this line number refers to the <mbox>
> file that they provided on the command-line. This assumption, however,
> is incorrect. The line count really refers to the
> .git/rebase-apply/patch file genrated by am.
>
> Teach am to print the location of corrupted patch files so that users of

s/corrupted/corrupt/;

> the tool will know where to look when fixing their corrupted patch. Thus

Likewise.

> the error message will look like this:
>
> 	error: corrupt patch at .git/rebase-apply/patch:87
>
> An alternate design was considered which involved printing the line
> numbers relative to the output of `git am --show-current-patch` (in
> other words, the actual mail file that's provided to am). This design
> was not chosen because am does not store the whole mail and instead,
> splits the mail into several files. As a result of this, this would
> break existing users' workflow if they piped their mail directly to am
> from their mail client, the whole mail would not exist in any file and
> they would have to manually recreate the mail to see the line number.

More importantly, a change to apply.c (hence "git apply", not "git
am") will mean the tool can only talk about its input.  If you
run, instead of "git am mbox", "git apply mbox" (assuming you are
lucky and the piece of mail does not use any fancy features like
MIME or RFC 1342) may work just as well and it would report the
corrupt patch relative to the entire mail text.

>
> Let's avoid breaking Junio's workflow since he's probably one of the
> most frequent user of `git am` in the world. ;)

Don't name me.

>  		if (len <= 0) {
>  			free(fragment);
> -			return error(_("corrupt patch at line %d"), state->linenr);
> +			return error(_("corrupt patch at %s:%d"), state->patch_input_file, state->linenr);
>  		}

Do not forget that you can run "git apply" and feed the patch from
its standard input, e.g.

	$ git apply <patchfile
	$ git show -R | git apply

Make sure state->patch_input_file is a reasonable string before
considering this.

Also, if you have a mbox file

	$ cd sub/direc/tory
	$ git am -s /var/tmp/mbox

The "git apply" process thatis run inside "git am" would be running
at the top level of the working tree, so state->patch_input_file may
say ".git/rebase-apply/patch" (i.e. relative pathname) that is not
relative to where the end user is in.  I personally do not thinkg it
matters too much, but some people may complain.

Other than that, looks good.  I am kind-of surprised that there is
only one place that we report an unusable input with a line number.
Nicely found.

> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 6579c81216..42cb2dd404 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -68,7 +68,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
>  	sed -e "s/-CIT/xCIT/" <output >broken &&
>  	test_must_fail git apply --stat --summary broken 2>detected &&
>  	detected=$(cat detected) &&
> -	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
> +	detected=$(expr "$detected" : "error.*at broken:\\([0-9]*\\)\$") &&
>  	detected=$(sed -ne "${detected}p" broken) &&
>  	test "$detected" = xCIT
>  '
> @@ -77,7 +77,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
>  	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
>  	test_must_fail git apply --stat --summary broken 2>detected &&
>  	detected=$(cat detected) &&
> -	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
> +	detected=$(expr "$detected" : "error.*at broken:\\([0-9]*\\)\$") &&
>  	detected=$(sed -ne "${detected}p" broken) &&
>  	test "$detected" = xCIT
>  '

These existing tests can serve a good test for this new feature, but
I think you'd also need a case where "apply" is fed the patch from
the standard input, and possibly another case where it is run from a
subdirectory of a working tree.

Thanks.

