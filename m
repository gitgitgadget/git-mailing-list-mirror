From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Poor status output during conflicted merge
Date: Thu, 01 Jul 2010 17:00:12 -0700
Message-ID: <7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
References: <loom.20100701T195742-266@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 02:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUTgB-0004AY-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 02:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab0GBAAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 20:00:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab0GBAAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 20:00:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30569C0F8E;
	Thu,  1 Jul 2010 20:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6PmYZaa6dHSybx6Y7tSMLCny0Uw=; b=KhJduZ
	25j/SdeHmp/DEaqT5NgUQH7BVv2W97aFmqAFscUtPAqMoCfJSw53rfK5QyGq9G5H
	XHZCJsfbLaQBOBloedJl3zIbFiF2KHQGxCRuLNdsa0tUEv5oYT7XWZ677owmv8Ac
	U+tEhBMmRvpuZd1v5P3Ef8UKlGAvtHf3n+uNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MEHL0KAwxFgcrurh62ItWeUuoXiIEkVE
	sqd7xlxWMYS+U5ACZB7xY0k4kMuhnxOhi9GaSe1po+g0Ih9R8qyyjnubC6EyPebm
	E4Z5TKGya3AgBfIBxIUFj1+958oCIycqlhkDLShv1etgQAOuS1mUthGT/qqVphPg
	aZJ+PJXDOyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F007C0F8D;
	Thu,  1 Jul 2010 20:00:17 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53FBFC0F8B; Thu,  1 Jul
 2010 20:00:14 -0400 (EDT)
In-Reply-To: <loom.20100701T195742-266@post.gmane.org> (Eric Raible's message
 of "Thu\, 1 Jul 2010 18\:16\:29 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC068E8A-856C-11DF-9351-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150092>

Eric Raible <raible@gmail.com> writes:

> A 'git status' at this point gives the following output:
>
> # On branch topic
> nothing to commit (working directory clean)
>
> Which is wrong, since the merge still needs to be committed.

It might be just a simple matter of ...

 wt-status.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 2f9e33c..757536f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -674,6 +674,8 @@ void wt_status_print(struct wt_status *s)
 			fprintf(s->fp, "# No changes\n");
 		else if (s->nowarn)
 			; /* nothing */
+		else if (s->in_merge)
+			printf("merge result will be the same as HEAD commit\n");
 		else if (s->workdir_dirty)
 			printf("no changes added to commit%s\n",
 				advice_status_hints
