From: Johan Herland <johan@herland.net>
Subject: Re: Notes in fast import stream.
Date: Sun, 29 May 2011 22:20:40 +0200
Message-ID: <201105292220.41322.johan@herland.net>
References: <BANLkTinpQ6HbTdNF8K5N0D3aYugj591LRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <sylvain.boulme@imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 22:20:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQmTi-0003TA-0M
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 22:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab1E2UUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 16:20:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49543 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1E2UUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 16:20:44 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLZ007LT4IIAQ60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 29 May 2011 22:20:42 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 795991EA5525_DE2AA9AB	for <git@vger.kernel.org>; Sun,
 29 May 2011 20:20:42 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5E99B1EA2AC8_DE2AA9AF	for <git@vger.kernel.org>; Sun,
 29 May 2011 20:20:42 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLZ0095U4III830@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 29 May 2011 22:20:42 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTinpQ6HbTdNF8K5N0D3aYugj591LRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174703>

On Sunday 29 May 2011, Arnaud Lacurie wrote:
> Hi,
> 
> I would like to add notes through a fast-import stream.
> The problem is that I can't know the SHA1 of the commit I would like
> to add a note to before the fast-import is done.
> I would like to use marks to link my note to a commit this way :
> 
> 
> commit refs/heads/master";
> mark :1
> committer user <user@example.com> GMT+0000
> data length_of_my_comment
> my_comment
> M 644 inline my_file
> data length_of_my_file
> my_file_content
> N inline :1
> data my_note_length
> my_note_content
> 
> This doesn't work because the mark 1 declaration is not finished, and
> I can't bind a note to it yet.
> 
> How could I do then ?

First, you should realize that even though the notes are "conceptually" tied 
to a commit (or any other type of Git object), the note objects are 
_technically_ independent from the annotated objects. In fact, the note 
objects live on a separate ref with a wholly separate history. In other 
words, it does not make sense to define the note in the very same 'commit' 
command that you're trying to annotate. Instead, you should organize it 
something like this:


commit refs/heads/master
mark :1
committer user <user@example.com> GMT+0000
data length_of_my_comment
my_comment
M 644 inline my_file
data length_of_my_file
my_file_content

commit refs/notes/commits
committer user <user@example.com> GMT+0000
data length_of_dummy_comment
dummy_comment
N inline :1
data my_note_length
my_note_content


(Obviously, you can add notes for several commits in a single "commit 
refs/notes/commits" command).


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
