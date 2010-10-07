From: Jeff King <peff@peff.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 10:10:15 -0400
Message-ID: <20101007141015.GB8162@sigill.intra.peff.net>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 16:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3rAm-0002HA-JH
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 16:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745Ab0JGOKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 10:10:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38229 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079Ab0JGOKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 10:10:05 -0400
Received: (qmail 17913 invoked by uid 111); 7 Oct 2010 14:10:04 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 14:10:04 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 10:10:15 -0400
Content-Disposition: inline
In-Reply-To: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158402>

On Thu, Oct 07, 2010 at 03:25:29PM +0400, Kirill Likhodedov wrote:

> With a null byte
> > git log --pretty=format:%H%x00%ct
> Ignores anything appearing after the null byte:
> 
> ee5d714b95d133ff555bc8c7933dc752b5b277f5
> cb1b9dd688d9cf155257c94e749172820b56d87a
> b4c75be10b14d021003853e527e47ad88dc5a55b
> 1963187da6a45f898e62e4e922faac6b9382b4e4
> 
> Other bytes behave fine. 
> 
> Using %x00 worked in Git 1.7.1 and stopped working in 1.7.2.3 (or even earlier).

I can't reproduce using v1.7.2.3. Are you sure your pager or terminal
isn't hiding everything after the NUL? Have you tried piping it through
"xxd" or "cat -A"? I get:

  $ git log -1 --pretty=foo%x00bar | xxd
  0000000: 666f 6f00 6261 720a                      foo.bar.

  $ git log -1 --pretty=foo%x00bar | cat -A
  foo^@bar$

> Is it a bug or a feature (not allowing null bytes in the custom format anymore)?

If it is not working, it is most definitely a bug.

-Peff
