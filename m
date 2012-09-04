From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: checkout extra files
Date: Tue, 4 Sep 2012 09:15:42 +0200
Message-ID: <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	<CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
	<7vsjayew50.fsf@alter.siamese.dyndns.org>
	<CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
	<7vd322ebsz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 09:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8nMU-0004AT-W2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 09:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab2IDHPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 03:15:44 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41921 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2IDHPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 03:15:43 -0400
Received: by vcbfk26 with SMTP id fk26so6267653vcb.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yu8q3sPrfTcwteof3A71/rfPGhTQ/oPR9G9qQJ1zZxA=;
        b=IpqFSWlaAcLfAbV3W1EQe3qpGWZck2neeQY8yWiE84xBPwUraxlPZTvfutUVSa7TlD
         VNsWieYTLhWgT9y5IMDTe+AWF0ew2zQ8ujZF1ee1BRJiDdKZK65gTfSNU1BPdev69AAu
         n4yWBJNCYxnFUa7B/C90xxi5rTrxbw6ZCVXTEp2BjY3WNWs+LVVTBjIEZZ8dFLQ84h4D
         fIB1KWBPw0Tz83rf231M2uUuT4epoghMglYenAQemMrK0VGASqB7DDht3V2rtogHzCTR
         LQWEmCVinrGvdt+jm/3yhF0pNUk0aJXlXLNo4TZzSGf2o8K58Q+xvYfgDc3EnU2PtuMj
         qpAg==
Received: by 10.220.218.144 with SMTP id hq16mr14267163vcb.61.1346742942798;
 Tue, 04 Sep 2012 00:15:42 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 4 Sep 2012 00:15:42 -0700 (PDT)
In-Reply-To: <7vd322ebsz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204719>

Hi all,

consider this example:

$ mkdir gittest
$ cd gittest
$ git init
Initialized empty Git repository in d:/gittest/.git/
$ touch f1
$ git add f1
$ git commit commit -m "first commit"
[master (root-commit) e6f935e] first commit
 0 files changed
 create mode 100644 f1
$ touch f2
$ git checkout e6f9 -- *
error: pathspec 'f2' did not match any file(s) known to git.

Note the error.
It is clear that the set of file names that git checkout is taking is
the union of the ones that
match the specified path ('*') in the work directory (gittest) with
the ones that match the
path in the specified commit (e6f9).
I am not questioning this behavior, but the documentation, which does
not describe it:

   "It updates the named paths in the working tree from the index file or
   from a named <tree-ish> ..."

There are two ways to read this sentence:

    1.  "named paths" referred to working tree, i.e. the files whose
names match the
          paths among all the ones present in the working tree
    2.  "named paths" referred to the index or tree-ish, i.e. the
files whose names match
          paths among oll the ones present in the index or tree-ish

In both cases, nothing tells the user that the matching of the paths
is done over the union
of the set of file names of the working tree + ndex or tree-ish.
Indeed, the first time I have seen the error above I got quite
confused because I thought
that the checkout would restore the working directory as it was at the
time I made the commit,
without bothering about extra files that the directory contained at
the moment (and note that
f2 is not even a tracked one).
This behavior is a bit strange, but if it is a hundred percent clearly
documented I can live
with it.

I think that knowing precisely what files are involved in this command
is essential for the user.

-Angelo
