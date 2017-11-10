Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA799201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 05:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750745AbdKJFEs (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 00:04:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750710AbdKJFEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 00:04:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19B48BA281;
        Fri, 10 Nov 2017 00:04:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4CNfMbjR+80JoKVFJwNIUVfPC0s=; b=KjW4ew
        anTN8yGjr8RJlZyJEpk7uWNOme/pDO9xIXDeWf2DsnmM5yy/UWLz9NYZ7shZO3NS
        cIHPRKoIx2ZXGfC6PaDmDWc0XN1tUZFoo9JZ6nGCaO6b/yoebOVRRa2EdGry/pW8
        +Ui9RKp/Q8IlQSMtN5q6IqEAKvVRSGtYmFBuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f+4xJbaZ7W2nqyDWdDE9XQMdZLn0kaJg
        geQDO1H0urSe/fultidyHkGFKReEDgNPmz4hvOzJx9UTF8Q18SevJpcP80A3VIDL
        PfYupF4UK2sYABiJCR+D7TanUWlVGsI+tjpTeWVaykPhzcKprzTfKjkYHo5DYNuV
        kV+E1zC0R4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12032BA280;
        Fri, 10 Nov 2017 00:04:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81F0FBA27F;
        Fri, 10 Nov 2017 00:04:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 1/2] fsmonitor: Read from getcwd(), not the PWD environment variable
References: <20171109195810.30446-1-alexmv@dropbox.com>
        <1a8090dfa6f273bae68cfcdd62446944bedbc8a7.1510257457.git.alexmv@dropbox.com>
Date:   Fri, 10 Nov 2017 14:04:45 +0900
In-Reply-To: <1a8090dfa6f273bae68cfcdd62446944bedbc8a7.1510257457.git.alexmv@dropbox.com>
        (Alex Vandiver's message of "Thu, 9 Nov 2017 11:58:09 -0800")
Message-ID: <xmqqzi7ug1w2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABE15B7A-C5D4-11E7-84C4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

This comment is only so that I do not keep editing them while queuing..

> Subject: Re: [PATCH 1/2] fsmonitor: Read from getcwd(), not the PWD environment variable

Downcase "Read" (or any word after "<area>: " on the commit title).

> Though the process has chdir'd to the root of the working tree, the
> PWD environment variable is only guaranteed to be updated accordingly
> if a shell is involved -- which is not guaranteed to be the case.
> That is, if `/usr/bin/perl` is a binary, $ENV{PWD} is unchanged from
> whatever spawned `git` -- if `/usr/bin/perl` is a trivial shell
> wrapper to the real `perl`, `$ENV{PWD}` will have been updated to the
> root of the working copy.
>
> Update to read from the Cwd module using the `getcwd` syscall, not the
> PWD environment variable.  The Cygwin case is left unchanged, as it
> necessarily _does_ go through a shell.

Interesting observation.  Why didn't anybody else notice it, I
wonder?

Thanks, will queue.

> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>  t/t7519/fsmonitor-watchman                 | 3 ++-
>  templates/hooks--fsmonitor-watchman.sample | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index a3e30bf54..5fe72cefa 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -41,7 +41,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
>  	$git_work_tree =~ s/[\r\n]+//g;
>  	$git_work_tree =~ s,\\,/,g;
>  } else {
> -	$git_work_tree = $ENV{'PWD'};
> +	require Cwd;
> +	$git_work_tree = Cwd::cwd();
>  }
>  
>  my $retry = 1;
> diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
> index 9a082f278..ba6d88c5f 100755
> --- a/templates/hooks--fsmonitor-watchman.sample
> +++ b/templates/hooks--fsmonitor-watchman.sample
> @@ -40,7 +40,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
>  	$git_work_tree =~ s/[\r\n]+//g;
>  	$git_work_tree =~ s,\\,/,g;
>  } else {
> -	$git_work_tree = $ENV{'PWD'};
> +	require Cwd;
> +	$git_work_tree = Cwd::cwd();
>  }
>  
>  my $retry = 1;
