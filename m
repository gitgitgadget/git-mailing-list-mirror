Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CED1F4B6
	for <e@80x24.org>; Fri,  5 Jul 2019 11:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfGELfl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 07:35:41 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45311 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGELfl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 07:35:41 -0400
Received: by mail-ed1-f45.google.com with SMTP id e2so1240357edi.12
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=/b18gu21M0gshMBYYq4cetHUhacZy6w57w8exNUJO7Y=;
        b=cOoOlgDH4obPJ8a1T4RD+fISMsv53uG/eLwqPF1HitpTWBmq2JPGmmGbsmYZ2JHdxD
         sYcsb4hpox59AFM0PguFjECcw+5lnyeqCCDCu4RDSucsW55d6oFcS8nKy83nHHddNShn
         Xv6rtq1ql2RnszlhUOhYV51ROB4EJhOeubdDE87683XtO8LAELH8OM3Mbnq9AnlVF/NN
         gigmcA7dRcAREUMrAfuAXs8LHQbOZ8KHYeOYxf1KmD8DCZVgUil5E4EP0SmzBd7BTmVF
         g0X8rxXRZlS6S163tuUTS08yZj3LZuyuwFp8p9eZ+9p4gfjd+GO4wxk/R+mP34X4EW4M
         RHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/b18gu21M0gshMBYYq4cetHUhacZy6w57w8exNUJO7Y=;
        b=lHzgQj2U/IA77NsIVNoYgUzfLR4PcnJifsFuECh4/EKSdP92vi0L50b4gGfk7DCB8U
         pkzRFbM3CMsM5vdwmkzzkQfudEI60+B6oUqWnw0Ai0JeFfLMJ2LunX65pDA6OYJqxURB
         xeaWOHEMVbikO0VVGOOlFDEGhd+M+pVmRRzrfQ5xfspJ7SWhg3RTpMlCZGd7RZyXLlCT
         e7ND/ADzS0LSP9vVbjiB7lb1wBKJbBGxT3U4XKm8Sybn8UEbb2jj09eUkPwoNIcSMZOF
         q6l2CzXoD/IG1y73Ju0ZVs9kKPIzBbojDrxMU0YZP1aPRoehDTborIk4eO/ZWWZcqgP7
         h85g==
X-Gm-Message-State: APjAAAVO90IOoVM0uxJFpTTd4W8wyu0/e6hhG5dj4JGyy6PED0HWVX9N
        mR5/ehGn+VnSIaKFbF14XqFnINdWKj7omWTZCkE5ZoLuZFvtjiUb
X-Google-Smtp-Source: APXvYqyKySp0INS9OwCrCvQoQKKp0arngQpneO0w86S0ndpCUl8toztCPIRfGhEKIgcDSOf4v2U88yPpnB6Pl1qjbu0=
X-Received: by 2002:a05:6402:134c:: with SMTP id y12mr3930675edw.96.1562326538982;
 Fri, 05 Jul 2019 04:35:38 -0700 (PDT)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Fri, 5 Jul 2019 13:35:13 +0200
Message-ID: <CABUeae_90xG7avh1yt2_X78pmpYUvLtXAZ2Kd9A=FpcEayvi-Q@mail.gmail.com>
Subject: Handling text files encoded in little-endian UTF-16 with BOM
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using git version 2.22.0.windows.1

I have a repository with number of .txt files encoded in
little-endian UTF-16 with BOM.

What are the best practice and recommended configuration to
manage such files with Git to avoid unexpected re-encoding to
UTF-8 or others?

Currently, there is .gitattriuts with entries like

   resource/*.txt   working-tree-encoding=UTF-16LE-BOM -text

Despite that some of team members have noticed that the files
occacionally get re-encoded to UTF-8. It is unknow what are
actual steps leading to that. BTW, there a few Git clients
in use: git in Git Bash, VSCode, Fork.

What bothers me in the .gitattributes is this `-text` attribute.

Is the use of `working-tree-encoding` and `-text` together a
valid combination at all?

The documentation at https://git-scm.com/docs/gitattributes
does not seem to touch on that.

I'll appreciate any suggestions on those UTF-16LE-BOM files.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
