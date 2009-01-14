From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 18:49:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <200901120947.13566.trast@student.ethz.ch> <7vprisj26i.fsf@gitster.siamese.dyndns.org>
 <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9t6-0001pU-4H
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbZANRtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760222AbZANRtD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:49:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:41679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755807AbZANRtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:49:00 -0500
Received: (qmail invoked by alias); 14 Jan 2009 17:48:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 14 Jan 2009 18:48:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19w1MMoqu5wRIhWr3aNyO8UcLkz4r9MKeIieh56ZI
	2QVjjOvby3pIRL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vprisj26i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105669>


This series is getting bigger and bigger, unfortunately, just what I tried
to avoid.

But at least I am pretty comfortable with the readability of the result,
and it adds tests -- finally.

Changes relative to the last round: color_fwrite_lines() had problems with
empty lines, and find_word_boundary() was replaced by find_word_boundaries(),
which finds not only the end of the next word, but the start, too.

The only "funny" thing I realized is that the lines which are output
by emit_line() add a RESET at the end of the line, and I do not do that
in color_fwrite_lines().

Can anybody think of undesired behavior as a consequence?

Johannes Schindelin (4):
  Add color_fwrite_lines(), a function coloring each line individually
  color-words: refactor word splitting and use ALLOC_GROW()
  color-words: change algorithm to allow for 0-character word
    boundaries
  color-words: take an optional regular expression describing words

 Documentation/diff-options.txt |    6 +-
 color.c                        |   28 ++++++
 color.h                        |    1 +
 diff.c                         |  203 ++++++++++++++++++++++++++--------------
 diff.h                         |    1 +
 t/t4034-diff-words.sh          |   86 +++++++++++++++++
 6 files changed, 253 insertions(+), 72 deletions(-)
 create mode 100755 t/t4034-diff-words.sh
