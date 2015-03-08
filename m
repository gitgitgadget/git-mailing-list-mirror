From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] cat-file: add "--literally" option
Date: Sun, 8 Mar 2015 18:50:57 -0400
Message-ID: <CAPig+cTWJcWuhbgbaHWYcFxXhCEN-ou3g=AP6k1KJ-+hgN_+Dg@mail.gmail.com>
References: <54F89D90.6090505@gmail.com>
	<1425579578-18955-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 23:51:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUk2J-0002bi-MV
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 23:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbbCHWu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 18:50:58 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:46292 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbCHWu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 18:50:57 -0400
Received: by yhoc41 with SMTP id c41so17496379yho.13
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Glc0ab1Ftkcor5q5dm0w5vgvUUuKL3bTcmgqBfGkRYg=;
        b=JgQ8oYlNW9b+rNRWoVeSczqu/Nvr/7MrJlwgle1BrCaJJw4pD9RUej90785eA1QzyS
         7zXV8thXYhceHViF5LFo0/KD9+5XOVuL63o22uJWTNgIa1MrS9YLYTbthyJLPL9Q7kD8
         9NB4ZvTAOrVjMPlPUYVbBbcqoTBylH4KShlowLip9e4YGu+KYyyzckPs0+WccrEGKCbI
         Htlf8uS06zdGTFIAJn98OWfQlgzaHvGJPVQlUQF6vcJMDiWnv1GR6ZRA96RdaOW0Rlzm
         UHBmzdSAX8YgwCMUJfprk2pH6/sJXRgKfItsN8UBT7rDXm7FTlOP9uJ17Fv+geR2ukfR
         nzlg==
X-Received: by 10.170.134.198 with SMTP id a189mr15662225ykc.103.1425855057145;
 Sun, 08 Mar 2015 15:50:57 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 15:50:57 -0700 (PDT)
In-Reply-To: <1425579578-18955-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: yvrGUd1Uig84rvgoibEgd5ym1JI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265116>

On Thu, Mar 5, 2015 at 1:19 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> made changes to "cat-file" to include a "--literally"

Write in imperative mood: "Teach cat-file a --literally option..."

> option which prints the type of the object without any
> complaints.

Unfortunately, this explanation is quite lacking. What "complaints"?
What problem is --literally trying to solve? To answer these
questions, you will probably want to say something about the sort of
object which requires --literally, and how cat-file fails or behaves
without it.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..60b9ec4 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
>  }
>
>  static const char * const cat_file_usage[] = {
> -       N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> +       N_("git cat-file (-t|-s|-e|-p|<type>|--textconv|-t --literally) <object>"),

This might read more naturally as:

    git cat-file (-t [--literally] | -s | -e | -p | <type> |
--textconv) <object>

rather than repeating the -t option.

>         N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
>         NULL
>  };
> @@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>                 OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>                 OPT_SET_INT(0, "textconv", &opt,
>                             N_("for blob objects, run textconv on object's content"), 'c'),
> +               OPT_BOOL( 0, "literally", &literally,
> +                         N_("show the type of the given loose object, use for debugging")),

Taking other help strings into account, there is no need for the
long-winded "type of the given loose object" when "loose object's
type" will suffice. More importantly, thought, you should try to say
something about how --literally is actually useful, such as for
"broken" objects or objects not of a known type.

>                 { OPTION_CALLBACK, 0, "batch", &batch, "format",
>                         N_("show info and content of objects fed from the standard input"),
>                         PARSE_OPT_OPTARG, batch_option_callback },
> @@ -380,7 +392,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>
>         git_config(git_cat_file_config, NULL);
>
> -       if (argc != 3 && argc != 2)
> +       if (argc != 3 && argc != 2 && argc != 4)

Perhaps it's time to rephrase this as "if (argc < 2 || argc > 4)"?

>                 usage_with_options(cat_file_usage, options);
>
>         argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
> @@ -405,5 +417,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>         if (batch.enabled)
>                 return batch_objects(&batch);
>
> -       return cat_one_file(opt, exp_type, obj_name);
> +       if (literally && opt == 't')
> +               return cat_one_file(opt, exp_type, obj_name, literally);
> +       else if (literally)
> +               usage_with_options(cat_file_usage, options);

I realize that existing cases in cat-file are already guilty of this
transgression, but it is quite annoying when a program merely spits
out its usage statement without actually telling you what you did
wrong; and it's often difficult to figure out why it was rejected. It
would be much more helpful in a case like this to state explicitly
that --literally was given without -t. (But perhaps such a
"friendliness" change is fodder for a separate patch.)

> +
> +       return cat_one_file(opt, exp_type, obj_name, literally);
>  }
> --
> 2.3.1.167.g7f4ba4b.dirty
