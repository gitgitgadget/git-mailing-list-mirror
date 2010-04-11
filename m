From: Jeff King <peff@peff.net>
Subject: Re: Status of all files
Date: Sun, 11 Apr 2010 06:25:35 -0400
Message-ID: <20100411102534.GC20484@coredump.intra.peff.net>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
 <20100409113248.GB27353@thyrsus.com>
 <m3sk74hjkg.fsf@localhost.localdomain>
 <20100409140215.GB27899@thyrsus.com>
 <4BC0F7D1.6000003@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: esr@thyrsus.com, Jakub Narebski <jnareb@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 12:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0uMj-0000EC-0i
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 12:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab0DKK0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 06:26:04 -0400
Received: from peff.net ([208.65.91.99]:40565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538Ab0DKK0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 06:26:01 -0400
Received: (qmail 3102 invoked by uid 107); 11 Apr 2010 10:26:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Apr 2010 06:26:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Apr 2010 06:25:35 -0400
Content-Disposition: inline
In-Reply-To: <4BC0F7D1.6000003@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144636>

On Sun, Apr 11, 2010 at 12:12:33AM +0200, Paolo Bonzini wrote:

> >Agreed. But there's no way to tell that this is the case without
> >doing a pull operation or otherwise querying origin, and I'm
> >not going to do that.
> 
> You can query the origin _as it was on the last fetch_.
> 
> If you are on branch X, the logic is as follows:
> 
> - Let R be the value of configuration key branch.X.remote,
> - let M be the value of configuration key branch.X.merge,
> - for all values S of configuration key remote.R.fetch,
>   - strip an initial +
>   - if S is M:N, return N
>   - if S is P/*:Q/* where P is a prefix of M, take M, replace this
>     prefix with Q and return the result
> 
> In the most common case you will have:
> 
> - X = master
> - R = origin
> - M = refs/heads/master
> - one key S = +refs/heads/*:refs/remotes/origin/*
> 
> so the prefix "refs/heads/" is replaced with "refs/remotes/origin/"
> and the result is refs/remotes/origin/master.

BTW, this procedure is complex enough that we have exposed it via a
plumbing interface:

  $ git for-each-ref --format='%(upstream)' refs/heads/master
  refs/remotes/origin/master

which does all of the correct magic internally.

-Peff
