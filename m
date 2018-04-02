Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA631F424
	for <e@80x24.org>; Mon,  2 Apr 2018 11:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeDBLz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 07:55:58 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34942 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeDBLz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 07:55:58 -0400
Received: by mail-io0-f169.google.com with SMTP id x77so11385675ioi.2
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hZM9ZNjEm8/kAjSjf0d3VCmjkmqjw+LuL4L2cV3RcgI=;
        b=cwDKZVhWMJ1KuJFrAVJIbqFQeISGLSBlI6x4i37WBZp4al+GLhbnCpG8AiVBgox1oO
         i66/SqQxn0XRT3pxg/+djLpfnjCSVyD0KrlaC4nCN1lUR4+SUAQBYJt27smPk8zFt8IL
         8Yxu62bEz4hK2GmudEHqkBmUlE56fkL5Q3SPfaVXRH6U4dbXSg6kJDeuwtNgmjwSgyUo
         f/s7v5wYzoW3yGwDvWlpBPe9V6POkYFqW3aOGoJWcb3yWXesFKph7Lx/21obTuLlMjvy
         gKIJ+m34dvaGuGuzkeRVxsw+dtTLxkFtLldtOTcUwboda4mnkuwnCkurLT88I10/nPIy
         g9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hZM9ZNjEm8/kAjSjf0d3VCmjkmqjw+LuL4L2cV3RcgI=;
        b=MHG1cdetgiW6Y3blA6GDcK7ywF24VqyVbPxrR6OC26OYrjRHORyJ8d+Z/IzX1g/vQ/
         +T/b9fewOqipS6lQUufEslNrJ6wjO7Tm2aQ0/UN9EhwGrHkodu8N72hsIlKYa+ZHhD3+
         OI7AVXZtMtb1FVEcQU1dbGfi9MBsnd9rgmPNbq0tS/QFK13whwZ0IoJLDJ3e8nujZ1Pm
         tmebMi9T9609aHZ8FuLNjAsOWh1DEknsWTHCqZnEyoBxxTYzqkoxH7WBpp8wJ10BNwMO
         9qdzLbgvrx/q/OpzTs3xhQTvtYJrVDNMHpjcQocoU9Ce4W5Ci2M73wBjoEd97iMwr8Zf
         /9pA==
X-Gm-Message-State: ALQs6tADdroJWV//gr+yxMzJjcqxBH6nSFUPj03xh73MsWlc4oGG3gq7
        Kb/R5xG9ca6v/kudBj9ubIlLCohhjetNiFk4XWLwNw==
X-Google-Smtp-Source: AIpwx493UpOaLGXNs10hTXLvhp/CDzuljq+FyA+SKncaRlkINkTiRV2PDdLWWmJd7bZBvYmRHBidJ3SctJBibZy66L4=
X-Received: by 10.107.201.23 with SMTP id z23mr7685575iof.135.1522670157158;
 Mon, 02 Apr 2018 04:55:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.85.4 with HTTP; Mon, 2 Apr 2018 04:55:16 -0700 (PDT)
From:   David Hoyle <davidghoyle@gmail.com>
Date:   Mon, 2 Apr 2018 12:55:16 +0100
Message-ID: <CAFGVh0yh-w3=s5WBK-HqHQd+dWKgpnqytF4E3mXv_HxrC1i78Q@mail.gmail.com>
Subject: Possible bug in git log with date ranges
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Hopefully I've read the readme file correctly for submitting something
that might be a bug.

I've recently migrated projects from an old version control system
(JEDI VCS) to Git (which I really like BTW). The way this was done was
by extracting the files from the original database and saving them to
a folder layout and then running git add / commit on the files. When
using the commit command I've used the --date switch to commit the
files using their original dates. However if I run git log with say
--since=date it seems as if this command uses the actual date the
commit was entered not the date given for the commit. The same seems
to apply to the other date filtering switches.

Below is an example using a log alias switch shows dates in a single
line format.

