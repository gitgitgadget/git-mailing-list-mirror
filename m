Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63596C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E8020862
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfKYPlu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 25 Nov 2019 10:41:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:43826 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfKYPlu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 10:41:50 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xAPFfeif062310
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Nov 2019 10:41:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <03ad01d5a167$a834e580$f89eb080$@nexbridge.com> <20191123041616.GD6430@camp.crustytoothpaste.net>
In-Reply-To: <20191123041616.GD6430@camp.crustytoothpaste.net>
Subject: RE: Report of use of "local" per t0000-basic.sh
Date:   Mon, 25 Nov 2019 10:41:33 -0500
Message-ID: <000d01d5a3a6$d454e610$7cfeb230$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF1G3gcnV6UyV+5Fmbe6M9hvJqGXwKYUb7TqEhLvKA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 22, 2019 11:16 PM, brian m. carlson wrote:
> Is there some place in particular that you've found we're using it outside of a
> function?  I don't know about others, but I'm certainly interested in fixing
> these.  It looks like we do use it in a function in
> t0000 itself, though.

I have been checking more deeply into this. The "local" keyword is being interpreted as a program instead of a keyword on the default shell on z/OS V2R3 USS even in functions. There are two shells, something resembling ksh and another tcsh. Tests do not run at all in tcsh (no support for . file). The ksh does not implement "local", so no option there. There is a bash port available, which supports local, but subtest 43 (tests clean up even on failures) does not work, although subtest 1 does work. To make any of this work, I have had to modify the tests to explicitly tag created files as ISO8859-1 (touch file && chtag -c ISO8859-1) because by default IBM-1047 is used (filesystem configured default), and test_cmp simply does not like IBM-1047 format.



