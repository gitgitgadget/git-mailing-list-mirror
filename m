From: Sean <seanlkml@sympatico.ca>
Subject: Re: how to use git merge -s subtree?
Date: Tue, 8 Jan 2008 00:34:55 -0500
Message-ID: <BAYC1-PASMTP152065390CFAF8C09F0B60AE480@CEZ.ICE>
References: <20080105230004.GY29972@genesis.frugalware.org>
	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
	<flpah7$beg$2@ger.gmane.org>
	<BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
	<47803CB6.4050102@gmx.net>
	<7vir277jz6.fsf@gitster.siamese.dyndns.org>
	<BAYC1-PASMTP1079A31936B4563801537DAE4E0@CEZ.ICE>
	<7vlk71z6sd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 06:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC77X-0002GQ-Lp
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 06:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbYAHFe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 00:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbYAHFe7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 00:34:59 -0500
Received: from bay0-omc2-s41.bay0.hotmail.com ([65.54.246.177]:10126 "EHLO
	bay0-omc2-s41.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286AbYAHFe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 00:34:58 -0500
Received: from BAYC1-PASMTP15 ([65.54.191.189]) by bay0-omc2-s41.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 7 Jan 2008 21:34:58 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP15.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 7 Jan 2008 21:34:57 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JC76u-0007zb-Qx; Tue, 08 Jan 2008 00:34:48 -0500
In-Reply-To: <7vlk71z6sd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 08 Jan 2008 05:34:58.0223 (UTC) FILETIME=[34D473F0:01C851B8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69839>

On Mon, 07 Jan 2008 13:04:34 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> That's asking for the history of a _path_ (or subset defined by
> paths, as in "what changes were made to paths under 'arch/'"),
> which is very different from asking "I have B/foo.c -- show me
> the history of that _file_".
> 
> Remember, David stated:
> 
> >> ... So you cannot do git-log B/foo.c as git doesnot know where
> >> to search it as it thinks it is in /foo.c not in B/foo.c ...
> 
> Notice "as git does not know where to search it" part?
> 
> Think --- what does that "it" refer to in that sentence?
> 
> The statement is not about paths.  If it were about paths, then
> the output of "git log B/foo.c" does show what he wants.  The
> question "git log B/foo.c" asks is "what change were made to the
> path at B/foo.c".  The changes made to B/foo.c (i.e. what's
> shown with the diff headers that begin with "--- a/B/foo.c") are
> shown.  The changes made to foo.c are not shown.
> 
> But that is different from what David is asking.  He wants to
> know what changes were made to B/foo.c or to foo.c, and wants to
> make the choice between the two depend on commit.  The reason
> you think you can pick between foo.c and B/foo.c is because
> there is an illusion that somehow there is an i-node like file
> identity that is kept track of, and it is preserved across
> renames and merges.
> 
> That's keeping track of the history of a _file_.
> 
> And as you know, git doesn't do that.
> 
> What git does is to keep track of the history of the whole tree,
> but prune the parts that are not interesting away when you view
> the history.  And the pruning can be specified by _PATH_.
> 
> See the difference?
> 

Junio,

Thanks for taking the time to answer, I know you're busy with much more
pressing issues getting 1.5.4 out the door.  You make the distinction
between paths and files quite clear, and why it's important to keep in
mind.

In the case of the "--follow" option though, the user might be forgiven
for thinking in terms of files rather than paths.  Even the git-log
documentation says for "--follow", "Continue listing the history of a
file beyond renames".   Which at least implies that Git knows about
file history, rather than just paths.

It's reasonable for a user to expect "git log --follow B/foo.c" to do
The-Right-Thing in the subtree merge case.  But I recognize that it would
actually be rather difficult to implement, perhaps making it impractical.

Cheers,
Sean
