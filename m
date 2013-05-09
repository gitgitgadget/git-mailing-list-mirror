From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Thu, 09 May 2013 13:27:49 -0700
Message-ID: <7vsj1v99ve.fsf@alter.siamese.dyndns.org>
References: <20130403092704.GC21520@suse.cz>
	<7v38v1yn8o.fsf@alter.siamese.dyndns.org>
	<20130411092638.GA12770@suse.cz>
	<CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
	<20130411110324.GD12770@suse.cz>
	<CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
	<20130411130652.GG12770@suse.cz>
	<7vy5bo7x62.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 09 22:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaXRV-0000xJ-K9
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 22:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab3EIU1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 16:27:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab3EIU1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 16:27:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 248761DFD8;
	Thu,  9 May 2013 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=udlfmiGKMO+wbNQC8bNLmdIQLdk=; b=Q+IxX1
	3jAsEIcfzpSuc/5Jkqx4jmMEr5kslsX/BFeHR8vOSK6KndWyxbAFGu563yaCVBI2
	slGsnIXlj/nrIy5A2pYY4B7J/Uj5IbLJLGRIwz5j0sN41wcmc79ClgiMSUX07hsv
	siKPP3zGwRjCOIOcKBtyfmN8b7h9YS13XofS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcCou7hOsNOjmXXAnVSCNeBJu4dsIKxn
	9hoMnty3ypa1IQNi+5NHgDNZ3WDzoUEmzi/vh7pF1U6u8LumerMSRwV3uK0/puvP
	EhxtQSO2C122Diofz5PvbDT96UYzeuqXX2mmf36FtMPLQu2IfFAMFCrX+AVl77uV
	Srz1nZeLZdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18CB51DFD7;
	Thu,  9 May 2013 20:27:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65FA21DFC4;
	Thu,  9 May 2013 20:27:51 +0000 (UTC)
In-Reply-To: <7vy5bo7x62.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 09 May 2013 12:47:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBE6716A-B8E6-11E2-8672-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223778>

Junio C Hamano <gitster@pobox.com> writes:

> Miklos Vajna <vmiklos@suse.cz> writes:
>
>> When a single argument was a non-commit, the error message used to be:
>>
>> 	fatal: BUG: expected exactly one commit from walk
>>
>> For multiple arguments, when none of the arguments was a commit, the error was:
>>
>> 	fatal: empty commit set passed
>>
>> Finally, when some of the arguments were non-commits, we ignored those
>> arguments.  Fix this bug and make sure all arguments are commits, and
>> for the first non-commit, error out with:
>>
>> 	fatal: <name>: Can't cherry-pick a <type>
>>
>> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
>
> This turns out to be an irritatingly stupid change.  While I am
> rebuilding a privately tagged tip of 'maint', I am seeing:
>
> 	fatal: v1.8.2.3: Can't cherry-pick a tag
>
> You would want to reject non committish, not non commit.

I'd apply this before -rc2.  I _think_ it is also OK to just let
lookup_commit_reference_gently() barf with its standard message

	error: Object %s is a %s, not a commit

without an extra sha1_object_info() call in the error codepath, but
I did not bother, as this is meant to be an emergency fix.

-- >8 --
Subject: cherry-pick: picking a tag that resolves to a commit is OK

Earlier, 21246dbb9e0a (cherry-pick: make sure all input objects are
commits, 2013-04-11) tried to catch an unlikely "git cherry-pick $blob"
as an error, but broke a more important use case to cherry-pick a
tag that points at a commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 61fdb68..f2c9d98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1077,10 +1077,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			continue;
 
 		if (!get_sha1(name, sha1)) {
-			enum object_type type = sha1_object_info(sha1, NULL);
-
-			if (type > 0 && type != OBJ_COMMIT)
+			if (!lookup_commit_reference_gently(sha1, 1)) {
+				enum object_type type = sha1_object_info(sha1, NULL);
 				die(_("%s: can't cherry-pick a %s"), name, typename(type));
+			}
 		} else
 			die(_("%s: bad revision"), name);
 	}
