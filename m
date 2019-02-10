Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D351F453
	for <e@80x24.org>; Sun, 10 Feb 2019 19:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBJTIi (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 14:08:38 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59287 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfBJTIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 14:08:37 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1AJ8ZH3032789
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 14:08:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
Date:   Sun, 10 Feb 2019 14:08:30 -0500
Message-ID: <000801d4c174$05b76860$11263920$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdTBdAEJ7eSCXBA8T9+iFYVd31RZ6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I tracked down a breakage in t1404 subtest 52. The line

test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err

is correctly working, but is reporting a completion 1.

The verbose output, with diagnostics, is:

error: 'grep Unable to create '.*packed-refs.lock': File exists err' didn't
find a match in:
error: Unable to create '/home/git/git/t/trash
directory.t1404-update-ref-errors/.git/packed-refs.lock': File already
exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

Reported 1 from test_i18ngrep

err contains (without the double quotes):
"error: Unable to create '/home/git/git/t/trash
directory.t1404-update-ref-errors/.git/packed-refs.lock': File already
exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue."

Which means that 

! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"

is completing with a 1. Is that the intent? Any clues?

Thanks,
Randall

