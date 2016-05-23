From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 23 May 2016 12:01:46 -0400
Message-ID: <CAPig+cSOOv9sGGCTD7=5As9Opu3=e9ofkTpFhCzXC9cJPK21Tg@mail.gmail.com>
References: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
	<1464014928-31548-4-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 18:01:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4sIh-0000ga-9K
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 18:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbcEWQBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 12:01:48 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33493 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcEWQBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 12:01:47 -0400
Received: by mail-io0-f196.google.com with SMTP id s67so4200079ios.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=nSWekPMVXV2mlowfyPF7Iw7VL1fNlvtMohufco04E4g=;
        b=DdVKEfz25lAZPS6qFVDChZCgS9E5sLVy3Kbd6aOclO06b01SArCCnGQf/7Wff3L6HY
         DbWEwgulfLO/89b22JgvEYv3YclbadDvBH8PToG9wj242Ez6sVq49/lljrE44cZ9KnXT
         7B5wLMU/IfXM9csQgDRFh0Q6kI0RYLFMOhWKCHWb0w4HjVXeDmNzHRdvNU8TkieoinOK
         cD/v4zBQEfSDS2Eer2KCETIjkRUfe1l8O/oVByBHdoNq4/j5BY9JcBg2yb395v4Oj2fn
         cOIIpP3RQ0syZbuF21NaVCybOLfx6gN5BfSJb4qEntweyKP5EeTEP9/nkh7uTlQdDItc
         Ta9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nSWekPMVXV2mlowfyPF7Iw7VL1fNlvtMohufco04E4g=;
        b=eiHSmOXOFHD5lORBBAr2xsaSssjfth28OHO+OHmHXtNZx3kiufK6syfb6BHv/SjrCW
         QKIz8kBkXPnwZnoiwDA5LRPAYsBU1IjUIVxHXJdVaVzJcTDWCORTa9mcAuxRSRSwrSnY
         FfklX4SXxMimrguBMWKeXhW/jkXOM3Fa3+s2w4M6IgSVe/zXU/UgCMsiArTV4c9nJs57
         Rs6JfXcbmev2a8fDtRU0Y7V+rtAbXQ9HZ4DGnw7AKQL7T1y7mG7NOm4+pIJuLsLXc5sx
         TxR0tsOqhYvH7TVBx3JE4d0Nn8WYezYDsEZBUU9cV2/BGIGbehvjQHOtAYtfpn58ntFh
         yL1A==
X-Gm-Message-State: AOPr4FXZGXyEHzAa30GQ3+haiM//sOGtzhnVlyquAHQRLM8hrVnVG52Iz7lGifPEoaVOg+sxH5PFUE/sYBX8bQ==
X-Received: by 10.107.47.37 with SMTP id j37mr12535900ioo.168.1464019306268;
 Mon, 23 May 2016 09:01:46 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Mon, 23 May 2016 09:01:46 -0700 (PDT)
In-Reply-To: <1464014928-31548-4-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: A4EVlAb1R3N77-PJU441wvCoZWU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295334>

On Mon, May 23, 2016 at 10:48 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `write_terms` shell function in C and add a `write-terms`
> subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
> remove the subcommand `--check-term-format` as it can now be called from
> inside the function write_terms() C implementation.
> [...]
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -56,18 +58,38 @@ static int check_term_format(const char *term, const char *orig_term)
> +static int write_terms(const char *bad, const char *good)
> +{
> +       FILE *fp;
> +       int res;
> +
> +       if (!strcmp(bad, good))
> +               return error(_("please use two different terms"));
> +
> +       if (check_term_format(bad, "bad") || check_term_format(good, "good"))
> +               return -1;
> +
> +       fp = fopen(git_path_bisect_write_terms(), "w");
> +       if (!fp)
> +               return error(_("could not open the file to write terms"));

By adding two pieces of information, you could make this error message
much more helpful for anyone trying to debug the failure.
Specifically:

(1) the pathname for which open() failed
(2) the actual system-level error

For (2), you could use strerror(errno) or, better yet, error_errno()
which recently graduated to 'master'.

> +       res = fprintf(fp, "%s\n%s\n", bad, good);
> +       fclose(fp);
> +       return (res < 0) ? -1 : 0;
> +}
