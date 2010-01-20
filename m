From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: do not require write permission
Date: Tue, 19 Jan 2010 17:09:32 -0800
Message-ID: <7v8wbt7far.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302>
 <20100120002836.GA16824@coredump.intra.peff.net>
 <7vhbqh7gpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXP4v-0007di-ST
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 02:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab0ATBJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 20:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218Ab0ATBJp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 20:09:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab0ATBJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 20:09:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDA969261F;
	Tue, 19 Jan 2010 20:09:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vQuXeFUMAaW5CQm1EAdogW4geJk=; b=kWYxxF
	RHjrz8IY2yfDJH+vn/INn4kkP+csOGqoKBU1iOi4U0fnydOTYaZqDrUXLbAMLOzq
	gpVCP4lyy5Ui0TunC1o+hRmVqHA6j2K7loxaKzxsMGMeXAZroKJ4mKSlrhxKsorv
	CeZ0cbfwui970DOdgP/L6S51ZbndY2poirpgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7JuvenRtKSCEwQdCTpAjxTerznL7T5C
	IuvUambl6j7/IDEJpiu9Low6JqFTsNoRKqV8evsAOnfZfwWTMkETeT8hXHkkCgzn
	HTR1jcyRgNBwdIUtZcNLqrKYfMQCEp9XA/e7Vkxi3TGzhZxVyx9y+jp9vShrVm4Q
	NvTiZZK6Kz4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89CF59261E;
	Tue, 19 Jan 2010 20:09:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB71D9261D; Tue, 19 Jan
 2010 20:09:34 -0500 (EST)
In-Reply-To: <7vhbqh7gpa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 19 Jan 2010 16\:39\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B23B52E-0560-11DF-89A2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137511>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jan 20, 2010 at 01:06:17AM +0100, Johannes Schindelin wrote:
>>
>>> Today, git status played violin on my nerves for the very last time.
>>> There is no good reason, really none, for git status to require
>>> write permissions.  If the index is not up-to-date, so be it, I
>>> cannot commit anyway.
>>
>> I agree it is annoying, but this patch does not apply (and is no longer
>> needed) on master since the status-is-no-longer-commit-dry-run series
>> has been merged.
>>
>> I don't know if it is worth putting your fix onto maint.
>
> I think the patch itself makes sense,...

Actually, I think it was somewhat a selfish patch and forgot that the
codepath is shared with a mode of operation where we should guarantee
that the index is updated, namely "git commit".

I think this would be a good addition to 'maint'.  I am not sure if it is
worth forward-porting to "commit --dry-run", though.  On one hand, it
might show what would happen if you ran "commit" better (i.e. you will be
told that you cannot write into it), but it is debatable if that is the
reason why people may want to run "commit --dry-run".

-- >8 --
Subject: status: don't require the repository to be writable

We need to update the index before hooks run when actually making a
commit, but we shouldn't have to write the index when running "status".
If we can, then we have already spent cycles to refresh the index and
it is a waste not to write it out, but it is not a disaster if we cannot
write it out.  The main reason the user is running "git status" is to get
the "status", and refreshing the index is a mere side effect that we can
do without.

Discovery and initial attempted fix by Dscho.

---

 builtin-commit.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 33aa593..83b7c35 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -278,11 +278,13 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 * We still need to refresh the index here.
 	 */
 	if (!pathspec || !*pathspec) {
-		fd = hold_locked_index(&index_lock, 1);
+		fd = hold_locked_index(&index_lock, !is_status);
 		refresh_cache(refresh_flags);
-		if (write_cache(fd, active_cache, active_nr) ||
-		    commit_locked_index(&index_lock))
-			die("unable to write new_index file");
+		if (0 <= fd) {
+			if (write_cache(fd, active_cache, active_nr) ||
+			    commit_locked_index(&index_lock))
+				die("unable to write new_index file");
+		}
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
