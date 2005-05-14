From: David Greaves <david@dgreaves.com>
Subject: Re: [RFD] Ignore rules
Date: Sat, 14 May 2005 18:51:43 +0100
Message-ID: <42863AAF.7020506@dgreaves.com>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net> <20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com> <20050514153027.GN3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 19:53:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DX0p3-0002RB-5W
	for gcvg-git@gmane.org; Sat, 14 May 2005 19:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVENRxC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVENRxB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 13:53:01 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:11136 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262814AbVENRv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 13:51:56 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 16954E6DB7; Sat, 14 May 2005 18:50:22 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31455-14; Sat, 14 May 2005 18:50:21 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.206.89])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 49A27E6DB4; Sat, 14 May 2005 18:50:20 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DX0nf-0008O6-7h; Sat, 14 May 2005 18:51:43 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514153027.GN3905@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Here, I would like more people to speak up, plaese, especially the
>authors of other layers over git than Cogito, since I think it'd be
>great if we could agree on common ignore rules format and we could just
>call the files ".gitignore" instead of ".cgignore", ".jitignore" etc.
>
>
>Dear diary, on Sat, May 14, 2005 at 05:13:08PM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>I was wondering about supporting _both_ globs and re's
>>right now my ignore file has a # to precede comment lines
>>    
>>
>
>I assume \# will override that?
>  
>
doesn't match /^\w#/ so yes

>>maybe re: precedes regexp lines and unadorned lines are globs.
>>    
>>
>Or maybe even /, which is the common regexp prefix anyway...
>  
>
I thought about it but thought it would look strange since we won't want
a closing /
OTOH, no globs will start with a / since they have to be relative so
maybe a good choice after all.

>To mention it in this mail too, I think leading '!' should do the
>"ignore exclude" - that is, it would override any possible previous
>ignore decisions about the file. E.g. '!*' would throw away all
>previously applied ignore rules.
>  
>
Well, CVS has a lone ! meaning just that.
I wonder if we should simply say that most patterns are 'ignore' patterns.
'!' patterns are 'accept' patterns.
The last seen pattern wins

so given:
*.o
!fre*.o
freddy.o

frog.o is ignored
fred.o is seen
freddy.o is ignored

This means !* (or is that !**) has the same effect as a lone ! in CVS.

>>However the re's provided by regex(7) are too weedy to be worth
>>bothering with.
>>If however, there is a serious plan to go to perl, it may be worth
>>providing for this now in the ignore syntax.
>>
>>Also... you haven't mentioned perl for a while - can you give us an update?
>>I personally think we're making life needlessly unpleasant by sticking
>>with shell.
>>    
>>
>
>If there is still a serious plan, it is much more long-term now, since
>shell turns out to keep doing fine and everything we need, and that all
>reasonably fast.
>
>That said, I think it's fine to use Perl regexps. I think they rule. :-)
>But what do others think? Should we stick with POSIX regexps (I assume
>at least extended instead of basic), or go with Perl regexps?
>  
>
I vote perl re's
You have the power if needed but most of the time it'll be basic regexps.
I think if we have a central 'path' matching .git/ignore then regexps
are needed.
Then if we have them, we may as well allow them.
OTOH: A plethora of .gitignore files with the !negation mechanism may
make globs adequate.

>>Additionally this causes problems with sharing the same exclude file as
>>used by git.
>>However...
>>I really think git's exclude file capability and cogito's are different.
>>Cogito is aiming to provide full-blown SCM capabilities - git isn't
>>    
>>
>
>If we get to agree on some common format, I'm thinking whether it
>wouldn't be actually good to extend the --exclude option to support it.
>How much of an issue would that be? What do others think?
>  
>
I'm not convinced it needs to be extended.
It's trivial to take git-ls-files and filter it's results.
The rest of git will need filtering.

>>I am also concerned that a centralised ignore file is not flexible enough.
>>Certainly limiting if we support globs only.
>>It may be that you want different rules in different trees - someone on
>>lkml mentioned that excludes vary in different parts of the source.
>>Eg .s files may be generally ignored - but not in the asm parts of the tree.
>>    
>>
>
>I imagine it as (ignore rules applied in this order):
>
><default ignore list>:
>
>Some builtin ignore list catching files like *.o, *.a and such.
>  
>
Why builtin?
Why not have a default setup for .git/ignore
The way I'd do it is in cg-init :
[ -f cogito.ignore ] && mv cogito.ignore .git/ignore
[ ! -f .git/ignore ] && cat <<STD_IGNORE > .git/ignore

>Remember that you can throw it away with !* if you don't like it.
>  
>
but it means reading the man pages to find it out whilst you're editing
.git/gitignore
I could never remember what CVS ignored...

>/.git/ignore:
>
>Per-repository ignore list, not version tracked etc; really a local thing.
>  
>
~/.gitignore ?? CVS has it - personal prefs for your editor's strange
numbered backups etc

>/.gitignore
>/**/.gitignore:
>
>(Applied in the order from the project root to the current directory.)
>  
>
>Version tracked ignore list, which concerns the current directory, BUT
>may match pathnames instead of just filenames (but no ..). That is, you
>could do something like
>
>	echo '*.o' >.gitignore
>
>to ignore all the object files in the current directory, and
>
>	echo '**.o' >.gitignore
>
>to also ignore the object files in all the subdirectories.
>  
>
well, is the matching against files or paths?
And do .gitignores affect their sub-tree or just their dir?
And if they're vc'ed then git needs to stop ignoring .files

>
>Opinions?
>  
>

I think the global ignores contain both:
* regexps against the path relative to the project root
* regexps against the filename
* shell globs against the filename
I think the .gitignore's operate on a per-tree basis (so their directory
and lower)
I think .gitignore matching should be against filenames (not paths)

# comments
/regexp
!/inverted regexp
shellglob
!inverted shellglob




Lesson from the CVS manual:
Specifying `-I !' to `cvs import' will import everything, which is
generally what you want to do if you are importing files from a
pristine distribution or any other source which is known to not contain
any extraneous files. However, looking at the rules above you will see
there is a fly in the ointment; if the distribution contains any
`.cvsignore' files, then the patterns from those files will be
processed even if `-I !' is specified. The only workaround is to
remove the `.cvsignore' files in order to do the import. Because this
is awkward, in the future `-I !' might be modified to override
`.cvsignore' files in each directory.





-- 

