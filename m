From: Tatsuhiko Miyagawa <miyagawa@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Sun, 9 May 2010 18:05:04 -0700
Message-ID: <x2k693254b91005091805re0f63ac5z471e05fa4ab71ca7@mail.gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
	 <201005100105.49985.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 03:05:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBHQq-0005yd-Ob
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 03:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab0EJBFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 21:05:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55968 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0EJBFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 21:05:06 -0400
Received: by gyg13 with SMTP id 13so1633275gyg.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cdSmbHORy+lmbEuFXlI5tTviXplepI//cr32bPvn5FA=;
        b=id0GUxsguJp08HnuwizdlwN+0daaKH+wcCq8fWWwX4Iq9wpAyjAK49N/onwnLzMGjS
         W6F5WlsPW6WHoJRYme5oQljpBNT5LJ9BDb7I/Pauj118wwAhlGaQ9UuVR4vZMjDCJ5Q4
         0pj3RyPvqa7uZpp4XzBFtA9QEcXDtzMruxjVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KUA3dVGchDFspGCQtJ8EB0MB+B6sjZvIve5dnURsM0xJQTEYeAEvkOiGAhxlcUbc5c
         nRy7Ld7ORxcYHBP6EIaIsnjv0kneIAHGU5H76D3Gt5/fIiSdfS99I43+H4FpcahyFIcR
         oU5lahMcWItL+SigoYgiqfkjtoh+ixB15ZiZw=
Received: by 10.231.183.68 with SMTP id cf4mr878516ibb.19.1273453504546; Sun, 
	09 May 2010 18:05:04 -0700 (PDT)
Received: by 10.231.154.79 with HTTP; Sun, 9 May 2010 18:05:04 -0700 (PDT)
In-Reply-To: <201005100105.49985.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146756>

On Sun, May 9, 2010 at 4:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:

>> `plackup -s FCGI` makes your PSGI app a fastcgi handler using FCGI.pm,
>> or `plackup -s Net::FastCGI` does the same but using Net::FastCGI,
>> pure perl alternative.
>
> It is a pity that Plack::App::WrapFCGI / FCGI::Emulate::PSGI does not
> exist, so that gitweb.psgi wrapper would not require indirectly
> CGI::Compile.

I *think* we discussed about this on IRC, but you still seems to be
misunderstanding:

You have a CGI script and you want to turn it into a PSGI application,
hence we have CGI::Emulate::PSGI and CGI::Compile.

You usually do not have a FCGI "application". You're writing a .fcgi
"wrapper" to make your CGI script runnable from a web server (like
you're doing with gitweb.fcgi).

Writing an FCGI emulation layer for PSGI would allow you to run the
FCGI wrapper from PSGI compatible web server - which does not make
sense AT ALLl. It's even one more indirection.


--
Tatsuhiko Miyagawa
