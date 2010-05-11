From: Tatsuhiko Miyagawa <miyagawa@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Tue, 11 May 2010 11:56:43 -0700
Message-ID: <AANLkTinDzAgLckK6z08DJwZPWRmXywQ69EImTaiFsDOE@mail.gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
	 <201005102310.47879.jnareb@gmail.com>
	 <AANLkTimypauJKP-ifPKDmM9TK0u0JsSG5PlcpWdkkbVd@mail.gmail.com>
	 <201005111129.10931.jnareb@gmail.com>
	 <20100511094409.GB5220@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue May 11 20:57:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBudv-0008EE-0b
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 20:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554Ab0EKS4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 14:56:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60601 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0EKS4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 14:56:45 -0400
Received: by gwb19 with SMTP id 19so514227gwb.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TviZ0tycxujAwE5XRR+9jZ0p1PTx50U3pUwF24yAZvQ=;
        b=T4X4uROcBjm5jRAqMbKnzEHfPvI2iarNGFEj5I6zj+pGbVycG7OhoSD6hS+5dK5eFq
         YySLQkyluh5JOA7iT2eKZOoL2F1/+e+yuCDKuBf0OB3JzrP/sJcc5hWDno/pbLh9RryE
         JwVo66aLUfSKVOw7ZiY+Kl6NVzAJtfVyvY2RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JHBpz98ZnJ6tIMmN0TtOOvdRZtO0j1seQo4zQZqFY7En0QBq1ABEw16D0DprMCG5W9
         5MDs5+A6SuaqKON8t2D22XLVhJwCtlXfpmd8vX1hpAWeUUBIItu4uxeyncDsBTOTLXc6
         S8dcM49xYZgEEHZ5O6Db6B4S3xaL+ebZZcvUs=
Received: by 10.101.134.6 with SMTP id l6mr2564942ann.50.1273604203741; Tue, 
	11 May 2010 11:56:43 -0700 (PDT)
Received: by 10.100.228.6 with HTTP; Tue, 11 May 2010 11:56:43 -0700 (PDT)
In-Reply-To: <20100511094409.GB5220@screwed.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146905>

2010/5/11 Peter Vereshagin <peter@vereshagin.org>:
> I know St. Peter won't call your name, Jakub!
> 2010/05/11 11:29:07 +0200 Jakub Narebski <jnareb@gmail.com> =3D> To T=
atsuhiko Miyagawa :
>
> JN> gitweb running as FastCGI script (using ab, ApacheBench). =A0Do y=
ou know
> JN> any pure-Perl FastCGI server with minimal dependencies, and pure-=
Perl
>
> I'd like to know about the pure-perl FastCGI protocol implementation =
either, at
> least to make tests for FCGI::Spawn.

There are two pure perl FCGI protocol implementations (caller side)
available: Net::FastCGI and FCGI::Client.

Plack::App::FCGIDispatcher is a PSGI application to connect to a
=46astCGI external daemon over TCP or UNIX sockets, so you can use pure
perl PSGI web servers such as Starman to talk to them. But since it's
all pure perl and experimental and not suited for the benchmarking,
but it could be handy for testing (we actually use FCGI::Client to
test our own FastCGI server side implementation in Plack).

When I seriously want to benchmark FastCGI i always use nginx or
lighttpd, which is easy to install and doesn't need external modules
such as the case with Apache.

--=20
Tatsuhiko Miyagawa
