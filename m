From: David Kastrup <dak@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 10:57:59 +0200
Message-ID: <86d4vgpxew.fsf@lola.quinscape.zz>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
	<E1IhIwR-0006be-Ki@fencepost.gnu.org>
	<Pine.LNX.4.64.0710150936070.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 11:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLnl-0005oE-6V
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 10:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbXJOI7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 04:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbXJOI7n
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 04:59:43 -0400
Received: from main.gmane.org ([80.91.229.2]:53949 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbXJOI7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 04:59:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IhLn1-00027c-VT
	for git@vger.kernel.org; Mon, 15 Oct 2007 08:59:07 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 08:59:07 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 08:59:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <Pine.LNX.4.64.0710150936070.25221@racer.site> (Johannes Schindelin's message of "Mon\, 15 Oct 2007 09\:44\:12 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:kIbxfpXMhLt8VzW3oWm7+OwjcBQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60965>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 15 Oct 2007, Eli Zaretskii wrote:
>
>> > Date: Mon, 15 Oct 2007 00:45:47 +0100 (BST)
>> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> > cc: Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, tsuna@lrde.epita.fr, 
>> >     git@vger.kernel.org, make-w32@gnu.org
>> > 
>> > The problem is not so much opening, but determining if an existing file 
>> > and a file in the index have the same name.
>> > 
>> > For example, "README" in the index, but "readme" in the working directory, 
>> > will be handled as "deleted/untracked" by the current machinery.  IOW git 
>> > will not know that what it gets from readdir() as "readme" really is the 
>> > same file as "README" in the index.
>> 
>> That's because you think file names are simple strings and can be
>> compared by simple string comparison.
>
> Almost...
>
>> This na?ve view is not true even on POSIX systems: "foo/bar" and 
>> "/a/b/foo/bar" can be the same file, as well as "/a/b/c/d" and "/x/y/z", 
>> given the right symlinks.
>
> ... not quite, ah ...
>
>> But for some reason that eludes me, people who are accustomed to POSIX
>> stop right there and in effect say "file names are strings, if we only
>> make them absolute and resolve links".
>
> ... yes!  There you have it.  Absolute filenames, resolved by
> readlink() are assumed to be the unique (!) identifiers for the
> contents.

They aren't.  One can mount the same file system several times in
different places.  In Linux, one can even mount directories and files
to several places at once.  Most Unices also support some
case-insensitive file systems, and readlink does not canonicalize the
casing.

> _Note:_ absolute paths _without_ readlink() resolving are _still_
> unique identifiers; this time for files/symlinks.

Not even that.  A unique identifier for files would imply that
touching the file does not affect, say, the access times of files with
other unique identifiers.

-- 
David Kastrup
