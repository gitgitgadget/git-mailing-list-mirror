From: Jeff King <peff@peff.net>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 16:13:35 -0500
Message-ID: <20160114211335.GB10825@sigill.intra.peff.net>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
 <20160114213113.c700484c7e3acddc467d0e75@domain007.com>
 <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
 <CAGyf7-H2jSW0vJZ7ng1OcN7X5tvs+sEuGUH4yMSpJ_-wwUcoTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pedro rijo <pedrorijo91@gmail.com>, Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:13:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJpDD-0003qM-3B
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 22:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbcANVNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 16:13:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:53949 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755524AbcANVNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 16:13:38 -0500
Received: (qmail 10214 invoked by uid 102); 14 Jan 2016 21:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 16:13:38 -0500
Received: (qmail 11732 invoked by uid 107); 14 Jan 2016 21:13:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 16:13:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 16:13:35 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-H2jSW0vJZ7ng1OcN7X5tvs+sEuGUH4yMSpJ_-wwUcoTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284094>

On Thu, Jan 14, 2016 at 12:12:35PM -0700, Bryan Turner wrote:

> The same thing works for GitHub. Here's the hazelcast/hazelcast repository:
> 
> bturner@ubuntu:~$ git remote-https
> https://github.com/hazelcast/hazelcast.git
> https://github.com/hazelcast/hazelcast.git | head
> list
> @refs/heads/master HEAD
> 988810c4b5c5195412c65357e06cbb0e51173258 refs/heads/3.1.8
> bddfb328e4779bccec6f7788c94960f6292b02c9 refs/heads/3.2-fix-eacg
> 84e7d1006cd342c39afdf0ac520b5b04b8233d75 refs/heads/3.3.6
> 2e4ffc4f593de0869f0db9f7224f964f72dac15d refs/heads/3.4-gem
> d0a7d416b1220ef4badd98e42991dabe34c7beeb refs/heads/3.5.1
> 6a13721d33bdb07de23f5c505b689e2ee50d5abb refs/heads/3.5.3-ercssn
> 56676b20baae8668e731f17c9f3b9844ddd486d0 refs/heads/3.5.4
> 
> I'm not aware of a simple equivalent for SSH. Also, note that this
> "git remote-https" trick won't work on Windows. When you hit Enter
> after "list" it writes a CRLF, so the "git-remote-https" process
> compares "listCR" against its list of known commands and finds no
> match.

There's no equivalent for ssh, because you're hooking in at the
remote-helper layer, and ssh (and git://) are builtins, and http is not.

I mentioned "git remote" elsewhere in the thread, which is probably the
least gross way (it's just ugly because it writes to a file instead of
to stdout). But you can also snoop on the protocol:

  $ GIT_TRACE_PACKET=3 git ls-remote origin 3>&1 >/dev/null |
    perl -lne '/symref=(\S+)/ and print $1'
  HEAD:refs/heads/master

It would be nice if "git ls-remote" just had some way of printing the
capabilities.

-Peff
