Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47CC2D0DC
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BFF21655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 12:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgABMKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 07:10:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:49569 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgABMKH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 07:10:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 04:10:06 -0800
X-IronPort-AV: E=Sophos;i="5.69,386,1571727600"; 
   d="scan'208";a="209775199"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 04:10:05 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     git@vger.kernel.org
Subject: BUG: sendemail-validate hook is run too early
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date:   Thu, 02 Jan 2020 14:10:02 +0200
Message-ID: <875zhut5yd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I'm trying to use the sendemail-validate hook to validate the recipients
of the patch email, among other things. Turns out the hook gets run
immediately on the input patches, *not* on the "e-mail to be sent" as
claimed by githooks(5).

This means the recipients added by git send-email automatically or on
the git send-email command-line, or any changes done by the user with
--annotate will not be validated.

This is easy to demonstrate in a git repo with e.g.

$ ln -s /bin/cat .git/hooks/sendemail-validate
$ git send-email --dry-run -1 --to bypass-validation@example.com

The file passed to the validate hook does not have the address.

If changing the location of the current validation hook seems too risky,
as apparently it's been like this for more than a decade, I suggest
adding another hook on the actual email to be sent.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
