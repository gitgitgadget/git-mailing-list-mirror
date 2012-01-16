From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 20:17:17 +0100
Message-ID: <87r4yzzcci.fsf@thomas.inf.ethz.ch>
References: <loom.20120112T193624-86@post.gmane.org>
	<4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de>
	<4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de>
	<4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rms3b-0007fM-8t
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 20:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab2APTRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 14:17:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:26268 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069Ab2APTRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 14:17:21 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Jan
 2012 20:17:16 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.158.96) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Jan
 2012 20:17:18 +0100
In-Reply-To: <4F14718B.80209@unclassified.de> (Yves Goergen's message of "Mon,
	16 Jan 2012 19:50:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188647>

Yves Goergen <nospam.list@unclassified.de> writes:

> It's getting more weird. I believe that (msys)Git doesn't really know
> how the filesystem on its operating system works. I have made some more
> changes now and want to commit them. TortoiseGit reports the files
> Form1.Designer.cs and Form1.designer.cs (note the case difference) as
> modified and ready to commit. How is that supposed to work?

Depends.

If you work together with developers who have a case-sensitive FS (such
as Linux, or with the right options OS X), it's entirely possible that
this file exists in both spellings within the repository.

Otherwise, because Git needs to have the ability to store such
spellings, there are some ways of introducing them (e.g.,
git-update-index).

I suspect the adoption rate of TortoiseGit across this list is about 0%,
partly because it is a Windows-only tool, partly because it was written
almost entirely without interacting with the Git list.  So speaking in
TortoiseGit terms here will most likely get you nowhere.

> If the index is such a problem child, how can I safely delete it
> completely and maybe have it regenerated if Git can't live without it?

The index is not only, as its name might imply, a throw-away cache.  It
is also used as the area where you prepare the contents of the next
commit, and thus might hold data you do not want to lose.  Nevertheless,
you can discard and reset it to the contents of HEAD with

  rm -f .git/index
  git reset

> Great, I have the same file with an equal name twice in my repository
> (with 'git ls-files').
> 
> How stupid! Git, go learn file names.

Please cut&paste (!) actual command invocations (!) and outputs.

To see why this is important, consider

  "I have the same file with an equal name twice in my repository"

Judging by how this thread is going, there are at least four ways this
could be interpreted:

* You have the byte-for-byte identical file name listed twice in the
  index.  That would be a pretty bad bug.

* Ditto, but in a commit.

* You have two filenames in the index that differ only by case, which
  makes them identical to your OS.

* Ditto, but in a commit.

See what I mean?

So please, let's be precise.  You could start by cut&pasting the outputs
of the following commands:

  git ls-tree -r HEAD
  git ls-files --debug
  git status -s

Otherwise, you can keep throwing around fuzzy complaints all you want
but nobody will be able to help you because we cannot determine the
exact state that your repository is in.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
