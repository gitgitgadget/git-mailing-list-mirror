From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] shortlog: warn the user when there is no input
Date: Wed, 24 Feb 2010 21:49:03 +0100
Message-ID: <201002242149.03662.barra_cuda@katamail.com>
References: <201002242020.27801.barra_cuda@katamail.com> <7vvddmmnvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkO84-0000Il-IX
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037Ab0BXUqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 15:46:39 -0500
Received: from smtp186-pc.aruba.it ([62.149.157.186]:42056 "HELO
	smtp2-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757992Ab0BXUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 15:46:39 -0500
Received: (qmail 12192 invoked by uid 89); 24 Feb 2010 20:46:31 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2-pc.ad.aruba.it
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RDNS_NONE
	autolearn=ham version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.77.18)
  by smtp2-pc.ad.aruba.it with SMTP; 24 Feb 2010 20:46:31 -0000
User-Agent: KMail/1.11.4 (Linux/2.6.32.8-mike-1mike; KDE/4.2.4; i686; ; )
In-Reply-To: <7vvddmmnvo.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140986>

A simple "git shortlog" outside of a git repository stalls
waiting for an input. Check if that's the case by testing with
isatty() before read_from_stdin(), and warn the user like
"git commit" does in a similar case.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Wednesday 24 February 2010, Junio C Hamano wrote:
> Michele Ballabio <barra_cuda@katamail.com> writes:
> 
> > A simple "git shortlog" outside of a git repository used to stall
> > waiting for an input. Fix this by testing with isatty() before
> > calling read_from_stdin().
> 
> I'd actually prefer doing what "git commit" does.  Give a helpful hint
> that it is waiting for input from the standard input, but do read from
> standard input as the program is instructed to do.

Ok.

 builtin-shortlog.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b3b055f..22668b4 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -295,6 +295,8 @@ parse_done:
 	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
+		if (isatty(0))
+			fprintf(stderr, "(reading log message from standard input)\n");
 		read_from_stdin(&log);
 	}
 	else
-- 
1.7.0
