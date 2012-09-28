From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Stopping git-svn pulling a particular branch
Date: Fri, 28 Sep 2012 21:03:26 +1000
Message-ID: <CAH3AnroU4gpf38qTAz87=jbcXCg3Zq_bDk=3BozGgyOGz5HREg@mail.gmail.com>
References: <CAH3Anro6EOq0Qh6R6-YXpMW+9h0xtZcBR3KY0kRgWT-4mGf1xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 13:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THYM8-0003BN-C5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 13:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab2I1LD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 07:03:28 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39773 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab2I1LD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 07:03:28 -0400
Received: by bkcjk13 with SMTP id jk13so3177608bkc.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 04:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=1TUHpipfYkXf6XgFNzB98G1O3TBNVWjBO4jsEIAFV9c=;
        b=MXBvrfNfwAwDtdYEZ+dj+QHTfXGmYRrPxhIl1U8B6etXoiL/9PUTXPWTI/QgNzmGJg
         Tla0yZ2pnedqQzOmKcjGrlZxnAduXpqM9KasL7spS0WdqSLMFutLl+tm/LELhxmqWCWs
         eaZTju9QFBl2H9ivDwNtG7sRzdaDAOQJ5da7d3XgD6PWW+KQaNfCooPu63JzxabNprP2
         yRiyvEllXRxHoFmW3kjsh13WGz1cJR5RDWD5wN+0u9wmN+1olrq5YpjGbcYfCeLWgfVt
         wC9ynGhODrvqD2NWNK2PEV7mXC6PFV2oZZzv71K87AflcygExu1HmH4C+KHR4LcXr/0V
         DWDA==
Received: by 10.112.83.35 with SMTP id n3mr2497272lby.68.1348830206710; Fri,
 28 Sep 2012 04:03:26 -0700 (PDT)
Received: by 10.112.28.8 with HTTP; Fri, 28 Sep 2012 04:03:26 -0700 (PDT)
In-Reply-To: <CAH3Anro6EOq0Qh6R6-YXpMW+9h0xtZcBR3KY0kRgWT-4mGf1xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206554>

On Fri, Sep 28, 2012 at 2:58 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> G'day
>
> An svn developer created a branch from a subdirectory of the trunk
> rather than by copying trunk itself.
>
> I want to avoid pulling this branch into my git repo with git svn
> fetch because the re-rooting pulls in too much history and content
> that I don't want.
>
> Is there any easy way to achieve this? I tried used the --ignore-paths
> option, but this doesn't seem suited to the purpose.
>
> I can delete the SVN branch if that will help, but past experience
> suggests that it won't.
>

Answering my own question. There is an undocumented option to git-svn
--ignore-refs which can be used to achieve this.

I found that I had to manually delete the directories corresponding to
the bogus branches from .git/svn/refs/remotes, then re-run git svn
fetch with the --ignore-refs option set to a regex that matched the
bogus branches.

This allowed me to fetch everything else I needed to fetch and
advanced the maxRevs metadata in .git/svn/.metadata past the
problematic  branches so that subsequent svn fetch calls avoided the
attempts to fetch the bogus branches.

I'll draft a documentation patch when I get a chance...

jon.
