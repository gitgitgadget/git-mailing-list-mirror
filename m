Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347BFC001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjG1PNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjG1PNj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 11:13:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE72187
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690557216; x=1691162016; i=georgmueller@gmx.net;
 bh=yycwE5PkoPtlCZTqvvepkn+AJq1G6plj0xJEMEtnDT8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=KzrIae5WnF/etFkAKUvKsxOIEfFKs2rPxLV6QWmnGnUVNcmBPDkbZev38xHLvtXo6njAYDR
 +Bvefz8SIqODsZnpTrhfrQOkH/Z/pOf0OELryZ/sazQl9psnqcpJHrHAorQQE3SmKkFXI10Lu
 +MqRcJw9yYide71TqwRhQFME48kcNJGQPsY9RwK5W9fkGl6f4VFgPm1obv2ZOS0CKyQ/jI1yb
 JL66eTUkbvjqHiU4nddwzwQhZrUJEGeqqimf0jQoyET2/wP46Xt9wzP/TaX37hzUwrkXYlUUc
 J8w3YJfwH0VYr4Hqo8C7OM2HYwhA3nwg4SINdlH3NINIHo4IOxMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.54.0.101] ([79.246.95.128]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1qSxX93OWB-005Jce for
 <git@vger.kernel.org>; Fri, 28 Jul 2023 17:13:36 +0200
Message-ID: <e52ab62e-935a-358d-4728-afaf070a7d27@gmx.net>
Date:   Fri, 28 Jul 2023 17:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] perf probe: skip test_uprobe_from_different_cu if there
 is no gcc
Content-Language: en-US
To:     git@vger.kernel.org
References: <20230728145305.449904-2-georgmueller@gmx.net>
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <20230728145305.449904-2-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4dVyPYNM+FhWXbBme01/zvH1+5AlM5KBbJjli9m+VHPxKaH9GfM
 trHnx90Ye9Pii+sfCDUQTiwsqvStqbyJanrG0fCtUpf/LMo3NHFt9fup/D72UkUi8A9aWy2
 jdITrBaUdWSu0MjhgkNf5afI8Yr68SRJw3G2xBixe39LtM2vDN/K77nDKIoPVTEhcvf69lp
 88w2Jt1PcppjZqlC8m9/g==
UI-OutboundReport: notjunk:1;M01:P0:8wyBmxwSviw=;RdFfdSf77bZueYlFH5SSkv0IGyj
 dNVgpR+J4bkgvtMpg8EWvnjZYRnNP8D/tZt5Q6qKmjFJRYL626FoRjs7TDOl3PPicKgwiOuL4
 xe8q/51x4hlbzQr4I/wWmMEUrjJAphyjwqMHHE0/xRbJelOE9SNpZsK8q1Y8buNqwMP/NZpt+
 HNixrkHkGDU4U5ChPNxKi/lbNl5tIQUB8GPjlBbZn3O1S3O+CnrmMQC3Bw+VnvH1rr1GawaAv
 MRFdPOT7oeZtsPaGZ0H0qCIG9HpmdiAunqFclZyCYm/3OCPhhQNlmH0Y7yvuoPqYaw1cDd1W7
 PCGgBDBCZMhu86TOLSzhAa72yz9bsvY+bEe/nFqNcVBH9nVBmn9PhlTxANKz/lav1s9AA6Ps+
 FZMROT4CGAhfeHeokZ9BFcstXv6b8ZDZzqlllmY/MPUN+aKRPMCtVINZ9cylqLQiLOMS41uWt
 kLvh7yLZZwReIsAQvo0tmqRYGMbUJ9I+ZHPcpLEN/Gf2CqjeR88/flpenHd61Ors5P6+pecVZ
 LOXmT8jid6JUYc9jDcqO1F/mX+iryZ/0KdXNFLXGCaj6pS0hJAP169sM+zuiLZOECUt0zdbrf
 HVl4UvjEaUDLtaCbthX9a3CuonASXJTSAR5SW0aIrfl2WJgAwIG1tPSD4kfN57mmolG4OJGdB
 OEuFRdgN7ryOhOtiJ63O2VmbSFlHVvy5J3HnpU+1FcndH6exHfqBlBKq8AoskAaatsBgngZu9
 Tiafvo5G0yo2k0WUSS9j+pg4uhx7akPF8wN4crlVha/GzLR663aWaHFdhykGpXhOaa+MbCawL
 FKa/4d4EWw0RCzkmYJcy9sGBwAXnb9JJ/OQrgGwsU1LPm16oKdKSUEmyvgj6VRhpR0AisZiVl
 YLIjQhXGE7OxYQIK2bqVIB1FRoGjwNdGTExxCptNdFfTkfKdBaCl0SLaSXEcLOc7v2iROWP4T
 Ma6Tmnrvav3DNcHYz+R5Pef/3HY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, wrong list... :(

Am 28.07.23 um 16:52 schrieb Georg M=C3=BCller:
> Without gcc, the test will fail.
>
> On cleanup, ignore probe removal errors. Otherwise, in case of an error
> adding the probe, the temporary directory is not removed.
>
> Fixes: 56cbeacf1435 ("perf probe: Add test for regression introduced by =
switch to die_get_decl_file()")
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/CAP-5=3DfUP6UuLgRty3t2=3DfQsQi3k4hDMz415=
vWdp1x88QMvZ8ug@mail.gmail.com/
> ---
>   tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/t=
ools/perf/tests/shell/test_uprobe_from_different_cu.sh
> index 00d2e0e2e0c2..319f36ebb9a4 100755
> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> @@ -4,6 +4,12 @@
>
>   set -e
>
> +# skip if there's no gcc
> +if ! [ -x "$(command -v gcc)" ]; then
> +        echo "failed: no gcc compiler"
> +        exit 2
> +fi
> +
>   temp_dir=3D$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
>
>   cleanup()
> @@ -11,7 +17,7 @@ cleanup()
>   	trap - EXIT TERM INT
>   	if [[ "${temp_dir}" =3D~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; the=
n
>   		echo "--- Cleaning up ---"
> -		perf probe -x ${temp_dir}/testfile -d foo
> +		perf probe -x ${temp_dir}/testfile -d foo || true
>   		rm -f "${temp_dir}/"*
>   		rmdir "${temp_dir}"
>   	fi
> --
> 2.41.0
>
