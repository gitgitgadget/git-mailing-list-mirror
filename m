From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] strbuf: add tests
Date: Mon, 30 May 2016 13:56:05 +0200
Message-ID: <vpqwpmbg3oq.fsf@anie.imag.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 13:56:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Lns-0003te-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 13:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbcE3L4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 07:56:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34838 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbcE3L4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 07:56:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4UBu4Ra009415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 13:56:04 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UBu5Re002055;
	Mon, 30 May 2016 13:56:05 +0200
In-Reply-To: <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 30 May 2016 12:36:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 30 May 2016 13:56:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UBu4Ra009415
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465214165.77747@nCw2WXLFiMOdfnnGJv7ovQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295889>

I agree with Johannes' remarks. I'd add two style nits:

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> --- /dev/null
> +++ b/t/helper/test-strbuf.c
> @@ -0,0 +1,69 @@
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +/*
> + * Check behavior on usual use cases
> + */
> +int test_usual(struct strbuf *sb)
> +{
> +	size_t size, old_alloc;
> +	char *res, *old_buf, *str_test = malloc(5*sizeof(char));

Spaces around binary operator.

> +int main(int argc, char *argv[])
> +{
> +	size_t size = 1;
> +	struct strbuf sb;
> +	char str_test[5] = "test";
> +	char str_foo[7] = "foo";
> +
> +	if (argc != 2)
> +		usage("test-strbuf mode");
> +
> +	if (!strcmp(argv[1], "basic_grow")) {
> +		/*
> +		 * Check if strbuf_grow(0) allocate a new NUL-terminated buffer
> +		 */
> +		strbuf_init(&sb, 0);
> +		strbuf_grow(&sb, 0);
> +		if (sb.buf == strbuf_slopbuf)
> +			die("strbuf_grow failed to alloc memory");
> +		strbuf_release(&sb);
> +		if (sb.buf != strbuf_slopbuf)
> +			die("strbuf_release does not reinitialize the strbuf");
> +	} else if (!strcmp(argv[1], "strbuf_check_behavior")) {
> +		strbuf_init(&sb, 0);
> +		return test_usual(&sb);

I think the command ("strbuf_check_behavior") should have the same name
as the function (test_usual). This avoids one indirection for the
reader going from t*.sh file to the actual test code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
