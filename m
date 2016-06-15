From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 15 Jun 2016 17:05:11 -0400
Message-ID: <CAPig+cTf72M2iaZr3bZj+0V_0VHXJahpusY6zwT_B5uJx0BP1g@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-5-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 23:05:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDHzx-0002kp-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 23:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbcFOVFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 17:05:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35233 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbcFOVFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 17:05:12 -0400
Received: by mail-io0-f194.google.com with SMTP id n127so4399295iof.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Yi5fOy0PtT2mOjj+K8Pp4ES1+6K74+8ytUXcq6MIa2o=;
        b=0xQdDomXdvhjWH6JXcz/2JfiiScdxTiQ1JEd7gCD+vxx6Rbggv8+VKh82PknSuudYr
         5xM0jDe0IDqkD9Rs6DkDNa9CyiSNMvOAPA/dwxn7KhvbyBjFEJqtr2M8d//UycrUtRTq
         pKKinPsGkbCNZOe27nUiK6I8yDlvsPwHmEoOtUQC8TmjeDCLpG5Y4KGjOcg+47LdIDbt
         69cLKC2DyVH3ErBsqIpZVipdqsXJuqIIuFilCzgHiL7df+fmPdkbU8i9yWSJi4njQi3U
         rrK/d1qLUg0QZ46W2nlP9TJjYgxhgN1CsB+gxYAzdFjhl+c3k3LaMs2vIDxBd2D+whqu
         r2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Yi5fOy0PtT2mOjj+K8Pp4ES1+6K74+8ytUXcq6MIa2o=;
        b=U9SfN3kewV8PEmSn9vhY3oI/tFBMxt4JlZDUQOMlciBbv0wdTpgi4CqzEsxCcu5qBH
         9zq8UxySt92i0LvN9A/Jfq1oVMRnZzw+Q18ZHkczzvsj6ElkNESoh98tgPfMqDBWIkT9
         I409M8302SZLUHdbrN0HeBOjwcrBzuBWVa/d0Dcc8PmacXq74uHRAndasBvOP40iFJNv
         qT5bAc/P1wl1cJc/D2+0BPcA39FlqvQchNkBME+7lMj3Xxvrnz6Mf3ID2NTD10QrXzfw
         GJOZCaqkPpWbUIA0AjjyvN5o0VIH0nzviV6fvh4KnDv/GnYr/slQyi4sc9GnctWc/mUM
         HuBw==
X-Gm-Message-State: ALyK8tIRlHSEERkHRsGsv7cCu7QbViRbPZ5y7zWcOyZn6NugiR2wxCCqnucy4zwKPX+r/DSbR4y2a3yqomKssw==
X-Received: by 10.107.197.70 with SMTP id v67mr2678459iof.34.1466024711489;
 Wed, 15 Jun 2016 14:05:11 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 15 Jun 2016 14:05:11 -0700 (PDT)
In-Reply-To: <20160615140026.10519-5-pranit.bauva@gmail.com>
X-Google-Sender-Auth: 3LRpdeUjWa0TFLxA1E_Qq4G-H_g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297401>

On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
> subcommand to `git bisect--helper` to call it from git-bisect.sh .
> [...]
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -123,12 +127,48 @@ static int bisect_clean_state(void)
> +static int bisect_reset(const char *commit)
> +{
> +       struct strbuf branch = STRBUF_INIT;
> +
> +       if (!commit) {
> +               if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
> +                       printf("We are not bisecting.\n");
> +                       return 0;
> +               }
> +               strbuf_rtrim(&branch);
> +

Style: unnecessary blank line

> +       } else {
> +               struct object_id oid;
> +               if (get_oid(commit, &oid))
> +                       return error(_("'%s' is not a valid commit"), commit);
> +               strbuf_addf(&branch, "%s", commit);

strbuf_addstr(&branch, commit);

> +       }
> +
> +       if (!file_exists(git_path_bisect_head())) {
> +               struct argv_array argv = ARGV_ARRAY_INIT;
> +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
> +               if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +                       error(_("Could not check out original HEAD '%s'. Try"
> +                                       "'git bisect reset <commit>'."), branch.buf);
> +                       strbuf_release(&branch);
> +                       argv_array_clear(&argv);
> +                       return -1;
> +               }
> +               argv_array_clear(&argv);
> +       }
> +
> +       strbuf_release(&branch);
> +       return bisect_clean_state();
> +}
