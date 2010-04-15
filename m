From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] (resend) stash: Don't overwrite files that have gone from the index
Date: Thu, 15 Apr 2010 09:33:40 +0200
Message-ID: <201004150933.41330.trast@student.ethz.ch>
References: <1271291062-32154-1-git-send-email-charles@hashpling.org> <1271291062-32154-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 09:34:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Jaq-00063I-Rw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab0DOHeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 03:34:09 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:50915 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757232Ab0DOHeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:34:05 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 15 Apr
 2010 09:34:03 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 15 Apr
 2010 09:33:42 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1271291062-32154-2-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144957>

Charles Bailey wrote:
> diff --git a/git-stash.sh b/git-stash.sh
> index 908aab2..9efc544 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -87,6 +87,8 @@ create_stash () {
>  			export GIT_INDEX_FILE &&
>  			git read-tree -m $i_tree &&
>  			git add -u &&
> +			{ git diff --quiet --diff-filter=D --cached ||
> +				git diff -z --name-only --diff-filter=D --cached | xargs -0 git add --ignore-errors; } &&

I think you'll also have to turn it into an 'add -f' invocation since
the file in question could conceivably have been ignored-but-tracked,
and straight 'add' would refuse to re-track it.

(No, I don't have any good ideas on how to get rid of xargs short of
some shell loop...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
