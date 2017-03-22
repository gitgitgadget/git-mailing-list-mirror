Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7832095D
	for <e@80x24.org>; Wed, 22 Mar 2017 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965746AbdCVSrM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:47:12 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34400 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935862AbdCVSrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:47:05 -0400
Received: by mail-pg0-f48.google.com with SMTP id 21so78470695pgg.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=we9z7Upj6tIP2K55vSri/VvXDDi8IdWh7AQ0aC/WEX0=;
        b=kIT0LY/Da3qkxoBxf33K55ZGDwX3zYCoPF+cXpQ79HD0eBPMaWleSNW0XZnBFoJe5l
         rO8Ezsoo02tSsJmg26hp39qaaf7O2vyxARFSm6HnRTeQ3RlBE//uFOoxn8SLb23horhl
         9baXserCBxYmYdUUuu0rVK8kkx31ArRc4eXIlir+JdwJqalE82NglmFNR60df41rYG0V
         WrXrLD5c+dxRQmSHAeuL7Yemsq95pjgk+ux+0Z3wVymKy7frtbaYM+Y1Joi1sTRrsVN2
         m0xfjkA0Hu18n9OO3WUEe3A8O6UD1rs0CfR3Nd9hMbVJ5lWDLq4lEGc97BsTyuustA/x
         JmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=we9z7Upj6tIP2K55vSri/VvXDDi8IdWh7AQ0aC/WEX0=;
        b=Y7FthJ32pb6DOsYU2+93iDxI/g9TJTS0tvu56OXrMKbEQ5pF+MrbjCDUb8+EvExGpb
         F/1FT3WpkAfPlQVFZyjVxTZK3LuIX9OOVenXQldwRoFii9O1U5OHnlycx5WuwTKKgOmF
         iWjnuusq2O44c6n2nxRDGCITIMRgTRfZMmnMPotJJ4uhCDY/Clp2ipWuga9tJLg55Ssi
         Mk3LNUQxQzAP/7gUJCtK78eDj2cYrk+vWv6hOz6iPZykzAROi05d8fnN0T7QQ0hf4Nil
         wCDckKbgpebWKENAZWLjFUkOEsRLOoOc4uuf/+47FMIOMAOyLm2nu66lfgkswGNzt9tS
         T99Q==
X-Gm-Message-State: AFeK/H3ULisVx2s2r1+GbVPM3B6jBIjqLZ8+fX4D7j7X9dG1Nk2YhI0veHba075fH91JfczzcGTU+9IZAwU0PGXQ
X-Received: by 10.84.231.135 with SMTP id g7mr36554056plk.12.1490208424016;
 Wed, 22 Mar 2017 11:47:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 11:47:03 -0700 (PDT)
In-Reply-To: <20170322173528.ho43ulndlozq35tu@kalarepa>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 11:47:03 -0700
Message-ID: <CAGZ79kYe73_iAPU7J9Z+7q_J3F6sUmbHpiC-u2G89auns3bP3Q@mail.gmail.com>
Subject: Re: EOF test fixes (t5615/t7004)
To:     Jan Palus <jan.palus@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 10:35 AM, Jan Palus <jan.palus@gmail.com> wrote:
> Hi,
>
> attached patch fixes 2 out of 3 tests failing in my env -- missing EOF,
> incorrectly placed "&&" after EOF. One test seems to be incorrect as it
> fails even after fixing. I suspect the main difference between my env and
> others is in shell used -- mksh in my case and probably bash in others.
> Looks like bash has a nasty behavior when it encounters syntax error:
>
> $ cat test.sh
> cat >/dev/null <<-\EOF
> tagname : forged-tag
> EOF &&
> echo foo
>
> $ bash test.sh && echo success || echo failed
> test.sh: line 4: warning: here-document at line 1 delimited by
> end-of-file (wanted `EOF')
> success
>
> # notice no "foo" printed
>
> $ mksh test.sh && echo success || echo failed
> test.sh[5]: here document 'EOF' unclosed
> failed
>
> Test that fails even after fixing EOFs:
> t7004-tag.sh:verifying a forged tag with --format fail and format accordingly
>
> Note that I'm not subscribed to mailing list so in case of any questions
> please mail me directly.

Thanks for catching these bugs!

Please have a look at Documentation/SubmittingPatches.
(the most important thing is the "Sign-off-by" line indicating you
are legally permitted to send such a patch;
for one-off patches the format can be negotiated, but it is easier
for maintainers to take the proper format.)

This email conveys the actual problem very well, so only a little
change is needed to make it a proper commit message.
(c.f. git clone git://git.kernel.org/pub/scm/git/git.git/ &&
git -C git log)

Thanks,
Stefan
