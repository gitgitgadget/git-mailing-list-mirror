From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/7] clone: introduce clone.submodulegitdir
Date: Fri, 5 Apr 2013 12:37:07 +0530
Message-ID: <CALkWK0n721iPE6=Lr2EZuq6OV++CW0U19wJDQ2BNfwo1ABKcYg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <1365100243-13676-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 09:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO0kz-0001Ty-P0
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 09:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161286Ab3DEHHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 03:07:48 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:58911 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161133Ab3DEHHr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 03:07:47 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so2939196iag.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pmA/0iga8na8xY8/WAP8RqacreOftQ0pwJlWjKwHuY0=;
        b=C5L12PeqCEawjHIe0E+JAdYzlVqdot4cNTPT2PJ1NZNNRgURt7UzUhyg1jvn+lH628
         7tFIwKNhY4r3670x5maIenQHQTeAUf23C656s5jOA7eYiRYGH7o3ncu13tztT+l6Z75s
         pBRrBFQ5KUU2dNQrB40JoLxj9LlDbVmYZ4MzkxCz2bA5EOqWxfJ4U5rZiiyerGJ7Mf9h
         Y8C7OdU4Lepzf7BYFam6iq0kSXEhtAPj7TDAhYsLRWszF9JJ3k4QEIoMyhMZCemVUe8k
         9hWqGk0gkVhEzJ/4f6ZeXr512PGXmF+lsBFvKKkkPmYErRn+zvqYGHli4zb8z+zE6Kz9
         EaNw==
X-Received: by 10.50.108.235 with SMTP id hn11mr791210igb.107.1365145667522;
 Fri, 05 Apr 2013 00:07:47 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 5 Apr 2013 00:07:07 -0700 (PDT)
In-Reply-To: <1365100243-13676-7-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220152>

Ramkumar Ramachandra wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index e0aaf13..1b798e6 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -658,11 +659,22 @@ static void write_refspec_config(const char* src_ref_prefix,
>         strbuf_release(&value);
>  }
>
> +static int git_clone_config(const char *var, const char *value, void *cb)
> +{
> +       if (!strcmp(var, "clone.submodulegitdir")) {
> +               git_config_string(&submodule_gitdir, var, value);
> +               return 0;
> +       }
> +       return git_default_config(var, value, cb);
> +}

submodule_gitdir can be a human-path, and we will need real_path() to
turn it into a concrete path.  Why doesn't real_path() expand ~ yet?
