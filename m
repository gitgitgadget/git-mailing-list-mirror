From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 13:48:58 +0100
Message-ID: <49255CBA.4030709@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <C33ABF98-2E52-4928-BF79-CB3B6A8460DB@feinheit.ch> <49252204.2070906@op5.se> <20081120112051.GB22787@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Kestenholz <mk@feinheit.ch>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 13:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L38z8-0007do-4l
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbYKTMs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbYKTMs7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:48:59 -0500
Received: from mail.op5.se ([193.201.96.20]:53456 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbYKTMs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:48:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F016C1B8005E;
	Thu, 20 Nov 2008 13:44:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ZAo4eSV+qu4; Thu, 20 Nov 2008 13:44:01 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2511C1B80053;
	Thu, 20 Nov 2008 13:44:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081120112051.GB22787@ravenclaw.codelibre.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101416>

Roger Leigh wrote:
> On Thu, Nov 20, 2008 at 09:38:28AM +0100, Andreas Ericsson wrote:
>> Matthias Kestenholz wrote:
>>> Hi,
>>>
>>> On 19.11.2008, at 12:37, Roger Leigh wrote:
>>>
>>>> I'm using git to store some generated files, as well as their sources.
>>>> (This is in the context of Debian package development, where entire
>>>> upstream release tarballs are injected into an upstream branch, with
>>>> Debian releases merging the upstream branch, and adding the Debian
>>>> packaging files.)
>>>>
>>>> The upstream release tarballs contains files such as
>>>> - yacc/lex code, and the corresponding generated sources
>>>> - Docbook/XML code, and corresponding HTML/PDF documentation
>>>>
>>>> Would it be possible for git to store the mtime of files in the tree?
>>> This subject comes up from time to time, but the answer always
>>> stays the same: No. The trees are purely defined by their content, and
>>> that's by design.
>>>
>>> If you do not want to regenerate files that are already up-to-date,
>>> you need multiple checkouts of the same repository.
>> Or a make-rule that touches the files you know are up to date. Since you
>> control the build environment, that's probably the simplest solution.
> 
> This is the approach I'm currently taking, since it's simple and
> doesn't require any tool changes.  Ideally, I'd like to avoid
> such hackiness, though.
> 
> I understand all the arguments I've seen in favour of not using the
> mtime of the files when checking out.  They make sense.  However,
> in some situations (such as this), they do not--git is breaking
> something that was previously working.  In my case, I'm
> injecting *release tarballs* into git, and the timestamps on the
> files really do matter.  Regarding issues with branching and branch
> switching, I always do builds from clean in this case.
> 
> If an option was added to git-checkout to restore mtimes, it need
> not be the default, but git could record them on commit and then
> restore them if asked /explicitly/.
> 

You can. The way to ask explicitly right now is to write hooks
that implement the functionality you want. It's not as easy as
setting a config value, but since you'd have to write the patch
to do that anyways (and it's likely it will get dropped), you'd
be better off writing some hooks and submitting them as contrib
stuff.

> For this, and some other uses I have in mind for git, it would be
> great if git could store some more components of the inode
> metadata in the tree, such as:
> - mtime
> - user
> - group
> - full permissions
> - and also allow storage of the full range of file types (i.e.
>   block, character, pipe, etc.)
> 
> This would allow git to be used as the basis for a complete
> functional versioned filesystem (which I'd like to use for my
> lightweight virtualisation tool, schroot, which currently
> uses LVM snapshots for this purpose).
> 

I believe someone else has done some work along the way of
turning git into complete-with-metadata backupsystem before.
Google might prove beneficial.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
