From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Mon, 25 Jan 2010 02:47:12 +0100
Message-ID: <201001250247.13101.jnareb@gmail.com>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net> <m3ljfydgmt.fsf@localhost.localdomain> <20100124221444.GB9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 02:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZE32-00048R-10
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 02:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab0AYBrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 20:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450Ab0AYBrT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 20:47:19 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:62457 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab0AYBrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 20:47:18 -0500
Received: by fxm7 with SMTP id 7so1515673fxm.28
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 17:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uHp8+tGCLVTAn90ubkdoK1TQbAdyHh4mKyCbLHmUqpg=;
        b=Ty5U8YSmaxA0HZvaPBx0x6N5ADs4xMwlXhLtMF47R/ww+6EP1jR/fiZfJ7hwLnVD/R
         C7RZGuFDuj9YzvUPkIjw7WL4Rg7lblkLyQvIP2rwqDXOG7VU1NwBFOsuPl7zW8vEZj1b
         z0z0LiWAw+4XT9553qQN3zJ8bk17vwqiXCFzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LnIJfkiN46ABB+Ag6u4VcCO80XbmTYI06iI+jyqCUctfK56YnhHJk4nPhv3UF3jJh8
         rhl0VaTzTFMu1LgkUPJiCMyLcNB+qrA52pgTU9MgD43UmdyeqqLH6OHMAVAvq+oxjgGO
         R6JTQk0jqpdJe+KJX3YNU/G9qXuxK/rhB3MFg=
Received: by 10.103.67.25 with SMTP id u25mr3044573muk.107.1264384036953;
        Sun, 24 Jan 2010 17:47:16 -0800 (PST)
Received: from ?192.168.1.13? (abvk247.neoplus.adsl.tpnet.pl [83.8.208.247])
        by mx.google.com with ESMTPS id s10sm18709474muh.29.2010.01.24.17.47.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 17:47:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100124221444.GB9553@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137934>

On Sun, Jan 24, 2010 at 23:14 +0100, Petr Baudis wrote:
> On Fri, Jan 15, 2010 at 04:43:32PM -0800, Jakub Narebski wrote:

> > Third, wouldn't it be better to use shorter variable name, e.g. $out
> > or $oh, instead of $output_handle?  We would be able to align print(f)
> > statements without making lines much longer.
> 
> I totally agree, I was going to comment on this too. Please use
> something very short, I think even the three characters might be pushing
> it a bit. Having long idiom will make it real pain to both read and
> write gitweb code.
> 
> It would still be nice if we could have some way to avoid this hack
> entirely. Couldn't we layer PerlIO::via over STDOUT and continue to use
> argument-less print as before?

First, the original version in v2 series, the one that can be found in
42641b1 (GITWEB - File based caching layer, 2009-12-10) commit in
git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v2
http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v2
the change was even larger. It was
  print <something>;
replaced by
  $output .= <something>;
and of course make functions that printed sth return formatted output
instead.

Also with original version you paid the price even if caching was turned
off (not used): the whole output had to fit in memory, and there was no
streaming, which meant that the whole output had to be generated before
it could be displayed (decreasing latency).


Second, PerlIO::via is not a good solution.  One solution would be to
require Capture::Tiny if caching is enabled, and just do

  $out = capture {
  	$actions{$action}->();
  }

or even simply (if it is possible with the way 'capture' is prototyped)

  $out = capture $actions{$action};

Another solution would be to use PerlIO::Util to redirect output to
scalar:

  *STDOUT->push_layer(scalar => \$buffer);
  # ...
  *STDOUT->pop_layer();
  
Yet another solution would be to manipulate *STDOUT directly

  $stdout = *STDOUT;
  *STDOUT = $buffer_fh;
  ...
  *STDOUT = $stdout;

for which, I think, to be done correctly we would have to duplicate
(large?) parts of Capture::Tiny.


So there is a bit of rule of preservation of difficulty at work.  Either
we have large patch adding explicit filehandle to all print statements
'print <sth> -> print $out <sth>' but simple code, or have smaller patch
but complicated *STDOUT manipulation, or have small patch but rely on 
non-core CPAN modules present.

> I think we (well, in practice, "you" nowadays :) should be less
> perfectionist when accepting gitweb contributions, so if the answer is
> "it's too hard for me to do right now", that's fine I guess; I know I
> can't contribute the code currently. :(

True.  At least two series ('categories' which I have copy locally
in http://repo.or.cz/w/git/jnareb-git.git as gitweb/category, and
'committags' by Marcel M. Cary[1]) that are not yet in gitweb because
of that...

[1]: http://thread.gmane.org/gmane.comp.version-control.git/100418/focus=133141

-- 
Jakub Narebski
Poland
