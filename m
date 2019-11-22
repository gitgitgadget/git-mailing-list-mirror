Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66FC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13BC2071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKVTE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:04:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35912 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKVTE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:04:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xAMJ4QID054697
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 14:04:27 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Report of use of "local" per t0000-basic.sh
Date:   Fri, 22 Nov 2019 14:04:19 -0500
Message-ID: <03ad01d5a167$a834e580$f89eb080$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdWhZwwPbMnlFYomRqqJRvXNhCswoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Based on the note in t0000-basic.sh below, I am just letting you know that I
have encountered a lack of support for the "local" on the z/OS 2.3 USS
platform except within a function. I thought you might want to know.

There are a other things that do not work, particularly preservation of the
value of $? across { } so test_eval_ does not work properly - I had to patch
it for the tests to catch non-zero completion codes. I had to move to bash
to get much of the test infrastructure. The other item that does not work is
the negative lazy prerequisites, so no tests that depend on that.

I am not contemplating submitting any patches for this situation at this
time because of other pretty significant encoding issues on the platform,
but thought the group might want to know about this.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


# This test is an experiment to check whether any Git users are using
# Shells that don't support the "local" keyword. "local" is not
# POSIX-standard, but it is very widely supported by POSIX-compliant
# shells, and if it doesn't cause problems for people, we would like
# to be able to use it in Git code.
#
# For now, this is the only test that requires "local". If your shell
# fails this test, you can ignore the failure, but please report the
# problem to the Git mailing list <git@vger.kernel.org>, as it might
# convince us to continue avoiding the use of "local".
test_expect_success 'verify that the running shell supports "local"' '
	x="notlocal" &&
	echo "local" >expected1 &&
	try_local_x >actual1 &&
	test_cmp expected1 actual1 &&
	echo "notlocal" >expected2 &&
	echo "$x" >actual2 &&
	test_cmp expected2 actual2
'

