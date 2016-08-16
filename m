Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8AB1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbcHPPN6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:13:58 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34611 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcHPPN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:13:57 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so29927502wma.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 08:13:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=E+0xKA21No1umO2RNn8XkCt8J+CvH+CIRESIJiC0p98=;
        b=uzNI0ELwXZwUJ/shnXTvhUT5rxYgFa3s7AOrnwcGuFnIgM3jCXzsr7KcT/Ejqryd0n
         3ruAPZFG6YJqFadxBlkbe2OHW8MlqJVpbkc0reklcW1r6zK3IfCRFskqSS9S3E75Oj8I
         j6Yj5oJmfF47SViWloFEAm6Nz5dKDUJ7ao+598D1qC3o4lI27SgS8qczXLbjd/KwbwHT
         qamXys6aMHHVHH5O63+IR52jZohDsJtb0gz0/dXUCoQ3hlVlALBd7zUhpEcCU2IdxiiH
         2JOFJJCbAj90ikw5veUKEXFPYSFUzOOFpPtB/HfiD9TfZu2UcrY6BfN71OehOIbYqw6S
         6JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E+0xKA21No1umO2RNn8XkCt8J+CvH+CIRESIJiC0p98=;
        b=G8/sL4KYwMwb+UGQzSV0aIqQhcs8wCBM26fwEvnZcbNttVRX6Yz8A5wFGUcS/3Bpxg
         2T/vQb6keyebCO+IkryAPCSSOVhyK6yC5MaFwheWAcVrJ+YWRfXhbMikuVKjaOnWNmqO
         UqPTWfj21s60TcINIyrW7yxQcRyPtE11Q3ZerQ6NDEFPRaPTgfxBjKRe/C/Vvmgo3vkv
         rKYUmK6+Ugaafu9rgH4VBqa/pBMygBV58ZaJDby/F0ABGz8DeCYx+Kvd3YOpoTlEA7PJ
         RsdBs+fb7kxV2GgBJXzVZfQVLlWLBTMAxM7v1O+F3fKiVR+wuxTSzsBF/jGOT9niuJXH
         goig==
X-Gm-Message-State: AEkoouutFV0cGvRmJAeYADuRV3N3Zs/5GZhMsWEXXv8LiL9E1+4YMZdXBVJoDetK9eC+9dKLOQ7cM22IyueLuA==
X-Received: by 10.28.100.70 with SMTP id y67mr23119666wmb.23.1471360435800;
 Tue, 16 Aug 2016 08:13:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.85.45 with HTTP; Tue, 16 Aug 2016 08:13:55 -0700 (PDT)
From:	Dmitry Neverov <dmitry.neverov@gmail.com>
Date:	Tue, 16 Aug 2016 17:13:55 +0200
Message-ID: <CAC+L6n0j0=6haBprM2ip75=orEi_5oBedHV1iPBTgi-N8Y6=4A@mail.gmail.com>
Subject: Credential helpers processing order
To:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I wonder why credential helpers are called in the order: system,
global, local, command-line and not in the reverse order? This make it
impossible to provide a custom helper and disable default ones via
command-line parameter. My use-case is to clone a repository in a
non-interactive environment where a system-level GUI helper is
configured: clone hangs since system-level helper called first and
there is no input from the user. Also if a system-level helper sets
quit=true, then lower-level helpers won't be called at all. Is it by
design?

--
Dmitry
