From: Jeff King <peff@peff.net>
Subject: Re: [bug] Working files created in bare repository when pushing to
	a rewound bare repository
Date: Mon, 31 Dec 2007 01:47:42 -0500
Message-ID: <20071231064741.GA4250@coredump.intra.peff.net>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 07:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9ERY-0005h9-UV
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 07:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbXLaGrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 01:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXLaGrp
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 01:47:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4630 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbXLaGro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 01:47:44 -0500
Received: (qmail 1028 invoked by uid 111); 31 Dec 2007 06:47:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 31 Dec 2007 01:47:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Dec 2007 01:47:42 -0500
Content-Disposition: inline
In-Reply-To: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69387>

On Mon, Dec 31, 2007 at 02:42:42PM +0800, Ping Yin wrote:

> Following scripts can reproduce the problem: in the final line,
> foo.txt is generated in bare foo.git

No, your script is wrong.

> # create bare foo.git and its clone foo
> mkdir foo
> cd foo && echo foo>foo.txt &&
> git init && git add . && git commit -m 'create project foo' && cd ..
> cd foo && echo foo1>foo.txt && git commit -a -m "update foo.txt" && cd ..
> git clone --bare foo foo.git && rm -rf foo
> git clone foo.git foo
> 
> # reset bare and then push
> cd foo.git && git reset --hard HEAD^ && cd ..

Try looking in foo.git after this step. The "--hard" to git-reset is
creating the file foo.txt. --hard makes no sense in a bare repository (I
thought we were disallowing it, but apparently not).

-Peff
