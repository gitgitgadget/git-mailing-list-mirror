From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/2] format-patch: give --reroll-count a short synonym -v
Date: Thu, 3 Jan 2013 23:21:35 -0000
Organization: OPDS
Message-ID: <A6A2DEC8F88743B88AA03DC5BD8547B7@PhilipOakley>
References: <1357166525-12188-1-git-send-email-gitster@pobox.com> <1357166525-12188-2-git-send-email-gitster@pobox.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 01:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqvWK-0003yc-Sd
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 01:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab3ADAuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 19:50:52 -0500
Received: from smtp2go.com ([207.58.142.213]:46881 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab3ADAuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 19:50:46 -0500
X-Greylist: delayed 5357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2013 19:50:46 EST
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212624>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Wednesday, January 02, 
2013 10:42 PM
> Accept "-v" as a synonym to "--reroll-count", so that users can say
> "git format-patch -v4 master", instead of having to fully spell it
> out as "git format-patch --reroll-count=4 master".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> * As I do not think of a reason why users would want to tell the
>   command to be "verbose", I think it may be OK to squat on the
>   short and sweet single letter option, but I do not mind dropping
>   it.
>
> Documentation/git-format-patch.txt | 3 ++-
> builtin/log.c                      | 2 +-
> t/t4014-format-patch.sh            | 8 ++++++++
> 3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt 
> b/Documentation/git-format-patch.txt
> index 736d8bf..ae3212e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
>     [--start-number <n>] [--numbered-files]
>     [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>     [--ignore-if-in-upstream]
> -    [--subject-prefix=Subject-Prefix] [--reroll-count <n>]
> +    [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
>     [--to=<email>] [--cc=<email>]
>     [--cover-letter] [--quiet]
>     [<common diff options>]
> @@ -166,6 +166,7 @@ will want to ensure that threading is disabled for 
> `git send-email`.
>  allows for useful naming of a patch series, and can be
>  combined with the `--numbered` option.
>
> +-v <n>::
> --reroll-count=<n>::
>  Mark the series as the <n>-th iteration of the topic. The
>  output filenames have `v<n>` pretended to them, and the
> diff --git a/builtin/log.c b/builtin/log.c
> index e101498..08e8a9d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1081,7 +1081,7 @@ int cmd_format_patch(int argc, const char 
> **argv, const char *prefix)
>      N_("use <sfx> instead of '.patch'")),
>  OPT_INTEGER(0, "start-number", &start_number,
>      N_("start numbering patches at <n> instead of 1")),
> - OPT_INTEGER(0, "reroll-count", &reroll_count,
> + OPT_INTEGER('v', "reroll-count", &reroll_count,
>      N_("mark the series as Nth re-roll")),
>  { OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
>      N_("Use [<prefix>] instead of [PATCH]"),
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 0ff9958..03b8e51 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -245,6 +245,14 @@ test_expect_success 'reroll count' '
>  ! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
> '
>
> +test_expect_success 'reroll count (-v)' '
> + rm -fr patches &&
> + git format-patch -o patches --cover-letter -v 4 master..side >list 
> &&

Shouldn't this be using the sticked form -v4 as described in the commit 
message and gitcli?
Or is this being too picky?

> + ! grep -v "^patches/v4-000[0-3]-" list &&
> + sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> + ! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
> +'
> +
> check_threading () {
>  expect="$1" &&
>  shift &&
> -- 
> 1.8.0.9.g5e84801
>
