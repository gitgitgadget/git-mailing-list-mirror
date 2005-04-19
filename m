From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [RFC] Another way to provide help details. (was Re: [PATCH] Add
 help details to git help command.)
Date: Tue, 19 Apr 2005 10:03:41 -0600
Message-ID: <42652BDD.5000604@mesatop.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <4263E782.6040608@mesatop.com> <200504181940.54453.elenstev@mesatop.com> <20050419015124.GW5554@pasky.ji.cz> <4265189E.6090801@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 18:02:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNv9I-0006GS-7U
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 18:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVDSQET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 12:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVDSQET
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 12:04:19 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:38967 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261618AbVDSQDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 12:03:49 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JG3lxt022060
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 10:03:47 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JG3f1g009609;
	Tue, 19 Apr 2005 10:03:41 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: David Greaves <david@dgreaves.com>
In-Reply-To: <4265189E.6090801@dgreaves.com>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Greaves wrote:
> Petr Baudis wrote:
> 
>> Dear diary, on Tue, Apr 19, 2005 at 03:40:54AM CEST, I got a letter
>> where Steven Cole <elenstev@mesatop.com> told me that...
>>
>>> Here is perhaps a better way to provide detailed help for each
>>> git command.  A command.help file for each command can be
>>> written in the style of a man page.
>>
>>
>>
>> I don't like it. I think the 'help' command should serve primarily as a
>> quick reference, which does not blend so well with a manual page - it's
>> too long and too convoluted by repeated output.
>>
>> I'd just print the top comment from each file. :-)
>>
> 
> On the other hand, having more complete docs seems like an excellent 
> idea (and other threads support that)
> I'd certainly like to see more specification oriented documentation...
> (even if it turns out to be disposable)
> 
> Steven, if you carry on sending more verbose docs I'll certainly read 
> and work with you on editing them...

I only did those first two as a straw man.  Doing the others is a couple
hours (or less) work, but I don't want to do it if folks don't want it.

Having the help files separate has advantages/disadvantages.

> 
> Nb kernel-doc doesn't seem appropriate for user level docs.
> maybe, whilst there's so much flux, have:
>   git man command
> that just outputs text
> 
> If Petr wants the top comment to be extracted by help then maybe a 
> bottom comment block could contain the more complete text?
> I *really* think that the user docs should live in the source for now 
> (hence I think that git man is better than going straight to man/docbook).
> 
> I wasn't sure whether to perlise the code or do a shell-lib - but 
> looking at the algorithms needed in things like git status I reckon the 
> shell will end up becoming a hackish mess of awk/sed/tr/sort/uniq/pipe 
> (ie perl) anyway.
> 
> So I'm going to have a go at that - Petr, if you have a minute could you 
> send me, off list, a bit of perl code that epitomises the style you like?
> 
> David
> 

Funny you should mention Perl.  Here is small bit of code:

[steven@spc0 git-pasky-testing]$ cat print_help_header.pl
#!/usr/bin/perl
# reads from stdin   writes to stdout  no error checking
<STDIN>;<STDIN>;
while (substr( $line=<STDIN>, 0, 1) eq "#") {
                  print $line;
}

[steven@spc0 git-pasky-testing]$ ./print_help_header.pl <gitdiff.sh | grep ^# | grep -v "(c)" | cut -c 3-
Make a diff between two GIT trees.

By default compares the current working tree to the state at the
last commit. You can specify -r rev1:rev2 or -r rev1 -r rev2 to
tell it to make a diff between the specified revisions. If you
do not specify a revision, the current working tree is implied
(note that no revision is different from empty revision - -r rev:
compares between rev and HEAD, while -r rev compares between rev
and working tree).

-p instead of one ID denotes a parent commit to the specified ID
(which must not be a tree, obviously).

Outputs a diff converting the first tree to the second one.
-------end of output from perl plus grep and cut.

Without the perl, extra comments came out (plus the dreaded first blank line).


[steven@spc0 git-pasky-testing]$ cat gitdiff.sh | grep -v "/bin" | grep ^# | grep -v "(c)" | cut -c 3-

Make a diff between two GIT trees.

By default compares the current working tree to the state at the
last commit. You can specify -r rev1:rev2 or -r rev1 -r rev2 to
tell it to make a diff between the specified revisions. If you
do not specify a revision, the current working tree is implied
(note that no revision is different from empty revision - -r rev:
compares between rev and HEAD, while -r rev compares between rev
and working tree).

-p instead of one ID denotes a parent commit to the specified ID
(which must not be a tree, obviously).

Outputs a diff converting the first tree to the second one.
FIXME: The commandline parsing is awful.
-------end of output from grep and cut.

David,

I'm a bit pressed for time, so if you or anyone else would like to
use this code to fix up my earlier patch, you're welcome to it.
Otherwise, it will be later this evening or tomorrow before I can
do any more with this.

Steven