Date: Mon  2 Apr 2018, Time: 12:39:21, Location: D:\Documents\RAD
Studio\Applications\Eidolon.GIT
>git lg1 --since=01/Jan/2018
* 9ce470f - (Sat Jan 20 11:54:54 2018 +0000) Prevent an overflow with
an Int64 for integers by not converting. - DGH2112 (HEAD ->
Development, master)
* 863988f - (Sat Jan 20 11:53:44 2018 +0000) Tested large hard coded
integer conversion integers - stopped conversion and left as string. -
DGH2112
* e14ecc9 - (Thu Jan 4 16:33:49 2018 +0000) Added new sub-option for
Hard Coded Integers to skip 'DIV 2'. - DGH2112
* 6039285 - (Wed Jan 3 21:51:08 2018 +0000) Bracketed CodeSiteLogging
with a CODESITE IFDEF. - DGH2112
* 651c682 - (Wed Jan 3 21:50:39 2018 +0000) Bracketed CodeSiteLogging
with a CODESITE IFDEF. - DGH2112
* c94ba4e - (Wed Jan 3 19:40:42 2018 +0000) Fixed unit name
correction. - DGH2112
* 368258b - (Wed Jan 3 14:09:48 2018 +0000) Separated Metric and Check
options from their sub-options (made them a simple enumerte set). -
DGH2112
* d7aa03e - (Tue Jan 2 18:10:20 2018 +0000) Fixed issues with disabled
metrics and checks showing up in the editor reports. - DGH2112
* f7fbe87 - (Fri Dec 29 20:59:22 2017 +0000) Fixed cyclometric
complexity test as the method default is 1 not 0. - DGH2112
* ab609f9 - (Thu Dec 28 22:54:45 2017 +0000) Added two new document
options for auto hiding checks and metrics with no issues. - DGH2112
* 6ed4786 - (Thu Dec 28 22:54:24 2017 +0000) Added two new document
options for auto hiding checks and metrics with no issues. - DGH2112
* e422751 - (Thu Dec 28 22:42:31 2017 +0000) Added two new document
options for auto hiding checks and metrics with no issues. - DGH2112
* d8a9b06 - (Thu Dec 28 18:11:11 2017 +0000) Updated all reference to
AddModuleCheck to AddCheck and update the method with checks. -
DGH2112
* 52bd768 - (Wed Dec 27 23:31:52 2017 +0000) Fixed depreciated
IsLetter().\nAdd the ability for metrics to be marked as overridden. -
DGH2112
* 0b05b16 - (Wed Dec 27 22:51:53 2017 +0000) Split metrics and checks. - DGH2112
* e94ab97 - (Wed Dec 27 16:13:00 2017 +0000) Fixed unit backward
compatibility. - DGH2112
* d6fde37 - (Wed Dec 27 15:12:53 2017 +0000) Fixed TParallel.For(). - DGH2112
* 9161ded - (Sat Dec 23 16:51:33 2017 +0000) Updated code for
VirtualTress 5.5.2. - DGH2112
* 2fa264d - (Sun Dec 17 14:02:54 2017 +0000) Fixed tests. - DGH2112
* 75d438f - (Sun Dec 17 12:09:04 2017 +0000) Fixed cyclometric
comlpexity sub options for boolean expressions. - DGH2112
* 9075a62 - (Sun Dec 17 11:56:55 2017 +0000) Broke a part metrics and
checks and their sub options. - DGH2112
* 76b5ec9 - (Sat Dec 16 21:01:18 2017 +0000) Broke a part metrics and
checks and sub options. - DGH2112
* 9807ad4 - (Tue Dec 12 20:43:04 2017 +0000) Tested unicode
identifiers. - DGH2112
* d831bc0 - (Sat Dec 9 20:35:05 2017 +0000) Fixed missing CONST in
parameters. - DGH2112
* fab9981 - (Sun Nov 26 19:22:21 2017 +0000) Moved some of the metric
checks so that they only work on implemented methods not declarations.
- DGH2112
* c61f460 - (Sun Nov 19 20:22:43 2017 +0000) Updated the special tags
to have custom fonts styles, fore and background colours. - DGH2112
* 7d1fced - (Sun Nov 12 19:47:00 2017 +0000) Fixed metrics for non
unit implementations. - DGH2112
* 32fe4de - (Sun Nov 12 19:45:21 2017 +0000) Added test for checks and
metrics. - DGH2112
* 6827a22 - (Sun Nov 12 13:40:54 2017 +0000) Fixed
TestGrammarForErrors. - DGH2112
* 8713e52 - (Sun Nov 12 13:07:57 2017 +0000) Added Doc Conflicts and
Mertrics to the list of checks. - DGH2112
* 0e5c169 - (Sun Nov 12 10:03:10 2017 +0000) Added an END line to
record, objects ,classes and interfaces. - DGH2112
* ac8091c - (Sun Nov 5 20:22:23 2017 +0000) Updated the special tags
to have custom fonts styles, fore and background colours. - DGH2112
* 10dacab - (Sun Nov 5 16:19:31 2017 +0000) Fixed tests for Program,
Library and Packages where Uses does not have Interface and
Implementation sections. - DGH2112
* e7996fa - (Sun Nov 5 16:17:44 2017 +0000) Ensured metrics are
expanded. - DGH2112
* 3f6d401 - (Sun Nov 5 16:17:25 2017 +0000) Added checks for Empty
FOR, WHILE, REPEAT, and BEGIN END. - DGH2112
* 579ebc8 - (Fri Nov 3 19:07:44 2017 +0000) Fixed capitalised USES
clause. - DGH2112
* 673de9a - (Sun Oct 29 10:25:03 2017 +0000) Added checks and metrics
to the module and did some refactoring in the process. - DGH2112
* ecd7f2b - (Sat Oct 28 12:02:06 2017 +0100) Updated the signatures of
a few of the base methods to have CONST keywords for their parameters.
- DGH2112
* 105c6b9 - (Fri Oct 27 21:04:18 2017 +0100) Added CONST to
parameters. - DGH2112
* e639e91 - (Fri Oct 27 21:04:06 2017 +0100) Added CONST to
parameters. - DGH2112
* f4a1576 - (Fri Oct 27 21:03:56 2017 +0100) Added CONST to
parameters. - DGH2112
* de2052e - (Fri Oct 27 21:03:50 2017 +0100) Added CONST to
parameters. - DGH2112
* 23094dd - (Fri Oct 27 21:03:44 2017 +0100) Added CONST to
parameters. - DGH2112
* 40380c0 - (Fri Oct 27 21:03:39 2017 +0100) Added CONST to
parameters. - DGH2112
* 3d0aa7e - (Fri Oct 27 21:03:16 2017 +0100) Added CONST to
parameters. - DGH2112
* 88cbfe1 - (Sun Oct 22 12:03:15 2017 +0100) Updated code to a
Container parameter in AddIssue(). - DGH2112
* 05ddbcd - (Sun Oct 22 12:02:50 2017 +0100) Updated code to a
Container parameter in AddIssue(). - DGH2112

regards
David Hoyle
