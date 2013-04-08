From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 01:37:12 -0700
Message-ID: <20130408083712.GE20159@elie.Belkin>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
 <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
 <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
 <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKA9-0002Am-2U
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395Ab3DHIhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 04:37:21 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61264 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934311Ab3DHIhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 04:37:17 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so3152876pad.39
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dCzWZpVGuuZy6FC4yam94KOPV53ibjR5t8qLrA5dvnY=;
        b=Fqb9PZgj4ncFQUxpKAf7ULPAIutki01hYBobQsmdKq87GOeX/KR9sOoW6uvqreqOTo
         jb9nuaUGNkjO09z0GKz0xwIRfWnzGzZBVbWZjTQEY1a4ezqLjO13i8cvkjoOKTf/RJiY
         hQdwFfVyA5uwOUnj6ECeaXlyG+5kPHmGTtsDhhB9Eja81P5w3G/0DpQu+Eu53S7Y6ARj
         sJUGdVOmhwHTCfz8ZOhv0qkwGg9BwYTuZxbdWXto+1cdaR+y94z0MfvpPrNQeBbF5Rxb
         UPBBRy3tdZUOAyIELos+cKa7cN+Vukpob5gt+7VIKdLsLerYp91Jsdwt6MMOWCpCRboe
         8ESg==
X-Received: by 10.66.147.103 with SMTP id tj7mr34588661pab.82.1365410237216;
        Mon, 08 Apr 2013 01:37:17 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id xl10sm37664836pac.15.2013.04.08.01.37.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 01:37:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220407>

Ramkumar Ramachandra wrote:
> Jens Lehmann wrote:

>> Hmm, at least the unstaged .gitmodules file has to be parsed from
>> the file system.
>
> You seem to be touting it as a distinct advantage.

To clarify what I said in a side thread: yes, as long as the submodule
metadata includes the hostname I am downloading a library from, having
it in an ordinary file is an advantage.

The problem with URLs (and especially hostnames) is that they change.
When my project's previous domain name is lost because the hosting
company lost interest, I want to be able to grep for all instances of
that domain name in my project's documentation and metadata and change
them all at once with a simple command like the following:

	git grep -l -F -e oldhost.example.com |
	xargs sed -i -e s/oldhost.example.com/newhost.example.com/g

When I clone a project with --no-recurse-submodules, I want to be able
to see what other servers will be contacted when I run "git checkout
--recurse-submodules".  The current .gitmodules file lets me find that
out with a simple, intuitive command:

	cat .gitmodules

I might change some URLs locally, because I know that some project's
upstream has moved.

	git submodule init
	git config --edit

On the other hand, the single .gitmodules file will be a pain to merge
if multiple branches modify it.  So I do look forward to a merge
strategy that deals more intelligently with its content, and wouldn't
have minded a design that split this information into multiple files
if we were starting over.

Jonathan
