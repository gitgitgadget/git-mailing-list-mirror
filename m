Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EAFC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbhLAXaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:30:46 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:60418 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353795AbhLAXao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:30:44 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1msZ0T-0000x7-Dn; Wed, 01 Dec 2021 23:27:22 +0000
Message-ID: <1f0cc771-b661-42ae-e928-75c27f1dab07@iee.email>
Date:   Wed, 1 Dec 2021 23:27:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
Content-Language: en-GB
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
References: <20211201053214.2902-1-sunshine@sunshineco.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20211201053214.2902-1-sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12/2021 05:32, Eric Sunshine wrote:
> It has long been practice in this project for a command to emit its
> primary output to stdout so that it can be captured to a file or sent
> down a pipe, and to emit "chatty" messages (such as those reporting
> progress) to stderr so that they don't interfere with the primary
> output. However, this idiomatic Unix practice is not necessarily
> universally understood and may be at odds with other schools of thought,
> such as the somewhat common one that only error messages should go to
> stderr, and all other messages to stdout. Let's help newcomers by
> documenting how stdout and stderr are used on this project.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/CodingGuidelines | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 711cb9171e..44dd178dc9 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -499,6 +499,32 @@ For Python scripts:
>   - Where required libraries do not restrict us to Python 2, we try to
>     also be compatible with Python 3.1 and later.
>  
> +
> +Program Output
> +
> + We make a distinction between a command's primary output and output
> + which is merely chatty feedback (for instance, status messages,
> + running transcript, or progress display), as well as error messages.
> + Roughly speaking, a command's primary output is that which one might
> + want to capture to a file or send down a pipe; its chatty output
> + should not interfere with those use-cases.

Is there a case for commenting on whether chatty output may be
suppressed if not feeding a terminal, or is that mentioned elsewhere? I
often see comments about the isatty() detection.

> +
> + As such, primary output should be sent to the standard output stream
> + (stdout), and chatty output should be sent to the standard error
> + stream (stderr). Examples of commands which produce primary output
> + include `git log`, `git show`, and `git branch --list` which generate
> + output on the stdout stream.
> +
> + Not all commands have primary output; this is often true of commands
> + whose main function is to perform an action. Some action commands are
> + silent, whereas others are chatty. An example of a chatty action
> + commands is `git clone` with its "Cloning into '<path>'..." and
> + "Checking connectivity..." status messages which it sends to the
> + stderr stream.
> +
> + Error messages are always sent to the stderr stream.
> +
> +
>  Error Messages
>  
>   - Do not end error messages with a full stop.
Philip
