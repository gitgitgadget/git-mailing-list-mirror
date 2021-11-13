Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E28C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A035E60462
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 19:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhKMTO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 14:14:26 -0500
Received: from avasout-peh-001.plus.net ([212.159.14.17]:56663 "EHLO
        avasout-peh-001.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhKMTOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 14:14:25 -0500
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id lyQxmQuWWBpY6lyQymaCTZ; Sat, 13 Nov 2021 19:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1636830691; bh=eYXLgnyJyFp5/SHyvzEHBoTcvth1nYVQa1Sdm23J+P0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TeMVppMzBcJLEGb8an0l67PkxHaXxSWBJCMOFd8XMrVyt9rsAeMemH2rdvmpN6BwI
         ElkL0Ixy8fEHWtq4vzwqzIFwoLQDB8iCgBXchARzoePym9QmHf/4hFofSUT2EuUHEZ
         yw68yj4O1rGayXU87XlLdAfBbP8a4t2ve2l3viqTBKlAX2pbPf6FQX8W4bo6mTrKVP
         qVtxe5DjgcNmSM65Pnau2mf9hVS/gGvoUvaGGBAa+3FqF41HF14vLOqUQTVnwwxn0Q
         gqJwhFQR8W9MsCnnhSyaYNHN2e/MPFcUFUMlc9k5LJej+bdvpsLYqXyKKZ/I298WCi
         dSS7x2564hzIg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=bsQvuGWi c=1 sm=1 tr=0 ts=61900de3
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8 a=PfiV3Cz3MVd0BCe0S3gA:9 a=QEXdDO2ut3YA:10
 a=Df3jFdWbhGDLdZNm0fyq:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
 <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet>
 <xmqqee7ozyx4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <02b6cfa8-bd0a-275d-fce0-a3a9f316ded3@ramsayjones.plus.com>
Date:   Sat, 13 Nov 2021 19:11:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJDDOoibqRnAsqOQgS54EYsZA27wS+tE2j+XwM8GH2iWgod5bXuj3ipCTtpeG5UrdwkvRmyia+otKScTrMkXgygRAAAYIOhKIt1znSQDIkoZ9NyQMEGD
 CZLCkRaJDbtRxTYcvt9ECV0kH59cfQqwD42fgjDFiAfLcvVWr3RtQSdEJbhgW4bpkVtBA7CvBB17M3lCQ/IkuRup8NoxHYssgYY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/2021 12:27, Johannes Schindelin wrote:
[snip]
>> I cannot give the change any better test than they can, and it is
>> their platform to improve, or break by accident while trying to do
>> so.
> 
> Right. I tested this as well as I could, via the `--stress` option, and am
> fairly confident that it is correct. Since the patch touches only
> `simply-ipc` code, the only test that could possibly affected is t0052,
> and it passes with `--stress` over here (when it failed without the
> patch).
> 
> Ciao,
> Dscho
> 
> P.S.: in case you wondered, no, I did not run the entire test suite. With
> the performance characteristics of the POSIX emulation provided by the
> Cygwin runtime, this would simply take too long. It's not the first time I
> wish our test suite was more efficient, across _all_ supported platforms.


[I seem to have lost Adam's reply about this now being Hunky-Dory, but ...]

I ran the test-suite on -rc2 on thursday night (note _not_ rc2 + this patch)
and it deadlocked on me; I didn't notice for 4 hours, so (in the early hours)
I simply Ctl+C-ed it and went to bed. I haven't had the test-suite deadlock
for many many years - I've been spoilt! ;-)

I tried -rc2 again last night; this time it finished, but I gained another
test failure: t0301-credential-cache.sh. I have _never_ had this test fail
before, so that was unexpected. :(

[Yes, t0052-simple-ipc.sh failed as expected, since this patch was not
applied].

Also, I was half expecting a small speed-up due to the new pipe code in
v3.3.2 of the cygwin dll, but it actually took an hour longer than normal. :(

The only change to my setup, between -rc1 and -rc2, was the cygwin update
to v3.3.2, so this may point to some more fallout from the new pipe code
(maybe?).

Anyway, I haven't even looked at the new failure (see below), which we will
probably not have time to fix before release, so I am just now building
current master (v2.34.0-rc2-16-g5a73c6bdc7) to give that a try. (So, I won't
have anything to report until tomorrow).

Just FYI:

  $ ./t0301-credential-cache.sh
  ...
  not ok 13 - socket defaults to ~/.cache/git/credential/socket
  #
  #               test_when_finished "
  #                       git credential-cache exit &&
  #                       rmdir -p .cache/git/credential/
  #               " &&
  #               test_path_is_missing "$HOME/.git-credential-cache" &&
  #               test_path_is_socket "$HOME/.cache/git/credential/socket"
  #
  ...
  not ok 26 - use custom XDG_CACHE_HOME if set and default sockets are not created
  #
  #               test_when_finished "git credential-cache exit" &&
  #               test_path_is_socket "$XDG_CACHE_HOME/git/credential/socket" &&
  #               test_path_is_missing "$HOME/.git-credential-cache/socket" &&
  #               test_path_is_missing "$HOME/.cache/git/credential/socket"
  #
  not ok 27 - credential-cache --socket option overrides default location
  #
  #               test_when_finished "
  #                       git credential-cache exit --socket \"\$HOME/dir/socket\" &&
  #                       rmdir \"\$HOME/dir\"
  #               " &&
  #               check approve "cache --socket \"\$HOME/dir/socket\"" <<-\EOF &&
  #               protocol=https
  #               host=example.com
  #               username=store-user
  #               password=store-pass
  #               EOF
  #               test_path_is_socket "$HOME/dir/socket"
  #
  not ok 28 - use custom XDG_CACHE_HOME even if xdg socket exists
  #
  #               test_when_finished "
  #                       git credential-cache exit &&
  #                       sane_unset XDG_CACHE_HOME
  #               " &&
  #               check approve cache <<-\EOF &&
  #               protocol=https
  #               host=example.com
  #               username=store-user
  #               password=store-pass
  #               EOF
  #               test_path_is_socket "$HOME/.cache/git/credential/socket" &&
  #               XDG_CACHE_HOME="$HOME/xdg" &&
  #               export XDG_CACHE_HOME &&
  #               check approve cache <<-\EOF &&
  #               protocol=https
  #               host=example.com
  #               username=store-user
  #               password=store-pass
  #               EOF
  #               test_path_is_socket "$XDG_CACHE_HOME/git/credential/socket"
  #
  not ok 29 - use user socket if user directory exists
  #
  #               test_when_finished "
  #                       git credential-cache exit &&
  #                       rmdir \"\$HOME/.git-credential-cache/\"
  #               " &&
  #               mkdir -p "$HOME/.git-credential-cache/" &&
  #               chmod 700 "$HOME/.git-credential-cache/" &&
  #               check approve cache <<-\EOF &&
  #               protocol=https
  #               host=example.com
  #               username=store-user
  #               password=store-pass
  #               EOF
  #               test_path_is_socket "$HOME/.git-credential-cache/socket"
  #
  not ok 30 - use user socket if user directory is a symlink to a directory
  #
  #               test_when_finished "
  #                       git credential-cache exit &&
  #                       rmdir \"\$HOME/dir/\" &&
  #                       rm \"\$HOME/.git-credential-cache\"
  #               " &&
  #               mkdir -p -m 700 "$HOME/dir/" &&
  #               ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
  #               check approve cache <<-\EOF &&
  #               protocol=https
  #               host=example.com
  #               username=store-user
  #               password=store-pass
  #               EOF
  #               test_path_is_socket "$HOME/.git-credential-cache/socket"
  #
  ok 31 - helper (cache --timeout=1) times out
  # failed 6 among 31 test(s)
  1..31
  $
  
ATB,
Ramsay Jones
