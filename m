From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 10:10:24 +0200
Organization: gmx
Message-ID: <96de4a8c540c041733fd47a4cb1af782@www.dscho.org>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:10:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsRke-00062A-2i
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 10:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933535AbbEMIKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 04:10:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:62868 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933517AbbEMIKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 04:10:31 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LgdBZ-1ZX3PY11Rl-00o0ex; Wed, 13 May 2015 10:10:25
 +0200
In-Reply-To: <1431482407-63642-1-git-send-email-davvid@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:a/o/E1UY8HUlMbEn7qc2GpMVkQy7c/XpJf+XroZ/ebD1lVjdoax
 F0oSbKxwvA9XO80l0ksDsOx4Vpw2AsCmZVd/Q1R26lTwFoxDIJgdHmo5MLW+Vjpxsr435ZS
 8dOYKA17ZXcFtYU5huPlmNcxNL/gwXjsqcVWA8QryJr3Om6ooGjkh3eOqTpS52quqsHRw+L
 1l7YBuyOZeLnPjXDi02ww==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268945>

Hi David,

On 2015-05-13 04:00, David Aguilar wrote:

> +	if test -n "$ProgramW6432" && test -x "$ProgramW6432/$winmerge_exe"
> +	then
> +		printf '%s' "$ProgramW6432/$winmerge_exe"
> +	elif test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES/$winmerge_exe"
> +	then
> +		printf '%s' "$PROGRAMFILES/$winmerge_exe"

I am terribly sorry that I confused you... What I *meant* was to test in the following order: $PROGRAMFILES, $ProgramW6432, /c/Program Files, /c/Program Files (x86).

While I am already nitpicking, I would also like to throw out the idea to write that in a loop instead (a little bit more DRY):

for directory in "$PROGRAMFILES" "$ProgramW6432" '/c/Program Files' '/c/Program Files (x86)'
do
    test -n "$directory" &&
    test -x "$directory/$winmerge_exe" &&
    echo "$directory/$winmerge_exe" &&
    break
done

Ciao,
Dscho
