From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Make gc a builtin.
Date: Mon, 12 Mar 2007 04:07:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703120403360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
 <1173650820969-git-send-email-jbowes@dangerouslyinc.com>
 <Pine.LNX.4.63.0703112332550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzwrtdmx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 04:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQat7-0005Ar-E0
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 04:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbXCLDHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 23:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbXCLDHr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 23:07:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:48660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964868AbXCLDHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 23:07:46 -0400
Received: (qmail invoked by alias); 12 Mar 2007 03:07:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 12 Mar 2007 04:07:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ALVdrlHiAESopiKBDNIyYPbHp7c9Sv0wKtApBEB
	hDAw2n9DnRfsBx
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vtzwrtdmx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42007>

Hi,

On Sun, 11 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > And instead of die()ing, I'd rather do something like
> >
> > 	return (pack_refs || run_command_v_opt(argv_pack_refs, RUN_GIT_CMD) &&
> > 		run_command_v_opt(argv_reflog_expire, RUN_GIT_CMD) &&
> > 		run_command_v_opt(argv_repack, RUN_GIT_CMD) &&
> > 		(prune || run_command_v_opt(argv_prune, RUN_GIT_CMD) &&
> > 		run_command_v_opt(argv_rerere, RUN_GIT_CMD);
> 
> Gaaaaaaaah.
> 
> That may be valid C,

Actually, it is not. As usual, I fscked up: run_command_v_opt() is 
supposed to return 0 on _success_, so all the "&&" should be "||", and all 
the "||" should be "&&".

> 	if (we are told to pack-refs)
>         	if (try to pack refs and find error)
> 			goto failure;

I find this not very elegant. Instead, I'd do

	if (do_pack_refs && run_comand_v_opt(argv_pack_refs, RUN_GIT_CMD))
		return error("Could not run pack-refs.");

It does not only avoid the evil goto, but uses the screen estate for some 
nice error messages so that the user is not left out in the cold when 
something is wrong.

Ciao,
Dscho
