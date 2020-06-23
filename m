Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EDFC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C30920738
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgFWMrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:47:33 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40683 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbgFWMrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:47:32 -0400
Received: from localhost (unknown [42.109.208.228])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F23A920000D;
        Tue, 23 Jun 2020 12:47:29 +0000 (UTC)
Date:   Tue, 23 Jun 2020 18:17:26 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Installing git-gui (2.27.0)
Message-ID: <20200623124726.3f3g7gmm7zfwxvhu@yadavpratyush.com>
References: <00dd01d63d9d$65f5dda0$31e198e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00dd01d63d9d$65f5dda0$31e198e0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On 08/06/20 10:02AM, Randall S. Becker wrote:
> Hi,
> 
> This is what I found when trying to install the whole git package on the
> NonStop TNS/E platform:
> 
>  DEST /usr/local/share/git-gui/lib
>     INSTALL 644 tclIndex
> install: cannot stat 'lib/tclIndex': No such file or directory
> Makefile:293: recipe for target 'install' failed
> 
> I’m not sure why we are only hitting this now at 2.27.0. We don’t use
> git-gui anyway on this platform as it has no GUI interface. It looks like
> the install script runs auto_mkindex that actually does nothing in our case,
> so lib/tclIndex is not built.
> 
> This does block the install from completing successfully. To bypass, I added
> the following:
> 
> index f10caedaa7..943febaf75 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -256,6 +256,7 @@ lib/tclIndex: $(ALL_LIBFILES) GIT-GUI-VARS
>           $(foreach p,$(PRELOAD_FILES),source $p\;) \
>           auto_mkindex lib $(patsubst lib/%,%,$(sort $(ALL_LIBFILES))) \
>         | $(TCL_PATH) $(QUIET_2DEVNULL); then : ok; \
> +        echo >>$@ ; \
>         else \
>          echo >&2 "    * $(TCL_PATH) failed; using unoptimized loading"; \
>          rm -f $@ ; \
> 

IIUC, this is a NonStop-specific problem. This fix shouldn't go in the 
git-gui 'master', right?

-- 
Regards,
Pratyush Yadav
