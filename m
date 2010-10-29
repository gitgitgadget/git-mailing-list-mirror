From: Dun Peal <dunpealer@gmail.com>
Subject: Inconsistent behavior of the path disambiguator
Date: Fri, 29 Oct 2010 19:11:03 +0100
Message-ID: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 20:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBtPy-0007h9-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 20:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0J2SLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 14:11:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52684 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab0J2SLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 14:11:04 -0400
Received: by ywk9 with SMTP id 9so2172269ywk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=PlzZOCjEUfyW5FNMh+lwpg2QSZxm2q3W2BDjnuG9QTU=;
        b=WE5ll19HtUtI2NJv3JFYB6eThZQ2rU3V3Or0qtDqd2wgYuFNjo+oVd6+yGwYQinaB+
         QoWF96YeDA/GCmES0WC/UvbtX4HS7FBE2zc5syWhfOvYOlzXtIeLMye8lZGZUnGGDtn9
         5Y5seiJ4+byiiwmJDswDV390g2HrLGfr5ye0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EetVWnSahSufk7uj3ayb/jn9FHNbokDhsF16US1M2WY3QzitGWFmV3rikHrwKQvTST
         +uB3BVeaOyUzC1qTv0HCJnpBQTQwYjk5mqpXPmu2cKLndsoD6oXsCaO+P9AS5hDxcO0w
         4aT5BuXMidGQKHaTm+gkc9RB7+Wpkg4bXjw38=
Received: by 10.42.215.71 with SMTP id hd7mr3405388icb.505.1288375863728; Fri,
 29 Oct 2010 11:11:03 -0700 (PDT)
Received: by 10.220.201.13 with HTTP; Fri, 29 Oct 2010 11:11:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160350>

Hi.

When I clone a remote that has a branch `foo`, then `git checkout foo
--`, the path disamgiuator makes the operation fail. `git checkout
foo` without the disambiguator works. Following that, when branch
`foo` already exists, `git checkout foo --` works even with the
disambiguator that caused it to fail previously.

Here's a log demonstrating a full reproduction of the bug with git
1.7.2 on Linux:

=== LOG START ===

$ mkdir origin && cd origin && git init && echo 1 >> test.txt && git
add test.txt && git commit -am "First." && git branch foo
Initialized empty Git repository in /home/afine/lab/gitexp/origin/origin/.git/
[master (root-commit) 6042525] First.
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
$ cd .. && git clone origin local && cd local
Cloning into local...
done.
$ git checkout foo --
fatal: invalid reference: foo
$ git checkout foo
Branch foo set up to track remote branch foo from origin.
Switched to a new branch 'foo'
$ git checkout master
Switched to branch 'master'
$ git checkout foo --
Switched to branch 'foo'

=== LOG END ===

This looks like a bug.

Thanks, D
