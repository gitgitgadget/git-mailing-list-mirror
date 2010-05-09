From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Sun, 9 May 2010 16:06:54 -0500
Message-ID: <20100509210654.GA1637@progeny.tock>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 23:07:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBDic-0007nn-GM
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 23:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab0EIVHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 17:07:04 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:54369 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0EIVHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 17:07:03 -0400
Received: by qyk13 with SMTP id 13so4942104qyk.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8gbRglefUQfi7a2BdhwhuSP+ZRkcnzrtq5mZKZ5avjo=;
        b=jF1aIfYTp8/4cOzI/zYsHbLs/HVYy/iq1gB854NKK1FAB6nDns3o3uanD1KP1lipil
         2AoqAjsw2Ja4i+vxXSq9olEQHYGIZTP+ZTijz+qpuN1w1GI4YO49zgwRWtubIK5KL+ZR
         tJtA//fxKXarCF8FW3hTjqFLM5uzKBC2eBRRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JE/Sw+CUcbFkWRUa9O5ehG5izWaoHrh9TjpQlQvAnkK14U+gPI22fgNeSf54YgBZeD
         BWVp66mssoXswLQoIFtLhA6W3TM/CUPdCfsWOLMJ/EFAxE0bTwSzyW6DwQFNit0/fgh4
         sLwW31DjTqdYiom1fifVI2yTWCVdwf2jepKMI=
Received: by 10.224.80.106 with SMTP id s42mr1993621qak.8.1273439221597;
        Sun, 09 May 2010 14:07:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v37sm3266999qce.6.2010.05.09.14.06.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 14:07:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146747>

Hi,

Bo Yang wrote:

> git log <revision> -L1,8 -L45,+6 <file1> -L/some/,/end/ -L9,29 <file2=
> <file3>

I like it.  It looks like paranoid script authors would have to check
for paths like =E2=80=98--=E2=80=99 and =E2=80=98-L=E2=80=99 and quote =
them as =E2=80=98./--=E2=80=99 and =E2=80=98./-L=E2=80=99, a
small price to pay for a nice syntax.

Unfortunately, this is completely incompatible with the existing blame
option syntax.  i.e., existing scripts might do things like this:

  git blame -L1,8 -C <file>

or

  git blame -L1,8 <rev> <file>

Maybe there should be a line range required before every file
specifier in this syntax, to avoid trouble.  Borrowing syntax from sed,
this makes

 git log <rev> -L1,8 -L45,+6 <file1> -L/some/,/end/ -L9,29 <file2> -L1,=
$ <file3>

which is also a little clearer to look at, I think.

> 'git log -L1,8 <revision> -- -L1,8' .

This provides a single line range specifier for all files?  Sounds
convenient.

  # who wrote the opening comments?
  git blame -L '/^[/][*]/,/^ [*][/]/' -- '*.c'

Summing up, with my refinement above, a human would parse args like
this:

  When an -L option is encountered, remember the current state.

  Try to parse the remaining arguments as ((-L range)* filespec)*,
  where filespec has some appropriately strict meaning that forbids
  =E2=80=98-L=E2=80=99 and =E2=80=98--=E2=80=99.  If that succeeds, we=E2=
=80=99re done.

  Otherwise, rewind.  Look for an upcoming =E2=80=98--=E2=80=99.  If --=
 is found, any
  -L arguments before the -- apply to all files specified.  Unclaimed
  arguments before the -- are revision specifiers.

  If no -- is found either, any -L arguments before the first
  unclaimed argument that is not unambiguously a revision apply to all
  files specified.  Arguments from that point on must be unambiguously
  paths.

A little hairy.  Maybe you can do better, but already it seems okay.
Maybe the last case ought to disallow multiple -L arguments and
multiple files, to encourage people to use the first syntax or an
explicit =E2=80=98--=E2=80=99.

Hope that helps,
Jonathan
