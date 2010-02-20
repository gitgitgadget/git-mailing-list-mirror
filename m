From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: avoid --cherry-pick when rebasing to a direct ancestor
Date: Sat, 20 Feb 2010 01:02:15 +0100
Message-ID: <201002200102.15777.trast@student.ethz.ch>
References: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com> <d1a75633daa062b25527dfb0675673480974c940.1266620423.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 01:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nico0-0000TP-N3
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 01:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab0BTACk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 19:02:40 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:59915 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab0BTACj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 19:02:39 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 01:02:36 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 01:02:16 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <d1a75633daa062b25527dfb0675673480974c940.1266620423.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140506>

On Saturday 20 February 2010 00:30:52 Thomas Rast wrote:
> Ordinary 'rebase -i' reads the commits to rebase with (roughly)
> 
>   git rev-list --left-right --cherry-pick $upstream...
> 
> which gives it the feature of skipping commits that are already
> present in $upstream.  However, in the common use-case of rewriting a
> few commits up to an ancestor, as in 'git rebase -i HEAD~3', the
> --cherry-pick is useless since there are no commits to compare to.
[...]
> The --cherry-pick mechanism itself could get a similar optimization,
> but I don't know that code.

Or maybe it's as simple as this?

diff --git i/revision.c w/revision.c
index 438cc87..29721ec 100644
--- i/revision.c
+++ w/revision.c
@@ -547,6 +547,9 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 			right_count++;
 	}
 
+	if (!left_count || !right_count)
+		return;
+
 	left_first = left_count < right_count;
 	init_patch_ids(&ids);
 	if (revs->diffopt.nr_paths) {

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
