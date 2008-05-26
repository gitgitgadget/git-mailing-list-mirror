From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-fast-export: Only output a single parent per line
Date: Sun, 25 May 2008 22:24:08 -0700
Message-ID: <7vzlqdd4ef.fsf@gitster.siamese.dyndns.org>
References: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl>
 <7vskw7jh7c.fsf@gitster.siamese.dyndns.org>
 <20080526014904.GZ29038@spearce.org>
 <7v7idhej6f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 26 07:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0VCs-00082T-Qu
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 07:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYEZFYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 01:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbYEZFYY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 01:24:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYEZFYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 01:24:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 90199328E;
	Mon, 26 May 2008 01:24:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BF704328C; Mon, 26 May 2008 01:24:13 -0400 (EDT)
In-Reply-To: <7v7idhej6f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 25 May 2008 22:19:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE7187D4-2AE3-11DD-A675-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82902>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> Is it fine for even git-fast-import?  fast-import.c: parse_merge() seems
>>> to suggest that it also wants one parent per "merge " line.
>>
>> fast-import wants the same as bzr-fast-import; one parent per
>> merge line.  If git-fast-import was doing anything with multiple
>> per line it was probably dropping everything after the first.  :-(
>>
>> This was a bug in fast-export; I'm glad Pieter has fixed it.
>
> Unfortunately, t9301 does not pass with the "fix".

Perhaps, this is needed on top?

 builtin-fast-export.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 4d28cf7..4bf5b58 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -209,8 +209,6 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 			printf("merge :%d\n", mark);
 		i++;
 	}
-	if (i > 1)
-		printf("\n");
 
 	log_tree_diff_flush(rev);
 	rev->diffopt.output_format = saved_output_format;
