Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A317E7D0A7
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjIUTms (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjIUTme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 15:42:34 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5AF3AB6
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 12:28:53 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id EB77423F67;
        Thu, 21 Sep 2023 15:28:50 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qjPM2-TQN-00; Thu, 21 Sep 2023 21:28:50 +0200
Date:   Thu, 21 Sep 2023 21:28:50 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] am: fix error message in parse_opt_show_current_patch()
Message-ID: <ZQyZcs/zXnPqc0Zd@ugly>
References: <fff19abd-263d-48c7-81fd-35a2766b6b16@web.de>
 <20230921110727.789156-1-oswald.buddenhagen@gmx.de>
 <xmqqh6nn5oo9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh6nn5oo9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2023 at 12:09:10PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> fwiw, this is currently the only message that actually uses the %s=%s
>> format, so as of now, factoring out the argument names has only
>> theoretical value.
>
>I am not sure I follow, if you mean that the programmer needs to
>pass "--show-current-patch" only once if we used something like
>"%1$s=%2s and %1$s=%3s", I agree that it probably has little value.
>
no, i mean that that the usual pattern is just "options '%s' and '%s' 
cannot be used together". this format string is indeed used many times, 
so it makes sense to factor out the option names to avoid duplication of 
translatable strings. not so here. but this particular case is still a 
lot less specialized than many of the other strings replaced by the 
referenced patch, and it's at least plausible that further uses would be 
added at some point, so i left it as-is.

i thought about the duplication of the option string as well, but 
compilers should merge the string constants, so that part is indeed 
de-duplicated. the cost of the extra pointer push could be avoided by 
use of the %1$s syntax, but afaict that's unprecedented in git, and i 
kind of expect that some printf implementation would throw up from it.
also, it might reduce the chance of the format being used in another 
place, but who knows.

regards
