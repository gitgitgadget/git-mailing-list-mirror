From: Thomas Rast <trast@student.ethz.ch>
Subject: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 22:44:09 +0100
Message-ID: <201101312244.10047.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1Xn-0001JH-GC
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab1AaVoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:44:13 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:37611 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756230Ab1AaVoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:44:13 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 31 Jan
 2011 22:44:07 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 31 Jan
 2011 22:44:11 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165758>

Proposal:

Running "git fetch origin master" only updates FETCH_HEAD, not
origin/master, which turns out to be quite confusing for newcomers
especially after running 'git pull origin master'.

Since the remote branches in some sense reflect the "last known state"
of the remote, it would make sense to also update them to whatever a
two-argument fetch got.

Risks:

Scripts might rely on the current behaviour.  The most likely case I
can think of would be to go along the lines of

  git fetch origin master
  git rev-list origin/master...FETCH_HEAD | do_something

to avoid relying on reflogs to get the same result.  Seems a bit
arcane to me though.  Such usage would see the updated state, i.e.,
process an empty range.

Migration plan:

Add a fetch.updateRemoteNamespace (or so) configuration variable that
defaults to false.  When enabled, it turns on the auto-updating
behaviour.

In 1.8.0, flip the default.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
