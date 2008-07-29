From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>"
	(solves part of problem with system_path)
Date: Mon, 28 Jul 2008 22:24:59 -0700
Message-ID: <20080729052459.GC11947@spearce.org>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de> <1217308647-23673-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhiy-0005S2-Gf
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYG2FZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYG2FZA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:25:00 -0400
Received: from george.spearce.org ([209.20.77.23]:60341 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYG2FZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:25:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7EA55383A5; Tue, 29 Jul 2008 05:24:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217308647-23673-1-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90575>

Steffen Prohaska <prohaska@zib.de> wrote:
> We prefer running the dashless form, so we should use it in MinGW's
> start_command(), too.
...
>  - We have non-builtins that are implemented in C, e.g. fast-import.c.
>    These non-builtins will still compute wrong paths.

This feels wrong to me.  fast-import probably won't be adversly
impacted by not being able to read /etc/gitconfig, unless the user
has set something like core.deltaBaseCacheLimit and is doing an
incremental import.  But other non-builtins may be impacted.

It feels like we're fixing this in the wrong place.  If the issue
is we don't find our installation directory correctly, we should
find our installation directory correctly, not work around it by
calling builtins through the git wrapper.

Though I can see where it may be a good idea to at some point
in the future (git 1.7?) stop creating the redundant builtin
links under libexec/git-core.

-- 
Shawn.
