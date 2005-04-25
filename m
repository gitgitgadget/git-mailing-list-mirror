From: Andreas Gal <gal@uci.edu>
Subject: [FILE] GNU BIT
Date: Sun, 24 Apr 2005 23:24:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504242308460.6454@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1014985434-495267289-1114409739=:6454"
X-From: git-owner@vger.kernel.org Mon Apr 25 08:20:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPwwk-0001WF-6G
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 08:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVDYGYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 02:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVDYGYp
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 02:24:45 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:57518 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262292AbVDYGYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 02:24:25 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3P6OO9a006664
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 23:24:24 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3P6OOBm006660
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 23:24:24 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Git Mailing List <git@vger.kernel.org>
Content-ID: <Pine.LNX.4.58.0504242316140.6454@sam.ics.uci.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1014985434-495267289-1114409739=:6454
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0504242316141.6454@sam.ics.uci.edu>



               BIT - a little bit like SCM
   

BIT is a training exercise in shell programming and is the result of
my attempts to wrap my head around GIT's inner working. BIT's
command line interface should be very familiar to anyone who worked
with other(tm) SCM tools before. I try to not depend on custom 
GIT features. BIT uses the off-the-shelf GIT core tools distributed
by Linus. This means that BIT has about 2% of the features of
Cogito. Also, it has about 0.1% of the user base of Cogito, so its
probably very broken and I really don't recommend using it.

You can obtain BIT from the following GIT repository:

http://nil.ics.uci.edu/~gal/public/bit

You can use the GIT core utilities to pull and check-out BIT:

init-db
curl http://nil.ics.uci.edu/~gal/public/bit/HEAD > .git/HEAD
http-pull -a `cat .git/HEAD` \
    http://nil.ics.uci.edu/~gal/public/bit
read-tree `cat .git/HEAD`
checkout-cache -f -a

Naturally, you can also use BIT to pull the current sources, which
is much simpler:

bit clone http://nil.ics.uci.edu/~gal/public/bit

This will create a directory "bit", pull the latest sources and perform
a check-out for you.

INSTALLATION

Put "bit" anywhere in your search path. Its only a single bash script. It
requires a link "bit-resolve" to itself and the (soft) link should reside
in the same directory as "bit" itself. "bit" acts as merge script when
invoked through that link.

At this point, BIT's functionality is minimal. It does what I need it for.
I will obviously add more commands as we go along, but I won't touch
things like tags and stuff like that until Linus' makes up his mind how to 
do it *RIGHT*.

BASIC CONCEPTS

- BIT always checks out all files in your repository and it does so
  automatically. In other words, there is no "bit co" command. Not
  everyone will like this, but I do.
- You can't seek around in a repository. Checked-out files always
  match the HEAD revision. You can diff files against older versions,
  but if you want to check out an older version, you will have to
  clone the repository (see below).
  
TRACKING SOMEONE ELSE'S TREE  
  
$ bit clone http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/

(Note: Don't forget the '/' at the end, otherwise http-pull won't work.)

This command pulls Linus' latest GIT tree to a local repository "git.git".
You can change the latter by giving clone an additional argument.
  
$ bit clone http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/ \
    git-trunk
  
Once you have a copy of the remote repository, you can check whether there
are new changesets in the remote repository that you haven't seen yet:
  
$ bit changes -R \
      http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/
      
If you see any changes, you can merge them into your own tree:
  
$ bit pull http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/
      
BRANCHING

Now lets assume you want to work on an extension to GIT. For this, we will
clone the repository:
  
$ bit clone git-trunk git-bit
  
This will create a copy of the git-trunk repository and name it "git-bit".
The object directory is shared (using a soft link), which has the nice
benefit that once you run "bit pull" on one of the repositories, the
other one will be able to merge changes without any network traffic
(except for reading the current HEAD).
  
Lets say we make some changes to sha1_file.c and want to commit it to
our local repository "git-bit":
  
... edit sha1_file.c ...
  
In case we already forgot what file we edited, "bit pending" will tells us:
  
$ bit pending
sha1_file.c
  
Just in case we still can remember what we changed, there is "bit diffs",
which shows a diff to the current HEAD or any other version of our 
tree.
  
$ bit diffs
--- 28ad1598e54200ca8ee1261ed7beb4e31e20b2f1/sha1_file.c
+++ sha1_file.c
@@ -70,6 +70,7 @@
        int i;
        static char *name, *base;
 
+       /* added a cool new feature here */
        if (!base) {
                char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : ...
                int len = strlen(sha1_file_directory);
  
To commit our changes, we use "bit commit". It will fire up "vi" to ask for
a commit message.

$ bit commit
... enter commit message in vi ...

MERGING

Lets assume Linus' put out a new version of GIT, so we want to update both of
our repositories. First lets do this for "git-trunk".

$ cd bit-trunk
$ bit pull http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/

(Note: You have to specify the URL explicitly every time because there is no
 consensus yet where to store this information. Once thats sorted out, this
 will be automatic, of course.)
 
As this repository only tracks Linus' sources, there should be no conflicts.

Now lets go to our "git-bit" repository and do the same there:

$ cd git-bit
$ bit pull http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/

Because both repositories share the object directory, you will get away
with minimal network traffic. Conflicts are resolved using RCS merge. If
that fails, you have to edit the offending files yourself.

PUSHING PATCHES UPSTREAM

Lets assume we want to send our improvements to Linus. For this, we can
ask changes to show us all local changes in our repository:

$ bit changes -L \
      http://www.kernel.org/pub/linux/kernel/people/torvalds/git.git/
      
There is currently no mechanism in BIT to generate patches automatically,
but I will add one shortly. What is working already is that you can
push your repository to a remote location:

$ bit push ssh://gal@sam.ics.uci.edu/.nfs/public_html/public/git/

This will update the remote repository via SSH and set HEAD to point
to your latest version. Please note that you have to create a 
repository at the remote location using "init-db".

HELP

Try "bit --help" to get some simple instructions how to use BIT. All
commands have builtin help as well. Try "bit commit --help". Not all
options are always implemented. Feel free to send me a patch.
---1014985434-495267289-1114409739=:6454
Content-Type: APPLICATION/x-gzip; name="bit.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0504242324240.6454@sam.ics.uci.edu>
Content-Description: 
Content-Disposition: attachment; filename="bit.gz"

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
fYWju446D/8PHYJs3rtAAAA=

---1014985434-495267289-1114409739=:6454--
