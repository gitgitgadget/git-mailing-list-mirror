Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01956EE49A3
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 16:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjHVQnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 12:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjHVQnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 12:43:08 -0400
Received: from silly.haxx.se (silly.haxx.se [IPv6:2a02:750:7:3305::2aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7321B0
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 09:43:02 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 33AFD64941; Tue, 22 Aug 2023 18:42:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 331F37E8FF;
        Tue, 22 Aug 2023 18:42:55 +0200 (CEST)
Date:   Tue, 22 Aug 2023 18:42:55 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: FYI: git issues with libcurl 8.0/1 HTTPS push
In-Reply-To: <xmqq7cpnm48k.fsf@gitster.g>
Message-ID: <4q22785-1qr2-824o-806r-26srs4r8p34@unkk.fr>
References: <qq3252n1-o71-n1r7-281p-npqo6rs5o50@unkk.fr> <xmqq7cpnm48k.fsf@gitster.g>
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 Aug 2023, Junio C Hamano wrote:

> The following is admittedly a very blunt workaround to disable HTTP/2 for 
> the affected versions for any purpose, but I wonder if it is an acceptable 
> workaround.  The remote-curl transport helper is used for both push and 
> fetch and I didn't find a good place to automatically force the protocol 
> version only for pushes.

The downside with this approach is that you make it build-time. Since libcurl 
8.2.x is binary compatible with the previous versions, users could easily 
upgrade to a newer libcurl without rebuilding git and then unnecessarily have 
the avoid-h2 code still used.

The ideal approach would do the check in run-time to avoid that.

Wether the problem is serious enough to actually warrant such a work-around in 
the first place, I really cannot say.

-- 

  / daniel.haxx.se
