From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Custom git completion
Date: Fri, 29 Jan 2010 09:59:50 -0800
Message-ID: <20100129175950.GE21821@spearce.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com> <20100129151127.GA21821@spearce.org> <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rhodes Clymer <david@zettazebra.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nav8Y-0005L3-Ja
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0A2R7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 12:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275Ab0A2R7z
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 12:59:55 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:50956 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab0A2R7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 12:59:54 -0500
Received: by qyk12 with SMTP id 12so998724qyk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 09:59:53 -0800 (PST)
Received: by 10.229.23.74 with SMTP id q10mr401239qcb.63.1264787993397;
        Fri, 29 Jan 2010 09:59:53 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm1576735qyk.0.2010.01.29.09.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 09:59:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138331>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > David Rhodes Clymer <david@zettazebra.com> wrote:
> >> Unless I read it incorrectly, the completion script included with
> >> git-core does not make it easy for users to write completion scripts
> >> for custom git commands. I can extend git itself by creating a command
> >> "git-foo", and placing it in my path.
> >
> > git config --global alias.foo /home/me/bin/my-git-foo
> >
> > git foo will now complete correctly.  No need to modify the
> > completion code.
> 
> Yes.  Aliases and custom subcommands are found from 'git help" output just
> fine (you need to install new subcommand in exec-path).
> 
> But.
> 
> How does the completion code learn what options and arguments such aliases
> and subcommands (e.g. "git foo") take without being told?

Sure.  But the patch offered by the original poster also suffered
from this problem, it didn't know how to complete arguments for
the subcommand.

 
> An alias that uses another git subcommand (i.e. the ones that do not start
> with a bang "!") seems to be handled correctly, but one of my aliases is
> this:
> 
>     [alias]
> 	lgm = "!sh -c 'GIT_NOTES_REF=refs/notes/amlog git log \"$@\" || :' -"

Doing this is difficult, because its hard to parse that string and
do completion on it.  On the other hand, we could do something like:

  [completion]
  	lgm = log

and have `git lgm` complete using the same rules as `git log`.
Its somewhat ugly though...
 
-- 
Shawn.
