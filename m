Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9742018D
	for <e@80x24.org>; Thu, 11 May 2017 18:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbdEKSxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 14:53:46 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38601 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdEKSxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 14:53:45 -0400
Received: by mail-wm0-f42.google.com with SMTP id 142so47283644wma.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=EQPlRSVLogXxH/18rVCtRminsl9A2MBg9cirUUSzjr4=;
        b=IfXrM6adVO5X3axCV+m8YPxcm1baYgHHHLX9tjYAo7F/YR+/QqbZD9Cwu0zeJpEgxO
         5WKH27fKP/ewI+s/DC59g8+YN6FiP4sZyATicEyesZHdOZAY2e2iT6Es2Q2BnVLIws+S
         RoYo5s20adbDJCYpOb8V6YYsLq/F8gEoHFavBZeOkVBgRdMKhIs9dQJrCKCi1ta/rpQt
         dtVk5FxI709Tb92S/j2cBy4hOYKceMNQwquz0aiTkEtCRsJh3nimhLp9yJ8IL8fx6jhX
         lytgI/xyY9fZtT4ISA6tQaFYv3UitumddQ1YYMa/xFC58O8sHCM/iI3afoCHr0+xCQHR
         cSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=EQPlRSVLogXxH/18rVCtRminsl9A2MBg9cirUUSzjr4=;
        b=jFVjitlOmehRxL0j74l+MYXoxjVMKn9cxJAUAL2d+WpcIH1JLGUaLku0iTFrOZQcvp
         rB45OBrziqFDsZ2rWSjCM6qaJVRVxP1OllWGpr3hLyYbOmbEq5JnCOw63aDLtSiOwSQT
         gE49KdC5jJuBPuTZzd+PONR8/WhKeyq+BHEy+AKA2fVmPUT8t/vaaDew0EqbNLbg1/RQ
         15jy5DZhf7++bOHL4Vye5Rnj8IBn/qdj5rS+blNnXuAQrkMzVc3WfnAWM/sVyqw998hc
         NgIF0Xih/2eKsCplH6Q2adf+pjxoRWFQix8b6ROt0NetRe0M8igjkdzh2k1JlPBDmhm8
         GV4Q==
X-Gm-Message-State: AODbwcCaY23dw8crAEKiyTQPg2ZAzstMvc3sN5zKYcYFuKa5fBurMpyC
        2dk6gFixs6XHnhv0lW+nrORp
X-Received: by 10.28.203.143 with SMTP id b137mr150839wmg.115.1494528823434;
        Thu, 11 May 2017 11:53:43 -0700 (PDT)
Received: from p2003005d8f7a37bd606bc52a7320110c.dip0.t-ipconnect.de (p2003005D8F7A37BD606BC52A7320110C.dip0.t-ipconnect.de. [2003:5d:8f7a:37bd:606b:c52a:7320:110c])
        by smtp.gmail.com with ESMTPSA id g132sm7844543wmd.33.2017.05.11.11.53.42
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 11:53:42 -0700 (PDT)
From:   Raphael Stolt <raphael.stolt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Possible bug in includeIf / conditional includes on non git initialised directories
Message-Id: <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
Date:   Thu, 11 May 2017 20:53:41 +0200
To:     Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I might have stumbled this time over a real bug in includeIf / =
conditional includes or maybe it's just as intended.
1) Given I have a correct configured includeIf and I=E2=80=99m issuing =
`git config --show-origin --get user.email` against an directory which =
hasn=E2=80=99t been `git init`ed I get the user.email configured =
globally.
2) Given I have a correct configured includeIf and I=E2=80=99m issuing =
`git config --show-origin --get user.email` against an directory which =
has been `git init`ed I get the user.email configured conditionally.
For 1) I would probably expect to get the user.email configured =
conditionally even for a plain directory.

More details see this =
(http://stackoverflow.com/questions/43919191/git-2-13-conditional-config-o=
n-windows/) Stack Overflow question.
Best regards,
Raphael Stolt





