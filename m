From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Wed, 5 Sep 2012 12:24:36 -0700
Message-ID: <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:25:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9LDi-0004JT-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 21:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200Ab2IETY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 15:24:56 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59072 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab2IETYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 15:24:53 -0400
Received: by ieje11 with SMTP id e11so1693590iej.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HivqMieJALede9upU6Pt7lW1TSH+dkZ26ThZ+A4pua4=;
        b=XW1ED1BN5T5Nfd4aALnNzwlHVgNibRAYgeL64R6MMOOEAcxLp9GMZvTvv1PZM9QptI
         +fvMElVNgIfH7tYTUOEUGHgtdPYHpVHO8KEmzNG5SThiyFFV80brt0xZEr64/cvY6mZ4
         B7716SsOQW82CON4CvRIGm/3eJLmKHqMy31zBiXki2HkNu8ihxCf7qO10nnle9gCfKdE
         cosC+vU18jtgS3sNz1IVpw0QQhA/vAJk33ZEfUEJ3EgGArRqhyaVXkVefSNsQXrkPrY/
         KAyWlIfbAUVYCqUe3CdZX/iKltJdme5Vk2ha7QyXX2WNtrnPHkdyP7+LBZsbAkbMC/wd
         GTBA==
Received: by 10.50.7.212 with SMTP id l20mr19110613iga.43.1346873093023; Wed,
 05 Sep 2012 12:24:53 -0700 (PDT)
Received: by 10.64.64.33 with HTTP; Wed, 5 Sep 2012 12:24:36 -0700 (PDT)
In-Reply-To: <1344983132-22578-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204839>

On Tue, Aug 14, 2012 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> @@ -745,13 +752,15 @@ sub file_declares_8bit_cte {
>  if (!defined $sender) {
>         $sender = $repoauthor || $repocommitter || '';
>         $sender = ask("Who should the emails appear to be from? [$sender] ",
> -                     default => $sender);
> +                     default => $sender,
> +                     valid_re => qr/\@.*\./, confirm_only => 1);

This is now bugging me if I just hit enter and don't want to specify
anything for
these headers (I want the defaults or what's in the files already).
Can we allow
the empty string to be valid as well so I don't have to go through
these prompts?
