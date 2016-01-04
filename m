From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 02/17] check-attr, check-ignore, checkout-index: read
 paths with strbuf_getline_crlf()
Date: Mon, 4 Jan 2016 13:27:26 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041305020.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-3-git-send-email-gitster@pobox.com> <alpine.DEB.2.20.1601041258280.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:27:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Ep-0007bM-JX
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbcADM1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:27:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:49970 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbcADM1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:27:30 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M0Ppl-1ZxiSo1nTB-00ubph; Mon, 04 Jan 2016 13:27:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1601041258280.14434@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7Gvku8/GpMgtrmb7T1KiLgU6PtKDYkDYp4RrNW+Qbo1Te1EfY+l
 FkjHQ2QMnTGnY5z8KI+4OnOvB7SXwDyszCGhplSFiwHMKY14j2HMekUS80FbZPj9vrN/rI+
 b4YQAV7Kzh8cxuta/EtHXCwagWxBONQb7AzEXFWGbn9Va740CGaNZEUouMzu4PVSvf1Y6b+
 YFqujf3wSDbwCjxMFiXSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uHhqrQpTgcM=:hYRds1hexjkP9R6sQTpwyz
 xreMKzOLbYVpMURDdQ3chln6kPINJWCHwhxXfCIT7lmxylJt4p2RK2C5Yb84laJqaa63f393M
 SXgSg2tTHRsV7hHRc4ZrdmmkH3MHZ6JtP6q66ADMDhfoTzghrR2viPpy/nVm6rGqGkZgpPzmN
 AUbftIkoBu7sYZQhd05iuKHFVR7dJFDXZ3GNvUGU7IWtaSXyecWmHA5bA97HY74gF45vxvVxH
 treBgbQTRs/f8UI0FIRh3egqiRPMchGhJMO5g9R2tQDN2QOk5ZnFwywAAEhdzLndeQa51zV8g
 PHc5feeaVuKEiMeoekgBkSvmdlX9Kh+GohYqmMPZr+EPzK4Tca3u3MsI2mwpQw/uZBB6swZD5
 0rw1C4htGmqyZL2guxuCQCommWr0E3KjVNfsQipqV/37FOOfYwwaImRA1C7QCeXqsUxz5tDWo
 ruUBvjqChB+gsi91orN0Kf+8ItyJEyBnoQzobCWA+EDCwIr9K/A2H1HLSpSh623/TWShXuLRq
 kkbjQ+JwfODhgGAQpK9o1Z9UyJgQh7zDTBOktYygq8a+m+Bi3KphEFegrZFoMkZiophSYsLOv
 Dk1UHTfA9rZ3+a+5LiFEc0PfNMqsmSSeqmLZGqWhn+SGTNAlTuidHcY9N9HbSsFv2GhjT1BbY
 J3wXfkYuBeLQnJufWlWXNPAz8YzsiPwXbBdnjIHWTQmz0fQlk35Wux669RpHLII4JuOjanSjV
 dE5RsZos8qEZaHnadVjzXXWUePFCZId8tYm9TPG0jRPT2t5Q4mQ+jvPdkyiOJ2YkGcgn8k3j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283302>

Hi Junio,

On Mon, 4 Jan 2016, Johannes Schindelin wrote:

>  	strbuf_init(&buf, 0);
>  	strbuf_init(&nbuf, 0);
> -	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> -		if (line_termination && buf.buf[0] == '"') {
> +	while ((nul_term_line
> +			? strbuf_getline(&buf, stdin, '\0')
> +			: strbuf_getline_crlf(&buf, stdin)) != EOF) {
> +		if (!nul_term_line && buf.buf[0] == '"') {
>  			strbuf_reset(&nbuf);
>  			if (unquote_c_style(&nbuf, buf.buf, NULL))

FWIW this is an example of that "abuse" I referred to earlier: the call to
strbuf_getline(..., '\0') is actually *not* interested in a line at all.
So I guess I would suggest to change the name "strbuf_getline" to
"strbuf_getdelim" first, and then re-introduce a different
"strbuf_getline" which is actually your "strbuf_getline_crlf". Because
let's face it, if we are really reading a line of text, CR/LF should be
handled automatically.

Ciao,
Dscho
