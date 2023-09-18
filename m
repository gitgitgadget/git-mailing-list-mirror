Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B29CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 10:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjIRKKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbjIRKKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 06:10:31 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F988A6
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 03:10:25 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DBD72242F6;
        Mon, 18 Sep 2023 06:10:23 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qiBCx-X0R-00; Mon, 18 Sep 2023 12:10:23 +0200
Date:   Mon, 18 Sep 2023 12:10:23 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <ZQgiD0ivfYRpSbnJ@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
 <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g>
 <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2023 at 11:28:31AM +0200, René Scharfe wrote:
>@@ -2300,12 +2301,12 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
> 				     "--show-current-patch", arg);
> 	}
>
>-	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
>+	if (resume->mode_int == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
>
this illustrates why i don't quite like the approach: the context 
determines which variable to use.

my idea would be to introduce a new type OPTION_SET_ENUM which would 
also use the callback field. one could even adjust the data type and 
elide the callback when c23 mode (or more specifically, the enum size 
feature) is detected.

> 		return error(_("options '%s=%s' and '%s=%s' "
> 					   "cannot be used together"),

> 					 "--show-current-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
>
totally on a tangent: the argument order is bogus here.
and the line wrapping is also funny.

regards
