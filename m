From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/17] cat-file: read batch stream with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:57 -0700
Message-ID: <1446071161-15610-14-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIF-0000nz-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbbJ1Wd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:29 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753889AbbJ1WdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A9FA26A4B;
	Wed, 28 Oct 2015 18:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TDWZ
	DdDzVX928bFdiZB58GymLj8=; b=Uvk+Kxp33dme2tgKp1tld6XU+bm4uxnHFf8X
	icW8SMDHR0fBfROiv3ZOO7H1XCw9M76CN14rzzQnMS2iiP3iyNF1rDQ4OspGxWzy
	EY9RWDchGEd+tfdgQDsw2a71wJ7m6gqnAe8tXlcwYhgN5YLa3I5Dtxo63J7x7qls
	rvG2w98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NF5rHZ
	bkw9lwKEQOptc2uQaav5MbKvoCghaogpO4NSdCe0qz+JIyJd9y15Z2HJfr+uOWvD
	YipX485FRkbK+y0HSznK5mQR4e9StitSqOb/0O75p2LLEYbFNbaP6WiNA0RJ14Sf
	QqaWs3jx4u3sWrQ8pgvuqDYlW5HQsdUwQAfPE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93D1A26A4A;
	Wed, 28 Oct 2015 18:26:22 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D58026A46;
	Wed, 28 Oct 2015 18:26:22 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EAD073C2-7DC2-11E5-AD1F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280411>

It is possible to prepare a text file with a DOS editor and feed it
as a batch command stream to the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index c0fd8db..e79097d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,7 +401,7 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_gets(&buf, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
-- 
2.6.2-423-g5314b62
