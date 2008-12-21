From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Sun, 21 Dec 2008 14:38:53 -0800
Message-ID: <7vhc4xkvb6.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <200812211359.31991.bss@iguanasuicide.net>
 <7vwsdtmg5m.fsf@gitster.siamese.dyndns.org>
 <200812211513.26808.bss@iguanasuicide.net>
 <7vprjlkwbb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:40:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWyJ-0004bL-5C
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbYLUWjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYLUWjD
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:39:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYLUWjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:39:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 42FC61AD08;
	Sun, 21 Dec 2008 17:39:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 447A61AD02; Sun,
 21 Dec 2008 17:38:54 -0500 (EST)
In-Reply-To: <7vprjlkwbb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 21 Dec 2008 14:17:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29274C90-CFB0-11DD-A943-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103727>

Junio C Hamano <gitster@pobox.com> writes:

>   Ok, so here is Robin's patch with a bit of rewording.  I want to have
>   something usable now, so that I can tag -rc4 and still have time left
>   for sipping my Caipirinha in the evening ;-)
> ...
> +			add_to_msg(",\nreverting damages made to %s");
> +			add_to_msg(sha1_to_hex(parent->object.sha1));

Crap.  Scratch that.  Obviously I should have done this:

diff --git a/builtin-revert.c b/builtin-revert.c
index 4038b41..c188150 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -352,6 +352,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		add_to_msg(oneline_body + 1);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
+
+		if (commit->parents->next) {
+			add_to_msg(",\nreverting damages made to ");
+			add_to_msg(sha1_to_hex(parent->object.sha1));
+		}
 		add_to_msg(".\n");
 	} else {
 		base = parent;
-- 
1.6.1.rc3.72.gf4bf6
