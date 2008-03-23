From: "alturin marlinon" <alturin@gmail.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sun, 23 Mar 2008 15:07:58 +0100
Message-ID: <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
	 <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
	 <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQsM-0006OS-S1
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbYCWOIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758291AbYCWOIB
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:08:01 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:27113 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbYCWOIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:08:00 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2505042wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1ZfWFr33Gm6HNTzqWZl11NQQSrdgzn14PuIqrlcx4Ac=;
        b=fDGAz19u5o5N8krzoQAgXdnke7iIZ+yX3rU9aVnbr5WHcX3V6hF+t0qdpUTqBnhZQbIag9Un6dPAoSW6rRbfGEa9NRfExGbYeB1Ac9dczX7EALrNYXqA8SlqmUiQJMeHHEcvoWXqrIHqBLR2CVBJ3OzwJuKNKdfe5BklqZPhdSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BLq3yX463rjxvv2CapuKVeNz4b8SLlYlpndAxfnLzfbHLKbEaaa6hQlycQMGQjnuT+qW7IcL/d18zTnR3SZ9Sg+IhB4/Z84aiCN6WttF9HOPmUdF42XMkLBI0ZLeTIghwaG34d87CWOosHSjkFARKfueQfVJ1emAIzgQyyTIRsI=
Received: by 10.142.73.8 with SMTP id v8mr3749332wfa.68.1206281278389;
        Sun, 23 Mar 2008 07:07:58 -0700 (PDT)
Received: by 10.142.77.6 with HTTP; Sun, 23 Mar 2008 07:07:58 -0700 (PDT)
In-Reply-To: <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77902>

On Sat, Mar 22, 2008 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Figure out which blocs of lines (not necessarily the whole files) relate
>   to each other by noticing that they are often modified in the same
>   commit.

I've worked with directed graphs before (including writing my own
implementation) and have written an algorithm to detect cycles in a
graph.
I think that this could be done by creating an undirected weighted
graph of all files in a commit.
If we create a graph that records how many time two files are edited
in the same commit, the connection with the highest value would
indicate that two files are strongly related.
I'm not sure how this could be extrapolated to a section-based
approach but a solution to that problem will have to be written
anyway.
(As with the other featires I'll need to be able to keep track of
lines, the mechanism to be developed for that can be used here also.)

>  * Who are early birds and who are late night owls?  Who are day-job
>   contributors and who are weekenders?

Sounds like a 'fun feature', but how about timezones?
I'm not sure how commit times are recorded, in UTC, if so, does it
also record their timezone?

>  * Identify "buggy commits" from history, without testing.  Zeroth order
>   approximation is that the lines it introduced were later rewritten by
>   other later commits, but the later ones are not necessarily fixes but
>   can be enhancements, so you would need a way to tell which ones are
>   "fixing commits" and which ones are not.  You may want to use project
>   specific hints to help you doing this:

A feature like this would fit well with the other "buggy
commit/maintainer detection" but would require a lot of customization.
However, considering git already comes with a good customization
system it should still be feasible.

>   - a log that matches /This(?: commit) fixes/ is likely to be a fix;

Perhaps a regexp could be configured that marks a commit message as being a fix?

>   - a commit that touches the same vicinity of another commit after a
>     short interval is likely to be a fix;

Do you mean with "touches the same vicinity " something like "edits
code within 5 lines and within 5 commits of a commit x"?

>   - a commit that is made on 'maint' branch by definition is a fix;

Either a list of branches that are maintenance branches or a regexp
would be in place again I think.

>   - a commit that changes test_expect_failure to test_expect_success have
>     a high probability that it itself is a fix, or it comes soon after a fix;

I'm not sure I understand this but that's probably because I'm not yet
familiar with git's testing suite.
Do you think a general rule to identify changes like this can be made?

>   * For the integrator, can you spot a pattern like "what he accepts
>     during weekdays tend to be buggier than what he applies during
>     weekends"?

That would be interesting data, I think a nice graph could be made
easily, showing a column for weekdays (or one for each day) and a
column for weekends (or one for each day). Each column could then
represent the amount of buggy commits / day, or perhaps the ration
buggy/enhancements. This histogram could then go back several weeks to
give a better picture.
Perhaps a line style graph with two lines could be made, one for the
weekends and one for the weekdays, or seven lines, one for each day.
That way it would be easy to track if the integrator is getting better
at his job, or that he is perhaps having a bad/good period lately.

>   * For each contributor, can you spot a pattern like "his late night
>     commits are buggier than his early morning commits"?

This would be a 'fun feature' again I think, although it could of
course be used to decide that 'late night commits' of this contributor
should be examined more carefully.

>   * Can you spot a pattern like "his changes to this area tends to be
>     buggy but to that area tends to be very good"?

This would require connecting commits to area's, that is, track what
area's the buggy commits apply to. Maybe instead of tracking this on a
commit basis a per-file basis might be more interesting. That is,
don't just track if a commit is buggy, but also if a specific change
to a certain file is buggy. Doing so would allow for more careful
tracking of the area's a developer provides good work in.

>   * Who tends to introduce more bugs, who tends to do more fixes than
>     enhancements?

The former is an confronting yet interesting statistic, something that
could best be presented in a pie chart or such. The latter could be
shown as a bar chart in which each bar is divided into three parts
'buggy', 'fixes', and 'enhancements', with one bar per contributor.

>   * Is their correlation between being a day-job contributor and being
>     more fixer than bug-introducer?

This would require information about whether a contributor has a day
job, although this might be inferred from the commit times feature
mentioned earlier. It might be nice to have this feature to help
decide what kind of work to assign a contributor to (in the case that
contributors are assigned a task).


The question now though, is which of these features are feasible to do
in one GSoC project? That is, which one should be done first, as I
want to finishing this feature even if I can't finish it all in three
months. Should this be something that is decided in the application
already, or should I list all the features and then later on decide
(with the aid of the community) which ones to implement first.

Thank you for your suggestions, this is starting to be very interesting indeed!

Sverre
