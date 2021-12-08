Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhLHNpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhLHNpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 08:45:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E67C061746;
        Wed,  8 Dec 2021 05:41:50 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1muxCY-0004xd-97; Wed, 08 Dec 2021 14:41:42 +0100
Message-ID: <af5ee2e8-cd59-fc9a-35fa-6fec1fc9aa33@leemhuis.info>
Date:   Wed, 8 Dec 2021 14:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Geert Uytterhoeven <geert@linux-m68k.org>, Eric Wong <e@80x24.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Junio C Hamano <gitster@pobox.com>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
 <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
 <20211127195231.GA4636@dcvr> <xmqqtufx5p19.fsf@gitster.g>
 <87mtlnjhj6.fsf@intel.com> <20211129172618.GA26651@dcvr>
 <CAMuHMdWygx9kTemsrZdru-ieYyJXm=8276Q_ZSxZGkqsu5OWVg@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
In-Reply-To: <CAMuHMdWygx9kTemsrZdru-ieYyJXm=8276Q_ZSxZGkqsu5OWVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1638970911;ed0faea9;
X-HE-SMSGID: 1muxCY-0004xd-97
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric!

On 30.11.21 09:24, Geert Uytterhoeven wrote:
> On Mon, Nov 29, 2021 at 11:29 PM Eric Wong <e@80x24.org> wrote:
>> It's a bit much for common cases with git-send-email and
>> reasonable MUAs, I think.  I don't know if formail is commonly
>> installed, nowadays...

Well, after your earlier suggestion I considered to go with this:

-	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link:
https://lore.kernel.org/r/$1|g;' "$1"
+	perl -pi -e 's|^Message-ID:\s*<?([^>]+)>?$|Link:
https://lore.kernel.org/r/$1|i;' "$1"

But...

> Of course ;-) You need it to run checkpatch on patch series obtained
> through "b4 am", before you apply them to your tree:
> 
> $ cat *mbx | formail -s scripts/checkpatch.pl

...this made me wonder if formail would be the better solution. I came
up with this:

formail -A "Link: https://lore.kernel.org/r/`formail -c -x Message-ID <
"${1}" | sed 's!.*<\(.*\)>!\1!'`" < "${1}" | sponge "${1}"

Downsides: instead of perl it requires sed and sponge (part of
moreutils, which I guess not everyone has installed; but I tried to
avoid a big here document or moving files around).

Is that worth it? Or is there a way to realize this in a more elegant
fashion with tools everyone has installed?

Ciao, Thorsten
