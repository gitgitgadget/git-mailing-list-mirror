Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B0F20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 22:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdKZWk5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 17:40:57 -0500
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:34094
        "EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751858AbdKZWk4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 17:40:56 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id J5bXeU6sHsNpzJ5bZe13lP; Sun, 26 Nov 2017 15:40:56 -0700
Date:   Mon, 27 Nov 2017 00:40:51 +0200
From:   Max Kirillov <max@max630.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] t5560-http-backend-noserver.sh: add
 CONTENT_LENGTH cases
Message-ID: <20171126224051.GF26158@jessie.local>
References: <20171126193813.12531-1-max@max630.net>
 <20171126193813.12531-3-max@max630.net>
 <CAPig+cROFS+3Yon2CFr-aPUGzDY4WVbU8kHbBx68O3M8k5eeug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cROFS+3Yon2CFr-aPUGzDY4WVbU8kHbBx68O3M8k5eeug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfLhXIO63e4HcNtZoDU0le4ifji9nxOsM6Zqr7LLwG5VZlTYQKcrzhdBLQpUKlfNdZV35j5Gjn7oza9y5H6B/gfWiG5hrRTNo/tL+Wp3L+cJpEovtfj8L
 2FSMV7uU9wkNMYsNHVG0aUXGYyDqrnqiONxXuh3Qz4fPkmhs/kKEoyyUOfWJNKo/YZh/+BFPW1NVVw4PVZWOHw/86qT7DethQK/GYtupXtsqPAGyhodgTs5C
 qdaXEyTaawCMhjfdHGIvy6Od1veC2MJj+XVHFfvJ30UclyMCqkSsoCdXppNeXZPVYWdg3bKy+S4/JaP0+SxRER0kj8Vk/2pDd3R1fV+CiVS53nqmgJkYQgYh
 4iRdujvpQJz/dGBoERD60XRN7tAD5rq3fc3L/j8rQkl1UYWyWkw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 05:18:55PM -0500, Eric Sunshine wrote:
> On Sun, Nov 26, 2017 at 2:38 PM, Max Kirillov <max@max630.net> wrote:
>> +int cmd_main(int argc, const char **argv)
>> +{
>> +       if (argc == 2 && strcmp(argv[1], "(size_t)(-20)") == 0)
>> +               printf("%zu", (ssize_t)(-20));
>> +
>> +       return 0;
> 
> Perhaps this should return 0 only if it gets the expected argument
> "(size_t)(-20)", and return an error otherwise.

Yes, makes sense.

> Rather than introducing a new 'test' program, would it be possible to
> get by with just using 'printf' from the shell?
> 
>     % printf "%zu\n" -20
>     18446744073709551596

I thought about it, of course. But, I am not sure I can
exclude cases when the shell's printf uses 64-bit size_t and
git 32-bit one, or vise-versa. Same way, I cannot say it for
sure for any other software which I might use here instead
of the shell's printf. The only somewhat sure way would be
to use the same compiler, with same settings, which is used
for the production code.

I do not exclude possibility that my reasoning above is
wrong, either in general of specifically for git case. If
there are some examples where it is already used and the
risk of type size mismatch is prevented I could do it
similarly.
