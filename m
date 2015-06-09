From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Tue, 09 Jun 2015 11:36:57 +0200
Organization: gmx
Message-ID: <9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
 <1433797202-97425-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 11:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Fy3-0000oh-17
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 11:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbbFIJhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 05:37:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:57550 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbbFIJhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 05:37:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MfEMs-1Yhxx21JbW-00OqY1; Tue, 09 Jun 2015 11:36:58
 +0200
In-Reply-To: <1433797202-97425-2-git-send-email-rappazzo@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:MBe3plUe/XaGdI2ZVEJ4KWYo62LSPEQWK3/4Dz3FnaavVmtSOYw
 MF+l5hJoOH22nfuiSp+MDFCuxLZZRtyhbyl/3apELMSaNaui0gWDs5wrNuZs5C+aUJZLXPS
 rLgybVcL0MwZVWKPGf6kWwGcwBajCO9sZ8JaU8CiY5R9S7X9k/mzpR4/HAeddGjkzlO+lHr
 AfFgSehimJiS/z+uIzULA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gE48lI09f5o=:OVLcpUFI4HNyl+KBka0t0U
 FNoO6mb4kEuzSbFexZmDTtZo4lLZ7zTr21wMar+WYJU6EHaZO4230abQvF9Ng/zRR2VQmF0Io
 s0QnEb9icqIOHhnH/+Q5pVH3sCG0OEaIkveOYz+onjKq0wSqGgLEmKG8Xranoc2OWpgzW4JC0
 StgZ9Uk3co/1VrOW0leqqVItyy6dmHmb05ZohNWZPGf3k4lJ7JpgNvPWiajG9fHh+dOixJW+W
 rYXI+g57rLxPVhjuv0FA+LdQUSqeZ/BMmzJ3Q9Kb+mxmAxkXAZSeTtGI61udnO+aaULuJi6aY
 v14f52Ltvl23rmEx3ZQcoIYoS2WeCLSEvh67l1Xh0kI72a+dZ+w8xYTmf0ZUQvmwqzZmI6t8z
 DY8rx8FLIiAUeJemr/f1lXNzo+P10Odp7PHQbn4PZsLfFkLBHc+glZPo2Vqbg0Ak4wKFlihdE
 6XurPhFDnS3GH3EWSwG8zdz/l/HtDn7gU/cmVIKPxuAGum4/JPyz2m4fboXTth20YOufnfNt7
 lyVi2IkdAaLN3gsIUxfaRxtn75YqdrQkzGuYQ6bEAeQcGpJowOVchFyjOwFFyze60VLJhAy5I
 1M1qPeGsHCoUe3UOEBBut69gI/Rnh6Wz3w11dWxvCmWnqDQWLf2H+QVzTOwehgpklu6MfFkV8
 VHpp1GrhhDAmAmM4UTia/J1kMWZe9voYmdyxEGqpxza4Fw3U4p+ip9tv79w3RhBwhFKs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271158>

Hi,

On 2015-06-08 23:00, Michael Rappazzo wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..b92375e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -977,7 +977,9 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> -git rev-list $merges_option --pretty=oneline --reverse --left-right
> --topo-order \
> +format=$(git config --get rebase.instructionFormat)
> +# the 'rev-list .. | sed' requires %m to parse; the instruction
> requires %H to parse
> +git rev-list $merges_option --format="%m%H ${format-%s}" --reverse
> --left-right --topo-order \

These two lines are too long (longer than 80 columns)...

Besides, are you sure you don't want to substitute an empty 'rebase.instructionFormat' by '%s'? I would have expected to read `${format:-%s}` (note the colon), but then, this was Junio's suggestion... Junio, what do you think, should we not rather substitute empty values by `%s` as if the config setting was unset?

>  	$revisions ${restrict_revision+^$restrict_revision} | \
>  	sed -n "s/^>//p" |
>  while read -r sha1 rest

Ciao,
Johannes
