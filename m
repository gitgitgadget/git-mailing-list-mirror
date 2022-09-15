Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E74ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIOQJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOQJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:09:41 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 09:09:40 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C6DECC
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:09:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CC2013E827;
        Thu, 15 Sep 2022 12:07:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ScPuawO+U6LJpvGraJpup3C8y
        97L3h45Xq2fUH1ZxqM=; b=SpPPrHZH6aauZPkPYXdLClFKvpoA0x4voNbpW1Bot
        DeKJqZ6y258hUzF6f/ZuPRvMAPwCRQ42o3LalBwklFAspnwbJeOqrdP+Mh9SbG5x
        esvSKxQ0wizSnC2jXnmUXWcHRtGZM9N/OlEg9OOv9BvB//7zGIbEKpOyp5oJuP3e
        hY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F63213E825;
        Thu, 15 Sep 2022 12:07:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47F5D13E824;
        Thu, 15 Sep 2022 12:07:00 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] Update docs on GIT_* environment variables
Date:   Thu, 15 Sep 2022 09:06:54 -0700
Message-Id: <20220915160659.126441-1-gitster@pobox.com>
X-Mailer: git-send-email 2.37.3-780-gd940517dcb
In-Reply-To: <xmqq8rmkpsit.fsf@gitster.g>
References: <xmqq8rmkpsit.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6E3617CE-3510-11ED-B11C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically the environment variables that affect the behaviour of
Git have been the least well designed part of the system, as they
were haphazardly added as the authors of new features find a need to
"tweak" and use of getenv() the simplest way to implement.

Although many use git_env_bool() to implement the parsing of a
Boolean value, some use handcrafted "ask atoi() to see if it yields
0", some use "mere existence is sufficient to signal true".

Here is a result of my quick audit of environment variables
mentioned in "git help git".

 * GIT_SSL_NO_VERIFY was mentioned in description of http.sslVerify
   but there was no description.

 * Many that used git_env_bool() explained acceptable "true"
   randomly as '1' or 'yes'.  Introduce and explain the concept of
   "Boolean environment variable" and mark them as such.

 * GIT_FLUSH is an oddball that used atoi() and not git_env_bool();
   leave a NEEDSWORK: comment to fix it later.

The last two are "I found them questionable while I was reviewing
the description" and are not about Boolean variables.

Junio C Hamano (5):
  environ: document GIT_SSL_NO_VERIFY
  environ: explain Boolean environment variables
  environ: GIT_FLUSH should be made a usual Boolean
  environ: simplify description of GIT_INDEX_FILE
  environ: GIT_INDEX_VERSION affects not just a new repository

 Documentation/git.txt | 43 +++++++++++++++++++++++++++----------------
 write-or-die.c        |  1 +
 2 files changed, 28 insertions(+), 16 deletions(-)

--=20
2.37.3-780-gd940517dcb

