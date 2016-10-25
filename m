Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5462022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965387AbcJYK2L (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:28:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:65128 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753152AbcJYK2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:28:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lh7sF-1cjXa905m3-00oVKY; Tue, 25 Oct 2016 12:27:54
 +0200
Date:   Tue, 25 Oct 2016 12:27:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, e@80x24.org, jnareb@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/2] sha1_file: open window into packfiles with
 CLOEXEC
In-Reply-To: <20161024180300.52359-2-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1610251220280.3264@virtualbox>
References: <20161024180300.52359-1-larsxschneider@gmail.com> <20161024180300.52359-2-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U29GSEePHz7YnafyCckkef/7pjACNAInA9cvpO2juokDPiTVWOF
 OgVLSKDFN1EjYtGO5uy9SdT/IMZBjSUB3RIq6zxYW94dawS84XmZ79DiMnRWc++YfvqH2gS
 mY3M0MGUPZlrM+ypuBmSYyamX9tQykVLOSHYWxQP0TGnAyAVs5rmsKrMJ7+jiCxTORZKG/3
 PhL2/ZibKIZ9ZSZhgC4lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s5uGam8zi70=:cz2lOeaxo4JlHAPNt/pttP
 l9iK/anuVn4WrFwEmU6wpt5lqEmy8tHL02VDOVoqCKpQ74FtEQfea4fWu+A+TM2eav9QXd8H0
 1zGiamyExTT974+PVT5tkAUPNIqGvuLGSdgnFk86Op0DFFFIj1WsPOajyuVw3ZloIXUX9SkHB
 yVH3KXDlpTvUjErdsaSMf3X8aW3oCDjRSrJAe+hDhALOgauXfPKyxISMdmfTYlSLvjHqsnjtX
 YMfhFIVsrLgcAVH0JIWLcD+9UfEv1y25czFkpAMrKY0lVobfYajPz7NZexMJxoGAHR3oz1/pH
 ENecMO8bijMX0ovWH3D38MDMG6xIvKT7e51QFZonbfvBGQruA7mxm3qs8Nm3Q5EXjcZ76bksR
 kIBW3gSCai1bbn6EW4UCWzz5WhCvY+F/IfaMjDcBZx2TkQADFoBsSLU8LdB3wl5ZJcxCHakwi
 CUo/JfTB6fLj2l9ukUqul1TSPe1SZX2YufZM1kC78Y3VP2eJJYjeuwuUhRjWZm55YuqXsmnGo
 s6D+i9NEScKj9ovb0vQVzysLRB8svlsBSt5kCigqvFk+iHoMs2u03HAHrbmEm9iXHwNWw0Cm0
 IqVzvgpOqqo/fdpGy8uXL0Su/xhxcZ38TKRaogvrT5z8YTN/80+N/3kAnGIbdIwIQfp4idKhO
 ZF6mjL2sY17hOhT5tUYXy4woQrCDwEfcb7D4453zUrtMtqik2VMilMeHW8f2+FLFy/H42gJn/
 QccpZgdw96EumKNcQqqxg0GbfI5hfu5rP8n8HJsRhKow7Y4RlnnTf/adWhfYDZN6HTec9PB7e
 VyLAeyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Mon, 24 Oct 2016, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> All processes that the Git main process spawns inherit the open file
> descriptors of the main process. These leaked file descriptors can
> cause problems.
> 
> Use the CLOEXEC flag similar to 05d1ed61 to fix the leaked file
> descriptors. Since `git_open_noatime` does not describe the function
> properly anymore rename it to `git_open`.

The patch series may be a little bit more pleasant to read if you renamed
git_open_noatime() to git_open() first, in a separate commit.

> @@ -1598,12 +1598,18 @@ int git_open_noatime(const char *name)
>  		if (fd >= 0)
>  			return fd;
>  
> -		/* Might the failure be due to O_NOATIME? */
> -		if (errno != ENOENT && sha1_file_open_flag) {
> -			sha1_file_open_flag = 0;
> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> +		if (O_CLOEXEC && errno == EINVAL &&
> +			(sha1_file_open_flag & O_CLOEXEC)) {
> +			sha1_file_open_flag &= ~O_CLOEXEC;

How about

		if ((O_CLOEXEC & sha1_file_open_flag) && errno == EINVAL) {
			sha1_file_open_flag &= ~O_CLOEXEC;

instead? It is shorter and should be just as easily optimized out by a
C compiler if O_CLOEXEC was defined as 0.

>  			continue;
>  		}
>  
> +		/* Might the failure be due to O_NOATIME? */
> +		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
> +			sha1_file_open_flag &= ~O_NOATIME;
> +			continue;
> +		}

I *think* the --patience diff option would have made that patch a little
more obvious.

Otherwise, the patch looks fine to me,
Dscho
