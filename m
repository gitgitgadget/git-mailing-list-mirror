Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65282035F
	for <e@80x24.org>; Wed,  9 Nov 2016 05:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbcKIF4V (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 00:56:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54517 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751799AbcKIF4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 00:56:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFB674D903;
        Wed,  9 Nov 2016 00:56:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=V5OJMkwSk466DmyIgIeKcGLadB4=; b=Sdg5byiZvXTFJeIAlaCC
        9sG7FYUPYUlYzTYV7vx0kQYJtFGRLKv9aNrqAVQts+CGTQDeegnTCyGSOtq94lup
        783afVSk37MYfzkJ6rpEAutW2TPztvUB2eqKhHv14oGfTR1EEawb5REsSxiJfxgA
        YB1haDzvfsebXplOsV6E8lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=fmaImsYQD5S3RsLy+eQM2NI/uLhVvwbY62HLBc8VUXa3RD
        Ym44yvWIRk9Zcb8PxKrNAUWcJHc5uV/+UEGwIx25cfFWYklbBtnAW+RH/DhpSwx7
        mSVr4/IKGGVKZ6BG0vQJdt+S9uQajY5+mmGX63iGRqmCxVcbsvKYtdqGLyhng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B748D4D902;
        Wed,  9 Nov 2016 00:56:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 241F54D901;
        Wed,  9 Nov 2016 00:56:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Anthony Sottile <asottile@umich.edu>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git submodule add broken (2.11.0-rc1): Cannot open git-sh-i18n
Date:   Tue, 08 Nov 2016 13:31:33 -0800
References: <CA+dzEBmP2aUit00ukJyQeg=iqUJJLVaovafo2gngf9MvEqZDPA@mail.gmail.com>
        <CAGZ79kYbrDu=9Hw+SBnubSHKOc8HmGPb721ZJQxGWW2egqmuDg@mail.gmail.com>
        <CA+dzEBnDZGsYyZkSO5E+3EX+d1j7Kb4kiY6OkC0mtwaq5px5aQ@mail.gmail.com>
        <CAGZ79kbyM0ssz3JgeNHsUpvHnBsCbhm-tHvHRp3+6O1QvmkYpw@mail.gmail.com>
Message-ID: <xmqqy40t9oxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B6F8F6E-A641-11E6-B629-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Nov 7, 2016 at 10:30 AM, Anthony Sottile <asottile@umich.edu> wrote:
>> This has worked great up until now (and is very convenient for trying things
>> out without blowing away the system installation).  What changed?
>>
>
> (Just guessing myself:)
>
> $ git log --grep git-sh-i18n v2.10.0..v2.11.0-rc0
> ...
> commit 1073094f30a8dd5ae49f2146f587085c4fe86410
> Author: Anders Kaseorg <andersk@mit.edu>
> Date:   Sat Oct 29 22:10:02 2016 -0400
>
>     git-sh-setup: be explicit where to dot-source git-sh-i18n from.
>
>     d323c6b641 ("i18n: git-sh-setup.sh: mark strings for translation",
>     2016-06-17) started to dot-source git-sh-i18n shell script library,
>     assuming that $PATH is already adjusted for our scripts, namely,
>     $GIT_EXEC_PATH is at the beginning of $PATH.
> ...

Before that one since v2.10.0, there ie d323c6b641 that starts to
include git-sh-i18n from git-sh-setup in the first place.  If you are
testing or using a newly-out-of-oven uninstalled Git, you would need
to do these to be correctly using it:

 * Many subcommand executables and helpers are not installed on any
   directory on your $PATH, but are installed in GIT_EXEC_PATH.
   Find out where it is by asking the newly-out-of-oven Git "git
   --exec-path" without setting GIT_EXEC_PATH environment variable.
   That is where your newly built one wants to find things.

 * Because you are trying to use the newly-out-of-oven Git without
   installing, you do not want to install into the real
   GIT_EXEC_PATH location yet.  Pick a new empty directory and
   arrange the files that would be installed by our Makefile into
   "git --exec-path" if you did "make install" to be in this new
   location.  The set of files include git-sh-setup and git-sh-i18n.

 * Set and export GIT_EXEC_PATH to point at this new empty directory
   you just populated.

That incidentally is how we make our "make test" work.

If you only set $PATH to the top of git build directory, without
doing the above arrangement with GIT_EXEC_PATH, things may have
appeared to work due to multitude of accidents.  Builtin commands
would worked fine because it is just a single "git" binary after
all, i.e. "git log" would not have consulted a "git-log" binary on
anywhere in your filesystem.  Other commands may have been run from
the already installed version on the system.  The latter is
particularly problematic, because it means that one thought that one
is testing the newly built on before installing to make sure that
the new one works OK, but is actually testing the already installed
one.
