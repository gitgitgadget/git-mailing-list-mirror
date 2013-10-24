From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Re: Finding the repository
Date: Thu, 24 Oct 2013 00:49:19 -0700
Message-ID: <5268d0ff.HMSQf8rpwyXtEYEA%perryh@pluto.rain.com>
References: <5267804b.JaxQnlQ5Cx+By4RS%perryh@pluto.rain.com>
 <CACsJy8DgxpjasroZv4iqTn9JhQ_3r2DD9uEf-xL-uyyPOtWh+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 24 10:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZG1e-0001f5-7R
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3JXIMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:12:09 -0400
Received: from agora.rdrop.com ([199.26.172.34]:3839 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab3JXIMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:12:07 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id r9O8C4EL041712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Oct 2013 01:12:04 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id r9O8C4DI041711;
	Thu, 24 Oct 2013 01:12:04 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA23234; Thu, 24 Oct 13 00:47:39 PDT
In-Reply-To: <CACsJy8DgxpjasroZv4iqTn9JhQ_3r2DD9uEf-xL-uyyPOtWh+A@mail.gmail.com>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236570>

Duy Nguyen <pclouds@gmail.com> wrote:

> ... it's not easy to determine ambiguity here, especially when the
> repo finding code does not know anything about "bar/barz.c" (is it
> a pathname or an argument to an option?).

IOW, the code that finds the repository is called "too early"?

One way to solve that to that would be to proceed, even if the
repository has to be left as "unknown" until it actually needs to
be consulted -- by which time the subcommand would presumably have
parsed all of the options and pathnames and so would know which is
which.  Then, use the pathname(s) to identify the repository(ies).
Yes, if there's more than one repository involved, the subcommand
has to do a "for each repository" loop.  The code to do all this
could go in a module shared among the subcommands.

> There are more cases to consider, like what if you do
> "git rm bar/baz.c and rab/zab.c" where bar and rab are
> two different repositories..

So we remove baz.c from bar and zab.c from rab.  It's not clear
to me that there's anything wrong with that -- it's exactly what
I would expect to have happen (and also what the hackish script
I posted will do).
