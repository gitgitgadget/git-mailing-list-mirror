From: Tatsuhiko Miyagawa <miyagawa@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 17:07:51 -0700
Message-ID: <AANLkTimypauJKP-ifPKDmM9TK0u0JsSG5PlcpWdkkbVd@mail.gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
	 <201005102040.36490.jnareb@gmail.com>
	 <AANLkTilXqAUs5-go-JHgTrQuslTyA1sZ3re5yuLtnxkz@mail.gmail.com>
	 <201005102310.47879.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 02:08:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBd0y-0002F0-EK
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 02:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab0EKAHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 20:07:54 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:46986 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab0EKAHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 20:07:53 -0400
Received: by yxe1 with SMTP id 1so3096200yxe.33
        for <git@vger.kernel.org>; Mon, 10 May 2010 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rLhD2kZAaWWLQxG/R8fHlcJpvIEFut9qbRokgOGHrCs=;
        b=lXV/8zP7Zo7MLtmXajdmSuhzYPc4I7cbzk252OWRHOh1nmXvAH27jYk1zbxtLrCTOu
         gBVcaCtd844A6NyEJtzIWjM42fXvDmQnhrDSh1WYjvmsp1LEFsIk+WkQwUgG5YJObUob
         4wlw9Iz4oLsVqj3b3G8VrRX7KnMwIz2OoTZIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=loiVObRbyMRVwoTg4JCpDqXA8yvG+WKboCNQMiAi0sQeytST3IH+CXoEjsABIivgYH
         BuUw6cXyzNqnmghfNxcRjp0jkl7btD4rqJQhM56ckqDME5Yo2rrgxijIlE1Tw6hz7Yda
         uiAnChczkrk0Ey3M6Ap5zh3/soEIxN8EINgzU=
Received: by 10.101.135.33 with SMTP id m33mr1075336ann.59.1273536471684; Mon, 
	10 May 2010 17:07:51 -0700 (PDT)
Received: by 10.100.228.6 with HTTP; Mon, 10 May 2010 17:07:51 -0700 (PDT)
In-Reply-To: <201005102310.47879.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146863>

On Mon, May 10, 2010 at 2:10 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> Well, the support for 'plackup' in git-instaweb is / would be done no=
t
> by converting gitweb from CGI to PSGI app, but by using gitweb.psgi
> wrapper.

wrapping gitweb.cgi with gitweb.psgi is a legitimate way to say
"converting CGI to PSGI app".

> It is true that with gitweb.psgi wrapper running gitweb as FastCGI
> script is just one command line option away. =A0But it does require P=
lack
> to be installed... well, on the other hand the modified gitweb needs
> FCGI module to be ran as FastCGI script, which is not a CORE Perl mod=
ule
> either.

*nods*

> I also wonder how running via wrapper script affect performance, as
> compared to modified gitweb running as FastCGI script, using CGI::Fas=
t
> and FCGI.

Based on my experience CGI::Emulate::PSGI doesn't have much of an
overhead because it's just swapping STDIN and STDOUT handles and
doesn't require stuff like tie or overload which tends to be slower.

> P.P.S. One of constraints to gitweb development is that it should run
> with minimal set of non-core modules. =A0Some people even complain th=
at
> gitweb (or was it about git in general?) requires at least Perl 5.8.6=
 or
> about (because of Encode module and Unicode support).

I know, but git-instaweb is a different story, since you rely on the
fact that the system has one of web servers like apache, lighttpd or
mongrel.

And that's exactly why I've been suggesting to you use WrapCGI
(CGI::Emulate::PSGI  + CGI::Compile) instead of converting gitweb.cgi
to natively support PSGI. We're on the same page and i don't
understand why you keep disagreeing with me :)


--=20
Tatsuhiko Miyagawa
