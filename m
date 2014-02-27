From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] fetch: add a failing test for prunning with
 overlapping refspecs
Date: Thu, 27 Feb 2014 15:19:27 -0500
Message-ID: <CAPig+cTjvkNEfv8ThdPBVUXEGvZKAmhv9PvH1-sf4eJALUTHww@mail.gmail.com>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:19:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7Qn-0000Lx-DI
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaB0UTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 15:19:32 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:47545 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaB0UT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 15:19:28 -0500
Received: by mail-yh0-f50.google.com with SMTP id t59so1587132yho.23
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=DNb0sZ1SNLG+WfwqTh2311pr8M3yUn2CmM8TiqUxbaE=;
        b=TcWZklXKSN45giExkaUqFel/JuNKI/dmYtNwgKtUHXtAc9LaQ7u6pAC2t1K3mQVD/q
         NB796YPUK4TyY+FHlqpP6pHhQoZVU1Et8d2Bm/UzWTw1aA1yEUYS7GAPAG+W91hh5XNE
         k8WMosbXAT99G+CpmlaPUKdYMdV3cyy2acjTjU31LgLmqo0iSOcdLTAGo4asMbxGTbi4
         99UDWv3rCssuwh+/8Tfdut7AxzAHO8MewuLTzYjCv2ggMeyDCUnniQn+dd694n+r92v5
         voQ0gjftIhq7voVAssuK2AWtwDHKHgY3avrFVLWcWMC3q5ITnvPFBu8Jr7DTw/HqOIFP
         lZjg==
X-Received: by 10.236.152.233 with SMTP id d69mr17435602yhk.11.1393532367705;
 Thu, 27 Feb 2014 12:19:27 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 27 Feb 2014 12:19:27 -0800 (PST)
In-Reply-To: <1393491610-19476-1-git-send-email-cmn@elego.de>
X-Google-Sender-Auth: GClC0rtvFd1pKsaLELqD-Eocljw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242847>

On Thu, Feb 27, 2014 at 4:00 AM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> Subject: fetch: add a failing test for prunning with overlapping refs=
pecs

s/prunning/pruning/

> Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 1f0f8e6..4949e3d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -113,6 +113,26 @@ test_expect_success 'fetch --prune with a namesp=
ace keeps other namespaces' '
>         git rev-parse origin/master
>  '
>
> +test_expect_failure 'fetch --prune handles overlapping refspecs' '
> +       cd "$D" &&
> +       git update-ref refs/pull/42/head master &&
> +       git clone . prune-overlapping &&
> +       cd prune-overlapping &&
> +       git config --add remote.origin.fetch refs/pull/*/head:refs/re=
motes/origin/pr/* &&
> +
> +       git fetch --prune origin &&
> +       git rev-parse origin/master &&
> +       git rev-parse origin/pr/42 &&
> +
> +       git config --unset-all remote.origin.fetch

Broken &&-chain.

> +       git config remote.origin.fetch refs/pull/*/head:refs/remotes/=
origin/pr/* &&
> +       git config --add remote.origin.fetch refs/heads/*:refs/remote=
s/origin/* &&
> +
> +       git fetch --prune origin &&
> +       git rev-parse origin/master &&
> +       git rev-parse origin/pr/42
> +'
> +
>  test_expect_success 'fetch --prune --tags does not delete the remote=
-tracking branches' '
>         cd "$D" &&
>         git clone . prune-tags &&
> --
> 1.9.0.rc3.244.g3497008
