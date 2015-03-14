From: Kevin D <me@ikke.info>
Subject: Re: [PATCH] forbid log --graph --no-walk
Date: Sat, 14 Mar 2015 23:42:42 +0100
Message-ID: <20150314224242.GA3311@vps892.directvps.nl>
References: <5504A8CF.9080202@norn.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: epilys <epilys@norn.io>
X-From: git-owner@vger.kernel.org Sat Mar 14 23:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWuld-00025a-HY
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 23:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbbCNWmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 18:42:44 -0400
Received: from ikke.info ([178.21.113.177]:44518 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbbCNWmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 18:42:43 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 5244E1DCF6D; Sat, 14 Mar 2015 23:42:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5504A8CF.9080202@norn.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265465>

Subject is usually prefixed with the part that is changed, in this case
log.

For example: 

log: forbid log --graph --no-walk

On Sat, Mar 14, 2015 at 11:31:59PM +0200, epilys wrote:
> In git-log, --graph shows a graphical representation of a
> continuous commit history, and --no-walk shows discrete specified
> commits without continuity. This doesn't make sense, so we forbid the
> combined use of these flags.
> 
> Signed-off-by: Manos Pitsidianakis <epilys@norn.io>
> ---
>  builtin/log.c  | 2 ++
>  t/t4202-log.sh | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..0194133 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -155,6 +155,8 @@ static void cmd_log_init_finish(int argc, const char
> **argv, const char *prefix,
>  	memset(&w, 0, sizeof(w));
>  	userformat_find_requirements(NULL, &w);
>  +    if (rev->graph && rev->no_walk)

Patch got corrupted here (Space before +)

> +        die("--graph and --no-walk are incompatible");
>  	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
>  		rev->show_notes = 1;
>  	if (rev->show_notes)
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..4dd939b 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph
> --show-signature for merged tag' '
>  	grep "^| | gpg: Good signature" actual
>  '
>  +test_expect_success 'forbid log --graph --no-walk' '

Here also

> +    test_must_fail git log --graph --no-walk
> +'
> +
>  test_done
