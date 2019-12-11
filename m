Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99302C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD9D20663
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="doCBr3XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfLKRrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:47:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64723 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfLKRrb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:47:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 324EA93775;
        Wed, 11 Dec 2019 12:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mzqqLaHrm3XLbyMpoiXkoe28b+o=; b=doCBr3
        XLgqbrH8Rvw9N2wmRLNPHuJfz0v91QUFsLpnRoBAGCKHA9B6odnpcId2bDSzPJG9
        8aZvlImvQlt4dhVQR5DVFBCMA2Vu2ezU5O6AmxqQpGEOBG+zQYUm0hVr10p5EsMH
        yDjoo4ZDpqnQBSVPxVQxQesrqYlG1GLJgXggg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WN17zbPMTBXq0+MEPuo812jyaPG7szUI
        TI+B+yjdmoJcv25BYzA56q2cW8frAahz3/tHGwHwwls5E3iXWUin+GhRGyxeO46w
        +ZZaNIoVCmchD+eDs+iEpXAn43YoN6z4lhO2mJWFXr/OWyy4ni+oTlKj1xteSYEO
        OhL7BVjHc2U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29E7D93774;
        Wed, 11 Dec 2019 12:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3868A93773;
        Wed, 11 Dec 2019 12:47:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     panzercheg <panzercheg@gmail.com>
Cc:     panzercheg via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom storage location by configuration variable lfs.storage, but when "git p4" interacts with GitLFS pointers, it always used the hardcoded default that is the .git/lfs/ directory, without paying attention to the configuration.
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
        <pull.483.v2.git.1575901722.gitgitgadget@gmail.com>
        <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com>
        <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912101317340.31080@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Dec 2019 09:47:23 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912101317340.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 10 Dec 2019 13:19:13 +0100
        (CET)")
Message-ID: <xmqq8snipxec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B246C2E-1C3E-11EA-9AD8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 9 Dec 2019, Junio C Hamano wrote:
>
>> "panzercheg via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> >Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom storage location by configuration variable lfs.storage, but when "git p4" interacts with GitLFS pointers, it always used the hardcoded default that is the .git/lfs/ directory, without paying attention to the configuration.
>>
>> Oops, what happened here?
>>
>> I wonder/I wish if GGG can be a bit more helpful when seeing a
>> commit that looks "strange".
>
> There is already a ticket about that:
> https://github.com/gitgitgadget/gitgitgadget/issues/120
>
> All it requires is a contributor with a little time :-)
>
>> > From: panzercheg <panzercheg@gmail.com>
>> >
>> > Use the value configured in lfs.storage, if exists, as all the
>> > "git" operations do, for consistency.
>> >
>> > Signed-off-by: r.burenkov <panzercheg@gmail.com>
>>
>> Please make sure that the name/email as the author matches whom you
>> sign-off the patch as.
>
> This, too, should be addressed as part of above-mentioned ticket.

Tooling improvement is fine, but let's not sink too much time on
tangents and steal time from *this* patch.

Would the following version (which I munged by hand) be close enough
to what the author would have sent out in the ideal world?  If so,
let's queue it.

-- >8 --
Subject: git-p4: honor lfs.storage configuration variable
From: r.burenkov <panzercheg@gmail.com>

"git lfs" allows users to specify the custom storage location by the
configuration variable `lfs.storage`, but when "git p4" interacts with
GitLFS pointers, it always uses the hardcoded default that is the
`.git/lfs/` directory, without paying attention to the configuration.

Use the value configured in `lfs.storage`, if exists, as all the
"git" operations do, for consistency.

Signed-off-by: r.burenkov <panzercheg@gmail.com>
---
 git-p4.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..0b3a07cb31 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1257,9 +1257,15 @@ def generatePointer(self, contentFile):
             pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
 
         oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
+        # if someone use external lfs.storage ( not in local repo git )
+        lfs_path = gitConfig('lfs.storage')
+        if not lfs_path:
+            lfs_path = 'lfs'
+        if not os.path.isabs(lfs_path):
+            lfs_path = os.path.join(os.getcwd(), '.git', lfs_path)
         localLargeFile = os.path.join(
-            os.getcwd(),
-            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
+            lfs_path,
+            'objects', oid[:2], oid[2:4],
             oid,
         )
         # LFS Spec states that pointer files should not have the executable bit set.
-- 
gitgitgadget
