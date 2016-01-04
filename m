From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/17] update-index: read list of paths with
 strbuf_getline_crlf() under --stdin
Date: Mon, 4 Jan 2016 13:27:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041314240.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:27:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Ep-0007bM-0u
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbcADM1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:27:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:53967 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbcADM1n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:27:43 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldttv-1ZpUyY0uRv-00j0wl; Mon, 04 Jan 2016 13:27:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-5-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gTuMzm9HJPAwM7+zh6q4MOp/kfmx8ximkCRkM6ZIlEQEYCjL4BG
 Mnmq2dTBALNBMgu/eMF9Tk3NzwNlx90jeOX2PuKDneCWFqw1pvFEtES02dcoNMcuE7McWYU
 MqWK+RSkM2gzKdBJ2a+W+C2yHR+UvbepOMFu3ptIVxzsUuit1GXMa7h+HZhyNP/RPKOBVZY
 NVEAt39EPHmWQPlvO+IAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sTLekrRr1LY=:jektp5vdOdiqqzlTQiLWwL
 E60Ii0xkxmsukXU5WOG1rgQGn17k2+bqfmI7/FUx4e191Wn2n13uvsDBFPPpWO6oFx6D1MOJk
 FBilwqmtp9qJjvlaThhrA9B5cR4s/Xz0hymCvPG9XsUfxbbVEjP6YGwdk7j9CM98w/jpd3qYg
 dLSYtHnYAoV5geBK0J3oIoQZtfAa3IO4OTH3AxX1dBELfDLVP2XvLEepAX2Qm2rqZx0kajNqu
 UaM8bOYX08pDmF0AIkV1PXZU33Ut1nh1e5HSyjMxnXJaWUjH1j5i8S8DSPRJf59n0PkvFntJC
 R0uWGRtxZbGR/j3w43zYpZXimODqeQkWGcdkdeUVArB1MwWBKe86DiWv2e6FydZWANL6tCUFJ
 z1HWXk9Vn/xg9FT5d8dCgvIJ1MnqrhvupxzeYY2UgrtknWQJvam13G9+9781tEyinelP7Cq8h
 c21dLBBtGA4VJ297k3r79434s+lpzqHzQ9h97ncHW3k0OB7Wi96u/d5pUwlYchwLG38H0ShyF
 HaLU+hSVCd7OJavVNHkfljRQJaEphgqBrw1CWpIruOqePfpJ/pL6SS8q53uxyZ0YPRXKlowG4
 w2oCAw/hpFGQnQ4ym2Wacopndl0QPc/i460mbw5oO//qmObdKf6ujdVxxc6XZ7vJWrVkdkguO
 1CvBswPtXXIqz0j6W0ciTrhSlieJRaDLHHMJ//qKtntDkP9CngfXCn+nttZYE3yTJQOb9psQS
 8ewm7gezCAXlVeWBqthtUElftycmXsddPLFO8+1aMdRLIlmaHIcPRH8NKXnbou+6irVn0qRY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283304>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index a7a9a7e..3a6c5b2 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1075,7 +1075,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
>  
>  		setup_work_tree();
> -		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> +
> +		while ((line_termination
> +			? strbuf_getline_crlf(&buf, stdin)
> +			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
>  			char *p;
>  			if (line_termination && buf.buf[0] == '"') {

Again, I think it would make things clearer and more future proof if we
changed the logic to talk about nul_delimited instead of line_termination.

Ciao,
Dscho
