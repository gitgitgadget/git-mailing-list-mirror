From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/5] gitweb: Do not use bareword filehandles
Date: Sun, 10 May 2009 11:27:51 +0200
Message-ID: <200905101127.51963.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com> <200905100236.20158.jnareb@gmail.com> <20090510075053.GA6058@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun May 10 11:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M35KG-0007XF-Bk
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 11:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZEJJ15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 05:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZEJJ14
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 05:27:56 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49665 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZEJJ1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 05:27:55 -0400
Received: by ewy24 with SMTP id 24so2784882ewy.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2wSffyLm7iDUo8G2C7ltBZ5xkMhnQJugd0IGx1Xx/SQ=;
        b=X11gvA8LdEnprWp6zQm9CYjcCxg3BsxKTKa1ERF1y7qycl5XHjpE+c/jhoTpct9sWD
         0hWXpz41X/GQyhouf6xynxSew0K1DHq/pQhzST8VPMdzXCIhFmoWandT7rO8knO07X9N
         nI8u9Ye6yGoUwjY4EleEBh9U/QG5P7esl61l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=r+yZYtMSTtlKb91fsD0/shYuVEavi2IEQy6Eo4oWS3YOslkVkLygoId1STMj5LAdWW
         gt6mC5AxvxiLjr28aaL1PAXZ1TYK2kWTf/5j2RR7ShQUKmgs3OGLQ6xXF5dkp2qFq6Y9
         OUlo6FCmW4PrRT2NmWaS6b7eIJHqd145ton1U=
Received: by 10.210.79.3 with SMTP id c3mr7137091ebb.96.1241947674817;
        Sun, 10 May 2009 02:27:54 -0700 (PDT)
Received: from ?192.168.1.13? (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id 28sm5360580eye.46.2009.05.10.02.27.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 02:27:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090510075053.GA6058@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118712>

On Sun, 10 May 2009, Petr Baudis wrote:
> On Sun, May 10, 2009 at 02:36:19AM +0200, Jakub Narebski wrote:

> > ---
> > Perl::Critic::Policy::InputOutput::ProhibitBarewordFileHandles
> > 
> >   Write open my $fh, q{<}, $filename; instead of open FH, q{<}, $filename;.
> > 
> >   Using bareword symbols to refer to file handles is particularly evil
> >   because they are global, and you have no idea if that symbol already
> >   points to some other file handle. You can mitigate some of that risk by
> >   'local'izing the symbol first, but that's pretty ugly. Since Perl 5.6, you
> >   can use an undefined scalar variable as a lexical reference to an
> >   anonymous filehandle.
> > 
> > See also Damian Conway's book "Perl Best Practices",
> > chapter "10.1. Filehandles" (Don't use bareword filehandles.)
> > 
> > 
> > This follows similar patch for git-send-email.perl by Bill Pemberton
> > http://permalink.gmane.org/gmane.comp.version-control.git/117886
> > 
> > CC-ed Pasky, who is responsible for code in both cases...
> 
> Yeah, the book I learnt Perl from many years ago used bareword
> filehandles (but it was an excellent textbook in most other aspects)
> so this is a custom I have to work hard to evict. ;-)
> 
> Acked-by: Petr Baudis <pasky@suse.cz>

Well, on one hand this is less of an issue for standalone script like
gitweb is than for library / module.  On the other hand we use indirect
filehandles everywhere else, so it is also matter of style consistency.

"Perl Best Practices" gives as an example of bad behavior which we can
get by using bareword [global] filehandles: 1) automatic closing of
other filehandle with the same name (e.g. not only you use FILE for
bareword filehandle); 2) open might fail if there exist subroutine /
constant with the same name as filehandle e.g. EXDEV (from POSIX module).

Note however that prior to Perl 5.6 it was not that easy to avoid
using bareword filehandles. Perhaps the book in question (or author of
the textbook you mention) started with earlier Perl...


P.S. Git.pm generates surprisingly small amount of perlcritic-isms,
most of whose are either matter of style, or are false positives.
-- 
Jakub Narebski
Poland
