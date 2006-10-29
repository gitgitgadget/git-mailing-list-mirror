X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 13:24:42 +0100
Message-ID: <200610291324.42566.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com> <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 12:24:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mdiFdXPqTyixO1UHrAq+Z/Jx3UOcymN7cO3mgmOPsJCryg7nX9RNVzRkGrh+mhJY0QbwEg6T/6yqdIXFGs9PyOoXSxh9SpwPg8TMI+BK9tKBuX7406CkFhMEoXrK4pXIE1dzIVROMaYimcP7vsZOWQe5oCAs7Pr3j1qYHtTUvTU=
User-Agent: KMail/1.9.3
In-Reply-To: <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30429>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge9id-0002XZ-Ut for gcvg-git@gmane.org; Sun, 29 Oct
 2006 13:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932309AbWJ2MYq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 07:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWJ2MYq
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 07:24:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4320 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932309AbWJ2MYp
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 07:24:45 -0500
Received: by ug-out-1314.google.com with SMTP id 32so970022ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 04:24:44 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr2452342ugh; Sun, 29 Oct 2006
 04:24:44 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e33sm1892627ugd.2006.10.29.04.24.43; Sun, 29 Oct
 2006 04:24:44 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Changes:
>> * "gitweb diff header" which looked for example like below:
>>     file:_<sha1 before>_ -> file:_<sha1 after>_
>>   where 'file' is file type and '<sha1>' is full sha1 of blob, is link
>>   and uses default link style is changed to
>>     diff --git a/<file before> b/<file after>
>>   where <file> is hidden link (i.e. underline on hover, only)
>>   to appropriate version of file. If file is added, a/<file> is not
>>   hyperlinked, if file is deleted, b/<file> is not hyperlinked.
> 
> I do not have time to look at the code right now, but here are 
> quick comments on the output.

Code is a bit horrible I think in trying to be smart and avoid
code repetition.

> I personally do not mind "hidden" but it might be more obvious
> to make them normal links -- the filenames in the header are not
> part of long text people need to "read".  On the other hand,
> it feels a bit wasteful to have these hidden links both on "diff
> --git" line *and* ---/+++ lines (these three are very close to
> each other).

Good idea. We have lost visible links with the change. And easy to
implement: just remove style override for .diff.header a.list from
CSS (or what would be better but harder to code remove "list" class
from <a> element in "git header").

Originally there was visible link with full sha1 of blob as text,
and hidden link with filename as text; perhaps dropping the latter
---/+++ line link is better idea (here hyperlink should I think be
hidden, if there is any, to match git-diff and GNU diff -u output).
And this would simplify code somewhat...

The hidden (but here I think we can change to not-hidden links) links
in the "index" extended header line are to stay I think: this is the
only place where we can have links to all the versions of file in the
future combined commitdiff format.

>> * there is added "extended diff header", with <path> and <hash>
>>   hyperlinked (and <hash> shortened to 7 characters), and <mode>
>>   explained: '<mode>' is extnded to '<mode>/<symbolic mode> (<file type>)'.
> 
> It somehow feels that deviating from what "git diff" gives makes
> it very distracting; I would feel better if "/-rw-r--r-- (file)"
> were not there.

Well, the old version had "(<file type>)" in gitweb diff header.
Not all git/gitweb users are familiar with POSIX numeric modes;
perhaps changing the style (color for example) of added stuff
to mark it as added would be enough?

> Also I think arguing over 7 or 8 hexdigits is pointless; if you
> are reading this from "git diff", it is probably the easiest to
> match what "git diff" gave you.  One thing we _might_ want to do
> in the future is to change "git diff" to use DEFAULT_ABBREV
> hexdigits at the minimum but more if needed to disambiguate; I
> think it currently does not do the "more if needed" part.

I used 7 hexdigits because git-diff uses 7 by default.

>> * <file> hyperlinking should work also when <file> is originally
>>   quoted. For now we present filename quoted. This needed changes to
>>   parse_difftree_raw_line subroutine.
> 
> This feels Ok.

I'm not sure if we shouldn't unquote filename always, or at least
remove double quotes surrounding filename, or [ab]/filename. The decision
to leave visible filename quoted was based on the troubles to code
it correctly in "git diff" header where one of the filenames might
not be hyperlinked: if file was added or deleted.

>> * from-file/to-file two-line header lines have slightly darker color
>>   than removed/added lines.
> 
> This visually feels right.

What is left is fine-tuning the color.

>> * chunk header has now delicate line above for easier finding chunk
>>   boundary, and top margin of 1px.
> 
> This visually feels right.

What is left is fine-tuning the line and vertical space.
-- 
Jakub Narebski
