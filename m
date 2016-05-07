From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/2] bisect: rewrite `check_term_format` shell function
 in C
Date: Fri, 6 May 2016 20:05:55 -0400
Message-ID: <CAPig+cSc-k-+41=mspJ_XS+cZXn-rM+h_tSSGVobU+gH6fxxEg@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-3-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 02:06:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aypl1-0008RL-Or
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 02:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbcEGAF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 20:05:56 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33246 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbcEGAF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 20:05:56 -0400
Received: by mail-ig0-f196.google.com with SMTP id rc4so6381474igc.0
        for <git@vger.kernel.org>; Fri, 06 May 2016 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hjTrRtC2Ap+r+iFyMVi7lFF247qscy+Y3IOZkcqE1WQ=;
        b=d+ob2Nr9GUyshbzIn+j8fGGMmc+qwgpIpGxBctKe7K86AAFIMcfHKskR5VYTEcZny5
         Og3vhGmD4ginouCVVV04wozKnRVfXt2NpQCjiW5Go8r+Szt093VPFjzJ7Bey+kigcVHH
         s06HKuIQuNFeSPDYp4e2Ssr4myoNAJtK2nU9qQaqueonH5fAS96WY70KEyzDCQNEoz0X
         N6jbAPwnUtbmiPfzT4dBj3CZOGuqJa7L0ZjTm+1QAyTKhGjKzew2kt3iRk21YOZAC7vD
         4gC0vvI+qh7YHkNYHczUUjHxtDFMQoQgvuYR06pMJ4ZJfAppdoV+gKXZzmmJlxGUg09K
         aecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hjTrRtC2Ap+r+iFyMVi7lFF247qscy+Y3IOZkcqE1WQ=;
        b=dPPt6sjy4w04mJjuPvWrIWBDQ1LRQY0x+EGxFrZXZ1VPhcpdop0GdyABcpqVcHyp9L
         vClLLdAC29eTDlwXGFR1j6yhhHg0pDYcyNF3YFnp8vLKOZraaMBRNUQtso7ABKefGJem
         kclcBP+XLmyKCH8Qoe9CP8+cb4WfFdUoQQQQeGWgIJbHjSj4B7jaK93Qc/L7vbc8X9Jw
         3bl/cgEhrB6mQvyUHCAm1yIzPb+iT32F/mRvTt40Xe55bZ9dWqqr/bXIxsoKjQTE2rVS
         Mfs9rXI5DMuO5nQdivvFVMNHIeZ7eVaTIuuDfO1nfcTJ838eeBTcIDgzuCa/yETjhHjv
         89Kw==
X-Gm-Message-State: AOPr4FV4kD2O+JnFlzsrvMRPLbp52nR+kXJg4SdIGjAF7aWaXQt50yo/7RjdXAax64Rmnzqq33GWbPAVQVYrow==
X-Received: by 10.50.6.15 with SMTP id w15mr279520igw.91.1462579555188; Fri,
 06 May 2016 17:05:55 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 6 May 2016 17:05:55 -0700 (PDT)
In-Reply-To: <1462546167-1125-3-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: CYXAdCpbjSPROBdpXMdIycSAp-E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293869>

On Fri, May 6, 2016 at 10:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `check_term_format` shell function in C and add
> a `--check-term-format` subcommand to `git bisect--helper` to call it
> from git-bisect.sh
>
> Using `--check-term-format` subcommand is a temporary measure to port
> shell function to C so as to use the existing test suite. As more
> functions are ported, this subcommand will loose its existence and will

s/loose/lose/

Though, maybe it would be better to say:

    ...this subcommand will be retired...

> be called by some other method/subcommand. For eg. In conversion of
> write_terms() of git-bisect.sh, the subcommand will be removed and
> instead check_term_format() will be called in its C implementation while
> a new subcommand will be introduced for write_terms().
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -2,16 +2,65 @@
> +/*
> + * To check whether the string `term` belongs to the set of strings
> + * included in the variable arguments.

This is still a sentence fragment as pointed out last time[1]. You can
fix it with: s/To check/Check/

> + */
> +static int one_of(const char *term, ...)
> +{
> +       int res = 0;
> +       va_list matches;
> +       const char *match;
> +
> +       va_start(matches, term);
> +       while (!res && (match=va_arg(matches, const char *)))

Style: add spaces around '='

> +               res = !strcmp(term, match);
> +       va_end(matches);
> +
> +       return res;
> +}

The rest of the patch seems to address the issues raised by my
previous review[1] (aside from my comments[1,2] about this bottom-up
approach repeatedly adding and removing unnecessary complexity as each
little function is ported from shell to C, but that's a separate
philosophical discussion).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289476/focus=293501
[2]: http://thread.gmane.org/gmane.comp.version-control.git/289476/focus=293517
