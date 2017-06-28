Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4707A2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 20:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdF1UoL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 16:44:11 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36209 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdF1UoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 16:44:10 -0400
Received: by mail-pg0-f42.google.com with SMTP id u62so37114634pgb.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=44GYWK78HArDY14aV2Pd6Efcl9kiK0/rqv/7rgUXdBU=;
        b=i+KvcghtimDH+vPIL09dahnsQyCZd7CeTIBK5eRzL+TJzflB24f7l1gqYdWOluuOFk
         Yjgg30i+pc2RlCJys+MGn4DA3DhSoqNl8NH3bwj+vvUBXvUs3iWA9BdX5/uLlz3tiiFU
         279QORGtUZ1Ptn5aq6WpjKem5peeleahYVL9lT1mPttLky81RsMRz7OVcDFjO/vVjjaH
         mZIvjSn1O5eaeL1VCgOtgJuvDAPgRoBd+pv3g/a7yNmplB1l1zPwAj2j2/b9QgtEQxD8
         bSyonVrdwWm0ffMopQCeN5XzACtkaXW3Bu9AVrijX0XI/vFapfxt6tbdPwmux7PYJmRg
         KAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=44GYWK78HArDY14aV2Pd6Efcl9kiK0/rqv/7rgUXdBU=;
        b=VnsZTEPihnzBHDybg6oiSQqP5MMn2a58pdkhAQHUYAQ0jROiIYBiA5t8cURo8qX9zz
         6Lnam9/8zVQzsmsq+qlMf5o42WHI3nek9d6itHAvuWApi4T64q9be/lTlvS/6SQU02tZ
         WdAy/deHCCMe7lguf2baLykMCD1sxq+IVZ/3CYkDlrF39/qpq+ufDO+s8dbArsIbJ6JO
         ZcX8pxy51+WBWjydssS564H1L5bLy1DuPeH2lJfWASLlvwOlaLNKGIzBNwg49a0RBqPY
         1dCmMddbNxdCmJKyTt4JPFD2VH9rwZfcnrlTuU+OwnsKNXkqZD3sgokeLR6IdDuQwUEd
         M9sA==
X-Gm-Message-State: AKS2vOx7JnHUDgXWznCjJ0IAC1VA7vr4BzvIpoe8mlEOQbuwxE/307W5
        BWQXLQE5t/IP+Rc2dd2y18SzlvI/spyD
X-Received: by 10.99.55.83 with SMTP id g19mr11940561pgn.243.1498682649451;
 Wed, 28 Jun 2017 13:44:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 28 Jun 2017 13:44:08 -0700 (PDT)
In-Reply-To: <xmqq1sq3x2xz.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sq3x2xz.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Jun 2017 13:44:08 -0700
Message-ID: <CAGZ79kbvncDoSuj8AF_rdDoEzavdzEaLxqr7NXi1_eCLNt01Kg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: do not call utf8_fprintf() unnecessarily
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 28, 2017 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The helper function utf8_fprintf(fp, ...) has exactly the same
> effect to the output stream fp as fprintf(fp, ...) does, and the
> only difference is that its return value counts in display columns
> consumed (assuming that the payload is encoded in UTF-8), as opposed
> to number of bytes.
>
> There is no reason to call it unless the caller cares about its
> return value.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * The helper was introduced at c0821965 ("Add utf8_fprintf helper
>    that returns correct number of columns", 2013-02-09), which also
>    taught the help text output from the parse_options API to use it
>    to align columns.  These original callers naturally do use the
>    returned value and left alone by this fix, which corrects all the
>    later callers that misuses it.
>

The patch looks correct.

Thanks,
Stefan

>  builtin/submodule--helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 8517032b3e..50c6af1de7 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -326,7 +326,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
>                         printf("%06o %s %d\t", ce->ce_mode,
>                                oid_to_hex(&ce->oid), ce_stage(ce));
>
> -               utf8_fprintf(stdout, "%s\n", ce->name);
> +               fprintf(stdout, "%s\n", ce->name);
>         }
>         return 0;
>  }
> @@ -1038,7 +1038,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>                 return 1;
>
>         for_each_string_list_item(item, &suc.projectlines)
> -               utf8_fprintf(stdout, "%s", item->string);
> +               fprintf(stdout, "%s", item->string);
>
>         return 0;
>  }
