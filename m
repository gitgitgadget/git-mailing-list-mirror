From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: git status --untracked
Date: Mon, 11 Feb 2008 05:23:59 -0500
Message-ID: <20080211102359.GA5916@coredump.intra.peff.net>
References: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVq4-0006VQ-V4
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbYBKKYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYBKKYF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:24:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2948 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbYBKKYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:24:04 -0500
Received: (qmail 7712 invoked by uid 111); 11 Feb 2008 10:24:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 11 Feb 2008 05:24:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 05:23:59 -0500
Content-Disposition: inline
In-Reply-To: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73507>

On Mon, Feb 11, 2008 at 10:46:25AM +0100, Rafael Garcia-Suarez wrote:

> I find myself wanting sometimes to filter out the output of
> git-status, to feed it to another command (for example, git-add, or
> rm, or cat >> .gitignore). However it's not currently very easy to
> parse in a one-liner.

Here's a one-liner:

  git status | sed -ne '/^# Untracked/,${s/#\t//p}'

Unfortunately it is both specific to GNU sed as well as horribly
unreadable.

> I'm suggesting to add options to control this behaviour. My suggestion
> would be (for a start) to add an option --untracked that will list all
> untracked files on stdout, without a leading "#\t", and without
> listing the added / modified / removed files.

The problem you are running into is that "git status" has a specific
purpose: generating the commit message template. Fortunately, it is
built on top of plumbing that is much easier to parse:

  git ls-files -o --exclude-standard

should produce the results you want. It even has a '-z' option to do
things safely in the face of filenames with newlines, and can limit
itself to partial paths.

-Peff
