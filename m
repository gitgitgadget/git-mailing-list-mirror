From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] help.c: strip suffix only if the STRIP_EXTENSION defined
Date: Wed, 16 Mar 2016 21:47:11 +0700
Message-ID: <CACsJy8ARrpu=7JJ0=viuNN0pN7wae8FWRN96EqtiH9bOF_vypw@mail.gmail.com>
References: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:47:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agCjk-0002gg-TL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 15:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934817AbcCPOrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 10:47:43 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36081 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbcCPOrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 10:47:43 -0400
Received: by mail-lb0-f176.google.com with SMTP id x1so49337454lbj.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dXmsYTDfTpLQHxHVwssqq34aYSmcxFsd15x5iUGQKyQ=;
        b=Qj3aSeatbLvjpPr+vaLTdJ/ZE6MTAt3UIzxffciwDPmSdDWG8+NKaogsyEImfqnQJ+
         DKjwQfgcXYQ6dnlUPdE+75ejdorGwQ3lAwWTBF4OntNntcASBuGNT2hotH8aOsRs/m8y
         5slDQ6BofA/4wGp91FIXRnXo7FBjZwWytwckZkV/yoej71UGpXTMAwEyVNzOl3EP+Iwn
         LGaG2BUexzdSRehObQkTklBQJW0aKszJAsF0GZHmta5VZg/xpIVCR0/79ofXSzI1FrR1
         7OR8G321g3lUniz5Ynrzyo7IP88nAy/TA8Vdvse+JKh/fwhLFQtSsTLEsWCrUEptkiik
         06wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dXmsYTDfTpLQHxHVwssqq34aYSmcxFsd15x5iUGQKyQ=;
        b=LmlfbyRIormF6CFZ3Jf5I14FHFZlUMP3J8F70Up9L7g6lj7m2CgQN35j9/cNyYNmp0
         E/uMYGSqbJIFbngbvx//6VBjpxvf5UhHxSUac3XYpIEJVed6NT8W5wE6w+YGXJ5op0g1
         0H2GuSCMo2IDwDhFDUlTI1ANe4F945mxZ2T+wG/lUBh1DsoYIETnnSSF6HUaiQ6SvgFx
         jSTvZiMdaLINBSXk3buHXlO8VuqRIlAdMDDx7BopyAY/eUs9ThpGsuHpTaRzMW8dSVvD
         L8mlan/Zs7uWW7UJdH3PgUxYVcUsJEZsWJhk3BtT3Vjd44VWnKw+lH7i+Y+2BWYrATcn
         Rfaw==
X-Gm-Message-State: AD7BkJL2ZjurEr/vme+lFd8wp6xsNKqskPHef6gdBY+hsCpFnYwTTFJJYcOMoj6wtlOxdCEsx6betH19i/1DEA==
X-Received: by 10.112.130.41 with SMTP id ob9mr1538471lbb.81.1458139660748;
 Wed, 16 Mar 2016 07:47:40 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 16 Mar 2016 07:47:11 -0700 (PDT)
In-Reply-To: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288977>

On Wed, Mar 16, 2016 at 9:27 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> We stripping extension in the list_commands_in_dir() to get
> commands without '.exe' suffix. Let's do it only if STRIP_EXTENSION
> is defined to not spend time for unnecessary strip_suffix() call in
> this case.

Unless the time saving is significant, I'm against this change. It
makes it harder to spot compile bugs in #ifdef'd code that's only
active on Windows (imagine somebody renames "ent" or change its type).
If you can do something like strip_extension() in git.c, it's better.
Or maybe just refactor that function a bit and share it with help.c

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  help.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/help.c b/help.c
> index 19328ea..c865991 100644
> --- a/help.c
> +++ b/help.c
> @@ -153,8 +153,9 @@ static void list_commands_in_dir(struct cmdnames *cmds,
>                         continue;
>
>                 entlen = strlen(ent);
> -               strip_suffix(ent, ".exe", &entlen);
> -
> +#ifdef STRIP_EXTENSION
> +               strip_suffix(ent, STRIP_EXTENSION, &entlen);
> +#endif
>                 add_cmdname(cmds, ent, entlen);
>         }
>         closedir(dir);
> --
> 2.8.0.rc2.216.g1477fb2.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
