From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: Implementing CSP (Content Security Policy) for gitweb in the
 future
Date: Sun, 05 Jun 2011 12:46:10 -0400
Message-ID: <1307292370.23564.10.camel@localhost>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com>
	 <201106051103.59541.jnareb@gmail.com> <1307278350.23564.5.camel@localhost>
	 <201106051533.51735.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 18:46:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTGSz-0003Wz-C2
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 18:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab1FEQqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 12:46:15 -0400
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:48465 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751703Ab1FEQqO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2011 12:46:14 -0400
Received: from homiemail-a38.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTP id E09D610AFAA;
	Sun,  5 Jun 2011 09:46:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=mattmccutchen.net; h=subject:from
	:to:cc:in-reply-to:references:content-type:date:message-id
	:mime-version:content-transfer-encoding; q=dns; s=
	mattmccutchen.net; b=b4fd/oYiVs2qgiY6WrE8NTOyi/Chk9DtzIAzb9MJPkv
	+KCS06dVvyx2LS7lIeOXNOnLw5aMMmwNNEC+Xsu+bfRVVIm9vwRPBt7ScSzlZWVF
	LdfqonvqmUIQkt40BanNNWfEf5IKGh7CJuBAKZOhk/2UK2XJTBTHYmoXcci5j6nU
	=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	subject:from:to:cc:in-reply-to:references:content-type:date
	:message-id:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=zkX7qefoA7tUnMZFTQ4BMJ9zgKQ=; b=utpUW2ZV7g
	dGXoyGN5VqkQzMT9fRROch0rGcl+TUdlDuEfCIxyx8aL0GUP8iF9PuYtfXic+XD3
	ZfdR/pGRmlqkjbpYMTb+5Iethy2z2RQUyBmcpfjpUsLM/klktf1pn1XHdW80lcvz
	ipBY6qiVp7UppvlZ1N4lqhg/M9MTHi/Q0=
Received: from [192.168.1.40] (pool-74-96-127-26.washdc.east.verizon.net [74.96.127.26])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTPSA id 6ED8510AFA1;
	Sun,  5 Jun 2011 09:46:13 -0700 (PDT)
In-Reply-To: <201106051533.51735.jnareb@gmail.com>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175081>

On Sun, 2011-06-05 at 15:33 +0200, Jakub Narebski wrote:
> On Sun, 5 July 2011, Matt McCutchen wrote:
> > On Sun, 2011-06-05 at 11:03 +0200, Jakub Narebski wrote:
> 
> > > In the future however it might be better solution for gitweb to implement
> > > (as an option) support for CSP (Content Security Policy), which IIRC did
> > > not exists in 2009, in addition to current $prevent_xss.
> > 
> > Sure.  CSP is not a substitute for designing to prevent harmful HTML
> > injection, but a mitigation for some of its worst effects in case some
> > injection points are overlooked.  There's no reason not to enable it by
> > default with $prevent_xss, though third parties adding functionality to
> > gitweb would need to know to disable it or modify the policy
> > accordingly.
> 
> I propose CSP support _in addition to_ and not replacing $prevent_xss
> (which would be nice to have more fine-grained control over).
> 
> Well, while we can whitelist HTML fragment from README.html, or render
> README.md / README.rs / README.pod etc. instead of blocking it like gitweb
> currently does if $prevent_xss is enabled, I don't think it would be
> feasible to do the same for text/html 'blob_plain' pages. 
> 
> Serving HTML pages etc. from 'blob_plain' view with path_info links
> is quite useful feature; this way one can use gitweb as a cheap and easy
> way to deploy web pages

Yes.

> and web apps;

Probably not: the browser features needed to make a nontrivial web app
are probably the same ones that are dangerous to other web apps.

> or just test results of development.
> CSP would serve this purpose well; current $prevent_xss behavior of
> serving as attachment (forcing download), or serving them as text/plain
> as e.g. GitHub does simply remove this feature.

CSP is not intended to be used by itself as a sandbox, although it might
almost work for the purpose.  It would be more appropriate to set up a
wildcard virtual host and appropriate rewrite rules to expose each
repository at a different DNS name and take advantage of the usual
same-origin policy.

-- 
Matt
