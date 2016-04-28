From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 4/5] submodule--helper: move config-sanitizing to submodule.c
Date: Thu, 28 Apr 2016 18:28:24 +0200
Message-ID: <6EAB03CC-F52B-463C-98EC-C1C91B3B00EB@gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133819.GD25319@sigill.intra.peff.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:28:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avons-0005gp-Cs
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbcD1Q2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:28:32 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38238 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbcD1Q2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 12:28:31 -0400
Received: by mail-wm0-f41.google.com with SMTP id g17so50596348wme.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=aFVI3DP41ZsU0b/Quxl+gaiZyg+hUnbudivh0cLKUY4=;
        b=fTgPxXsY63ntQVJIsfWKwr0KVWZhynW57AqoHEFCoteeLL9ywJ/onROB5x41Ah+xLB
         3iWCHi5MpvOFibDTvUDwyoGsXSKI7IYbSrU4rDC2DvrcIkozSdjsBu70BHVVii+cCEhX
         m4YGPNyn38417E/YKsn6zUv7xA8AojmDr14n/CT8hrzvKC8JQf1MAxix0Vjyn7gKRQvE
         TIX/vfYRfk9mCJTcmTAfGK66X68o40eet5BmUayTwGJgpCytHKeOFaKTHst9lwgq1L68
         5m9d6zSZi9DV5E3Ku1qJjTUE6OSKtGwsXI4ArUYM3n0Us2SH6S+q6QUiqFT02T3QuYdu
         Vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=aFVI3DP41ZsU0b/Quxl+gaiZyg+hUnbudivh0cLKUY4=;
        b=kwXVHIx/2wH93QkGGcgL5w8r7rUVRQgGIoHt+zBNS7TSfT+erLTOpVEAnu2cOisBHk
         vqXeERrLVnPo8loD2lJRLPpOXz8edBWOLzcJQmUf2oPbitnuMf7PvCtVqmP2H9/IuHLE
         K6UxITmtPH+u03YrTVPHT2qUHlH3t3MSQLx5dADLqmZJbiXcR6LNTXdDrT67YpVGIFkB
         KnBt4VKb2fn7Ybw9C/FvYmbVcn83YkU3gYcbfUyt5vnV9wFMkcWPDVnxRCDtC8rWccjF
         Zq0mqHuNW2OAVSG3FcxsWtWNFyIdte6dNi83Zl4nlVLmK5yVFAXtUgqj4WkPQjD7e1vb
         ed+g==
X-Gm-Message-State: AOPr4FUWhWQ2cHRF2Rzcix/N83RWzis6bDq7kxIgY/2UjaSYRR1AWeSMnE0sY3crD3ty6w==
X-Received: by 10.28.53.193 with SMTP id c184mr34319942wma.93.1461860910044;
        Thu, 28 Apr 2016 09:28:30 -0700 (PDT)
Received: from [10.166.1.115] (tmo-102-244.customers.d1-online.com. [80.187.102.244])
        by smtp.gmail.com with ESMTPSA id g132sm14917238wme.0.2016.04.28.09.28.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2016 09:28:29 -0700 (PDT)
In-Reply-To: <20160428133819.GD25319@sigill.intra.peff.net>
X-Mailer: iPhone Mail (13E238)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292914>



> On 28 Apr 2016, at 15:38, Jeff King <peff@peff.net> wrote:
> 
> These functions should be used by any code which spawns a
> submodule process, which may happen in submodule.c (e.g.,
> for spawning fetch). Let's move them there and make them
> public so that submodule--helper can continue to use them.
> 
> Sine they're now public, let's also
s/Sine/Since

Thanks for fixing this entire issue, Peff!

- Lars

