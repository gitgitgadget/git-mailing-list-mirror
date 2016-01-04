From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 03/17] update-index: read --index-info with
 strbuf_getline_crlf()
Date: Mon, 4 Jan 2016 13:27:31 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041308310.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:27:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Ej-0007Uk-8X
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbcADM1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:27:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:59811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbcADM1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:27:35 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MXq3L-1albKl0wEh-00WpA1; Mon, 04 Jan 2016 13:27:32
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-4-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lq9/sRByOKtUGT+chT+1nQ3HuZVEEqNN1rfS1GxPC+lSfba8JBs
 +3Z4+BYl1yzteZeNWWuK4tIXWBsFNk6FyB8kvqi1QOUFlGn/gHm3W/O1TqHZ9RO2KScAeo8
 5TY3mAPlkx63tZ0IBee/zw18N8gaDiZ/8oyjJNMedrEiz8lcdIWhdKU8fzkPNJ/UHoRWb4y
 lRmjHaD9WkMFqE+oiwYeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RxpOgMofZN4=:egdfrVW2DflGzzcKLjoH7T
 tnNHZ+dCJ1EMFvKF1pRQmaHNyDecCuv7oQBx5yJ1/31naepRFUGWo4hb/GeBrJ9npVFj7z0bb
 pmqHJ/6iowYAWpWCF8MK0NaB0evo1eN4KeiQ3vZNIHHwOyxjERQAjI16dLOsNhheHXC4FvFiY
 oKhWF+mtjDXNVBRSeveCr0wHUS42LrRFCa1YYloTPVy2g9hNAL2BHX+Bq/yDAHcjzRxW+8fcd
 akPf5PdVkkhE3Vb+TzT7NY3TA1kq/ivolFp+al4SmzZNIorCUHT8DbZkJdZv7VgmpvrX7pVnj
 4uIXgNtuuC530cHqtKqRmZLARtFaDWY7KdWDXL36GrsA5kIiRAwQYFFejZOxiSutQMhJnX8lB
 F/V9MTsclzSGyBVLxlmxXmYxo8awSncVel/BTpjoRaAgT/Jbv54JHh77Z9EPQCa791w45YXPD
 vGGKBiYsgAP00t5hDZ3bRMjFk4q12hJ3GoVyyfTATL5Z/QV4P29JJEMFIGijcKk03hSYSIsix
 5Uoy10iMGt7DAPFDtpCCOq/C1USyVU5Ch9VmCwpnDnDc+f6pDXTuvlHOGJfsqsqnnFebMAOiw
 rdrmwV0Dg/T9/RpjhfoCzwnGUWXoPKYc3c+dHo6vCejkEstkubzdL0hh6hvZb+JHrwttUuXMz
 ZLCwS8N5qsAuIVVl4khCJklO1RBuVzbrg7VM6dlwc+8Yt5/+dfkughL+jN5AggTJ2MiUdKbMF
 usNxxjpDs5Ff96/qwkIcIP2LJsilevsbDp8ixXTCvwbD+no6eBPM1o5iJHGNLGsHXVyZUii3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283303>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 7431938..a7a9a7e 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -473,7 +473,9 @@ static void read_index_info(int line_termination)
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf uq = STRBUF_INIT;
>  
> -	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> +	while ((line_termination
> +		? strbuf_getline_crlf(&buf, stdin)
> +		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
>  		char *ptr, *tab;

This is a problematic change because it does not safeguard for future
introduction of a line_termination value other than LF or NUL. I believe
the safest would be to change read_index_info() to take a `nul_delimited`
parameter instead of the `line_termination` parameter first, and then
introduce that change to use strbuf_getline_crlf if !nul_delimited.

Ciao,
Dscho
