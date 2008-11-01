From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Sat, 1 Nov 2008 14:27:03 -0600
Message-ID: <51419b2c0811011327j492b520dq2388fc8972b48cab@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <1225389068.19891.28.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org,
	"Sam Vilain" <samv@vilain.net>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:28:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwN56-0006pd-NB
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYKAU1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYKAU1H
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:27:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:65412 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYKAU1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:27:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1871381rvb.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FMCkzjHTtw9wEAThl1vc51tGl0CAtPyfDclJPBpDuCE=;
        b=VMVjUrDjem1O1zzwZHBmPkgB4O3LKNF+FtYN2osJjTneVBDsTfhFJm/04iEpi1OPdN
         qI1PthA9ykJwyqNuRGrY1rV6Tx/JXg/5owMXAmd4Z2RUoscFQ7o9ZeL9igfTP/e/c9oQ
         GY8eaDJXRZIVt00YTvXWdfw3pLOvMQho+akfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KoJzaI35aMi08D3zWlN5ZjDBT4xnpVAU9zUjkOdi/COtm8fTDXpHe8yYDdFt1mxvw3
         BphDWOJHqqwcoJ2Ln/KoS1ux0MP64yiKiGZM8kjfFdLGWvoFCfg3SOwZcouuGdHYlFf1
         fvsYsiViaiNqPW/TummbYpDn+kOhwV7fykdC8=
Received: by 10.141.82.20 with SMTP id j20mr7694121rvl.234.1225571223812;
        Sat, 01 Nov 2008 13:27:03 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Sat, 1 Nov 2008 13:27:03 -0700 (PDT)
In-Reply-To: <1225389068.19891.28.camel@maia.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99772>

Hi,

(Sorry for sending so many emails, and being late to the conversation.
 There's a couple others that I wanted to respond to but I'll wait off
on those and finish with this email to avoid spamming everyone any
more right now.)

On Thu, Oct 30, 2008 at 11:51 AM, Sam Vilain <sam@vilain.net> wrote:
> Well, I don't have strong feelings on the exact command name used; I
> suggested "undo", probably also ambiguous.  But still, a significant
> number of users are surprised when they type 'git revert' and they get a
> backed out patch.  It's such an uncommon operation, it doesn't deserve
> to be triggered so easily.  And reverting files to the state in the
> index and/or HEAD is a common operation that deserves being short to
> type.
>
> Making it plain "revert" would violate expectations of existing users;
> it seems a better idea to just deprecate it, and point the users to the
> new method - cherry-pick --revert - or the command they might have meant
> - whatever that becomes.

There is another option, though it has its own problems too.  There
are basically two kinds of reverting here -- reverting all the changes
*in* a given revision (which I'll called 'revert-in') and reverting
all the changes *since* a given revision (typically HEAD; I'll call
this 'revert-since').  These two operations can be supported from the
same command, though their use cases are different enough that it may
seem slightly weird:

     revert-since                        revert-in
     * is usually used in a dirty tree   * is typically used in a clean tree
     * specific paths are usually        * specific paths are not often
       specified                           specified
     * it is rare to want to commit      * making a commit after reverting
       immediately after reverting         is what you usually want
     * it is uncommon to need to
       specify a revision

I decided to combine them in EasyGit, simply because that made things
the most discoverable for both existing git and svn/bzr/hg users.  The
big problem here is that --commit is turned on by default when --in is
specified, and --no-commit is the default when --since is specified.
Anyway, some examples:

eg revert REVISION   =>   Error -- you must specify either --since or
--in when specifying a revision
eg revert --in REVISION  =>  Same as git revert REVISION
eg revert --since HEAD FILE1 FILE2  =>  Same as svn revert FILE1 FILE2
eg revert FILE1 FILE2  => shorthand for the previous command; --since
HEAD is default when no revision is specified
eg revert --since HEAD~3 SUBDIRECTORY => should be clear; an extension
over what svn revert can do

Then there's also the possibility that users only want to revert
unstaged changes, or only want to revert staged changes...


Anyway, just some food for thought.  I've spammed the list enough in
this thread, so I'll break for now.  Thanks for listening.

Elijah
