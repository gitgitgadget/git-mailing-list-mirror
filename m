Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080EACA0FFA
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjIEQAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354355AbjIEK6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 06:58:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7D1A8
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693911486; x=1694516286; i=johannes.schindelin@gmx.de;
 bh=JO0TnVB1IFNbWL6uc+NnKzP0OK3dxp6ePWEy5sViIgU=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=lmw/QljNWhlfF27yOzkWcy7kezvEidbFZKZ52kNtbPwBRCVV/MIShc+YxGFD1Id+6WbPpOR
 GfV3W4RCpPocZ6FMUBpjB4QDmP1hT/IrGN1XV0W6Mk1iyCGgR7Gy9vBQJ858SUQk1anDRdo/T
 Rmb5wrQ8MV9ZtfhCSXmiQPwKMAsKnXElnjZ/M5O5rNbZQzTah5L/NHZ6sIQw8Qjwle0/KBCE+
 kYoN5OlbAWW0QTr97VGjbGfkNS1lraSOGfzPhnezvZT8m7ekQlKR+pTqUMGcW2MuCWtIeZioO
 WEIf02zvA5qDnSmE0g7p2bKfXqisjXIFzPfvV1/v1uNGiOHHuKCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1pky7t2nnr-00sygP; Tue, 05
 Sep 2023 12:58:06 +0200
Date:   Tue, 5 Sep 2023 12:58:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] var: avoid a segmentation fault when `HOME` is unset
In-Reply-To: <ZPY9j0XDt/VVMnhG@tapette.crustytoothpaste.net>
Message-ID: <d43d0b9d-6e97-94e6-2843-e6025142f963@gmx.de>
References: <pull.1580.git.1693808487058.gitgitgadget@gmail.com> <ZPY9j0XDt/VVMnhG@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CXfYiO1Yto4aA27uTkXptiknInK7NavwOuCtMOEjpYYlfKulHVu
 2SWYcCm3sOYNhWrc2G5IKyhjBpjwv/FRx5QUBzGqndX20RrDJZwmoxr5HutJ6W8N1/+JmEU
 Q2lLiySdZEWOrbrhHqN82xXiJXsGp/mbgZkmG5Umgew4V61hoEVgwYrUqK6pb21AKAYS/hm
 6lUpP0jqXyTT2mncV0AHQ==
UI-OutboundReport: notjunk:1;M01:P0:CiaSesmIrSc=;yhhTkQuhgdiY9pEnLw3lKK+1EPM
 Qv+ZBLmxqT2CLboSbpb2g7QuCyn/DB1BlKlDvJPvaZ2LvDgcfyDuv7bm1256P11f63MF4tkAN
 valfupvFEjq7NRgmRI7ekPTp5LfdaqmhVePeDVeDi8iPVC5s+mRFtKX06qkp8/lW0TLW4nILV
 D/1uQa/xreVl7v7wYAidhLp0NYkYL5mo2b00svV3B4rrbaucedbCPbkg4RX1qXOtPyYT7R78J
 R6JIjMGF+c/wA1lP4TPhOmxoxB5QTWVk9R+o87o/uTAPQCtNcqnz9b3lwTUMUOrUlvpJxld0i
 PA+rSsO5mR123kostceCZHXENWgHD9R9Rp4zViB19qqXF0uSOCsTcr/8YDgU7Pika0Pc0qc0N
 5/oEtdp9xa+frtM35Co+AqMEca2gNaTvsNSUsYq/gZo6pKSAA98hr/WhFLCaLziypEF0KaI1L
 Px7kzo+/uc6fGrVJCswDNMQsztGDIWE/A28Vyu8zlLVtRIZzzXq3ZgF5IXNXZDD0TUAyvkui9
 SkwrnmQ8522Wv6EmPahWcLYAJMZTF56M+iZxiiPBrsw9vj4aHjA24fyYYJz4wbo/mi6Zk4uiX
 GJ7XEa0tmcvQrMm3Z5P48pra7Fl6BDUeCdAugf62i9c8r+cPIoOG3z1RR7rMoV21l6mSHvrZu
 T5WisMCkR+vIlKl526k/0pxNTVJ0kcSf4BDzRoEfiw8unCl+6yM3+VuHoScweXP6/NmyQghpX
 /2oP36VhBcs53N2h/U6psKb3wcKlaLcW/jj/aKnvLD2XbNcDJzX2TkA6TGvf6gIsT+ac7pAhs
 gXCqpfd9duyvF7AsE1WQPqcKr7RGeD9J1OL/XcpnEARu6s5y26suZPHhHzb2xqRCeVzl6XrHB
 j7n8J1cioTD4bwwIY15EXNjWCgrNHLEGiEXXdLMIgAX8fci+9EC8fMFqQnyJLnwfs6H57hlbb
 3yyFwA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Mon, 4 Sep 2023, brian m. carlson wrote:

> On 2023-09-04 at 06:21:26, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The code introduced in 576a37fccbf (var: add attributes files location=
s,
> > 2023-06-27) paid careful attention to use `xstrdup()` for pointers kno=
wn
> > never to be `NULL`, and `xstrdup_or_null()` otherwise.
> >
> > One spot was missed, though: `git_attr_global_file()` can return `NULL=
`,
> > when the `HOME` variable is not set (and neither `XDG_CONFIG_HOME`), a
> > scenario not too uncommon in certain server scenarios.
> >
> > Fix this, and add a test case to avoid future regressions.
>
> Looks good to me.

Thank you for the review.

Ciao,
Johannes
