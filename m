From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 16:29:43 +0200
Message-ID: <864pirej6w.fsf@lola.quinscape.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 16:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INrE8-0006fS-P0
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 16:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763020AbXHVOaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 10:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759388AbXHVOaG
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 10:30:06 -0400
Received: from main.gmane.org ([80.91.229.2]:60828 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762678AbXHVOaC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 10:30:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INrDY-0003lh-58
	for git@vger.kernel.org; Wed, 22 Aug 2007 16:29:56 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 16:29:56 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 16:29:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:JOiGcXKFJhQd94UpN9s4FDnybi8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56383>

Andreas Ericsson <ae@op5.se> writes:

> David Kastrup wrote:
>> Carlos Rica <jasampler@gmail.com> writes:
>>
>>> This is the first version of the program "builtin-reset.c",
>>> intended for replacing the script "git-reset.sh".
>>>
>>> The --mixed option with -- paths is not implemented yet.
>>>
>>> The tests I made for it are not finished so they are not included,
>>> but it seems to pass the rest of the test suite.
>>
>> Could you be so kind as to give a one-sentence summary what the
>> benefits over using a shell script would be?
>
> One word: Portability.
>
> There's a plethora of various shell syntaxes. Discerning what's
> correct shell and what's a bash'ism that may or may not be posixly
> correct (but perhaps not supported on a multitude of out-of-the-box
> solaris system) has so far taken almost as much time as convincing
> newcomers to git that there really is no point in tracking file
> renames explicitly.
>
> Otoh, the list of large and renowned projects that have shunned git
> for its weak windows support grows longer, meaning we potentially
> lose competent programmers simply because they're forced to use
> something else.

The problem I see is that C sucks really really bad as a scripting
language, and tying together plumbing functionality into porcelain is
one of the most powerful, flexible and hack-friendly features of git.
Deprecating scripts is making git more opaque.

Personally, I would prefer an approach of using an embedded script
interpreter: then language incompatibilities become a non-issue.
git-busybox sounded like a great idea for portability.

When the Unix toolchain is not the main focus, a very interesting
language for such projects is Lua <URL:http://www.lua.org>.  It is
(among hundreds of other applications) used as a scripting,
programming and extension engine for LuaTeX (now in beta), the
designated PDFTeX successor.  It is very portable, efficient and
minimalistic, while being quite expressive at the same time.

>>  So unless there is some issue that can't be addressed reliably or
>> efficiently by reverting to other commands for everything involving
>> bulk processing, I am not really happy to see shell scripts
>> replaced.
>>
>
> It will happen, sooner or later. We may not like MS or their
> products, but sooner or later we'll have to cater to their users or
> face the problem of all the competent programmers helping out on
> some other SCM, because that other SCM works everywhere, while git
> doesn't.

I am just not sure that C is the ultimate solution since it makes
things harder to hack on.

I'd prefer to see some scripting abilities retained: many of the
recent advances in the porcelain (like rebase -i) would likely not
have happened if one would had to write them in C in the first place.

If the scripting engine of choice for cobbling together prototypes
remains the Unix toolchain outside of git proper, then Windows users
will _always_ remain second class citizens since they will get to work
with and on new porcelain much later than the rest of the world:
namely when somebody bothers porting his new favorite tool for them to
C.

-- 
David Kastrup
