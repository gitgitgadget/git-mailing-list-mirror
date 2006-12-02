X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-add update with all-0 object
Date: Sat, 02 Dec 2006 09:35:52 +0100
Organization: At home
Message-ID: <ekrdph$tg6$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org> <20061201045727.GA22622@thunk.org> <Pine.LNX.4.64.0612010223010.20138@iabervon.org> <200612010937.08468.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 08:34:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 65
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33008>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqQK1-00011Y-OU for gcvg-git@gmane.org; Sat, 02 Dec
 2006 09:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162462AbWLBIeG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 03:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162836AbWLBIeG
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 03:34:06 -0500
Received: from main.gmane.org ([80.91.229.2]:29074 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162462AbWLBIeD (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 03:34:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqQJr-00010D-09 for git@vger.kernel.org; Sat, 02 Dec 2006 09:33:59 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 09:33:58 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 09:33:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Friday 2006 December 01 08:10, Daniel Barkalow wrote:
> 
>> My position on this subject is that "index" is a good name, but that
>> description is a terrible description, and "index" is a word that needs a
>> good description in context. If we just said up front:
> 
> If we need to explain what "index" means in the context of diff then it's not 
> a good name :-)

But "staging area" or more descriptive "staging area for commits" is
a bit long. But we no longer name the "index" "dircache".

> An index /everywhere else/ is a lookup table.  topic->page number; 
> author->book title.  record id->byte position.  There is never any content in 
> an index, indices just point at content.

Just like git index.

> I imagine that's how git's index got it's name.  (I'm only guessing as I've 
> not looked at what's actually inside git's "index").  Here's my guess:
> 
> git update-index file1 hashes file1, stores it somewhere under that hash and 
> writes the hash->filename connection to .git/index.  That is why git's index 
> is called an index.  It's a hash->filename index.

This "somewhere" is object repository. And it is reverse: it is 
filename->(stat + hash) index; from a file in the working area to the blob
(or tree) in the repository.

> Unfortunately, "index" in colloquial git actually means the combination 
> of .git/index plus the hashed file itself.  That's no longer an index, it's 
> a "book". :-)

Yes, it is true that "index" in colloquial git means "index version"
(version pointed by the "index").

> It's made worse, I think, by the fact that git doesn't want to do any 
> index-like things with the "index".  Being content-oriented rather than 
> name-oriented means that an entry like "file1->NOTHING" is impossible in git.  
> This leads to the sort of "git-add means track this filename" confusion that 
> turns up a lot with new users.

It is possible. By convention all-0 hash means 'no such object'. The very
first message in this thread tried to make use of it... but "git add" to
mark filename as interesting instead of "git add" to add _current_ contents
of the file goes a bit against git ideas.

> It's probably all too late to change the nomenclature, but I've always been of 
> the opinion that names are important, they confer meaning.  When we use a 
> common word, with common meaning and deviate from that common meaning we are 
> bound to create confusion.  New users don't have any "git-way-of-thinking" 
> knowledge when they begin, so when they hear "index" they can only fall back 
> on their standard understanding of that word.  We shouldn't be surprised then 
> when new users don't get "the index".

Well, "dircache" was changed to "index". "<ent>" was axed in preference
to "<tree-ish>". I think using "staging area" name in git man pages would
be a good idea (as would be making --index to be alias to --cached).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

