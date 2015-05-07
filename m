From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fixed translation error in config.c file
Date: Thu, 7 May 2015 12:28:52 -0400
Message-ID: <CAPig+cSNj2_JVH=nU=pSkHmdW_Yvd0aLC8Hk5we9r=mduKDj=g@mail.gmail.com>
References: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Alangi Derick <alangiderick@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 18:28:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOfS-00086G-8d
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbbEGQ2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:28:54 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34434 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbbEGQ2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:28:52 -0400
Received: by iget9 with SMTP id t9so14717691ige.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=0z6NkGVh583i4J0g50B1Mg93vSkC8SteG4Uhlpi6b/M=;
        b=OMng//dvEk6ZKFAXQm/jgSxlyIqLqr5gGRp7OwnNcaZ0Y9jGgPhS4+HHkod6TLkc3A
         e1q9cPyLvcVCbaduERXlrQAmMQyFGX8xPYvU4EXKq3jvafvkhu9rhPGYpDkSVaV5h+vv
         XsXbz81/qa9wl04+qDfdX7S/8GVswjB9eVjKbNf7uvvzG6uRmTIEwJVdUp4ag7H4kFAq
         ZJj/c1/ghynd3y63Ik9lb26E59Hu+/R3pAbnz0Xqliy5OkHmt3Or+yyjAaAJu49FVk9g
         ohkWLQihnmOz/qQjDB14g27/im4U8WwoNYTHz5o1Z/Ah9/d0w0rNaWx4QXw4KsVkgKSP
         dcRA==
X-Received: by 10.107.3.163 with SMTP id e35mr5626883ioi.92.1431016132261;
 Thu, 07 May 2015 09:28:52 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 09:28:52 -0700 (PDT)
In-Reply-To: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
X-Google-Sender-Auth: ontN7LRnEFgJbS2GWR7Hwdxen6M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268543>

On Wed, May 6, 2015 at 4:51 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> There was an existing translation in 'git config' output, that was
> incorrect in some unspecified way, and this change corrects that
> breakage
>
> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> index bfd3016..47c1a42 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -193,7 +193,7 @@ static int get_value(const char *key_, const char *regex_)
>
>                 key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
>                 if (regcomp(key_regexp, key, REG_EXTENDED)) {
> -                       fprintf(stderr, "Invalid key pattern: %s\n", key_);
> +                       error(_("Invalid key pattern: %s\n"), key_);

A couple comments:

As a convenience, error() automatically outputs a newline (\n) after
the message, therefore, when you convert this from fprintf() to
error(), you will need to remove the '\n' from the string.

Changing fprintf() calls to error() is a very distinct change from
marking strings for translation by wrapping them with _(...),
therefore the fprintf()-to-error() change should be done separately in
its own patch. (And, that patch should only change fprintf() to
error(); it should not do the _(...) wrapping.)

>                         free(key_regexp);
>                         key_regexp = NULL;
>                         ret = CONFIG_INVALID_PATTERN;
