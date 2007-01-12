From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 06:41:21 -0700
Message-ID: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 12 14:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Mer-0007yh-Lt
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 14:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbXALNlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXALNlX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 08:41:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:41083 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXALNlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 08:41:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so840167wxd
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 05:41:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JWFST9d5eIZRndIxRW4W9NXXwOL9yNUuB/6UizqxphhC+YYGPA5OLbC7Zd0Zcoks+TiUuoifIbO0raCMBZ+D+SwCc+G6OH94j1FVVSXqP9ktMAjJ6j9AUJbpXRYRaf1QqxP/tOBg8INLNMLIuW9BnjG9DKZiRfRnvAcTrMo0h1Y=
Received: by 10.70.115.17 with SMTP id n17mr1303948wxc.1168609281642;
        Fri, 12 Jan 2007 05:41:21 -0800 (PST)
Received: by 10.70.61.5 with HTTP; Fri, 12 Jan 2007 05:41:21 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36671>

Hi, folks.

I've got a very, very old codebase I'm trying to wrap my head around.
It was apparently once tracked with RCS, but the ,v files are long
gone and all that remains are a series of tarballs on an FTP site
containing alpha, beta, and final releases of various versions of the
project.  There's a logical progression, but between each there are
new files, deleted files, and lots of changed files.  gitk will at
least help me make sense of the actual changes.  I've got part of a
shell script to automate this process.

Here's the problem.

I have tried to follow the debate on git add, rm, commit -a, etc.  But
I can't figure out how to simply say, take the full state of the
working directory, and make the index directly reflect that state.
Additions, removals, and differences alike.  One step, preferably.

My 2 cents on recent UI changes: I'm quite uncertain about the correct
(future 1.5.0) way of handling this kind of change to the index.  To
elaborate:

First, specifying extra files after 'git commit' bypasses the index.
If I remove foo.txt, and want to make a new commit reflecting only
that removal, would 'git commit foo.txt' do what I mean?  Apparently
so; I had to test it to find out, though.  It is a little surprising.

Using the 'add' command to really mean 'record the state of this file'
is confusing.  It makes me think of CVS's add (predictably), which
makes note of a new file and I think, "Well, I read on the list that
this is just another kind of 'adding content to the index,' right?"
Okay, I can accept that.  But using the 'git add .' idiom makes me
wonder whether the subdirectories are also supposed to be added, or
whether I need to worry about a recursive option.  Oddly, 'git pull .'
doesn't make me blink.  But then I need to remember to use 'git add'
to keep track of most changes in the index, new files and edits alike.
 I suspect a newbie coming from CVS might even use the word "re-add"
in their head to understand 'add'.

But this makes 'git rm' quite confusing.  After thinking I finally
understand 'git add', I think 'git rm' would mean "record the new
(nonexistent) state of this file in the index."  And then I'm
surprised to discover the file in my working directory actually
removed.  No, I guess I needed --cached.  Oops.  Wait a minute.
Cache?  The same cache mentioned in glossary.txt as being "Obsolete
for index?"

If rm is the opposite of add, shouldn't it work on the index by
default?  Hmm... "adding content to the index."  This file being
removed is new information that needs to be added to the index, like a
modification.  Removing a file is a kind of modification, after all.
I think this was the logic behind someone's suggestion of 'git add
--remove' which is quite ridiculous but follows somewhat naturally
from the idea that 'git add' is supposed to add information about
changes in the working directory to the index.

At this point, I think the behavior of 'git add' is as ridiculous as
that of 'git rm'.  Recent changes to 'git add' and 'git rm' make me
believe we're indecisive about whether we want people to think in
terms of the index or not.  I get the impression we're leaning towards
encouraging awareness of the index, because it's so helpful with
merges.

You know what I think we need?  A good command for updating the index.
 It could even be both porcelain and plumbing, if it had the right
error-checking.

I suggest calling it something like update-index.  ;)

Unless I'm completely misunderstanding git?

-- 
epistemological humility
  Chris Riddoch
