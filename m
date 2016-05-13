From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Sat, 14 May 2016 01:37:04 +0530
Message-ID: <CAFZEwPNVmcVpzAocYF8e5+Y9J10+TSewNkWkj7yhVrJwXm=H=Q@mail.gmail.com>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
	<1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 22:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JMf-0006cO-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbcEMUHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:07:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33103 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbcEMUHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:07:06 -0400
Received: by mail-yw0-f194.google.com with SMTP id y6so12379915ywe.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=57oatJN7Q15iqQm8miKbATQXesOPMs94HVaHZenU06U=;
        b=xKt6H0Sv4ePJWFoQb2UR39YaC4P7WXeI8x9hbZphaHBYbAjr4hSYw/7tGhbpAufkvp
         p8lVox91M1GaRWCfza74CHkmGUZ9MtTFtwP40OrVB1KFFVHMUGraR89fbmlN8/h+IS3D
         F7SvrUd49CK6/gNapFIp7O5SM7iq+aqoY49Ep1Sg3R7fzDkg++ePxiJAVWjf71xK4ghG
         HNELO9nWrjkYsudAzNiPW5E7TRB1GiMsZBHOBiIjb2CI6XspyVBjj1WPHRD/E3AiV0Bh
         1G+POF9qWtZ2jpLeVhN6XOJ38JxBMMg9HYEreUh9nnnDaWG4ETOz4wxASc+wN4869qYo
         laeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=57oatJN7Q15iqQm8miKbATQXesOPMs94HVaHZenU06U=;
        b=k9VxZgg4sgK825Wzn/vMA3rgiQ0lgsxurSYeYheN1PI1uo85o1pgaIna8xxavcpy7x
         sJ/JtfJb/H4gzcX7AAOa5CSBnutISGzqy+Wf7LexERCt2o98wCV9SXc295e8cAnBFQGC
         xthxV/cZ5rdb+Y72Ev9LfILxmYU8wc05YbCugpUfm72TycG1uhXXWTDabKJWXLiwyMYk
         vLjIOyOusi0aG9XOOBBH0b7zTq/7WKLT/xY8v3vP1y+KIH+wqwIp7ILKnuI+m7rlEFd7
         K7n42CFkfzCcr0GZoL5lL/jQTQvJ9hbxbXNPzSUiQj1BIT9I8ZPN2IM9ZfoEufw3FsVW
         rkBw==
X-Gm-Message-State: AOPr4FWg/zlBz/Vd7w556OvgciEJcnBIR706vdh9dO8SEyfojbfJtoePqlmO4e663s/hb2DIN0x8FpyqrnDx2g==
X-Received: by 10.13.198.5 with SMTP id i5mr9292240ywd.263.1463170024690; Fri,
 13 May 2016 13:07:04 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 13 May 2016 13:07:04 -0700 (PDT)
In-Reply-To: <1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294573>

On Sat, May 14, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `bisect_voc` shell function in C. This is a too small
> function to be called as a subcommand though the working of this
> function has been tested by calling it as a subcommand.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Pranit Bauva <pranit.bauva@gmail.com>

I missed this. It should be
     "Mentored-by: Christian Couder <chriscool@tuxfamily.org>"

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> ---
> The PR for testing of this function by the subcommand approach can be
> found at:
> https://github.com/pranitbauva1997/git/pull/5
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 87764fe..455f1cb 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -94,6 +94,16 @@ int bisect_log(void)
>         return 0;
>  }
>
> +int bisect_voc(const char *term)
> +{
> +       if (!strcmp(term, "bad"))
> +               printf("bad|new\n");
> +       if (!strcmp(term, "good"))
> +               printf("good|old\n");
> +
> +       return 0;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>         enum {
> --
> 2.8.2
>
