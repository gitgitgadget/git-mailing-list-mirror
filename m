Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF68F207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947909AbdDTV6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:58:45 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36594 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947882AbdDTV6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:58:44 -0400
Received: by mail-io0-f181.google.com with SMTP id o22so97638905iod.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8VVe6uWKLl9Dwe/gFpO7zmNyTVATq7104B9xYFKS1ao=;
        b=Bjb7E0Sqo3EGF9iZBtuA5uAMje+MDYwRgpri+lEtsZyyVxU5jYKP0fc0wzw9BIxEmp
         FLjZH0my1e7ox1ZGiVqYsh47IWc84e9weDkro7DUeQynOKy0Nbdnvmt38IzI+v9SuHuh
         mgonClGn7WdZnrcSaskjg3zfYbx+Regx5/xTrd7QsYkVB7IIN1NJr5BuJ5MurMQHk9qs
         GzdlAfjW4yjzrYSil/CvXG66Xu0VMVgtvXMUbxq2Dlc24jG5KRZc3fFVmg7LrrBpPZNN
         A6L3a4Hy8//cl4CbY74uEwK6Oc9SUWCl80AQTaBCuN1lcCqwcZqHppxHQU+ow45AAkzR
         mh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8VVe6uWKLl9Dwe/gFpO7zmNyTVATq7104B9xYFKS1ao=;
        b=pPtvfZFG88DX5plw3p6waaGVv27rBCCguIQSmb++XmzkQ2S4fJ41iP8niCVuSGrEDp
         ILFVgwKhqQ/ibHHi+N+QpJIgzQZK8BPB+Y4DmVbioT8Kkpftv9SQpr0TWlWF0o25606a
         sXewqUJelijImqXhjIkPwtmfxNedDgzXHcFtTMuFefq5EM4X36bUH00AZ46os+zIvwsB
         DnidqAMMq5Xa2mE5e3C3Jrtdl0spkePH5ToUAXaXaEy0tL90BT9i/AU38tZxGvYGpj/J
         Dtp80nytxr9SpE153LYMsVbgzeMLzHiU9TW3BSw+Lw7svIepVCcX0TdcMvnAUDCU/0uW
         KtIw==
X-Gm-Message-State: AN3rC/61w3XrvTe9utDkujWO+ii5Mfv+Zh35qEiUuj4o9WnHxXUYIjJR
        FkRXeRcftW52xIELx55z4qn/QYeJDg==
X-Received: by 10.107.35.200 with SMTP id j191mr12888699ioj.33.1492725521831;
 Thu, 20 Apr 2017 14:58:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Thu, 20 Apr 2017 14:58:20 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 20 Apr 2017 23:58:20 +0200
Message-ID: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
Subject: [BUG] test suite broken with GETTEXT_POISON=YesPlease
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a refresh of everyone's memory (because mine needed it). This is a
feature I added back in 2011 when the i18n support was initially
added.

There was concern at the time that we would inadvertently mark
plumbing messages for translation, particularly something in a shared
code path, and this was a way to hopefully smoke out those issues with
the test suite.

However compiling with it breaks a couple of dozen tests, I stopped
digging when I saw some broke back in 2014.

What should be done about this? I think if we're going to keep them
they need to be run regularly by something like Travis (Lars CC'd),
however empirical evidence suggests that not running them is just fine
too, so should we just remove support for this test mode?

I don't care, but I can come up with the patch either way, but would
only be motivated to write the one-time fix for it if some CI system
is actually running them regularly, otherwise they'll just be subject
to bitrotting again.
