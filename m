Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B5C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 02:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0EE20661
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 02:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=webssup.com header.i=@webssup.com header.b="ywQQ64fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgAMC4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:56:40 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:45244 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732866AbgAMC4k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 21:56:40 -0500
Received: by mail-pl1-f182.google.com with SMTP id b22so3227877pls.12
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webssup.com; s=google;
        h=from:mime-version:subject:date:references:to:in-reply-to:message-id
         :content-transfer-encoding;
        bh=nhFZcq5jaCdeTI9cvaeUuj65MI6YnSLBaR57bvLS4vg=;
        b=ywQQ64fBxczx79LvzBvT2xJB54zwRizzaEDlvNBTKQpO6cDoxxaQYHfxyFWHLgAqWR
         oplZS9nBVT/w/XQ+LlUGFN1auZ8UZbtO9rUaN7J92ooqhdHBK38dNKemIIDGyuEKUolK
         87O8ltVvSjr5VgGQ8A98TO78TexJD/XZkLPEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:date:references:to
         :in-reply-to:message-id:content-transfer-encoding;
        bh=nhFZcq5jaCdeTI9cvaeUuj65MI6YnSLBaR57bvLS4vg=;
        b=D1o58gAtUcVlw8dFyXkidjiNP/6bSXhg3+8MW9NEYh2AM+9kSay8fZepTPQHMvd/UH
         1aSHA+ZWep9U6PR9UDhR5Mqk4yQDAzMd3qn3/T621qzWJMqKJqHojmXc/K0R4AgSapMs
         wvyVKvv1Bw9Yq67ouPRHutyiDm3vcXdCxJWwws2tDxZygrzdussLpGtIATYD+SsUh25x
         bTiDXfnxEZ/5QLHcqQUWTH1jEAEdH+TjsPRwiJE48S5/jp4TyXpaMpxupFEIufujLB9H
         NdhiyebuBLAX1kluuuGOgZ7B4ssSvwpSTf3jPXiI3wWY69eCD7+Jr4Oi9ecRCLxTXdmy
         GyjA==
X-Gm-Message-State: APjAAAUCWfNr/jxEnWtylI3JoC0JerQeUtFgqA5szPyy/cU3RvREuqqe
        O/KT4lwDxpjEbosQMQEovIEQuPsJEMaDySepceIxtzrbdrBrKe3nYxOFypqnIe8vWmc+g0rnZZS
        G1x2gbvE9Ug==
X-Google-Smtp-Source: APXvYqyAsxOhMGIhj5tbRn8H7W69rTEwo2WMZBMZ3iUrdlvPDSSNLx/XnDCEMQ9F6pTrFw9BW+FbFw==
X-Received: by 2002:a17:90a:a596:: with SMTP id b22mr20536579pjq.28.1578884197891;
        Sun, 12 Jan 2020 18:56:37 -0800 (PST)
Received: from [10.102.0.70] (061244206222.ctinets.com. [61.244.206.222])
        by smtp.gmail.com with ESMTPSA id p28sm11092880pgb.93.2020.01.12.18.56.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 18:56:37 -0800 (PST)
From:   On Luk <on.luk@webssup.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Dropbox do not sync particular files after using git push
Date:   Mon, 13 Jan 2020 10:56:35 +0800
References: <EC87F304-78E6-40C4-840C-45F118902079@webssup.com>
 <16B44F67-E85E-4D87-A8EC-18ED1B35DB41@webssup.com>
 <9A165840-280C-43C4-B92B-3349E07AC0B1@webssup.com>
To:     git@vger.kernel.org
In-Reply-To: <9A165840-280C-43C4-B92B-3349E07AC0B1@webssup.com>
Message-Id: <C8290530-F064-47CD-8FA0-F42CFBF777D9@webssup.com>
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
