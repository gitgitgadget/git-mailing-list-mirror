Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF8C4332F
	for <git@archiver.kernel.org>; Tue, 24 May 2022 06:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiEXGkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiEXGkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 02:40:05 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 23:40:02 PDT
Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC497282
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:40:02 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id CD3D961F1B; Tue, 24 May 2022 08:31:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id CC6E78035F;
        Tue, 24 May 2022 08:31:55 +0200 (CEST)
Date:   Tue, 24 May 2022 08:31:55 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <xmqqa6b7lrw6.fsf@gitster.g>
Message-ID: <q274s3nn-pp38-4sn-53ro-o2q63447r341@unkk.fr>
References: <cover.1651859773.git.git@grubix.eu>        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g>
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 May 2022, Junio C Hamano wrote:

>> It calls into cURL, which I suspect has a multi-threaded mode of
>> operation,
>
> https://curl.se/libcurl/c/threadsafe.html ;-)
>
> My understanding is that what we have is pretty much select() driven 
> single-threaded multi-fd transfer.

Confirmed. libcurl *can* use threads (if built that way), but the only use it 
has for such subthreads is for resolving host names. libcurl, its API and its 
callbacks etc always operate in the same single thread.

-- 

  / daniel.haxx.se
