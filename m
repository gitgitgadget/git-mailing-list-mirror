Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0DDC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 05:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiK3Fus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 00:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiK3Fuq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 00:50:46 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD859FEE
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 21:50:43 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1p0FzV-0008Sy-0E
        for git@vger.kernel.org; Wed, 30 Nov 2022 00:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
        Subject; bh=Gmc+TYwvnWEgUFK1/5FhejholBDpXeq0ld31LXwNdko=; b=Cbnl8IbbCGO13AZQX
        dPIAVPyHes9+4pzlBn7VUFpOFMybsGEc5MNHiEUD1Cigyi332v64KXl5KTqIIZRo/PSAM/hE/wIc9
        DH3yI1Vi8EYlB932/iunSnKBBFT+GSHwy03Y7Gqe0LaZr/KVCPCLAYJnwZrCq9ilNEzm4NCJ3qwac
        pXcKYDV3Ih5Tk1thIV3zpJjPdpyAU2URvHT40QneIYnptU7sbxhktIsXzYv9/EO6QgbontynNpwEs
        eJAu6WaUvAlYi2rp5LPJplw3aDPDNlm0yC9xJC15Rmf+upovNvgq9wNbxZx5XeYKJpytY3Jlus/Bx
        WkMs3Wn3S/DbGCSLg==;
Received: from static-11-191-147-69.axsne.net ([69.147.191.11] helo=[10.200.51.190])
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1p0FzU-0001d8-FV
        for git@vger.kernel.org; Wed, 30 Nov 2022 00:50:40 -0500
Message-ID: <25c59966c83cdae078bdefa49f47ca8d3199475c.camel@gnu.org>
Subject: Re: [PATCH v2 3/4] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     git@vger.kernel.org
Date:   Wed, 30 Nov 2022 00:49:09 -0500
In-Reply-To: <xmqqk03dyskc.fsf@gitster.g>
References: <20221127224251.2508200-1-psmith@gnu.org>
         <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
         <patch-v2-3.4-6db7dd74e52-20221129T140159Z-avarab@gmail.com>
         <xmqqk03dyskc.fsf@gitster.g>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (by Flathub.org) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2022-11-30 at 13:28 +0900, Junio C Hamano wrote:
> I have to wonder how many projects they have broken with this change

Some, but not that many.  Most projects don't try to investigate
MAKEFLAGS, and of those that do many were already using the recommended
method, because even prior to GNU make 4.4 it was possible for
MAKEFLAGS to have stray "s" characters, in unusual situations (for
example if MAKEFLAGS were set in the makefile).

There were various bugs filed that various options could not be
investigated from within makefiles and also that running make from
within $(shell ...) didn't work right because MAKEFLAGS was not set.

It was just a mess, trying to keep the value of MAKEFLAGS set to
different values at different points in the processing of make.

Also, ensuring this trick for searching MAKEFLAGS continues to work
would have meant strictly controlling what new options we could add to
GNU make.  I haven't seen any other project use the filter-out --%
trick that the Git makefiles do, but even with that it won't help if a
new single-letter option that takes an argument is added.
