From: Dale Worley <worley@c-66-31-108-177.hsd1.ma.comcast.net>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Tue, 5 Mar 2013 16:18:50 -0500
Message-ID: <201303052118.r25LIoAC000463@freeze.ariadne.com>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com> <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 22:19:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzGb-0004AL-1e
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 22:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336Ab3CEVSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 16:18:54 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:60740
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525Ab3CEVSx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 16:18:53 -0500
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id 7nWx1l0020SCNGk54xJsCD; Tue, 05 Mar 2013 21:18:52 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id 7xJr1l00y1KKtkw3VxJsz3; Tue, 05 Mar 2013 21:18:52 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r25LIopm000465;
	Tue, 5 Mar 2013 16:18:51 -0500
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r25LIoAC000463;
	Tue, 5 Mar 2013 16:18:50 -0500
In-reply-to: <7vtxoqx3s1.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1362518332;
	bh=syRWrXfJuRK4xIBkoe9VN6mvYlOBi3cy8kMVx0fx3Hw=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=Tq7hUMgHME+neIZKiIXY0wzub++pP5QcWecditUzAJ6/vR4/FywqrGcT2+w8wYqw+
	 NjTLMnJEhupNI1pl8CR2K0pwWycMbpgwXQ6Mv81VxjQtxoQFn3W4bk8C7qiuvAoyY4
	 K2Hl6/453HTv/vCcP18zg1CNsreFjz0o3sMdZLFQ2ffj4thZaoe2L1oBDXaAPVgfH3
	 5K62wb9jWCEascwyRQSTuzm5hlHmi9eMF7XvMklJ8jq6F2xrLgfIxICNDrVzmmZS0v
	 i6OZZJ1qe22OgRqC/lsOqAl6Y2nfTPu32ZXTvshP1Zx66wa3Uu9AuSF0g1V8CaZiES
	 JkMPH/mRHDx7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217482>

> From: Junio C Hamano <gitster@pobox.com>
> 
> I think this is to be expected for "git rebase", as it does not even
> look at merges.  It is a way to find non-merge commits that haven't
> been applied yet, and apply them to the upstream to create a new
> linear history.

I disagree. "git rebase" is not characterized as a way to "find
non-merge commits that haven't been applied yet", but rather (as
described in the git-rebase manual page):
 
    git-rebase - Forward-port local commits to the updated upstream head

    All changes made by commits in the current branch but that are not
    in <upstream> are saved to a temporary area. [...]  The commits
    that were previously saved into the temporary area are then
    reapplied to the current branch, one by one, in order.

Now if you read far enough down the page, I'm sure it warns about
merge commits.  But the stated basic *intention* is to replicate the
existing branch, re-rooted at a new place on the upstream branch.

The current implementation fails this intention by losing changes made
in merges.  It fails this intention in a *dangerous* way by causing
changes to be lost without warning.

Dale
