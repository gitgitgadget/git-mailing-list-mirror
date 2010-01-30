From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 11:02:09 -0800
Message-ID: <7veil7pgb2.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org>
 <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org>
 <bd7fb2a884e55e176eea3002fd0c68dd@212.159.54.234>
 <ron1-A99355.16145629012010@news.gmane.org>
 <ron1-4F99DE.16184529012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 20:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbIaR-0005L0-Ns
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 20:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0A3TCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 14:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669Ab0A3TCT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 14:02:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0A3TCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 14:02:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC5295C21;
	Sat, 30 Jan 2010 14:02:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ObaFXUp6q0lRO4RLvqR2juhAyEo=; b=m0Ss0s
	33WcaNI2y8PB7gyv65ocRozrKf7xImFt7+I6ZnouLyXnZ2viEkn0rgSc8+ZCXm5D
	LgdOo1XDHuher/tMrwn0fIEAxn1PK8DJq42gEkvmoYuR9gjLvtsZfBLoGtIVFOXH
	TNnNNf80UZC8zlEpaIO8SIH3bJN0WW7jdV6Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cnF7ZdbkLhJfS5PbV8o/jaVQN09utI6B
	4zJjWWR8dPE2wqyvd5zl1Lu0aX9vS0FY+XqQAAFWUZIoER/TJiyZU9NVII0mGIbs
	xYsNbMHbA/1et/zMMmyhQFg80C+Q4Wr30GvRO78Y+PH/H4+pH6qsJ8dYeVeFR0D5
	27A56uqgvrQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F017295C1A;
	Sat, 30 Jan 2010 14:02:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34A6495C19; Sat, 30 Jan
 2010 14:02:11 -0500 (EST)
In-Reply-To: <ron1-4F99DE.16184529012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 16\:18\:45 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA1700CE-0DD1-11DF-86A3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138493>

Ron Garret <ron1@flownet.com> writes:

>> > > If I do a git reset --hard then I get the old version, but I lose my 
>> > > HEAD pointer so that git diff doesn't give me what I want any more.

I think it would be helpful to point out one issue that may hurt you (and
anybody who thinks "git update --tree" without --index is a good idea).

Keeping the index and HEAD in sync but matching the work tree files to
that of a different commit has one major downside.  To git, a work tree
file that does not exist in the index is a yet-to-be-added-untracked file
(that is how and why "rm --cached file" works, for example).  It won't
participate in the diff output (other than being treated as "no such file
in the work tree version").

Suppose that you used to have a path in older revision, but not in the
current revision.  You remove everything from the work tree and replace it
with the files in the older revision, and you do not touch HEAD nor index.
"git diff -R" appears to show "what changed since that older version and
the latest", because it compares what is in the index relative to what is
in the work tree.  Nice.

Not quite.  Since the index does not know that path you recently removed,
you won't see that path.  If you run "git ls-files" for a list of files
known to git, it wouldn't be shown either.

Your original "git checkout master^" is a valid and probably the optimal
way to get a checkout of a older revision (which you could feed to your
running Lisp interpreter, in addition to being able to run "less" and
"make" on them).  Exactly because the index is updated to that of the
older version, you won't lose the sight of the path that you removed in a
later version, and you can review the change with "git diff -R master".

I think this is an XY problem that comes from your wanting to use "git
diff" (compare work tree with index) instead of "git diff $commit", and
that was because you wanted to use "HEAD" as a name of a commit.  If you
used a branch name you originally came from, none of this desire to "keep
index intact" or "keep HEAD intact" would have been necessary.

But this is all tangent; I think you now know more about git to improve
your IDE integration, without fighting with git but instead taking
advantage of it.
