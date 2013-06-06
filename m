From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 6/9] cherry-pick: add support to copy notes
Date: Thu, 6 Jun 2013 07:17:56 -0500
Message-ID: <CAMP44s2Jo9A-Dr3S-Pcj6WQ8W4Wg9dLn_f-WGyVZ2Bp4JysBCw@mail.gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 14:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkZDm-0001cE-Td
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 14:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933442Ab3FFMSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 08:18:02 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61997 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933433Ab3FFMR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 08:17:59 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so3004933lbd.15
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qZ1JB5nfVUfp0lI0eUsOGv9XAhk+/Z1t9mD2OJtZoXk=;
        b=qxLycAIO11DFI/8EsbAtHSZ9Q4qMM4aCf7oGg2pOUGb6OrNixXe++CY5a3OxIYoY5R
         sCKPeZEU8ilmYbH9+Bc6wWcWHDP11Pw6iVBWa2h1aChb7NjBaOX9SEP8JrG3NJ02xw6y
         +iwCywu1GalvVL4jjbaBCdIpS02F2RVeyn2V6FWVKJcMwfzHRZVk8Rf54OhExQLfjpg0
         LaaXwC2Lx02sh53/NuVA/j05zXW/0RB05NmzNq0rkBowLazpIvtAhaqeQPg9uVcB9Yqp
         MZ1gspiK/kimxuE0IWS1njX51zvCpl6zPTDVmZaB5kj2ol6+TaOWvfA2XW5VNfls42qH
         zYpg==
X-Received: by 10.112.132.66 with SMTP id os2mr11184561lbb.118.1370521076427;
 Thu, 06 Jun 2013 05:17:56 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 05:17:56 -0700 (PDT)
In-Reply-To: <1370509144-31974-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226500>

On Thu, Jun 6, 2013 at 3:59 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  sequencer.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 74480d7..6d13e63 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -14,6 +14,7 @@
>  #include "merge-recursive.h"
>  #include "refs.h"
>  #include "argv-array.h"
> +#include "builtin.h"
>
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>
> @@ -158,6 +159,32 @@ static void run_rewrite_hook(const char *name)
>         finish_command(&proc);
>  }
>
> +static void copy_notes(const char *name)
> +{
> +       struct notes_rewrite_cfg *cfg;
> +       int i;
> +
> +       cfg = init_copy_notes_for_rewrite(name);
> +       if (!cfg)
> +               return;
> +
> +       for (i = 0; i < rewritten.nr; i++) {
> +               struct rewritten_list_item *item = &rewritten.items[i];
> +               copy_note_for_rewrite(cfg, item->from, item->to);
> +       }
> +
> +       finish_copy_notes_for_rewrite(cfg);
> +}

Unfortunately this doesn't work, because all these functions are part
of the builtins, not git lib.

-- 
Felipe Contreras
