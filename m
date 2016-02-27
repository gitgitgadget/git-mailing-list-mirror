From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv4 2/2] submodule: port init from shell to C
Date: Sat, 27 Feb 2016 15:30:49 +0700
Message-ID: <CACsJy8C7t9LEVaEqS9GRQ3oYmXwRp33=qOo-+4R4urHco25bAA@mail.gmail.com>
References: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com> <1453948237-9860-1-git-send-email-sbeller@google.com>
 <1453948237-9860-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 09:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZaHd-0003XN-RC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 09:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbcB0IbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 03:31:21 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34136 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbcB0IbV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 03:31:21 -0500
Received: by mail-lb0-f181.google.com with SMTP id of3so57617011lbc.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 00:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u7WJWFZFByOEy0IW3BTgSnIM1ZowYN34vJSh3Y31n4U=;
        b=Id1o6cmFvqIwWHfKYyuVOeq5o/dFcUwA+yDwnUywdDcSGMvHFAy1gmpZlPRZkzszHD
         A3FIK5/Wv3ncHtJdp9cgF2tK9xyOIvKbjOYemz1+ATQMaxgcw5TcZDEkX6R0aY6N8OaE
         F0HMrozFbCrJwGXgsQzSzgBSx9PuGZx2N4519dAIXV34966DpBAOi8nB9oieUBCiOKJI
         UMSN2qjfRtiJ9xLT79vsPJzxxqRQL+r3RdU6RqXM5E698sRUWt8ShTvqRgm/1S7pFgi9
         mpG0kT1MawpcsZSBI8HIB7Rj37JlHJ1XuNYxv5BHBxosd1/Ld+JznZcBSPXmCMcV0czJ
         ti4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u7WJWFZFByOEy0IW3BTgSnIM1ZowYN34vJSh3Y31n4U=;
        b=MpDfTJNn3cpET0oE1S+iEUoshNQrSuLkmCA1Kv+XTvV3wpDgfADRk/BCHFTS//oUH5
         iFsy96SZgX6P8tVk0oqITzPShAdhM35p6KNNEy+DY40a5F6raAN6P2k/icZJObHwxVlQ
         7JOgIXp1XSLGCVdRF5lCgKn2gOIdTVSEgtECGSP3JVw7awK+WdO2y7Wp7RyGtUMkMLnx
         kmOcybHP0OpU5G8zm5Q8MHZYjuEUu8cYz05VtsCqDzbhmnw4gwi0WevFdFi+1J/KrNQg
         Ckj0nBd1JWd+TH5GPoLu+YZxGFXZ3oi/5mWjxpGbu60I7u3ZNopQ+wTSmvxQB8ST/IOS
         iOIg==
X-Gm-Message-State: AD7BkJKg0SDm1zIR9aml1sOgCD88kGawuKobA2zGSaZTXskkWW0ds45rIhY3sTwCAb1Qhurp3SoyxSq26a2VMQ==
X-Received: by 10.112.209.99 with SMTP id ml3mr2056804lbc.26.1456561879521;
 Sat, 27 Feb 2016 00:31:19 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 27 Feb 2016 00:30:49 -0800 (PST)
In-Reply-To: <1453948237-9860-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287687>

On Thu, Jan 28, 2016 at 9:30 AM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 13583d9..689c354 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> +static int module_init(int argc, const char **argv, const char *prefix)
> +{
> +       int quiet = 0;
> +       int i;
> +
> +       struct option module_init_options[] = {
> +               OPT_STRING(0, "prefix", &prefix,
> +                          N_("path"),
> +                          N_("alternative anchor for relative paths")),
> +               OPT__QUIET(&quiet, "Suppress output for initialzing a submodule"),

I think we need N_() around this "Suppress..." string. By the way,
typo in "initializing"
-- 
Duy
