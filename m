Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434AEE498E
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379644AbjHRTij (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379653AbjHRTiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 15:38:13 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ACB421E
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 12:38:11 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37IJZnRm2359182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:35:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <018601d9d1fc$2049ede0$60ddc9a0$@nexbridge.com> <xmqqedk0uq6r.fsf@gitster.g>
In-Reply-To: <xmqqedk0uq6r.fsf@gitster.g>
Subject: RE: [BUG] Git 2.42.0-rc2 t1092.57 script error
Date:   Fri, 18 Aug 2023 15:38:01 -0400
Organization: Nexbridge Inc.
Message-ID: <01a101d9d20b$836f1a30$8a4d4e90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJj6rMrd+LkSlDs2vIPsHje5s2cMgKgLe3Drsc/ajA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 18, 2023 3:05 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> I'm getting the following error when running t1092.57 in Git
>> 2.42.0-rc2 on NonStop ia64:
>>
>> + ensure_not_expanded status
>> test_region[8]: test: argument expected
>> grep: ensure_full_index: No such file or directory
>> error: last command exited with $?=1
>> not ok 57 - sparse-index is not expanded
>>
>> Any suggestions?
>
>Sorry for not coming up with anything concrete.
>
>"ensure_not_expanded status" should be running as its second step
>
>	test_region ! index ensure_full_index trace2.txt
>
>Which should do this:
>
>    test_region () {
>            local expect_exit=0
>            if test "$1" = "!"
>            then
>                    expect_exit=1
>                    shift
>            fi
>
>            grep -e
'"region_enter".*"category":"'"$1"'","label":"'"$2"\" "$3"
>            exitcode=$?
>
>            if test $exitcode != $expect_exit
>            then
>
>
>As "grep" complains that ensure_full_index is not a file, when the command
runs
>there the file name is "$3".
>
>So it appears to me that the first
>
>	test "$1" = "!"
>
>is not firing and failing to set expect_exit to 1 and shift the "!"
>out of $@.  Why?  I dunno.  Perhaps your shell has quirks around "local"?
I dunno.

Is this new test code? The local qualified appears to be a bash extension,
not available across all shells - from what I can determine. Is it really
required here or just fancy?

