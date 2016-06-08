From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 03:59:35 -0400
Message-ID: <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com> <20160607205454.22576-4-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 09:59:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYOq-0004tU-QH
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 09:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbcFHH7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 03:59:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36238 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbcFHH7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 03:59:36 -0400
Received: by mail-it0-f67.google.com with SMTP id h190so342370ith.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mG0MTeTbMQQpyVXXTI90hWv7XfF30RJHNzGbVV4HL0Y=;
        b=AxHge4xdn4XVsduqxnDpcSdBpaQsPii+VsXnGe2xmo8d2mM1wLNVKUtVQj5XIYUXoG
         AGnxTBeKUowMpdN+TJV7e7o6rbTY7eIwm/+OQACcg5Moag5MX4GDLq8vX43Kj7/pAcAf
         ZTLKYCTnrHwI4Z6vZyCH/90Wl37JuAmpfhU/uic/04ZYIIhe79RsK1ZTji1x9UrLC5k4
         OI2mj7KzqmAfCPXW4ih+8cKnMcW13HevsLiyDlLa6ACzShC6p6paNDgC/xlOGIHp4qDC
         osio8TYBBg6Fm/wnn6Y8e70dgJyY8SZ5sbosaWegqKCDMET0nt4pG2FfnvSMMWTSL5DB
         lvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mG0MTeTbMQQpyVXXTI90hWv7XfF30RJHNzGbVV4HL0Y=;
        b=k98vcDYGtELeoMAyLXXNPFw0LN9UxNLmP8IsVIH3/C0BkJ56QAv2fplK8OiW3nIA0o
         56FzQfpeAQQjv8ahS7a5dFm6ct8Fesc43D1Ph3h4KEDPqrwQpYIWlZo+MZwt/ube4BEI
         bCf0bihDDrSGJScJoYC++Ti6GE++DIPx8gLbQruWPjjH8B5d/m379kMpjqSz64GDWyO0
         Gwdrwm0l++Ogi5EhpDgl4pCgUcCF7Hxn47PZZR2Sb3cEUzQqcePwvpI3I5yYiooGh3KF
         AAkSNMyj6Itxyt/nWtv4TcXr5g/vcjj+mvtPe/WcxmhnmWsqouF+W6pmnr1kGTCup07z
         ZBog==
X-Gm-Message-State: ALyK8tJ++fk2O5tnRqX25ry6aAK0i2dNVx6FkQsXNkIog67apXeGE1CXiktRxhwaqcexByPydKv64zge8Ej3Ng==
X-Received: by 10.36.29.137 with SMTP id 131mr6019875itj.84.1465372775776;
 Wed, 08 Jun 2016 00:59:35 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 00:59:35 -0700 (PDT)
In-Reply-To: <20160607205454.22576-4-pranit.bauva@gmail.com>
X-Google-Sender-Auth: xIOaQOigBwV8ElD7MA1E_lJjSHc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296763>

On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
> subcommand to `git bisect--helper` to call it from git-bisect.sh .
>
> Using `bisect_reset` subcommand is a temporary measure to port shell
> functions to C so as to use the existing test suite. As more functions
> are ported, this subcommand would be retired and will be called by some
> other method.
>
> Note: --bisect-clean-state subcommand has not been retired as there are
> still a function namely `bisect_start()` which still uses this
> subcommand.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -118,12 +122,51 @@ int bisect_clean_state(void)
> +int bisect_reset(const char *commit)

s/^/static/

> +{
> +       struct strbuf branch = STRBUF_INIT;
> +       int status = 0;
> +
> +       if (file_size(git_path_bisect_start()) < 1) {

This doesn't even care about the size of the file, only if it
encountered an error while stat()'ing it. Why not just use
file_exists() instead (which you already use elsewhere in this
function)? Alternately, if you're trying to be faithful to the shell
code, then you *do* need to check that the file has non-zero size
before issuing the "not bisecting" diagnostic, so:

    if (file_size(git_path_bisect_start()) <= 0)
        printf("... not bisecting ...");

A different approach would be to invoke strbuf_read_file()
unconditionally, rather than performing this separate check. If
strbuf_read_file() returns -1, then the file didn't exist or couldn't
be read; if it returns 0, then the file has no content:

    if (strbuf_read_file(&branch, ..., 0) <= 0)
        printf("... not bisecting ...");

> +               printf("We are not bisecting.\n");
> +               return 0;
> +       }
> +
> +       if (!commit) {
> +               strbuf_read_file(&branch, git_path_bisect_start(), 0);

Shouldn't you be checking the return value of strbuf_read_file()?

> +               strbuf_rtrim(&branch);
> +       } else {
> +               struct object_id oid;
> +               if (get_oid(commit, &oid))
> +                       return error(_("'%s' is not a valid commit"), commit);
> +               strbuf_addf(&branch, "%s", commit);
> +       }
> +
> +       if (!file_exists(git_path_bisect_head())) {
> +               struct argv_array argv = ARGV_ARRAY_INIT;
> +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
> +               status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
> +               argv_array_clear(&argv);
> +       }
> +
> +       if (status) {

What's the purpose of having this 'status' conditional outside of the
above !file_exists() conditional, which is the only place that
'status' gets assigned. Likewise, 'status' itself could be declared
within the scope of that conditional block.

> +               error(_("Could not check out original HEAD '%s'. "
> +                               "Try 'git bisect reset <commit>'."), branch.buf);
> +               strbuf_release(&branch);
> +               return -1;
> +       }
> +
> +       strbuf_release(&branch);
> +       return bisect_clean_state();
> +}
