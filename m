Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F141C33C9E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 03:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DAF2067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 03:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=webssup.com header.i=@webssup.com header.b="h9k2gkR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgAIDSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:18:36 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:52487 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 22:18:36 -0500
Received: by mail-pj1-f43.google.com with SMTP id a6so501247pjh.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 19:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webssup.com; s=google;
        h=from:mime-version:subject:date:references:to:in-reply-to:message-id
         :content-transfer-encoding;
        bh=nhFZcq5jaCdeTI9cvaeUuj65MI6YnSLBaR57bvLS4vg=;
        b=h9k2gkR/rxWAf1ZPx1CkrHuby4vuKab59teA8PyXD4h/Y4RzC+xRGUeKnmZ9HfLguQ
         ilAsvdZ6EX9f0qNvDPnpa/eiQrzNMER2Opf+ApKLb6us1CnLq7IrFPGepeAF3IAkUrrm
         M+UEt1Amry/nULuvANyvLmKgkBRb62PxuQqcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:date:references:to
         :in-reply-to:message-id:content-transfer-encoding;
        bh=nhFZcq5jaCdeTI9cvaeUuj65MI6YnSLBaR57bvLS4vg=;
        b=btIX31Jeh1B6sux/ombBgWQ7ECnqEG5610Hn0hraEMkrhjh6l2p3FuiHAfC6oaRr/b
         nGwk2NX8XYhGHtus7SzwsWsp/BPe/K4Fiy9NUwgxXFvmwNq+BcySweuZeNCTewQcqpEx
         bCmh9dLRhr/s47RMWjABqhGcGuDEe6yV2RLvtsA25Ef2CZBEuCnS4NFpVIW2ALABJyeh
         MuvOcHQElA4rp/KtUYJvdW230G85zx3N9RTnwuXH7YGQzh9ch8XDEHXhD+aC+Q80yUHD
         yzi32ayHBzdrCMAIMWjEwklDISFp2+Pzfz717jKknHPPAbtFBluuaHAiQs9RQMblenjB
         hDUg==
X-Gm-Message-State: APjAAAW0TQqVzexNR/Gxe6Xk9q3lr2Wo4n+jlIjguIgXNELLEYqwsEUq
        8wZdkYM8vBDTzpPg2KvGrmikM+NTaaPWsN8oJirj+5CBhUgyYMor/UesNkVNLQAeMmKwzZMypfL
        jRf969rqpzg==
X-Google-Smtp-Source: APXvYqwJ1rV12Te10fzEwUo2xmJ07DVgc22HR2PDuuIPhDOkMJglrHAmOqm/MHlkrprv0PdAgaiM2A==
X-Received: by 2002:a17:90a:3643:: with SMTP id s61mr2600906pjb.44.1578539915291;
        Wed, 08 Jan 2020 19:18:35 -0800 (PST)
Received: from [10.102.0.70] (061244206222.ctinets.com. [61.244.206.222])
        by smtp.gmail.com with ESMTPSA id c18sm5326710pfr.40.2020.01.08.19.18.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 19:18:34 -0800 (PST)
From:   On Luk <on.luk@webssup.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Dropbox do not sync particular files after using git push
Date:   Thu, 9 Jan 2020 11:18:32 +0800
References: <EC87F304-78E6-40C4-840C-45F118902079@webssup.com>
 <16B44F67-E85E-4D87-A8EC-18ED1B35DB41@webssup.com>
To:     git@vger.kernel.org
In-Reply-To: <16B44F67-E85E-4D87-A8EC-18ED1B35DB41@webssup.com>
Message-Id: <9A165840-280C-43C4-B92B-3349E07AC0B1@webssup.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sir/Madam,

I tried to report this issue to dropbox technical team, but they replied th=
at the issue was not caused by Dropbox, so I try to report to your team as =
a bug report below:

Everytime I used git to push commit to my remote repo located in my dropbox=
, some files stuck in syncing status and can=E2=80=99t be able to sync to d=
ropbox. To get those files be synced, I need to do one of the follow steps =
everytime by manually:

1.	Drag and drop back the file to dropbox using the finder.
OR
2.	Click Pause and resume syncing in dropbox desktop manager.
OR
3.	Restart Dropbox.

To make it clear, I prepared a screen recording to show the issue that I am=
 facing.

www.dropbox.com/s/ivn7qytk0u67v6n/Screen%20Recording%202020-01-03%20at%2012=
.21.21%20PM.mov?dl=3D0

This issue only appear after I switch to use my new computer running as mac=
OS 10.15, everything works fine in my old computer running as macOS 10.13.6=
.

p.s: git version 2.24.1

BRs,

On
--=20










The information in this electronic mail ("e-mail") message is for=20
the use of the named recipient(s) only and may be confidential.=C2=A0The=20
information may be protected by privilege, work product immunity or other=
=20
applicable law. If you are not the intended=C2=A0recipient(s), the retentio=
n,=20
dissemination, distribution or copying of this e-mail message is strictly=
=20
prohibited. If you receive this=C2=A0e-mail message in error, please notify=
 me=20
immediately by replying to the message and thereafter, delete all copies on=
=20
your=C2=A0system and destroy any hard copies.=C2=A0
