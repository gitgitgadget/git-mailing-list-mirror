From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Mon, 12 Apr 2010 00:21:13 +0100
Message-ID: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Cc: Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 01:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16We-0000OT-M1
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0DKXYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:24:47 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:38490 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753010Ab0DKXYp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:24:45 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 29D67819C6C6;
	Mon, 12 Apr 2010 00:24:38 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 76E6F20CF56;
	Mon, 12 Apr 2010 00:24:43 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yUg0509SR-Dm; Mon, 12 Apr 2010 00:24:42 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 67DB220CF4F;
	Mon, 12 Apr 2010 00:24:42 +0100 (BST)
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144693>

Ok, round 2 of an attempt at making a format agnostic structured output library.
The idea being that the command doing the output doesn't have to care what the
actual output format is, it uses one set of output functions and the user gets
to choose their preferred output style.

The current backend/frontend interface probably needs expanding so that a less
noddy XML output can be used, but it's a start.

Rather than building an in-memory structure and then writing it out I've gone
for the approach of writing out immediately.  The thought behind this was that I
didn't really want to force commands like log to have to wait 'til the end to
start outputting information (though I still haven't got around to working on
converting log).

Probably the biggest change from v1 is an expanded aim.  Now the output library
is aimed at controlling _all_ plubming output.  This series includes a patch for
ls-tree that has all it's output going through the library, and a patch for
status that has all the --porcelain output going through the library.

The XML patch still needs a lot of work, as I've been busy playing with the
library API and the NORMAL/ZERO backends ...

Julian Phillips (4):
  output: Add a new library for plumbing output
  ls-tree: complete conversion to using output library
  status: use output library for porcelain output
  output: WIP: Add XML backend

 Documentation/technical/api-output.txt |  116 ++++++++++++++
 Makefile                               |    5 +
 builtin/commit.c                       |   21 +++-
 builtin/ls-tree.c                      |   51 ++++--
 output-json.c                          |  127 +++++++++++++++
 output-normal.c                        |   95 +++++++++++
 output-xml.c                           |   68 ++++++++
 output-zero.c                          |   74 +++++++++
 output.c                               |  270 ++++++++++++++++++++++++++++++++
 output.h                               |   93 +++++++++++
 wt-status.c                            |   88 ++++++++++-
 wt-status.h                            |    3 +-
 12 files changed, 985 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/technical/api-output.txt
 create mode 100644 output-json.c
 create mode 100644 output-normal.c
 create mode 100644 output-xml.c
 create mode 100644 output-zero.c
 create mode 100644 output.c
 create mode 100644 output.h
