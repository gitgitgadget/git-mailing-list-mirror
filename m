From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git diff vs git diff-files
Date: Tue, 14 Aug 2012 10:18:20 +0200
Message-ID: <87vcgl999v.fsf@thomas.inf.ethz.ch>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	<87fw7qhm31.fsf@thomas.inf.ethz.ch>
	<CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Bernd Jendrissek <bernd.jendrissek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1CKe-0005ql-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 10:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2HNIS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 04:18:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:59873 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab2HNISX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 04:18:23 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 10:18:20 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 10:18:20 +0200
In-Reply-To: <CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
	(Bernd Jendrissek's message of "Mon, 13 Aug 2012 18:06:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203389>

Bernd Jendrissek <bernd.jendrissek@gmail.com> writes:

> On Mon, Aug 13, 2012 at 5:02 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Can you share this repository?
>
> This weird behaviour doesn't even survive making a copy (cp -a) of the
> whole repository, so I very much doubt making it available would be
> illuminative. My disk's SMART data seems okay. The weird-quotient just
> rose a bit.

That sounds like an issue with stat() data, and then it doesn't.  cp -a
would change all the inode numbers, triggering a full refresh of the
index in 'git diff'.  But I'm not sure exactly how this can lead to
disagreement, since both commands read *both* index and worktree version
of the file.  Very confusing.

Can you try the following:

  git ls-files --debug gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
  cp .git/index .git/index.orig
  touch gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
  # note, it is important that you run diff first
  git diff gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
  git diff-files -p gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
  git ls-files --debug gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net

>> Or at least the pre- and post-change
>> files, transferred in such a way that there won't be any whitespace
>> damage (your snippets above show obvious damage).  You can use
>
> http://www.bpj-code.co.za/downloads.php/bugs/TwoStageAmp-output.net?text
> contains the output from git show a5ee1e7. Leave off the ?text for an
> application/octet-stream download.

Umm, that's only one side of the diff, isn't it?  The hunk header claims
that the hunk goes up to line 47, so there must be more changes beyond
what you showed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
