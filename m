From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log: invert --author and --committer
Date: Mon, 23 May 2016 14:47:10 -0700
Message-ID: <xmqqshx878gx.fsf@gitster.mtv.corp.google.com>
References: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
	<xmqqmvngaedn.fsf@gitster.mtv.corp.google.com>
	<xmqq37p8a84y.fsf@gitster.mtv.corp.google.com>
	<CAP=KgsSNgKY5gR3uSSMZdOxZ1687YRnQRQFsV22UwCXqmdfB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:47:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xhT-0003cG-BX
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbcEWVrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:47:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbcEWVrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:47:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8B421CD36;
	Mon, 23 May 2016 17:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ePkziHxyklKO9GUSTId0XOd1z8U=; b=c3yXxl
	O1ADj9P/FT759aPU85GSbizBwXl929vt7yyAWgArNrhdAECt9KGG0uax5/KkOg78
	0zdOZtZfHY0UutfKHaYvoo+Wn08OGjATg27K8Zw02Qt3nBCZDROK53/ducaJwvPC
	HZIUHacLcAE8/g92a95dh19ndHfVVyYjJh9Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGYX6JRakNcq1dau/EkTJIQYJB+X/nqU
	HcacqokIZlrqePv//nClA/ENDoU1XYKt6l/RkpjelWK2R1YSr+H0OHTZhjAxrN5Y
	S0vy/A9MzN7Qt8PCNt79Cw2AhCrDjKEhU5HhB8X8lNrhmyh1Xg9+ZX6YmGaXNYkt
	botrnldVfXc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE9EF1CD35;
	Mon, 23 May 2016 17:47:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BCEC1CD32;
	Mon, 23 May 2016 17:47:12 -0400 (EDT)
In-Reply-To: <CAP=KgsSNgKY5gR3uSSMZdOxZ1687YRnQRQFsV22UwCXqmdfB9g@mail.gmail.com>
	(Per Cederqvist's message of "Mon, 23 May 2016 23:21:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8064098-212F-11E6-A4CC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295399>

Per Cederqvist <cederp@opera.com> writes:

> I think it does make sense to document this with the --author/--committer
> options.
>
> That wording would however make me assume that --all-match could also
> be used, so that
>
>     git log --all-match --author ceder --author cibot
>
> would list nothing (since there are no authors that match both
> "ceder" and "cibot" in this codebase).  That isn't the fact, though.
> It seems to list all commits that have either ceder or cibot as author,
> just as if I had not used --all-match.
>
> As a reader of the man-page, I would prefer to have the exact list
> of options in the documentation.  (I realize that it will make it harder
> to maintain.)
>
>     /ceder

Ok, take 2.

This makes `--all-match` the only one that explicitly mentions that
the option applies to patterns given with the `--grep` option; from
an end-user's point of view, --author/--committer is not given via
the `--grep` option, so it may help to alleviate the above issue.

All others use "limiting patterns" consistently, so that eyeballing
for the phrase would catch things like "--invert-grep", "-E", etc.
and it would be easier to keep future additions to conform to the
convention, hopefully.

 Documentation/rev-list-options.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..51ead72 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -44,6 +44,10 @@ endif::git-rev-list[]
 	expression).  With more than one `--author=<pattern>`,
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=<pattern>`).
++
+Options that affect how a limiting pattern matches (listed below,
+such as `-i`, `-E`, `--invert-grep`) can also be used to affect
+these options.
 
 --grep-reflog=<pattern>::
 	Limit the commits output to ones with reflog entries that
@@ -70,7 +74,7 @@ endif::git-rev-list[]
 
 --invert-grep::
 	Limit the commits output to ones with log message that do not
-	match the pattern specified with `--grep=<pattern>`.
+	match the regular expression limiting patterns.
 
 -i::
 --regexp-ignore-case::
