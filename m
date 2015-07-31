From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] clone: add tests for cloning with empty path
Date: Thu, 30 Jul 2015 17:58:04 -0700
Message-ID: <xmqqzj2d5ejn.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-7-git-send-email-ps@pks.im>
	<CAPig+cQ5wR8xp8erAHBzEMEs62ddULrrML53GNVuuie3kd9EvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 02:58:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKyeS-00072I-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 02:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbbGaA6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 20:58:12 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33942 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbGaA6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 20:58:11 -0400
Received: by pdbbh15 with SMTP id bh15so32638280pdb.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 17:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nHNQjDU9Q4+05fz9zex8uHNYUK2kaoDj9uYoADmMR5Q=;
        b=nf4RwwosgzGRb24LYQ9/HhVJ+e4W1tgmJAmmhAXxNfZaPWyf/UZohWjcaNpvnkstnW
         9T/+lzfNLoWEDxk9guYHRh919aaFh3pJuSTlSeodCj1uoQe/IweX6duN0J/LPUdnmXn7
         OJ0Y5Z5Lb9To0f7y80/1H0e7F6xuMFFuCdkgZY1l01P/XCj1d3DYRbFDE5uCKqFHloWC
         auYmyT2RkTaYhDycC6UGQC/8H4j068nOFdKsX6mJIqBT/x5qxAn41SdrPw3Qo1bLTJmR
         rWQ72heygaLZT1aQdTFZS9e6GI2MranaMStx1rDtQdsbP4oMtryF28opLNhjI7n88UR5
         y05w==
X-Received: by 10.70.49.73 with SMTP id s9mr212281pdn.149.1438304288887;
        Thu, 30 Jul 2015 17:58:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id k5sm4246935pdo.48.2015.07.30.17.58.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 17:58:05 -0700 (PDT)
In-Reply-To: <CAPig+cQ5wR8xp8erAHBzEMEs62ddULrrML53GNVuuie3kd9EvA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 30 Jul 2015 14:18:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275033>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jul 29, 2015 at 11:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
>> Test behavior of `git clone` when working with an empty path
>> component. This may be the case when cloning a file system's root
>> directory or from a remote server's root.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
>> index 553a3f6..acfa133 100755
>> --- a/t/t1509-root-worktree.sh
>> +++ b/t/t1509-root-worktree.sh
>> @@ -237,6 +237,45 @@ test_foobar_foobar

All true, but a more interesting question is why add more to this
test, which is known to be skipped by everybody?  The issue being
corrected is that any "<scheme>://<user>@<pass>:<site>/" that says
"the whole site serves a single repository" is problematic.

Surely, file:// and ssh:// may be examples of schemes that require
the filesystem root to be usable as the trash directory to test,
requiring a dedicated VM (causing most people to skip t1509), but
wouldn't "http://<user>@<pass>:<site>/" be easier to arrange to make
the whole site serve a single repository?
