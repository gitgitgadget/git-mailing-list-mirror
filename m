From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 12:37:29 +0100
Message-ID: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Cc: Eric Raymond <esr@thyrsus.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 13:39:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0vVB-0003bK-P1
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 13:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab0DKLig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 07:38:36 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41427 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065Ab0DKLi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 07:38:28 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id AC94A819C4C7;
	Sun, 11 Apr 2010 12:38:20 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 6888820CF48;
	Sun, 11 Apr 2010 12:38:26 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HQ1jJQLtY8Fl; Sun, 11 Apr 2010 12:38:25 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 44DE520CF47;
	Sun, 11 Apr 2010 12:38:25 +0100 (BST)
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144642>

Here is an attempt at making a format agnostic structured output library.  The
idea being that the command doing the output doesn't have to care what the
actual output format is, it just uses the abstract notion of objects and arrays.

The current backend/frontend interface probably needs expanding so that a less
noddy XML output can be used, but it's a start.

Rather than building an in-memory structure and then writing it out I've gone
for the approach of writing out immediately.  The thought behind this was that I
didn't really want to force commands like log to have to wait 'til the end to
start outputting information.

The JSON output is formatted differently from my previous JSON-only status
modification, but the actual information output is the same (i.e. the output of
a json parser should be identical ignoring item ordering in objects).

Julian Phillips (3):
  strbuf: Add strbuf_vaddf function
  add a library of code for producing structured output
  status: add support for structured output

 Makefile         |    3 +
 builtin/commit.c |   12 +++
 output-json.c    |  128 ++++++++++++++++++++++++++++++++
 output-xml.c     |   68 +++++++++++++++++
 output.c         |  212 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 output.h         |   71 ++++++++++++++++++
 strbuf.c         |   13 +++-
 strbuf.h         |    1 +
 wt-status.c      |   73 +++++++++++++++++++
 wt-status.h      |    2 +
 10 files changed, 581 insertions(+), 2 deletions(-)
 create mode 100644 output-json.c
 create mode 100644 output-xml.c
 create mode 100644 output.c
 create mode 100644 output.h
