X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Fri, 01 Dec 2006 14:31:45 -0800
Message-ID: <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 22:31:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> (Nicolas Pitre's
	message of "Fri, 01 Dec 2006 15:06:20 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32976>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGv8-0004F1-86 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162115AbWLAWbr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162118AbWLAWbr
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:31:47 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17611 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1162115AbWLAWbq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:31:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201223146.UDMY296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 17:31:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id taXu1V00q1kojtg0000000; Fri, 01 Dec 2006
 17:31:55 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> I personally think this is going to make the GIT experience lot more 
> enjoyable for everybody.  This brings the power of the index up front 
> using a proper mental model without talking about the index at all. See 
> for example how all the technical discussion has been evacuated from the 
> git-add man page.

I like the direction this is taking us.

The documentation update is in the same spirit with the sample
rewrite of 'git diff' manpage.  We might want to tweak the
wording to make this round of documentation updates consistent.

My preferences:

 - You used the word "changeset"; I am not sure that is a good
   wording.  The recent explanation I saw on the list and liked
   were "you _stage_ your changes to prepare for the next
   commit (footnote: the staging area is called 'the index')".
   My impression was that both extremes (Linus and Carl) are
   also Ok with this wording.

 - We keep the word "index", and not reword it to "stage" in the
   names of commands and options.  "to stage" is very good verb
   to explain the _concept_, but there is no need to use
   inconsistent wording Porcelain-ish and plumbing use to
   describe the entity used for staging.

   (1) New people need to learn the new concept anyway, and they
       are intelligent enough to learn what that new concept has
       been called for a long time in git-land at the same time.

       "The index" is the receiver of new contents to be staged;
       conversely, "to stage" is the act of registering contents
       to the index.

   (2) Majority of git old timers do not follow git mailing list
       discussion closely.  They already know the concept of
       "registering thing in the index".  We on the list are
       just about to agree to give a good short name, "to
       stage", for that action they have known about, in order
       for us to make it easier to explain to new people.  That
       should not affect the terminology the old timers are
       accustomed to and and trained their fingers with
       ("update-index", "diff --cached", "apply --index").

   (3) I hope nobody proposes to rename "update-index" to
       "update-stage" nor "diff-index" to "diff-stage"; that
       would break countless number of existing third party
       scripts old timers rely on and even new people would find
       on the web and tempted to try out, so plumbing level
       commands and options have to keep using the word 'index'.
       The option to 'git diff --cached' may need a new synonym
       to make things consistent, but the new synonym should be
       --index, not --staged.

   (4) New people will not stay newbies forever.  Using a
       consistent word for the entity used for staging for the
       next commit across Porcelain and plumbing is important.

> maybe add a -f/--force argument to allow for adding ignored files 
> instead of going through git-update-index.

Yup.

> maybe add --new-only and --known-only arguments if there is a real need 
> to discriminate between new vs updated files.  I would not suggest 
> against it though, because if someone really has such fancy and uncommon 
> requirements he might just use git-update-index directly at that point.

Borrow from "update-index --again", perhaps?

> +Contrary to other SCMs, with GIT you have to explicitly "add" all the
> +changed file content you want to commit together to form a changeset
> +with the 'add' command before using the 'commit' command.

... "before a new commit is made"; it is not an offence to leave
local changes outside the index.  Staging such changes to all
files is done using the "-a" flag and that is done "before a new
commit is made", but not "before using the 'commit' command" --
it is done at the same time.

> +This is not only for adding new files.  Even modified files must be
> +added to the set of changes about to be committed. This command can
> +be performed multiple times before a commit. The 'git status' command
> +will give you a summary of what is included for the next commit.
> +
> +Note: don't forget to 'add' a file again if you modified it after the
> +first 'add' and before 'commit'. Otherwise only the previous added
> +state of that file will be committed. This is because git tracks
> +content, so what you're really 'add'ing to the commit is the *content*
> +of the file in the state it is in when you 'add' it. Of course there are
> +legitimate usage cases for not updating an already added file content
> +in order to commit a previous file state, but in this case you better
> +know what you're doing.

May be we could hint the reader that a faster-to-type
alternative exists here.  Perhaps...

        Note: instead of doing 'git add' to stage the modified contents,
        you can ask 'git commit' to take all the modified contents in
        the working tree and stage them all before creating a commit
        with 'git commit -a'.

> +GIt tracks content not files

s/I/i/

> +But here's a twist. If you do 'git commit <file1> <file2> ...' then only
> +the  changes belonging to those explicitly specified files will be
> +committed, entirely bypassing the current "added" changes. Those "added"
> +changes will still remain available for a subsequent commit though.
> +
> +There is a twist about that twist: if you do 'git commit -i <file>...'
> +then the commit will consider changes to those specified files _including_
> +all "added" changes so far.
> +

I think there is another twist more deserving of mention than -i twist.
If you jump the index using --only, what is committed with that
commit becomes part of what is staged for the commit after that,
and in order to prevent data loss, we disallow this sequence:

	$ git checkout
	$ edit foo
        $ git add foo ;# your new add to update the existing entry.
	$ edit foo
        $ git commit foo

If we did not have the second edit (the behaviour is the same if
we did not have "git add foo" there), this commit:

 * commits the changes to 'foo' (not because you staged it
   earlier with 'git add', but only because you said "commit
   foo" to invoke the '--only' semantics), obviously;

 * updates 'foo' in the index to what was committed.

So if we allowed the above sequence to succeed, we would commit
the result of the second edit, and after the commit, the index
would have the result of the second edit.  We would lose the
state the user wanted to keep in the index while this commit
jumped the index, and that is why we disallow it.

> +But for instance it is best to only remember 'git add' + 'git commit'
> +and/or 'git commit -a'.
> +
> +No special command is required when removing a file; just remove it,
> +then tell `commit` about the file as usual.

I wonder if this sequence should do the same as "git rm -f foo":

	$ /bin/rm foo
        $ git add foo

That's one of the reasons I suggested 'checkin' instead of
'resolve', 'resolved', etc.  You check-in the removal of the
content from that path to the staging area, to go as a part of
the next commit.

> diff --git a/builtin-add.c b/builtin-add.c
> index febb75e..b3f9206 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -94,9 +94,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
>  
> -	if (read_cache() < 0)
> -		die("index file corrupt");
> -
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  
> @@ -131,6 +128,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  
> +	if (read_cache() < 0)
> +		die("index file corrupt");
> +
>  	for (i = 0; i < dir.nr; i++)
>  		add_file_to_index(dir.entries[i]->name, verbose);
>  

Hmph.  Fair enough.

> diff --git a/wt-status.c b/wt-status.c
> index de1be5b..4b8b570 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -163,7 +163,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
>  	int i;
>  	if (q->nr)
>  		wt_status_print_header("Changed but not updated",
> -				"use git-update-index to mark for commit");
> +				"use git-add on files to include for commit");
>  	for (i = 0; i < q->nr; i++)
>  		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
>  	if (q->nr)

"use git-add to mark for commit, or use commit -a"?

I think the one source of confusion is "update-index" sounds as
if it is a command to "update the index" and as if you can leave
out "with what?" part to complete the order to the command.

We can use the word "add", thanks to your patch that enhances
the user level command, and I do not think the word "add" would
not induce that confusion.  It is more obvious that you have to
say "what to add".

