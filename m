From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: Cloning svn project with flat layout (remote wildcard inside path component)
Date: Fri, 17 Sep 2010 23:14:33 +0200
Message-ID: <AANLkTin7byfdi=K2eN_9Cqx_HQBJatm1qW7zO-te2F-1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 17 23:14:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwiGV-0001kD-N9
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 23:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab0IQVOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 17:14:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49132 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0IQVOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 17:14:34 -0400
Received: by qwh6 with SMTP id 6so2236588qwh.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=1S/wXTi9tdf0Z7Wjb+MLbwE02M78v7WEeGjNmyrapRY=;
        b=HHFnzElGDhDN5IXHnxguleiGhLCEmssWazDjJvkLgLRcGACp6pnNUNoEG9iALwABth
         /Jyb5BBat8mV2GxBcltU0rgjza9zta+i1R1C5X0bfKojmhnBxiWzDZ7ofzniXQLeDW0a
         w+hg4qMhJfYn2GFZAa7RflGWOyvWqibT5L4NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iXud2Ggj9oaznk7CDB9zsoTHdwob3XPVD5pMoIoCH1dYuNc5RimrcLawdePd0GWwbe
         yHV4AWdqCWvxBZwBZPbvxcHzbY+aPnqUoH5UAqRv18/OWMpuiGNLMRRzZXwG10nn0zKF
         j0btbbQrHMMrj3QJ/BL2FWK4g+vCmh5ry4j+0=
Received: by 10.224.113.1 with SMTP id y1mr3676498qap.333.1284758073346; Fri,
 17 Sep 2010 14:14:33 -0700 (PDT)
Received: by 10.229.213.201 with HTTP; Fri, 17 Sep 2010 14:14:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156414>

I'm trying to clone putty project from it's svn repository.
Unfortunately they are using very nonstandard layout where everything
is in a single directory:

/putty = trunk
/putty-branches-* = release branches
/putty-spinoffs = another branch
/putty-0.* = release tags

To get it working I tried following:

[svn-remote "svn"]
        url = svn://svn.tartarus.org/sgt
        fetch = putty:refs/remotes/trunk
        branches = putty-branch-*:refs/remotes/branches/*
        branches = putty-{spinoffs}:refs/remotes/branches/putty-*
        tags = /putty-[0-9]*:refs/remotes/tags/*

Turns out however, such configuration is invalid since remote
wildcards are supported only in place of whole path component, not as
a part of it.

Obviously, it would be nice if it was working. Consider this a feature
request, if I may make one.

Actually, I have another: support extended regular expressions (with
capture groups) on remote side and back-references on local ref side,
giving the user control over local branch names.
