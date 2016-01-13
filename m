From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase can be 'interactive'
Date: Wed, 13 Jan 2016 10:42:45 +0100
Message-ID: <vpq7fjdyfvu.fsf@anie.imag.fr>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 10:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJI0i-0002IY-UG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 10:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101AbcAMJqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 04:46:07 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53058 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932277AbcAMJqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 04:46:03 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u0D9gga7030796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Jan 2016 10:42:43 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0D9gjVA009669;
	Wed, 13 Jan 2016 10:42:45 +0100
In-Reply-To: <8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 12 Jan 2016 16:22:16 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Jan 2016 10:42:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0D9gga7030796
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1453282965.59389@fyO5DW/KcEofSM/Uf93Acg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283897>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 6694cf2..0af8300 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -251,7 +251,7 @@ static int add(int argc, const char **argv)
>  struct branch_info {
>  	char *remote_name;
>  	struct string_list merge;
> -	int rebase;
> +	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
>  };
>  
>  static struct string_list branch_list;
> @@ -312,6 +312,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  				info->rebase = v;
>  			else if (!strcmp(value, "preserve"))
>  				info->rebase = 1;
> +			else if (!strcmp(value, "interactive"))
> +				info->rebase = INTERACTIVE_REBASE;

What happens if one has branch.*.rebase=interactive, and wants to make
an exception? Does

  git pull --rebase=true

cancel the 'interactive' part? I guess it is, but if so I think it
should be tested and documented.

Anyway, thanks for the patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
