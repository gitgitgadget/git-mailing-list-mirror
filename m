From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: GIT character codecs
Date: Sun, 13 Nov 2005 00:14:43 -0800 (PST)
Message-ID: <20051113081443.38296.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 09:15:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbD0w-00021F-GS
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 09:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVKMIOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 03:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVKMIOp
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 03:14:45 -0500
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:52057 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964909AbVKMIOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 03:14:44 -0500
Received: (qmail 38298 invoked by uid 60001); 13 Nov 2005 08:14:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=p8MoflWWH1FG5TD9TSr+n0Q0K1C+5OavluIEHjmEF4ShIfILahjmFXPCsGJWb1j7e1xh9j4j62Vrx3iKzyRnnlJw4BRJPUzi8hElARjCIbrzOOPDYCxBRJodtzL8NQMtL7nNvorN81d3PWBDyvHzdSQklOlqGSanGI4wD7A1tt0=  ;
Received: from [151.42.66.244] by web26309.mail.ukl.yahoo.com via HTTP; Sun, 13 Nov 2005 00:14:43 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11728>

Junio C Hamano wrote:

>Marco Costalba <mcostalba@yahoo.it> writes:
>
>>I modified qgit to force the use of utf-8 codec instead of the local one, 
>>in my case ISO-8859-15.
>
>
>I suspect that trying to have a globa single encoding is a wrong
>approach overall.  There are a handful issues to think about.
>

I agree.

>First the easiest one -- the commit log messages.  We encourage
>use of UTF-8, 
>
> [cut]
>
>But we do not _enforce_ UTF-8.
>
>What this means for qgit is that it is often sufficient for its
>log browser to support one encoding at a time, provided if it
>allows the user to switch which encoding to use depending on
>what project is being viewed.
>
>
> [cut]
>
>
>But other projects may use different
>encodings, and even a single project can have its i18n message
>files in different encodings and charsets in different files.
>Users probably want to be able to view all of them, even if they
>only understand a couple of languages and not others.
>
>What this means for qgit is that at least you should be able to
>show a whole file in a single encoding, but if you show more
>than two files at the same time, one in each window, these
>windows may be showing its contents in different encodings and
>charsets.  So you would need to give a way to your users to tell
>you what encoding each file is in.  Using global locale as the
>default and having a way to override that per file basis would
>be sufficient.
>

If encoding is a per-blob _and_ per-log message property a real solution, although cumbersone,
could be that git stores encoding togheter with the blob and the commits.

The interfaces to read out encoded info could be something like 

git-rev-list --pretty  --encoding
git-ls-files -e

for commits and blobs respectively.

This avoids all user settings. More, the user could do not know the encoding, as
example when browsing a public repo. 


But I understand is too late for something like this. So what qgit can do is
to show a setting with a list of all supported encodings from the user to choose from.

But this is also a problem because, first we should have _two_ settings, one from log 
messages and one from blobs _and_ also in this case we miss the problem of different 
blobs with different encoding.

A practical workaround, *that do not catches all cases at all* could be qgit has only one global
setting (defaulting to local codec) and applies that setting blindly to everything, from commits
to blobs, the user changes that setting and refreshes the view until he finds the correct one.

But I'm a bit reclutant to add this 'codec list' stuff because, as said, is *not* the real
solution.

   Marco




		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
