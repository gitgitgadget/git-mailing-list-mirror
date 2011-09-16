From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] request-pull: state what commit to expect
Date: Fri, 16 Sep 2011 12:04:54 -0700
Message-ID: <7viposfgvd.fsf_-_@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <7vobynui8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4dij-00038J-6M
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 21:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab1IPTE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 15:04:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab1IPTE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 15:04:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7604F4146;
	Fri, 16 Sep 2011 15:04:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=loOuuf+QX+1ERj1SzEDUvPeVfMI=; b=q62AJZ
	yBbm4YUqpTWG58l8YXnIdPWpcy1GLLWaGdDo+qBOyQfo+P6wg2k6iu04DfIDsHZH
	Kss5AQH+ENsAoaRpmDo+ZGpbGVZf+jttNaDTHIq9hbTYvZGG70wBqpG0Q4YpRVb3
	JujMyz6CjEYhSX7hu5GCra3GfTjWn8LvlvK6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R4/aN4NAwWLlBZVHN0ZWBRiqv0ErSoqm
	Ifjco4x4aj6c921WSQRxpYVVgA2f3bD09x9UAo1vT8NhCtNA8Q2skFC6DnG/iJQI
	QUtIykXU1S0cHhjM6uWMHgHein+cccWmX828yQhtbg47HPIABWDto2NGu5OpdtnB
	WtkQYRRfS5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CBC34145;
	Fri, 16 Sep 2011 15:04:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCDE2413F; Fri, 16 Sep 2011
 15:04:56 -0400 (EDT)
In-Reply-To: <7vobynui8a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Sep 2011 10:49:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C48471BE-E096-11E0-AB84-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181544>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I think that would probably be a good idea, although I'd actually
>> prefer you to be more verbose, and more human-friendly, and actually
>> talk about the commit in a readable way. Get rid of the *horrible*
>> BRANCH-NOT-VERIFIED message...
>>
>>  Top commit 1f51b001cccf: "Merge branches 'cns3xxx/fixes',
>>  'omap/fixes' and 'davinci/fixes' into fixes"
>>
>>  and at *that* point you might have a "UNVERIFIED" notice for people
>> to check if they forgot to push.
>
> That UNVERIFIED thing was neither my favorite nor my idea, and I'd happily
> rip it out in any second ;-)

So this is the third round.

-- >8 --
The message gives a detailed explanation of the commit the requester based
the changes on, but lacks information that is necessary for the person who
performs a fetch & merge in order to verify that the correct branch was
fetched when responding to the pull request.

Add a few more lines to describe the commit at the tip expected to be
fetched to the same level of detail as the base commit.

Also update the warning message slightly when the script notices that the
commit may not have been pushed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

A UI wart that we cannot fix without breaking backward compatibility is
that the "end" parameter (which defaults to HEAD and is assigned to $head
variable in the script) the requestor uses from the command line names a
commit (often the name of a local branch), but for the purpose of telling
which ref to pull from the public repository, that is a _wrong_ thing to
give to the recipient.

Because the act of generating a request-pull message and the act of
pushing to the public repository are not linked in any way, the script
does not know _how_ the requestor caused (or intends to cause) the commit
to sit at the tip of which branch. There is no guarantee that a lazy "git
push" that relies on the configured refspec will be (or have been) used,
so even parsing the output from "git push -n --porcelain -v $there" would
not tell the script which branch the commit to be pulled is to be pushed
out to, or if the branch is consistent with the request message.

The use of "git ls-remote" in the script and picking one of the refs that
matches the commit object at random from its output is unsatisfactory, but
that is unfortunately the best this script could do without correcting the
design mistake and redefining what the "end" parameter means.

If we can break the backward compatibility and redefine that the "end"
parameter now means the name of the branch at the public repository, it
would make the operation a lot more robust.  We could then:

 - $branch is what is given by the end user (it is an error not to give
   the "end" parameter);
 - run "git ls-remote $url $head" to find $headrev;
 - generate the message and shortlog using the information obtained from
   $url; and
 - get rid of "did you forget to push" message.

We could allow adding yet another argument which names a commit object
locally, and make sure if the $headrev observed by ls-remote does not
match it.

---
 git-request-pull.sh     |   34 +++++++++++++++++++---------------
 t/t5150-request-pull.sh |    6 ++++++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index afb75e8..438e7eb 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -35,7 +35,7 @@ do
 	shift
 done
 
-base=$1 url=$2 head=${3-HEAD}
+base=$1 url=$2 head=${3-HEAD} status=0
 
 test -n "$base" && test -n "$url" || usage
 baserev=$(git rev-parse --verify "$base"^0) &&
@@ -51,25 +51,29 @@ find_matching_branch="/^$headrev	"'refs\/heads\//{
 }'
 branch=$(git ls-remote "$url" | sed -n -e "$find_matching_branch")
 url=$(git ls-remote --get-url "$url")
-if test -z "$branch"
-then
-	echo "warn: No branch of $url is at:" >&2
-	git log --max-count=1 --pretty='tformat:warn:   %h: %s' $headrev >&2
-	echo "warn: Are you sure you pushed $head there?" >&2
-	echo >&2
-	echo >&2
-	branch=..BRANCH.NOT.VERIFIED..
-	status=1
-fi
 
 git show -s --format='The following changes since commit %H:
 
   %s (%ci)
 
-are available in the git repository at:' $baserev &&
-echo "  $url $branch" &&
-echo &&
+are available in the git repository at:
+' $baserev &&
+echo "  $url${branch+ $branch}" &&
+git show -s --format='
+for you to fetch changes up to %H:
+
+  %s (%ci)
+
+----------------------------------------------------------------' $headrev &&
 
 git shortlog ^$baserev $headrev &&
-git diff -M --stat --summary $patch $merge_base..$headrev || exit
+git diff -M --stat --summary $patch $merge_base..$headrev || status=1
+
+if test -z "$branch"
+then
+	echo "warn: No branch of $url is at:" >&2
+	git show -s --format='warn:   %h: %s' $headrev >&2
+	echo "warn: Are you sure you pushed '$head' there?" >&2
+	status=1
+fi
 exit $status
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 9cc0a42..5bd1682 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -193,8 +193,14 @@ test_expect_success 'pull request format' '
 	  SUBJECT (DATE)
 
 	are available in the git repository at:
+
 	  URL BRANCH
 
+	for you to fetch changes up to OBJECT_NAME:
+
+	  SUBJECT (DATE)
+
+	----------------------------------------------------------------
 	SHORTLOG
 
 	DIFFSTAT
-- 
1.7.7.rc1.3.g559357
