From: Yang Zhang <yanghatespam@gmail.com>
Subject: Simplifying work across multiple projects (while tracking 
	relationships among commit histories)
Date: Sun, 30 May 2010 23:41:28 -0700
Message-ID: <AANLkTimC0SoVAG-2xByZFFitl2KNlAhYlAw5fN_XqriT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 31 08:41:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIyh9-0007VA-BK
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 08:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0EaGlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 02:41:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:59654 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0EaGlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 02:41:49 -0400
Received: by fg-out-1718.google.com with SMTP id l26so610809fgb.1
        for <git@vger.kernel.org>; Sun, 30 May 2010 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=QMjS7ezC7allKMD/2hamjzEzzKkBYpACIHIG4kuwy8g=;
        b=D88pqbVSeBFxPx4nYBxJqDTr24hPzD05P0tzyyzd9WfG0CtxOb+MQhdgQvvtJttdnS
         X3TlzFtVkAibTcrdSX036cpFVwMCrFZgzZzLvgHX0fOQgtuUpYfZxyOURF/EePBTJ2j+
         r3bFMO9awoK49oPb+TxDTfo0jR1Z3xCdZ4B0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=bOy/K7QrcDxdfPbDcvWBmKhmXUy4XaGu70ibWCgdRNCz93CgvaEkJD3M7jp7KL5eFy
         H/tWg/wX/X2h8Ax+DzC2CFuAG979VBTNmX64ubW7fw1mlg3beSEoCp+6CnFhZTrLIEdh
         Ar8nyGHkH1Z6Wi2yhImhHulbtAdBrA1fii9GE=
Received: by 10.103.85.26 with SMTP id n26mr1603041mul.5.1275288108136; Sun, 
	30 May 2010 23:41:48 -0700 (PDT)
Received: by 10.204.143.70 with HTTP; Sun, 30 May 2010 23:41:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148034>

After looking at some of the tools/techniques out there for working
with multiple git projects (submodules, subtree merge, braid, repo),
it seems that none are really well-suited for our use case. We're
developing a large system consisting of several components (libraries,
servers, applications, etc.). None of these components will ever exist
or be released as a stand-alone product. We're in "rapid development"
mode, so we're not even close to dealing with e.g. manually
maintaining information on versions/dependencies, and we just want
very tight integration among all the components -- yet the components
do deserve their own disentangled histories and (eventually)
independent branches/tags/versions/etc.

If we were using svn, all the code would live in a single repository,
and that would be all there was to think about this. However, it seems
that our use case (surprisingly) doesn't have a lot of good support in
the DVCS world.

For now, we'll probably just have some simple scripts that basically
do 'for i in $projects' loops for pulls, pushes, commits, etc.
However, this loses a lot of information that should be tracked about
the version/dependency information among the projects -- information
that at the same time we're not interested in manually tracking. We're
currently thinking of having a simple system that is initially set up
with a dependency graph among projects, e.g.:

  a: no dependencies
  b: depends on a

and whenever a commit is made to a project with dependencies (b), the
commit (perhaps in the commit message) contains a reference to the
particular versions of the dependent project(s) (a) that were checked
out.

The tool could simplify the use of such a scheme, e.g.:

- automatically augmenting commit messages with this information
- on commits/pushes, first commit/push the dependent projects
- checking out consistent versions of all the projects (or subgraphs thereof)

Does this make sense to others? Are we overlooking a better/existing
approach? Would it be worth building this? Suggestions on design
improvements to such a tool over what was described (e.g. better
approach than augmenting commit messages)?
--
Yang Zhang
http://yz.mit.edu/
