From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] bisect--helper: `check_expected_revs` shell function
 in C
Date: Thu, 9 Jun 2016 17:54:45 -0400
Message-ID: <CAPig+cQVWng0idk0ETRQA44OsS5+GewVX=pt4uOg-=SFbL+deQ@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com> <20160608152415.7770-2-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7up-0000wj-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbcFIVys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:54:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36759 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbcFIVyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:54:46 -0400
Received: by mail-it0-f67.google.com with SMTP id h190so6814666ith.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u34qCsZAvfeS79Z+r1hLI2XthXKBjO0UnOg5xokM1Rc=;
        b=XYksa5iM+4LCNc74BQ/DPdRRFdjHccv5nmUhAdx3vaEBwfdFcEyrp+4fx+Xj5FQMzs
         wSTQgh1ESxP3ur44OlCsd/QOWS1zTSo5oNJHuI/S2BS1c5epUbJHe1ggomHP7rVi3oNi
         svJ5T2WLkXfy0uL5MJQQ+7caLqAe0njLbn+o5UIn5vhaRZh4ugGb7Qq4E9eS6d6VM9Gu
         7nxesfyrdLnAko01e8gRCpNO+C16luNUgIQEyggfAXYi87TisL0+6L10HY/tgXhi/hTJ
         FZmtUW8dVdPkkioubhPytErjHF+prRzJxyE52YTbXspzqaT8AB1NuFAWaWIyTvjl7LW3
         3oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u34qCsZAvfeS79Z+r1hLI2XthXKBjO0UnOg5xokM1Rc=;
        b=UQfA9Vk4XBRmmAuJNa326NjVSvQGkpAkfLw/HG3zSEOHpUYog6O+v11P1grjiQ1v8S
         6TaT5Amjf3c9dQDB2T/IIXYGypEHD6ADNn1hlj7PImpBCu9t8AhtHdKB8gSBCvu/Wivw
         IElhWuoPWAWVnBEE6uwR6bzIgzoOxxucMcs/9XRJ1CemuWTVjjZPy7ULB7BtBO/atEqo
         tJNTz4mZzlZ6G1lXNlkLE/aSeAovIrAPDa67IJl9u/9vXx3jjD1tF/IDO+ve/3VHVeGY
         J3i8JcTMIHl6nWRHndb75DRJI6rKUeJ7f4Ubmq59uaSKWYwp9wzhvtSOfdYj5q+0+1ST
         hc2g==
X-Gm-Message-State: ALyK8tKtGLL1Da0lRtKvrdCvFLaL9qdAf9jj+IW1KvLUdF9XvU+hKCTcKGZ78JoFmIZDBECv8xc1Ral21LG45A==
X-Received: by 10.36.207.137 with SMTP id y131mr26495718itf.32.1465509285451;
 Thu, 09 Jun 2016 14:54:45 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Thu, 9 Jun 2016 14:54:45 -0700 (PDT)
In-Reply-To: <20160608152415.7770-2-pranit.bauva@gmail.com>
X-Google-Sender-Auth: kMEmg8CJMgQQYdIkVUONo0wrncQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296934>

On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `check_expected_revs` shell function in C and add a
> `--check-expected-revs` subcommand to `git bisect--helper` to call it
> from git-bisect.sh .
> [...]
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 06bc9b8..500efd5 100644
> @@ -174,13 +174,28 @@ static int is_expected_rev(const char *expected_hex)
> +static int check_expected_revs(const char **revs, int no)

In this codebase, it's more common to name this 'nr' rather than 'no'.
'revs_nr' would also be a good name.

> +{
> +       int i;
> +
> +       for (i = 0; i < no; i++) {
> +               if (!is_expected_rev(revs[i])) {
> +                       remove_path(git_path_bisect_ancestors_ok());
> +                       remove_path(git_path_bisect_expected_rev());
> +                       return 0;
> +               }
> +       }
> +       return 0;
> +}
