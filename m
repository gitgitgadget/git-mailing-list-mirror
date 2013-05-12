From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] teach the user to be nice to git and let him say please sometimes
Date: Sun, 12 May 2013 17:23:15 +0700
Message-ID: <CACsJy8A+vjtwnB0LStVS3Q9v2JaKcMDa0sATr9H==X3EhQt6Jg@mail.gmail.com>
References: <20130511201928.GA22938@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun May 12 12:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbTRa-00065o-F7
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 12:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab3ELKXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 06:23:47 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39118 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3ELKXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 06:23:46 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so2825230obb.16
        for <git@vger.kernel.org>; Sun, 12 May 2013 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9udU0M0q3jnSiXkmVe82K1bCCabGmN53l0LMsYRaobU=;
        b=v+CvlrZPzAd4ezNeBVkhV5nAehsOOvq3GKWmBVMCw/R5NmwoeEpHfM1UUh6jnfTznJ
         VzHvZOSqfWlPCOznTosIJ/ewebutHiEIU0qbm0raELrWRoPRHlNJHCGSIEOfgFRYNoJv
         qIABjVhO/sPJCTAFZ4k0a/oqlcTQiDC6exQUCRjBOMaC8i3oYCwdYy0AYtpqZXhqX94D
         w1+5udCCFNFb5sr0gqi24eNzo472kAsesLXQhqGFTDAJPbxvmol2rydRakKkNidc8U46
         WDJ0mTntZsgAd5usxzGtUgv5cZNf5H+4J2qSHyi8/V5a0kaFB20jl422Mt7gvbNG5XgO
         fzaA==
X-Received: by 10.60.34.69 with SMTP id x5mr10264183oei.110.1368354225643;
 Sun, 12 May 2013 03:23:45 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 12 May 2013 03:23:15 -0700 (PDT)
In-Reply-To: <20130511201928.GA22938@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224033>

On Sun, May 12, 2013 at 3:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Since ages we do not care about our program enough. Lets not treat them
> as slaves anymore and say please.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Johan Herland <johan@herland.net>

A product of Git Berlin Meetup?

> +static void check_politeness(const char *cmd)
> +{
> +       const char *user_config;
> +       struct strbuf buf = STRBUF_INIT;
> +
> +       if (getenv("GIT_POLITENESS_CHECK_PASSED"))
> +               return;
> +
> +       setenv("GIT_POLITENESS_CHECK_PASSED", "Yes", 1);
> +
> +       git_config_early(read_polite_counter, NULL, NULL);
> +       if (!strcmp(cmd, "please")) {
> +               impolite_counter = 0;
> +               polite_counter++;
> +       } else {
> +               impolite_counter++;
> +               polite_counter = 0;
> +       }
> +
> +       if (impolite_counter > 10)
> +               die("Error: Learn some manners, say please some time!");
> +       if (polite_counter > 10)
> +               die("Error: Too many please! I don't believe you.");

NAK. If we truly care, we need better AI here!

> +
> +       user_config = git_user_config();
> +       strbuf_addf(&buf, "%d", polite_counter);
> +       git_config_set_in_file(user_config, "user.polite", buf.buf);
> +       strbuf_reset(&buf);
> +       strbuf_addf(&buf, "%d", impolite_counter);
> +       git_config_set_in_file(user_config, "user.impolite", buf.buf);
> +       strbuf_release(&buf);
> +}
--
Duy
