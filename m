From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace "git-" with "git " in *.[ch] comments and
 notifications
Date: Fri, 29 Aug 2008 19:12:18 -0700
Message-ID: <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
References: <20080829234751.GA2396@zakalwe.fi>
 <7vvdxj2ucl.fsf@gitster.siamese.dyndns.org>
 <20080830011509.GA16289@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Sat Aug 30 04:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZFxz-0001UW-A5
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 04:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbYH3CM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 22:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbYH3CM0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 22:12:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbYH3CMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 22:12:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C19C859286;
	Fri, 29 Aug 2008 22:12:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC26359285; Fri, 29 Aug 2008 22:12:20 -0400 (EDT)
In-Reply-To: <20080830011509.GA16289@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 30 Aug 2008 04:15:09 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16263BB8-7639-11DD-AFA6-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94356>

Heikki Orsila <shdl@zakalwe.fi> writes:

> On Fri, Aug 29, 2008 at 05:56:58PM -0700, Junio C Hamano wrote:
> ...
>> I do not think a single patch with the above hunk (which I think is a
>> mistake) and other bits that are obviously good (e.g. the first hunk to
>> builtin-apply.c we see below) is reviewable, but I cannot think of a
>> better alterantive.  Sigh...
> ...
>> I did not look at the rest.
> 
> Is the concept OK for this change? I can submit another patch.

By "concept" if you mean the goal to stop implying to the end users as if
it is a good practice to type (either from the command line or in their
scripts) "git-foo" dashed form, the goal is obviously good.

I however am not sure if posting a single patch that is 1300 lines long
would be the most effective way to achieve that goal.  Splitting them into
a handful batches, spread over a few weeks to give reviewers some
breathing room, might make it more reviewable.  I dunno.

Let's see hands; how many of you on git mailing list are willing to review
a re-rolled series, when Heikki posts one?  How can we make it easier to
apply "many eyeballs" to make the issue shallower?

One thing you might be able to do would be to separate user visible
strings and in-comment strings.  Frankly, when a comment talks about a git
subprogram, blindly replacing s/-/ / makes it _far worse_ and the
resulting text is harder to read for git hackers (who are primary
audiences of comments).  E.g. taking one random example from your patch:

diff --git a/builtin-init-db.c b/builtin-init-db.c
index baf0d09..81aa822 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -37,7 +37,7 @@ static void copy_templates_1(char *path, int baselen,
 
 	/* Note: if ".git/hooks" file exists in the repository being
 	 * re-initialized, /etc/core-git/templates/hooks/update would
-	 * cause git-init to fail here.  I think this is sane but
+	 * cause git init to fail here.  I think this is sane but
 	 * it means that the set of templates we ship by default, along
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.

I do not think this is an improvement.  We are talking about a single
subprogram, not what the user types from the command line.  Either of
these two would be easier to read:

	... would cause git-init to fail here...
        ... would cause "init" to fail here...

than:

        ... would cause git init to fail here...

Among these three, I think the second one is the most readable.  Perhaps
dropping "git-" prefix when we are talking about a git subprogram, and
quoting the word to make it stand out, could be a good approach , than
replacing it with "git " prefix.
