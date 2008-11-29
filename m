From: "Ian Clarke" <ian.clarke@gmail.com>
Subject: A better approach to diffing and merging
Date: Sat, 29 Nov 2008 12:12:05 -0600
Message-ID: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 19:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6UJt-0002GZ-88
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 19:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYK2SMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 13:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYK2SMH
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 13:12:07 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:7230 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYK2SMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 13:12:06 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1938285wfd.4
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=OsKjDGLEre9Fi1wzuWiaJelDXZVXTCiRkOHQjPWr4cY=;
        b=Ly6/FlbDHPbKRW06obKUUXpwZtTQivbyw1JDyMEKQGNzbYR+YaaWlDovHVEqe5enw1
         e4HHKiuciGQg21vHXVFjjT4RJ6C1PlF49keMULcW8PZeivrftbR6aXrGbX6kaNEAdbBf
         UY/OhASv0/Ln3LjiCHVIGAsKRi6GlZPmOwROY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=MTA+kk7uh4tIohu2IfDwfFo72EbNygmsLfMxJY6vGUyPt7N2z8mni7K+9PW00Kb348
         PykyVUnetqwUDmrSYnXQzjgsTApyjMsB8vYTVdXeJeASU6hDv7fsgMScgDRUomu1cyu+
         5rw7FfqBvnX0HZPaFvE8bqVuLTN3zRXIGzlYA=
Received: by 10.142.51.4 with SMTP id y4mr3821607wfy.52.1227982325747;
        Sat, 29 Nov 2008 10:12:05 -0800 (PST)
Received: by 10.142.223.9 with HTTP; Sat, 29 Nov 2008 10:12:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101921>

Apologies if this is off-topic, but I recently had an idea for a
better way to do diffs and merging which I thought may be of interest
to those on this list.

I described it in a blog entry here: http://budurl.com/jyt6

For your convenience text is pasted below (although missing a few hyperlinks):

A plan for better source code diffs and merging
======================================

I've been using Subversion for years, but a few months ago I was
really starting to feel the limitations of being able to create and
merge branches easily. I'd heard that Git made this very easy indeed,
and so I decided to try it.

Anyway, this isn't yet another "I discovered Git and now I've achieved
self-actualization" blog post, so to cut a long story short, I now use
git for everything (together with the excellent GitHub).

Even though merging is a lot better with Git than Subversion, I've
still found myself getting into situations where it requires a lot of
work to merge a branch back into another branch, and it got me
thinking about better ways to do merging.

While I'm no merging expert, it seems that most merging algorithms do
it on a line-by-line basis, treating source code as nothing but a list
of lines of text.  It got me thinking, what if the merging algorithm
understood the structure of the source code it is trying to merge?

So the idea is this:

Provide the merge algorithm with the grammar of the programming
language, perhaps in the form of a Bison grammar file, or some other
standardized way to represent a grammar.

The merge algorithm then uses this to parse the files to be diffed
and/or merged into trees, and then the diff and merge are treated as
operations on these trees.  These operations may include creating,
deleting, or moving nodes or branches, renaming nodes, etc.  There has
been quite a bit (pdf) of academic research on this topic, although I
haven't yet found off-the-shelf code that will do what we need.
Still, it shouldn't be terribly hard to implement.

The beauty of this approach is that the merge algorithm should be far
less likely to be confused by formatting changes, and much more likely
to correctly identify what has changed.

I can't think of any reason that such a tool wouldn't work in the
exact same way as existing diff/merge tools from the programmer's
perspective. The tool would automatically select the correct grammar
based on the file extension, or fall-back to line-based diffs if the
extension is unrecognized (or the file isn't valid for the selected
grammar). Thus, it should be trivial to use this new tool with
existing version control systems.

I'd love to have the time to implement this, although regretfully it
is at the bottom of a very large pile of "some day" projects.  I think
this is an interesting enough idea, and one that would be immediately
useful, that if I put it out there someone somewhere might be able to
make it a reality.

Any takers? I've set up a Google Group for further discussion, please
join if interested.
