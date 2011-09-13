From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make-static: master
Date: Tue, 13 Sep 2011 16:46:06 -0700
Message-ID: <7v62kwvwe9.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
 <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
 <4E6FDE71.9050606@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cgB-0003wQ-Ax
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105Ab1IMXqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 19:46:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933075Ab1IMXqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 19:46:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F025227;
	Tue, 13 Sep 2011 19:46:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ls0qmZmnjrbQ6QvFOOJMdQSxyFo=; b=Mm9YQi
	VjARk1v6JMmpGhjHXKoCYZi95ZHnGdEhjxaVvWAT3kRiwoZGBpZtsdOmlo1vaZkO
	yQ0zT6BR6kE2IyQirQiw2rGmHcDi8O8h8DbiKqVooClOwxVfZuVNeL4ShC4pOAY3
	pHXJTcdYwB+xVv/EGROfdK97Qp5Bf3m48ia40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ADmP67CWEia7h5BdWG8Q1UJF4moAI75G
	yHMkHg8Y5r/l1QLSbn4iXAQ9cdrowfZTTgtcgNTU+fZJjNprTPP5a3SsJ4f0M4CY
	9ljX5sM3fwgEWBnPOeWioHy2/tGJvMapHswzXoQSleDBxwAGNpQxazbmf+e/JpOj
	LQUMn1jZ+ss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DA275226;
	Tue, 13 Sep 2011 19:46:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6A325225; Tue, 13 Sep 2011
 19:46:07 -0400 (EDT)
In-Reply-To: <4E6FDE71.9050606@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 13 Sep 2011 23:51:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D337FCE-DE62-11E0-ACE1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181328>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
>> Many symbols that are exported to the global scope do not have to be.
>> 
>> Signed-off-by: Junio C Hamano <junio@pobox.com>
>> ---
>>  * To be applied on top of 3793ac5 (RelNotes/1.7.7: minor fixes, 2011-09-07)
>> 
> [snipped patch]
>
> commit f34196da7b55cbf9f2651e095b6559430aff0baf (make-static: master, 11-09-2011)
> in the next branch (at repo.or.cz), but *not* this patch, breaks the build on
> cygwin.

Thanks.

This kind of breakage report was exactly what I was looking for by
merging it early to 'next'. Hopefully no other (function / platform) combo
has such dependencies...

 environment.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/environment.c b/environment.c
index 478f2afa..e810f6b 100644
--- a/environment.c
+++ b/environment.c
@@ -147,6 +147,15 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !get_git_work_tree();
 }
 
+/*
+ * This symbol might be unreferenced in normal builds but
+ * compat/cygwin.c refers to it. Do not remove without checking!
+ */
+int have_git_dir(void)
+{
+	return !!git_dir;
+}
+
 const char *get_git_dir(void)
 {
 	if (!git_dir)
