Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 7086 invoked by uid 107); 24 Aug 2009 09:42:31 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 05:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZHXJmL (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 05:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZHXJmL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 05:42:11 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:37395 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbZHXJmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 05:42:10 -0400
Received: by qyk3 with SMTP id 3so211156qyk.4
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 02:42:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ALXhV/srhg9bpnmA867ajVJilvOV6VwIYH7hYpH0Gj4=;
        b=CJL0Ap86kJTAwJBB1s+NjZE9N4hPDz2hEZCl/6z595g4kXlKE3xA11A+G9uF4ya56k
         EsxK4lRSH7tR0D5nGT1eBzxdiT7Fy4aQhebb0RHJiPJQMRK1E+T8QsH5AKzH1dKFX9gg
         6Dbn+wDyd1jt3tAyuSMYK7m5VQrO160H6QTd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j80E1Upr/TswsTeuAoVAovZ2owyRiozj9UMSpDAL/lefTpBQHKckJEd+Edq7+Mpxsy
         G2/zvC+EeKqVUtU2HsfxUz7mCDuJ+LKvgiSNyjKnYBQ4LfvvzgliWs9BWsoHX8yRCzaD
         ZDJ+fmkK+L/0VC8zpAngIdp1qEHjhBLCB/Ero=
MIME-Version: 1.0
Received: by 10.224.74.146 with SMTP id u18mr2550783qaj.67.1251106932174; Mon, 
	24 Aug 2009 02:42:12 -0700 (PDT)
In-Reply-To: <0123e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
References: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
	 <0123e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Date:	Mon, 24 Aug 2009 11:42:12 +0200
Message-ID: <40aa078e0908240242t6ff6c5b7y9a5957e6472b7b14@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] Change regerror() definition from K&R style to 
	ANSI C (C89)
From:	Erik Faye-Lund <kusmabite@googlemail.com>
To:	Marius Storm-Olsen <mstormo@gmail.com>
Cc:	lznuaa@gmail.com, msysgit@googlegroups.com, git@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 21, 2009 at 10:10 PM, Marius Storm-Olsen<mstormo@gmail.com> wrote:
>  size_t
> -regerror (errcode, preg, errbuf, errbuf_size)
> -    int errcode;
> -    const regex_t *preg;
> -    char *errbuf;
> -    size_t errbuf_size;
> +regerror(int errcode, const regex_t *preg,
> +        char *errbuf, size_t errbuf_size)
>  {

Since the real reason isn't the K&R style defintion, but that
"errcode" has been typedef'ed, perhaps it's better to either do
something like this:

#ifdef _MSC_VER
#define errcode dummy_def
#include <crtdefs.h>
#undef errcode
#endif

...before the first crt-inclusion, or simply to rename "errcode" to
something like "error"? The latter can be done with the preprocessor
after the first crt-inclusion.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
