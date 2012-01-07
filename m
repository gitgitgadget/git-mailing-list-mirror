From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Sat,  7 Jan 2012 12:42:42 +0100
Message-ID: <1325936567-3136-1-git-send-email-drizzd@aon.at>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 12:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUoE-0003Hb-2S
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 12:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab2AGLvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 06:51:12 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:36231 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751357Ab2AGLvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 06:51:11 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 31779CDF8C;
	Sat,  7 Jan 2012 12:52:01 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188070>

On Fri, Jan 06, 2012 at 02:49:05PM -0800, Junio C Hamano wrote:
> 
> but it seems that the best course of action would be to drop it
> and queue your re-roll afresh, aiming for the next cycle.

Here's the re-rolled series, also available as cb/git-daemon-tests based
on current master at https://github.com/drizzd/git .

[PATCH 1/5] run-command: optionally kill children on exit
[PATCH 2/5] run-command: kill children on exit by default
[PATCH 3/5] git-daemon: add tests
[PATCH 4/5] git-daemon: produce output when ready
[PATCH 5/5] git-daemon tests: wait until daemon is ready

On Fri, Jan 06, 2012 at 05:32:15PM -0500, Jeff King wrote:
> On Fri, Jan 06, 2012 at 08:48:00PM +0100, Clemens Buchacher wrote:
> 
> > I have rebased Junio's cb/git-daemon-tests onto your
> > jk/child-cleanup and replaced the call to pkill with a regular kill
> > command.
> 
> Looks pretty good from my cursory examination. I think you should fill
> out the rationale for "kill dashed externals on exit" a bit. My
> reasoning is that whether a git command is an internal or external
> process is purely an implementation detail, and killing the git wrapper
> should behave identically in both cases.

The previous version of this patch only changed the behavior for users
of run_command_v_opt, but not for those who filled out the child_process
structure by themselves. I could have manually enabled all of those, but
that felt unnatural. Instead, I have now reversed the meaning of
clean_on_exit to stay_alive_on_exit in [PATCH 2/5] run-command: kill
children on exit by default.  Cleanup is on by default and callers of
run_command must disable it if children should stay alive.
