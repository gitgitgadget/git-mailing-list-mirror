From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 19:47:45 +0200
Message-ID: <200910201947.50423.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 19:48:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Iox-0005tL-RV
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 19:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZJTRsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 13:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbZJTRsV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 13:48:21 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:22652 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbZJTRsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 13:48:21 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 19:48:24 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 19:48:24 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130819>

Hi all,

While everyone is busy in two other UI threads, I figured I might as
well toss up another (probably) controversial topic.

Especially on IRC, we see many people who are some combination of
misunderstanding, misusing or overusing git-pull.  I figure this is
the result of several factors, notably

a) pull/push are not symmetric,

b) guides/tutorials recommend pull for situations where they
   shouldn't,

c) people blindly fire commands at git.

While the latter two are probably hopeless, I find (a) rather
annoying.  It breaks everyone's intuition of git-pull when they first
see it.  (I know that BK has a pull that also merges, but I gather
from the manual [never used it] that you cannot do the equivalent of
git-fetch in BK.)

As you probably guessed by now, here is an idea for a very aggressive
transition plan to address (a) in four phases:

1. git-fetch gets options --merge/-m and --rebase that make it behave
   like (current) git-pull, but requiring explicit arguments.
   git-pull gets a new option --merge (-m) that only enforces presence
   of arguments.

2. git-pull refuses to do any work unless given either --merge or
   --rebase.  Deprecation warnings for this start at the same time as
   (1.).

3. git-pull becomes a synonym for git-fetch.

4. git-fetch gives deprecation warnings that point the user to
   git-pull instead.

(1.) is probably harmless and could be put into any particular
release.  (2.) obviously breaks everyone's favourite script and needs
to fall on a major release.  (3.) should be delayed significantly from
(2.) to allow time to expose such breakage, and similarly (4.) should
be delayed after (3.) (or just ignored, but in any case git-pull would
become the preferred spelling).

As you probably noticed, while 'git pull $remote $ref' only needs to
be changed to 'git pull --merge $remote $ref', this leaves a gap at
the current functionality of 'git pull' without arguments.  Bj=C3=B6rn =
laid
out a nice suggestion for a git-update in

  http://article.gmane.org/gmane.comp.version-control.git/130679

briefly summarised as: git-update would cover what 'git pull' (without
arguments) does right now.  However, it could also be restricted to
fast-forward updates by default (with per-branch configurability as
with current git-pull).

Comments?  Flames?  Improvements?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
