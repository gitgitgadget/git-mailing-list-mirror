Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E731E1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 03:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdBHDGI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 22:06:08 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53840 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdBHDGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 22:06:08 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1cbIa2-0000Wv-AC; Wed, 08 Feb 2017 12:06:02 +0900
Date:   Wed, 8 Feb 2017 12:06:02 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
Message-ID: <20170208030602.dlr5qfvlwogudteg@glandium.org>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan>
 <20170208024042.trmkjm4jnxidcflg@glandium.org>
 <CA+55aFxTwK=+oJT_zujKLWEho9CoL6u6LTLDEP+wzjFDx=JQyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxTwK=+oJT_zujKLWEho9CoL6u6LTLDEP+wzjFDx=JQyQ@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 06:49:24PM -0800, Linus Torvalds wrote:
> On Tue, Feb 7, 2017 at 6:40 PM, Mike Hommey <mh@glandium.org> wrote:
> >
> > As such, the default positive match should be ':/' (which is shorter and
> > less cumbersome than ':(top)', btw)
> 
> So that's what my patch does.
> 
> However, it's actually very counter-intuitive in a subdirectory.
> 
> Git doesn't do much of that, but let me give you an example from the
> kernel. Again, this is not an example of anything I would do (because
> I'm always at the top), but:
> 
>   [torvalds@i7 linux]$ cd drivers/
>   [torvalds@i7 drivers]$ ll
> 
>   .. whee, *lots* of diorectories ..
>   .. lets see what happened in net/ ..
> 
>   [torvalds@i7 drivers]$ git diff -M --dirstat=1,cumulative
> v4.10-rc6..v4.10-rc7 -- net/
>      7.4% drivers/net/ethernet/adaptec/
>     47.9% drivers/net/ethernet/cadence/
>      7.1% drivers/net/ethernet/emulex/benet/
>      1.1% drivers/net/ethernet/freescale/
>      3.6% drivers/net/ethernet/mellanox/mlx4/
>     23.5% drivers/net/ethernet/mellanox/mlx5/core/
>     27.2% drivers/net/ethernet/mellanox/
>     92.5% drivers/net/ethernet/
>      5.3% drivers/net/wireless/intel/iwlwifi/mvm/
>      5.9% drivers/net/wireless/intel/iwlwifi/
>    100.0% drivers/net/
> 
>   .. let's see what happened *outside* of net/ ..
> 
> [torvalds@i7 drivers]$ git diff -M --dirstat=1,cumulative
> v4.10-rc6..v4.10-rc7 -- :^net/
>    2.4% arch/arm64/crypto/
>    2.1% arch/powerpc/include/asm/
>    1.5% arch/powerpc/kernel/
>    3.9% arch/powerpc/
>    3.5% arch/sparc/kernel/
>    4.1% arch/sparc/
>    8.3% arch/x86/events/intel/
>    1.7% arch/x86/kernel/cpu/mcheck/
>    1.6% arch/x86/kernel/cpu/microcode/
>    3.3% arch/x86/kernel/cpu/
>    3.8% arch/x86/kernel/
>    1.0% arch/x86/platform/efi/
>   13.3% arch/x86/
>   24.0% arch/
>    1.1% drivers/base/
>    2.9% drivers/dma/
>   12.3% drivers/gpu/drm/i915/
>    1.0% drivers/gpu/drm/nouveau/
>   16.2% drivers/gpu/drm/
>    3.9% drivers/hid/
>    1.6% drivers/iio/
>    2.3% drivers/regulator/
>    ...
> 
> Notice? When you say "show only the net subdirectory" it does the
> obvious thing relative to the current working directory, but if you
> say "show everything _but_ the net subdirectory" it suddenly starts
> showing other things.

I can totally see how this can be confusing, but the case can be made
that the problem is that `git diff` would be showing everything if you
didn't pass an exclusion list. Now, what you're suggesting introduces
some inconsistency, which, in itself, can cause confusion.

I'm not sure which confusion is worse.

Mike
