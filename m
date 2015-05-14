From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] t7601: test for =?UTF-8?Q?pull=2Eff=3Dtrue=20over?=
 =?UTF-8?Q?rides=20merge=2Eff=3Dfalse?=
Date: Thu, 14 May 2015 15:06:18 +0200
Organization: gmx
Message-ID: <2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
 <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 15:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YssqK-0001T1-2G
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066AbbENNGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 09:06:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:52911 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933101AbbENNGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:06:22 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MUI8w-1YkjtO13go-00R4mg; Thu, 14 May 2015 15:06:20
 +0200
In-Reply-To: <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:uKjT4UBOh2vWrQsGn1n/v/IEuDTLcfQR5rX8aEgo4ov/f+GRX81
 obdxx75yyKVsbCNZ2ZeyeZh1+GWA2wdjhZ7AExGpknC/CGly95S2ps2/T5t7JDNTsVbPJGs
 Nqa+t47bH3z3DXsf/KhaQpE94S6IL3OOUs342ZmlCiURe+DPCyhZ3F4gKqtrySJtiOdcu+m
 qGn8z0eJ5HgxRNAilx7Pg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269038>

Hi,

On 2015-05-13 11:52, Paul Tan wrote:
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index f768c90..cef94e6 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -45,6 +45,14 @@ test_expect_success 'fast-forward pull succeeds
> with "true" in pull.ff' '
>  	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
>  '
>  
> +test_expect_failure 'pull.ff=true overrides merge.ff=false' '
> +	git reset --hard c0 &&
> +	test_config merge.ff false &&
> +	test_config pull.ff true &&
> +	git pull . c1 &&
> +	verbose test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"

Given that Junio objected to this "verbose test", maybe you want to remove the "verbose"? Or introduce a `test_assert_equal` of the form

```sh
test_assert_equal () {
    test "a$1" = "a$2" || {
        echo "$1 != $2" >&2
        false
    }
}
```

Hmm. Now that I think about it, `test_eq` is probably a better name, still.

For the sake of having better reporting, say, in Continuous Integration (where re-running tests via `sh -x t????-*.sh -i -v` -- as Junio suggested -- is not an option), I agree that it would be good to report the non-matching strings.

Ciao,
Dscho
