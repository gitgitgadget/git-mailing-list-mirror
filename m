From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH] daemon: enable SO_KEEPALIVE for all sockets
Date: Wed, 25 May 2016 23:11:14 +0000
Message-ID: <20160525231114.GA20691@dcvr.yhbt.net>
References: <20160525031505.5720-1-e@80x24.org>
 <xmqq37p5zrjk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 01:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hxP-0007M7-9p
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbcEYXLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 19:11:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43414 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbcEYXLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:11:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4241FCC7;
	Wed, 25 May 2016 23:11:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq37p5zrjk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295614>

Junio C Hamano <gitster@pobox.com> wrote:
> This makes sense as a follow-up to e47a8583 (enable SO_KEEPALIVE for
> connected TCP sockets, 2011-12-06), I think.

Yes, a15d069a19867 for http, too; hat trick :>

Anyways, it might've helped Savannah when they had networking
problems:

  http://mid.gmane.org/20160524214102858920068@bob.proulx.com

They might be running an old version that didn't send keepalive
heartbeats during packing, too.  But SO_KEEPALIVE will still
help during init when --init-timeout is not set.

Perhaps it also makes sense to squash the following xinetd
setting into giteveryday.txt, too; since some users could be
running out-of-date git but reading new documentation on
the web:

--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -390,6 +390,7 @@ service git
 	server          = /usr/bin/git-daemon
 	server_args     = --inetd --export-all --base-path=/pub/scm
 	log_on_failure  += USERID
+	flags           = KEEPALIVE
 }
 ------------
 +
