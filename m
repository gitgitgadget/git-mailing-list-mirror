From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 18 Jul 2013 20:54:16 -0400
Message-ID: <CAPig+cTXn4hdKoCjnNXmybNxYt0Bt_QuxsfFxiA5b0J1FxUUmQ@mail.gmail.com>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan>
	<871u6v93a8.fsf@igel.home>
	<7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
	<7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 02:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzyxi-0002Dh-IR
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 02:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934401Ab3GSAyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 20:54:18 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37378 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933632Ab3GSAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 20:54:17 -0400
Received: by mail-ie0-f177.google.com with SMTP id w15so133740iea.36
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=XBLHR1OSUdM7sTA3RR7CVxDyVLmUh7AYMbLn2Y2WZIk=;
        b=v3T0H1aK3htUcY7Nu1IYG7lapYBogBlzYFWx/GEbx/xwQOG0vxY4d4j69DWUcTWkTV
         1wrBxgLDZAsGfWD70RixiidSXEsNE9M/rSPcxZ61JWJexqrhLhHJGwXCkXGHmm1R/gqK
         0yEsPwgDn+Yc3fkSLvqJ9Dk8O7TnCGv3nYYt9TRbDXZzcHRnhYznJJUjPSsD+7E6YqYY
         JDcPNz4QJddrbSJBLvabQ6khWExLeZ7ykLgKabKwKu7xrrJVXE8FKGfSFTHSx5bPpAo2
         rRZEu6U0C9ZIbl3NedmCzoHcZWOeerL4LC+S6cX5/0JEYaMDeadQ0LaiZS2EGckj7E+u
         CXaw==
X-Received: by 10.43.112.198 with SMTP id et6mr7693089icc.4.1374195257182;
 Thu, 18 Jul 2013 17:54:17 -0700 (PDT)
Received: by 10.64.86.164 with HTTP; Thu, 18 Jul 2013 17:54:16 -0700 (PDT)
In-Reply-To: <7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
X-Google-Sender-Auth: s6ykBs03-7JY_G2rOFArYmEbSBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230774>

On Thu, Jul 18, 2013 at 3:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Add a safety valve to fail "git pull" that does not explicitly
> specify what branch from which repository to integrate your history
> with, when it is neither a fast-forward or "already up-to-date",
> until/unless the user expressed her preference between the two ways
> of integration.
> ---
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 24ab07a..86f5170 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -97,6 +97,14 @@ must be given before the options meant for 'git fetch'.
>  Options related to merging
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> +When `git pull` that does not explicitly specify what branch from
> +which repository is to be integrated with your history on the
> +command line, recent Git will refuse to work until you specify how
> +that integration should happen, either with a command line option
> +(`--merge` or `--rebase`) or a configuration variable (`pull.rebase`
> +or `branch.<name>.rebase`, which is the same as `--merge`
> +(`--rebase`) when set to `false` (`true`) respectively.

This paragraph-long single sentence may be intimidating. Perhaps some
simplification is possible:

    As a safety measure, bare `git pull` (without repository or
    branch) needs to be told how to integrate pulled changes with
    your history; either via `--merge` or `--rebase`.  Also see
    configuration variables `pull.rebase` and `branch.<name>.rebase`
    in linkgit:git-config[1].

I intentionally omitted the true/false explanation of the
configuration variables since the user can follow the link and read
about them. It also may make sense to drop mention of those variables
altogether since they are already described (including link) in the
description of --rebase.

I also intentionally omitted "recent Git" since it's rather nebulous.
