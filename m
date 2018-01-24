Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CB81F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeAXXzz (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:55:55 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45894 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXXzy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:55:54 -0500
Received: by mail-qt0-f173.google.com with SMTP id x27so14990089qtm.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 15:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudbees.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NJvgj2XIUaR8Ln0ox7REANAMO0lCL2tkrs1DDFW/JQw=;
        b=CNHPS26XldCZ6aaT+PXV9d1VTYA+OLhgtnPIqnpP7qpAI2/bb00B6Poy1OPNe22sh0
         S/m+2Qd1Z5Or1U2xX1W3822SDXeLWo54P9gJyxr3CsXs/KC7ltb6KNJiZYMNWmA2kibk
         RwskCj5bnXb89GCCEUCQW8a/uM3+dB9RUWELE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NJvgj2XIUaR8Ln0ox7REANAMO0lCL2tkrs1DDFW/JQw=;
        b=f1qrgXr5nHf1JEjn54/OB12LnB8IB3xzcmtyme+CW9K+0p2KKi5E9vnnCifW7ja+vm
         ucrs5njgaohmkHawJZfPd27E2C7RdLeOqIBP9YiMy9b6gvEJfjX9JOjXT0mGrIHAz5A2
         GaxAcQtwfnSIrGkovDJDld+JCrurszD6Gw3/nHtrCVMJiDNCOUHygw63cDzKz8ETE135
         h4nJJ3csj0RNf/D+xTrwlnXMpXx4eQCli18Pq8NR3LotZ2Bw8bj6FtgHxWqxgjXsekct
         2XA83GpWvot6X/imMCWmyMo1et4SINAhVnvMnEFTD4mSXYVohOfzsfnqcX8RmGMfi5pU
         BPkQ==
X-Gm-Message-State: AKwxytcm4BMzkPVZXU0tGhMugrFROf1ADr8nrJOmrgKkuzM6lch4X2ia
        LPwVxByHsWUH7AKwOLU+7nipwVfSmInzOO4kIF6GczmC5eg=
X-Google-Smtp-Source: AH8x226evGovuDLMFnUWo9EEkcnF1gefzGcdMOo4+sk4KMphFwIyLqhGknTNSP8s/bzLGuJpfctWVR6nC8rskrSizPM=
X-Received: by 10.200.8.87 with SMTP id x23mr13588134qth.182.1516838153491;
 Wed, 24 Jan 2018 15:55:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.81.84 with HTTP; Wed, 24 Jan 2018 15:55:53 -0800 (PST)
From:   Mark Waite <mwaite@cloudbees.com>
Date:   Wed, 24 Jan 2018 16:55:53 -0700
Message-ID: <CAM2y_jWnpDSA8kE+9z1jKW0dCzjOz053HrD479qc0ZjL13Gabw@mail.gmail.com>
Subject: git 2.16, Jenkins git client plugin, and ""
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears that git 2.16.0 and 2.16.1 have introduced a change which
surprises the Jenkins git client plugin.

Git 2.16.0 and 2.16.1 on Linux both report "fatal: ssh variant
'simple' does not support setting port" when used in the context of
the Jenkins git client plugin.

The solution we've accepted into the git client plugin source code is
to set the environment variable "GIT_SSH_VARIANT=3Dssh".  That allows
the failing case to pass, and does not seem to harm older versions of
git.

The documentation at https://git-scm.com/docs/git says that
GIT_SSH_VARIANT "overrides Git=E2=80=99s autodetection whether
GIT_SSH/GIT_SSH_COMMAND/core.sshCommand refer to OpenSSH, plink or
tortoiseplink."

I haven't seen the same message from Git 2.16.1 for Windows.

The Jenkins bug report
(https://issues.jenkins-ci.org/browse/JENKINS-49111) describes the
user experience.

Is the GIT_SSH_VARIANT solution expected to be used by git consumers
like the Jenkins git client plugin when passing credential information
through environment variables like SSH_ASKPASS?

I see "ssh", "plink", and "tortoiseplink" as values of GIT_SSH_VARIANT
used in tests, and "auto", "putty", and "simple" used in the source
code in addition to "ssh", "plink", and "tortoiseplink".  What are the
allowed values for GIT_SSH_VARIANT?

What is the recommended value so that the Jenkins git client plugin
can remain most compatible with previous behavior?

No value was assigned previously to GIT_SSH_VARIANT in the Jenkins git
client plugin.  I was expecting that git would choose "ssh" as the
default value for GIT_SSH_VARIANT, rather than apparently choosing
"simple".

Is this a bug, or is this the new, intentional behavior of git?

Thanks,
Mark Waite
