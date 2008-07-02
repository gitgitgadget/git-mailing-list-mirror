From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 21:36:20 -0400
Message-ID: <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
	 <20080701095117.GC5853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 03:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDrHf-0005sl-Aj
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 03:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbYGBBg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 21:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755201AbYGBBg0
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 21:36:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:43248 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYGBBgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 21:36:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so72558ywe.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gWde4edh+QBVYD1/ALbD1zOLfPSxLDjBk74W45XKa/E=;
        b=t9Gy9Ot2kQ0l5W6MLaLGmChRS9RSkFgTadbr2PxwBlC+L60ylIk3y+kKCHyxifRArJ
         Uioh0xnNoHLVm8CaQ5F54oSUkVjJbAtuwf2D4VbuhxfbIVrhofe5AlwT/HEqUlAizU5e
         hojUdrWdEKZtI10cOKj/LZGjtEsQyxIL6uoSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xBQ50ldcyx+12fawuS/hw17o93rr0t68LKnixZ/gTN5Vp9F3lVQSnb3TrT4Szr4mg0
         XUP8AmEMWnlBBABOK35JfQTyWRt2eJTqe4F3l0aMT9Wf/5J2WKS5YWTMs6YNPgNZrBAZ
         gs3EOuml5WPSMykt3vi9uSVDxPFt0NywAD+NI=
Received: by 10.151.111.15 with SMTP id o15mr11641066ybm.166.1214962580242;
        Tue, 01 Jul 2008 18:36:20 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Tue, 1 Jul 2008 18:36:20 -0700 (PDT)
In-Reply-To: <20080701095117.GC5853@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87076>

Hi Jeff,

Thank you for your feedback.  I have made most of the code changes you
suggested, and am in the process of writing tests, but it looks like
some others on the list have more serious objections, so I'll hold of
on that until I think it might actually be accepted.

In the mean time, I have a couple of responses to your comments below.

>
> When a new feature depends on other, more generic improvements
> to existing code, it is usually split into two patches. E.g.,
>
>  1/2: add --stdin to git-bundle
>  2/2: add git-basis
>
> with the advantages that:
>
>  - it is slightly easier to review each change individually
>  - it is easier for other features to build on the generic improvement
>   without requiring part 2, especially if part 2 is questionable
>
> As it happens in this case, I think in this case the change was already
> easy to read, being logically separated by file, so I am nitpicking
> somewhat. But splitting changes is a good habit to get into.
>

Makes sense,  I thought it was small enough for one commit, but I'll
split it up when I resubmit.

>> +                               if (len && line[len - 1] == '\n')
>> +                                       line[--len] = 0;
>
> Style: we usually spell NUL as '\0'.
>

Okay.  I can also include a third patch for the code I cut-and-pasted.

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 11a7eae..73fe334 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -582,7 +582,7 @@ static void read_revisions_from_stdin(struct rev_info *revs)
        while (fgets(line, sizeof(line), stdin) != NULL) {
                int len = strlen(line);
                if (len && line[len - 1] == '\n')
-                       line[--len] = 0;
+                       line[--len] = '\0';
                if (!len)
                        break;
                if (line[0] == '-')


>> diff --git a/git-basis b/git-basis
>> new file mode 100755
>
> This should be git-basis.perl, with accompanying Makefile changes.
>
>> +if ( ! -d "$d/bases" ) {
>> +    system( "mkdir '$d/bases'" );
>> +}
>
> Yikes. This fails if $d contains an apostrophe. You'd want to use
> quotemeta to properly shell out. But there's no need at all to shell out
> here, since perl has its own mkdir call.
>

Made both of these changes.

>> +if ( $#ARGV == -1 ) {
>> +    print "usage: git-basis [--update] basis1...\n";
>> +    exit;
>
> Usage should probably go to STDERR.
>

Makes sense.

>> +    my %new = ();
>> +    while (<STDIN>) {
>> +       if (!/^^?([a-z0-9]{40})/) {next;}
>> +       $new{$1} = 1;
>> +    }
>
> Why make a hash when the only thing we ever do with it is "keys %new"?
> Shouldn't an array suffice?
>

It's probably a non-issue, but using a hash will prevent duplicates.

>> +    foreach my $f (@ARGV) {
>> +       my %these = ();
>> +       open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";
>
> Style: I know we are not consistent within git, but it is usually better
> to use local variables for filehandles these days. I.e.,
>
>  open my $fh, "<$d/bases/$f"
>

Okay.

>> +       open F, ">>$d/bases/$f" || die "Can't open bases/$f: $!";
>
> So the basis just grows forever? That is, each time we do a bundle and
> basis update, we add a line for every changed ref, and we never delete
> any lines. But having a commit implies having all of its ancestors, so
> in the normal case (i.e., no rewind or rebase) we can simply replace old
> objects if we know they are a subset of the new ones (which you can
> discover with git-merge-base). For the rewind/rebase case, probably
> these lists should get pruned eventually for non-existent objects.
>

If all goes well then you're right, but I thought old objects should
be kept around  in case the user has some reason to manually delete
them.  As it is, you can go into the basis file and delete everything
past a given date line and be back where you were.  If I delete the
redundant objects, then that's not always possible.

It'd be nice if it could prune old objects (maybe older than 6 months,
or settable by git-config) that are redundant, but I currently have no
need for such functionality.

I also hadn't thought about rebasing.  Objects that don't exist
shouldn't hurt anything though.  Just a waste of a little disk space.
If pruning is ever put in, objects that don't exist can be deleted.

> But maybe it is not worth worrying about this optimization at first, and
> we can see if people complain. In that case, it is perhaps worth a note
> in the 'Bugs' section (or 'Discussion' section) of the manpage.
>

Agree.  I put it under bugs.

>> +       print F "\#" . `date`;
>
> I don't think there are any portability issues with 'date' (especially
> since it appears to be just a comment here, so we don't really care
> about the format), but in general I think it is nicer to use perl's date
> functions just for consistency's sake.
>

Maybe I'm a idiot, but I can't find any built-in date to string
functions that do nice things like print the date the way the user
says he likes to look at dates.

I updated the comment line to be "# <git-date> // `date`" where
git-date is as per git-fast-import (seconds since 1969 +/-TZ).  If
automatic pruning ever happens, the git-date will be used, so `date`
is just for humans.

>
> Notably absent: any tests.
>

Working on those.  I'll also include tests for git-bundle.

Adam
