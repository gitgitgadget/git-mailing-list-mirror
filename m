Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F8CC55191
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03E62070A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDZJ6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:58:39 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22886 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZJ6j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 05:58:39 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jSe3Y-0003Ql-64; Sun, 26 Apr 2020 10:58:37 +0100
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Mateusz_Nowoty=c5=84ski?= <maxmati4@gmail.com>
Cc:     git@vger.kernel.org, mattr94@gmail.com, bwilliams.eng@gmail.com
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <383520d8-0623-ecf5-bb02-230a35359a6b@iee.email>
Date:   Sun, 26 Apr 2020 10:58:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/04/2020 01:16, Junio C Hamano wrote:
> Mateusz Nowotyński <maxmati4@gmail.com> writes:
>
>> Currently, there is no way to use config file other then ~/.gitconfig.
>> This can cause a problem, for example, when running tests of software that
>> depends on git. In such a case user's gitconfig may contain settings that
>> are incompatible with tests.
> While I can remotely imagine how an environment variable that
> overrides everything might be useful at times, we already use
> GIT_CONFIG environment for a different purpose, so even if such a
> feature were desirable, the name is already taken, and you'd want to
> hunt for another one.  Also, I do not think I'll take this patch if
> the justification were solely the above, as it is a solved problem,
> together with the use of GIT_CONFIG_NOSYSTEM and GIT_ATTR_NOSYSTEM.

Mateusz: is there a discoverability/documentation issue for these extra
config settings (a better patch maybe there).
I know in the past (in another context) I had failed to appreciate that
these had been set so couldn't work out why some problems were occurring
for me when testing some ideas.
>
> Tests of a software that depends on git, and perhaps other things,
> will be affected in things under the testing user's home directory,
> and not just ~/.gitconfig file.  Providing stable environment to run
> in to your tests is a useful thing to do, but it is not a viable or
> a particularly smart strategy for doing so to tweak each and every
> software that your software may depend on, and your software itself,
> with a custom change like this patch.
>
> You can prepare a pretend-home directory for the use of your tests
> and point the environment variable $HOME to it while running your
> tests.  See how we do this in our test suite for inspiration---it
> all happens in t/test-lib.sh, I think.
>
> Thanks.
>
--
Philip
