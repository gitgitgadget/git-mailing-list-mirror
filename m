Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60DC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20A620709
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgERRHd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 13:07:33 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54066 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRHd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:07:33 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 04IH7RKG045430
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 May 2020 13:07:28 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: RE: [ANNOUNCE] Git v2.27.0-rc0 - Results on HPE NonStop TNS/X
Date:   Mon, 18 May 2020 13:07:21 -0400
Message-ID: <02b701d62d36$ced15ec0$6c741c40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdYtNSSFr477yKEpRB6DWgs7uj91fw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 14, 2020 7:28 PM, Junio C Hamano wrote:
> An early preview release Git v2.27.0-rc0 is now available for
> testing at the usual places.  It is comprised of 479 non-merge
> commits since v2.26.0, contributed by 53 people, 16 of which are
> new faces.

All tests passed except, t9001 and t9020, which is normal.

t0301 subtest 8 (1x), 11 (3x), 12 (1x), 26 (2x), still randomly fail when run 10 times, but I can't reproduce any of the failures 100% of the time. Number of failures of each is listed. For 26, the removal of a socket is not instantaneous on a MPP system, so this may be partly at fault. It can take a few microseconds, which is less than the time it takes to execute that subtest from end-to-end. If the system is heavily loaded, the results are different. Checking that a file that was created is no longer there, unless you are doing an explicit rm in the same script, is not a good plan in this platform. It looks like that 'git credential-cache exit' may be happening in a different logical CPU from the test script so it takes non-zero time for the file system on the script's logical CPU to see the removal. If I stick a sleep 5 (to be paranoid) into subtest 26, the subtest becomes a stable pass.

Regards,
Randall

