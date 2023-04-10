Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D2C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDJXXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJXXX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:23:23 -0400
X-Greylist: delayed 1076 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 16:23:22 PDT
Received: from st43p00im-ztbu10063701.me.com (st43p00im-ztbu10063701.me.com [17.58.63.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1D1BD2
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mervin.works;
        s=sig1; t=1681167925;
        bh=bGJ5V/90yUf6kT2G83wf1HFWl0FYkvaiHu5cyQhfZsA=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=CEvnHWrXj0PL+4AhOmzIuen4RJLPAIeOHyQD6wUaP+gD5YBdfC7B7x+OqL5YezBXU
         4x1/SORcX5dI7wuj6FRNJXpo97pua+NePR2DuiWs3iXKabC7Sbi9p3Ket3PO7Mgyjm
         jN5rCOBs8zcbT0TB5L9snb+MJpTDXaohOsbBUp6+siLeJh0a4VrEj2h4w4AWqoE4n1
         j814g10wdDCfxrlR4Mfovwx7M6PgeHXQm44gbVBIkdvP2QH5zOoLphw6foaoUC2KZV
         1EAIw0s74aBPFJy9sn3eEmL2IQksJJfQ+I32wLiHlUhJ3b3Gr/eektfrepnuNz+VPT
         a3AKNZkUiIhRA==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 1A237D00C78;
        Mon, 10 Apr 2023 23:05:23 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Mervin Guy <mail@mervin.works>
Mime-Version: 1.0 (1.0)
Subject: Re: 'git config --edit' unexpected behavior
Date:   Mon, 10 Apr 2023 19:05:12 -0400
Message-Id: <C65981B6-49FA-4A62-84D6-541D3CFF0541@mervin.works>
References: <D6798678-9CC3-416F-B238-F3D28EC910B2@mervin.works>
Cc:     git@vger.kernel.org
In-Reply-To: <D6798678-9CC3-416F-B238-F3D28EC910B2@mervin.works>
To:     Jeff King <peff@peff.net>
X-Mailer: iPad Mail (20F5028e)
X-Proofpoint-ORIG-GUID: v4seWXFricdCXIy25uAkE83YxNKgCGcs
X-Proofpoint-GUID: v4seWXFricdCXIy25uAkE83YxNKgCGcs
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304100202
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm confident there is an error in the `git config --global -e` pipeline tho=
ugh (very likely git.c), because when using git-aliases the function perform=
s as expected.

My current alias `ec` pointing to the command `!vi $HOME/.gitconfig` - where=
 $HOME is `/root`. The full command looks like `git ec` and works as expecte=
d.

Meaning that the only difference between the failed-run and successful-run w=
as calling the git built-in `git config --global -e`.

> On Apr 10, 2023, at 16:49, Hello World! <mail@mervin.works> wrote:
>=20
> =EF=BB=BFUsing the command, the trace says it=E2=80=99s using 'vi /root/.g=
itconfig' - which is indeed the set editor.
>=20
> For more verbosity, the call-chain is 'git.c' (trace: built-in: git config=
) =E2=86=92 'run_command.c' (trace: run_command: 'vi /root/.gitconfig') whic=
h doesn=E2=80=99t seem strange.
>>> On Apr 10, 2023, at 16:25, Jeff King <peff@peff.net> wrote:
>>> =EF=BB=BF On Mon, Apr 10, 2023 at 03:44:26PM -0400, Mervin Guy wrote:
>>>=20
>>> What did you do before the bug happened? (Steps to reproduce your issue)=

>>> - Changed my directory to a git-repo I was working on, using 'cd <direct=
ory_name>'. Then I ran 'git config --global -e'.
>>> What did you expect to happen? (Expected behavior)
>>> - I exepected the command to display my current-config file, with all se=
ttings included, in my editor.
>>> What happened instead? (Actual behavior)
>>> - My config-file was overwritten and displayed a default-setup message, t=
he config-file was lost after this point.
>>> I experimented with different ways of activating the command, but they a=
ll led to an overwrite of the file.
>>=20
>> That's certainly unexpected. "git config --global -e" works fine for me.
>> And Git itself won't overwrite the file; it will run your editor with
>> the name of the file, and the editor is responsible for any writing.
>> Which editor are you trying to use? Can you try running with:
>>=20
>> GIT_TRACE=3D1 git config --global -e
>>=20
>> which should show the editor command that Git runs.
>>=20
>> -Peff
