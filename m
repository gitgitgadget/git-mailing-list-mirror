From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/5] status, commit: separate "# " from the translatable
 part of output
Date: Fri, 25 Feb 2011 23:07:23 -0600
Message-ID: <20110226050723.GA27864@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 06:07:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCNl-0007Aj-Mr
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769Ab1BZFHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 00:07:38 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43070 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1BZFHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 00:07:37 -0500
Received: by vxi39 with SMTP id 39so1975389vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=EelyZr4wevME+5/4AXD9/SGNScN/1/0TzUayhH0fNbU=;
        b=aE8bUIgvA9SilDkm5hGfGvBzfbDg6iabZADkkLn/RHvk5TcNYs912oRd9JUJ4/BLYU
         TePwl5aR2cbLsjmhbFfN+mlehnJyXuD5FItbJy1cp8G7ZT59iUVPog/uccGIPTh2zf23
         4S627tHH8u/CtzmRdmlN1W0kJNq8rVeJVR1ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=VpPnfQjWepRGCypC1ITfXzGzdypaubeE20LVLGHSqsK5a/1tFHmAseg9WoYW7xj+sv
         h4S6QEfb6VfZqGIPjRqg6D/lrUPPxx0xmFBabRBKU/+gAUjF2Nf7hHcTktbR0jUeAoDu
         FRNHtSYZzOakMMOq2TSe83DqEwWv1/dgFkZdc=
Received: by 10.52.167.166 with SMTP id zp6mr5381072vdb.286.1298696857049;
        Fri, 25 Feb 2011 21:07:37 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id u4sm716331vch.36.2011.02.25.21.07.34
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:07:36 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167954>

Hi,

This series makes wt-status and builtin-commit code a little
less explicit about the '#' signs they produce in their output.
The main goal is to make messages like

		"\n"
		"It looks like you may be committing a MERGE.\n"
		"If this is not correct, please remove the file\n"
		"	%s\n"
		"and try again.\n"
		""

safe to translate by getting rid of the functionally important initial
# signs; a nice side effect is to make the source code a little easier
# to read and change (for example if we want to use some other kind
of formatting some day for "git status" output).

The first two patches (va_copy, strbuf_vaddf) are stolen from Jeff's
GIT_TRACE_FACET series.

Thanks for your help and patience so far.  I hope the series can be
useful.

Jeff King (2):
  compat: provide a fallback va_copy definition
  strbuf: add strbuf_vaddf

Jonathan Nieder (3):
  wt-status: add helpers for printing wt-status lines
  commit: refer to commit template as s->fp
  commit, status: use status_printf{,_ln,_more} helpers

 builtin/commit.c  |   58 ++++++++++----------
 color.c           |    9 +++
 color.h           |    3 +
 compat/msvc.h     |    1 -
 fsck.c            |   14 +----
 git-compat-util.h |    4 +
 merge-recursive.c |   15 +-----
 strbuf.c          |   27 +++++----
 strbuf.h          |    2 +
 trace.c           |   32 ++---------
 wt-status.c       |  160 ++++++++++++++++++++++++++++++++++++++--------------
 wt-status.h       |    7 ++
 12 files changed, 195 insertions(+), 137 deletions(-)
