Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F35C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 20:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AB860241
	for <git@archiver.kernel.org>; Wed,  5 May 2021 20:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhEEUIz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 May 2021 16:08:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64852 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhEEUIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 16:08:55 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 145K7m7F049496
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 May 2021 16:07:49 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Yuri'" <yuri@rawbw.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
In-Reply-To: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
Subject: RE: [feature suggestion] Add 'git stash export', 'git stash import' commands to allow to backup stash externally
Date:   Wed, 5 May 2021 16:07:42 -0400
Message-ID: <000401d741ea$5227c610$f6775230$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMxqwy0zF/LN/3zoRDHLW3YwxXN66ggfG0A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 5, 2021 3:52 PM, Yuri wrote:
>Subject: [feature suggestion] Add 'git stash export', 'git stash import' commands
>to allow to backup stash externally
>
>I work in a very large repository, but all of it except for my stashed items can be
>re-downloaded from the remote URL.
>
>
>Stash though is much smaller in size and is especially valuable. Its
>loss would be very expensive.
>
>
>Could you please consider adding 'git stash export', 'git stash import'
>commands so that in case of an accidental repository loss stash can be
>imported from the external backup?

I would like to suggest another option: Teach clone and fetch to transfer stash commits. They are filtered out normally. It might be straightforward to preserve the stashed commits. A mirror approach is probably not appropriate since that needs the repo to be bare and Yuri's situation is unlikely to support that. So something like --include-stashes, which would be off by default.

As a side potential defect/bug, if you fetch refs/stash, git is happy to comply and reports the HEAD update and then loses it. git show-refs does not show the stash. What I saw on the fetch was (I only had untracked files in my stash to make things more painful) as follows in 2.29.1:

$ git fetch origin refs/stash
From /path-to-repo
 * branch              refs/stash -> FETCH_HEAD

-Randall

