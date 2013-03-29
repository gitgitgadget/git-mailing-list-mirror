From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 08:25:00 +0700
Message-ID: <CACsJy8CcTqkPeOZ7Xa=7J4BH4sSFD6X6hKjrLz3kf0J0E_J+cw@mail.gmail.com>
References: <20130328214358.GA10685@sigill.intra.peff.net> <20130328214728.GB10936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 02:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULO4t-0008MY-5u
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 02:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab3C2BZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 21:25:31 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:63364 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab3C2BZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 21:25:30 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so108133oag.29
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CEGJadi3sdHVpt7Hn8jUz3waVe0Zhou1dWCbZZAtJNI=;
        b=V+UgUtXdmmKQay9I7+QMtdBEt2XtjtJg1X13vz1IIoj8X4cUFsPexJk2mLbzjsaSqk
         9i+pvPGdFA6YBTIZZcxeWhtC+CFo03LA8htrKCa4dx6H64eZgZi+vetjIKgNOHgWvjtz
         0TXDTcfnGWW0VonPn2nlO4Or1g4pSEROquRPYjAER2ICAExvLmWB3aylvX5yUmM1qLxB
         yyDUmYh/PXIGYnU7AZJaiPKxU7kEC1Wbxo5/wf2yeYa7y8LCrVAk0fT7ZyNkSC/sCXaG
         4aTRzcKo3LRFlRJfCWbfyNQTEZPIZevi2H2TSGvTXaId+1kgXce8G/4ueeOEJGV8BNfg
         mKRg==
X-Received: by 10.60.13.39 with SMTP id e7mr249467oec.74.1364520330111; Thu,
 28 Mar 2013 18:25:30 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 28 Mar 2013 18:25:00 -0700 (PDT)
In-Reply-To: <20130328214728.GB10936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219479>

On Fri, Mar 29, 2013 at 4:47 AM, Jeff King <peff@peff.net> wrote:
> +static int fnmatch_icase_mem(const char *pattern, int patternlen,
> +                            const char *string, int stringlen,
> +                            int flags)
> +{
> +       int match_status;
> +       struct strbuf pat_buf = STRBUF_INIT;
> +       struct strbuf str_buf = STRBUF_INIT;
> +       const char *use_pat = pattern;
> +       const char *use_str = string;
> +
> +       if (pattern[patternlen]) {
> +               strbuf_add(&pat_buf, pattern, patternlen);
> +               use_pat = pat_buf.buf;
> +       }
> +       if (string[stringlen]) {
> +               strbuf_add(&str_buf, string, stringlen);
> +               use_str = str_buf.buf;
> +       }
> +
> +       match_status = fnmatch_icase(use_pat, use_str, 0);

You should pass flags in here instead of 0.
-- 
Duy
