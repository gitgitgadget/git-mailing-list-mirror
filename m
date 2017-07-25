Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A965E2089A
	for <e@80x24.org>; Tue, 25 Jul 2017 21:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbdGYVS6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:18:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50074 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752084AbdGYVS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:18:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA33C700E5;
        Tue, 25 Jul 2017 17:18:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9C/4COSgepFoBCPJECZkotJNEh4=; b=l88163XtIx7+TkFeJJzQ
        vcUhfMn2leIyc6ceDPksxssYxF+2r24NGx8S5g6qJRk95Qc5t51TkT5cCSAfAdXa
        f39bsSCalvOkeSsMrhKOtw34CTuP4mNY0NCtrZhQpOcWl1XwayyVtIOWSVv2Wx3o
        biSYcll8DowbkZONPOcCNe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=tOaES8MCXlvDSAPSz5/P8K0YK7C7PxbfsDh9G9hG5o8hnK
        oaohkbW6kSe6xWeipLiMBW/wjliKI6Cca2X5APWap+DiPAmU+XUBueqLZqlIdG08
        PJ0MvT1EN8I0zJCnc3Oq18Ijg94c4ZhSTJ5VWqzZWVTLtcd8hwXtGD0rrIHzo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0ED7700E2;
        Tue, 25 Jul 2017 17:18:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 107AE700DE;
        Tue, 25 Jul 2017 17:18:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Raman Gupta <rocketraman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] contrib: rerere-train overwrites existing resolutions
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
Date:   Tue, 25 Jul 2017 14:18:47 -0700
Message-ID: <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9BB1252-717E-11E7-B021-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raman Gupta <rocketraman@gmail.com> writes:

> From 41116889f7eb2ddd590d165d9ca89646f7b15aaf Mon Sep 17 00:00:00 2001
> From: Raman Gupta <rocketraman@gmail.com>
> Date: Tue, 25 Jul 2017 10:28:35 -0400
> Subject: [PATCH] contrib: rerere-train overwrites existing resolutions

These do not belong to the body of the message.

Imagine that your title line appears in "git shortlog --no-merges"
output together with 600 other commits, and you see that list 3
months later.  Can you tell what this change was about?

To me, it sounds like a user is complaining that it overwrites and
loses a precious one, implying that the change is to fix it by being
more careful, i.e. checking if there is an existing one and avoid
overwriting it.

As our convention is to write the log message as if you are giving
an order to the codebase "to behave like so",

	contrib/rerere-train: overwrite existing resolutions

would convey what you are doing better, I would think.

As to the change itself, I do anticipate that a user who is used to
rerere-train will complain that the updated one overwrites existing
resolutions, losing data, as the existing one didn't, and they are
used to the way to correct an incorrect resolution that is recorded
earlier, which is:

 * perform the botched merge again, which will materialize the
   botched merge result in the working tree;

 * do "git rerere forget" for the path;

 * correct the path with the right merge result; and then finally

 * do "git rerere".

If this new behaviour is triggered only when a command line option
is given (e.g. "--overwrite" which is better than "--force"), I
would imagine that it might give us an easier way to achieve the
same thing without learning about "rerere forget".  So I do not
fundamentally oppose to having such an option, but changing the
default behaviour is not going to fly.

> When running rerere-train, the user is explicitly asking the training to
> occur based on the current merge commit. However, if the current cache
> has a resolution for the same conflict (even if out of date or wrong),
> rerere-train does not currently update the rr-cache. Now, forget
> existing resolutions before training so that training is always
> reflective of the trained data.
> ---

Actually, the user is asking to record what is not recorded yet,
which is the originally intended use case.  You may fetch my 'pu'
branch into a repository you already have a copy of git.git, and
want to grab conflict resolutions I did between master..pu that you
still do not know about.  The tool is conservative and avoids
clobbering your resolution if you already have resolved some of the
merges yourself.

In any case, please make it a habit to sign-off your work when
posting here.

>  contrib/rerere-train.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 52ad9e4..a222d38 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -34,6 +34,7 @@ do
>  		# Cleanly merges
>  		continue
>  	fi
> +	git rerere forget .
>  	if test -s "$GIT_DIR/MERGE_RR"
>  	then
>  		git show -s --pretty=format:"Learning from %h %s" "$commit"
