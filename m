From: Jeff King <peff@peff.net>
Subject: Re: t5539 broken under Mac OS X
Date: Thu, 15 Jan 2015 18:57:53 -0500
Message-ID: <20150115235752.GB25120@peff.net>
References: <54B68D99.2040906@web.de>
 <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
 <54B6C897.5030405@web.de>
 <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
 <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net>
 <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:58:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuIa-00048Z-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbbAOX54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:57:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:35304 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751433AbbAOX5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:57:55 -0500
Received: (qmail 9328 invoked by uid 102); 15 Jan 2015 23:57:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 17:57:55 -0600
Received: (qmail 18509 invoked by uid 107); 15 Jan 2015 23:58:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 18:58:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 18:57:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262527>

On Thu, Jan 15, 2015 at 02:39:56PM -0800, Junio C Hamano wrote:

> Before writing that patchlet, I briefly looked at grep output and
> thought that many that are protected only by SANITY lacked POSIXPERM
> by mistake:
> 
>  t/t1004-read-tree-m-u-wf.sh:test_expect_success SANITY 'funny symlink in...
>  t/t3600-rm.sh 'Test that "git rm -f" fails if its rm fails'
>  t/t7300-clean.sh:test_expect_success SANITY 'removal failure' '
>  t/t7300-clean.sh:test_expect_success SANITY 'git clean -d with an...
> 
> All of the above relies on a working chmod as far as I can tell, so
> they should require POSIXPERM,SANITY, not just SANITY.

Yeah, skimming the grep output, I had the same feeling. But I did not
investigate closely.

> lib-httpd should, if it cares about the root-ness, be checking that
> in a more direct way, "test_have_prereq RUNNING_AS_ROOT".  Making
> the implementation of that portable is another matter, though.

Exactly. I am happy to submit a patch, but I cannot think of any
mechanisms besides:

  1. Calling `id`, which I suspect is very not portable.

  2. Writing a C program to check getuid(). That's portable for most
     Unixes. It looks like we already have a hacky wrapper on mingw that
     will always return "1".

Is (2) too gross?

-Peff
