Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7CDC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 19:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiGMTcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 15:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGMTcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 15:32:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A892A94D
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 12:32:17 -0700 (PDT)
Received: (qmail 15570 invoked by uid 109); 13 Jul 2022 19:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jul 2022 19:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15550 invoked by uid 111); 13 Jul 2022 19:32:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jul 2022 15:32:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jul 2022 15:32:16 -0400
From:   Jeff King <peff@peff.net>
To:     Manuel Boni via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Manuel Boni <ziosombrero@gmail.com>
Subject: Re: [PATCH] config.txt: add completion for include, includeIf
Message-ID: <Ys8dwDZK2L4QfSZu@coredump.intra.peff.net>
References: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 07:02:16PM +0000, Manuel Boni via GitGitGadget wrote:

> diff --git a/Documentation/config/includeif.txt b/Documentation/config/includeif.txt
> new file mode 100644
> index 00000000000..18248cf462e
> --- /dev/null
> +++ b/Documentation/config/includeif.txt
> @@ -0,0 +1,6 @@
> +include.path::
> +
> +includeIf.<condition>.path::
> +	Special variables to include other configuration files. See
> +	the "CONFIGURATION FILE" section in the main
> +	linkgit:git-config[1] documentation.

Heh, the subject says "add completion" but the meat of this patch is
really "add documentation". I know your ulterior motive is the former,
but we should note this affects the latter just as much.

That said, I think it's an improvement there, too. It helps not only the
completion, but also humans looking in the variable list. And it does
the right thing by pointing to the existing documentation, rather than
trying to come up with a new description. So I like the direction. I
have one fix and one suggestion, though.

First the suggestion: rather than just point them to the "CONFIGURATION
FILE" section, there are subsections for "Includes" and "Conditional
Includes". Maybe worth pointing to those specific sections?

And the fix: this won't change the documentation unless you also mention
the new config/includeif.txt file from the main config.txt, like:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce..5b5b976569 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -445,6 +445,8 @@ include::config/i18n.txt[]
 
 include::config/imap.txt[]
 
+include::config/includeif.txt[]
+
 include::config/index.txt[]
 
 include::config/init.txt[]

Without that, I don't think the completion will find it either (at least
your tests did not seem to pass for me until I added it).

-Peff