> provide a basic overview
> of their intended use.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> builtin/submodule--helper.c | 48 --------------------------------------------
> submodule.c                 | 49 +++++++++++++++++++++++++++++++++++++++++++++
> submodule.h                 | 16 +++++++++++++++
> 3 files changed, 65 insertions(+), 48 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3bd6883..de3ad5b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -119,54 +119,6 @@ static int module_name(int argc, const char **argv, const char *prefix)
>    return 0;
> }
> 
> -/*
> - * Rules to sanitize configuration variables that are Ok to be passed into
> - * submodule operations from the parent project using "-c". Should only
> - * include keys which are both (a) safe and (b) necessary for proper
> - * operation.
> - */
> -static int submodule_config_ok(const char *var)
> -{
> -    if (starts_with(var, "credential."))
> -        return 1;
> -    return 0;
> -}
> -
> -static int sanitize_submodule_config(const char *var, const char *value, void *data)
> -{
> -    struct strbuf *out = data;
> -
> -    if (submodule_config_ok(var)) {
> -        if (out->len)
> -            strbuf_addch(out, ' ');
> -
> -        if (value)
> -            sq_quotef(out, "%s=%s", var, value);
> -        else
> -            sq_quote_buf(out, var);
> -    }
> -
> -    return 0;
> -}
> -
> -static void prepare_submodule_repo_env(struct argv_array *out)
> -{
> -    const char * const *var;
> -
> -    for (var = local_repo_env; *var; var++) {
> -        if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> -            struct strbuf sanitized_config = STRBUF_INIT;
> -            git_config_from_parameters(sanitize_submodule_config,
> -                           &sanitized_config);
> -            argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> -            strbuf_release(&sanitized_config);
> -        } else {
> -            argv_array_push(out, *var);
> -        }
> -    }
> -
> -}
> -
> static int clone_submodule(const char *path, const char *gitdir, const char *url,
>               const char *depth, const char *reference, int quiet)
> {
> diff --git a/submodule.c b/submodule.c
> index 90825e1..02eaf0e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -13,6 +13,7 @@
> #include "argv-array.h"
> #include "blob.h"
> #include "thread-utils.h"
> +#include "quote.h"
> 
> static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> static int parallel_jobs = 1;
> @@ -1129,3 +1130,51 @@ int parallel_submodules(void)
> {
>    return parallel_jobs;
> }
> +
> +/*
> + * Rules to sanitize configuration variables that are Ok to be passed into
> + * submodule operations from the parent project using "-c". Should only
> + * include keys which are both (a) safe and (b) necessary for proper
> + * operation.
> + */
> +static int submodule_config_ok(const char *var)
> +{
> +    if (starts_with(var, "credential."))
> +        return 1;
> +    return 0;
> +}
> +
> +int sanitize_submodule_config(const char *var, const char *value, void *data)
> +{
> +    struct strbuf *out = data;
> +
> +    if (submodule_config_ok(var)) {
> +        if (out->len)
> +            strbuf_addch(out, ' ');
> +
> +        if (value)
> +            sq_quotef(out, "%s=%s", var, value);
> +        else
> +            sq_quote_buf(out, var);
> +    }
> +
> +    return 0;
> +}
> +
> +void prepare_submodule_repo_env(struct argv_array *out)
> +{
> +    const char * const *var;
> +
> +    for (var = local_repo_env; *var; var++) {
> +        if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> +            struct strbuf sanitized_config = STRBUF_INIT;
> +            git_config_from_parameters(sanitize_submodule_config,
> +                           &sanitized_config);
> +            argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> +            strbuf_release(&sanitized_config);
> +        } else {
> +            argv_array_push(out, *var);
> +        }
> +    }
> +
> +}
> diff --git a/submodule.h b/submodule.h
> index 7ef3775..7577b3b 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -61,4 +61,20 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
> void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> int parallel_submodules(void);
> 
> +/*
> + * This function is intended as a callback for use with
> + * git_config_from_parameters(). It ignores any config options which
> + * are not suitable for passing along to a submodule, and accumulates the rest
> + * in "data", which must be a pointer to a strbuf. The end result can
> + * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
> + */
> +int sanitize_submodule_config(const char *var, const char *value, void *data);
> +
> +/*
> + * Prepare the "env_array" parameter of a "struct child_process" for executing
> + * a submodule by clearing any repo-specific envirionment variables, but
> + * retaining any config approved by sanitize_submodule_config().
> + */
> +void prepare_submodule_repo_env(struct argv_array *out);
> +
> #endif
> -- 
> 2.8.1.617.gbdccc2d
> 
