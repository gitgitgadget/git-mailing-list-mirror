Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C3C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 19:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbiHRTru (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiHRTrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 15:47:48 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3066110E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:47:47 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 27IJlbNP015670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Aug 2022 15:47:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Sergio via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>,
        "'Sergei Krivonos'" <sergeikrivonos@gmail.com>
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>        <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>        <Yv5wF0DxVe38ygap@tapette.crustytoothpaste.net> <xmqqa681pga7.fsf@gitster.g>
In-Reply-To: <xmqqa681pga7.fsf@gitster.g>
Subject: RE: [PATCH 2/2] Add Eclipse project settings files to .gitignore
Date:   Thu, 18 Aug 2022 15:47:32 -0400
Organization: Nexbridge Inc.
Message-ID: <032c01d8b33b$5f0253a0$1d06fae0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQExzKgjNKIBp2O0iCjgn7BX6KJRHQLOUnRxAUu7858Bxh04Tq7T2INQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 18, 2022 2:18 PM, Junio C Hamano wrote:
>To: brian m. carlson <sandals@crustytoothpaste.net>
>Cc: Sergio via GitGitGadget <gitgitgadget@gmail.com>; git@vger.kernel.org;
>Sergei Krivonos <sergeikrivonos@gmail.com>
>Subject: Re: [PATCH 2/2] Add Eclipse project settings files to .gitignore
>
>"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> location).  For example, I do this with Vim-related files, and it
>> applies to all repos on my system, such that other developers don't
>> have to care what editor I use.
>>
>> However, Eclipse is a popular editor, so it may be that Junio really
>> likes this change since it will benefit many people.
>
>I am all for making new contributor's life better, and in this case, NOT
adding
>editor-specific patterns to OUR .gitignore contributes better for that
goal.  It will
>be a shame for us to make a move that will keep our contributors unaware of
>what they can do with Git, and in this case, lack of Eclipse specific
patterns did
>trigger Sergio to notice that these are not ignored, and learn that a
better place to
>do so is in $HOME/.gitignore, because it will help not only when the
contributor
>works on Git, but when the same contributor works on anything using
Eclipse.
>Adding editor-specific patterns ourselves robs such a learning opportunity
from
>new contributors.

There is a related case to this in ECLIPSE,
https://bugs.eclipse.org/bugs/show_bug.cgi?id=575408, discussing a problem
with where ECLIPSE CDT is improperly storing and modifying build settings.
What my project team found is that much of the ECLIPSE settings need to be
preserved, especially the encodings - .gitignore is not a valid option for
these. ECLIPSE has a habit of inheriting container encodings, which is not
always correct (we keep our files in UTF-8 not cp1292). Most settings should
be retained, but the ones in .settings/language.settings.xml changes each
time ECLIPSE restarts or sometimes clones a project. Unfortunately, some of
the settings in that file are needed to bootstrap builds for new clones. The
case has been open a while with no resolution. Whether a good idea or not,
what our team found an acceptable solution is to use update-index
--assume-unchanged on that specific file and manage other ECLIPSE artifacts
in git not excluding them in .gitignore.

--Randall

