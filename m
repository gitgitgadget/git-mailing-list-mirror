From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: counting the number of connections?
Date: Thu, 05 Mar 2009 17:18:14 +0100
Message-ID: <87ab80j649.fsf@krank.kagedal.org>
References: <be6fef0d0902272244q468b1fa4sacdc15afa9a65f15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 17:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGIo-0000jR-UJ
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZCEQSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbZCEQSd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:18:33 -0500
Received: from main.gmane.org ([80.91.229.2]:56015 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbZCEQSc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:18:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LfGHB-0002E7-VP
	for git@vger.kernel.org; Thu, 05 Mar 2009 16:18:25 +0000
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 16:18:25 +0000
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 16:18:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:O+c6WQkmfrWa1VKplgqT9q5PpJM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112315>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Hi,
>
> some time ago I noticed curl doesn't remember your credentials (apart
> from those it can get from ~/.netrc), and very recently there was an
> thread on repeated prompting for credentials while pushing to https.
>
> I've written a simple patch series, which allows git to play nice
> without curl_multi. That is, git uses a single persistent connection
> throughout.
>
> However, I'm at a loss at how to test for this. How does one count th=
e
> number of connections made during the lifespan of a program's
> execution? So far, I've been relying on my firewall log (Comodo on
> windows). Perhaps there a more operating system/software-agnostic
> method to do this?

You could set up a single-use tcp forwarder which will make any second
connection fail. Using socat, for instance:

  $ socat tcp-listen:2222,bind=3Dlocalhost tcp:my.server:22 &
  $ nc localhost 2222
  SSH-2.0-OpenSSH_5.1p1 Debian-3ubuntu1
  ^C
  $ nc localhost 2222
  localhost [127.0.0.1] 2222 (?) : Connection refused

--=20
David K=C3=A5gedal
