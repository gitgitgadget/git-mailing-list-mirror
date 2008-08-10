From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sat, 09 Aug 2008 18:01:41 -0700
Message-ID: <7vd4kh4r9m.fsf@gitster.siamese.dyndns.org>
References: <1218324810-35376-1-git-send-email-pdebie@ai.rug.nl>
 <1218324810-35376-2-git-send-email-pdebie@ai.rug.nl>
 <7vhc9t4s2c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Aug 10 03:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRzKg-0007Ho-5s
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 03:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYHJBBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 21:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYHJBBt
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 21:01:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYHJBBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 21:01:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6466C5370A;
	Sat,  9 Aug 2008 21:01:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8279953705; Sat,  9 Aug 2008 21:01:43 -0400 (EDT)
In-Reply-To: <7vhc9t4s2c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 09 Aug 2008 17:44:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E835F502-6677-11DD-9226-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91797>

Junio C Hamano <gitster@pobox.com> writes:

> Pieter de Bie <pdebie@ai.rug.nl> writes:
>
>> dwim_ref() used to resolve HEAD to its symlink (like refs/heads/master),
>> making a call to 'git reflog delete HEAD@{1}' to actually delete the second
>> entry in the master reflog.
>>
>> This patch makes a special case for HEAD (as that's the only non-branch
>> reflog we keep), fixing the issue.
>
> What happens to remotes/origin/HEAD that points at remotes/origin/master?

Perhaps this might work better?

 builtin-reflog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 0c34e37..a48f664 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -604,7 +604,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
