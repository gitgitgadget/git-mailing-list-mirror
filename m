From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 09:19:48 +0100
Message-ID: <4EF2E824.7020509@viscovery.net>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org> <4EF2D436.3080303@viscovery.net> <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 09:19:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rddsc-00013B-PK
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 09:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab1LVITy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 03:19:54 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62767 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753361Ab1LVITx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 03:19:53 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RddsT-0000ns-GC; Thu, 22 Dec 2011 09:19:49 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3E9DC1660F;
	Thu, 22 Dec 2011 09:19:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187602>

Am 12/22/2011 8:38, schrieb Junio C Hamano:
> +static void v_format(const char *prefix, const char *fmt, va_list params,
> +		     emit_fn emit, void *cb_data)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf line = STRBUF_INIT;
> +	const char *cp, *np;
> +
> +	strbuf_vaddf(&buf, fmt, params);
...
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
> -	char msg[4096];
> -	vsnprintf(msg, sizeof(msg), err, params);
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	v_format(prefix, err, params, emit_report, NULL);
>  }

Using strbuf (or xmalloc for that matter) from a function that can be
called from die() is a big no-no. You should keep the fixed-sized buffer.

-- Hannes
