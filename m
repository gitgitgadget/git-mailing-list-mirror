From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] help git-upload-pack find git
Date: Tue, 16 Sep 2008 17:38:54 +0200
Message-ID: <48CFD30E.7030206@drmicha.warpmail.net>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net> <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org> <48CEC3FB.5070101@drmicha.warpmail.net> <48CF4F6A.6080604@viscovery.net> <48CFB183.1090205@drmicha.warpmail.net> <48CFB81A.5060108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 17:42:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfch3-0001Y5-2d
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 17:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbYIPPi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 11:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYIPPi7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 11:38:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33958 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064AbYIPPi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 11:38:59 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0827A1614CC;
	Tue, 16 Sep 2008 11:38:58 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Sep 2008 11:38:58 -0400
X-Sasl-enc: 8h8bLgoz2wHdh88f56vGKxCcWoLc1Y29URgEoMeazf7v 1221579537
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 563822A14E;
	Tue, 16 Sep 2008 11:38:57 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48CFB81A.5060108@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96009>

Johannes Sixt venit, vidit, dixit 16.09.2008 15:43:
> Michael J Gruber schrieb:
>> Why is it that setup_path() cannot be done before commit_pager_choice()?
>> We need the pager in case list_common_cmds_help() is triggered, but why
>> can't setup_path() be before that? Not because of "--", really.
> 
> I think that setup_path() must be called *after* handle_options() because
> of this use-case:
> 
>   $ git --exec-path=/some/where foo
> 
> and git_set_argv0_path() must be called *before* handle_options() because
> of this use-case:
> 
>   $ git --exec-path
> 
> -- Hannes

Tricky, I see. But still I'm getting more and more confused:
handle_options() calls git_exec_path() in this case, which does (unless
there is argv_exec_path or the variable):
return system_path(GIT_EXEC_PATH)
Duh, that comes from the Makefile, -DGIT_EXEC_PATH... Back to somewhat
less confused state.

OK, now how about

A: path as submitted

or

B: leave git.c as is, except that setup_path(NULL) is used; have
setup_path(argv0path) call git_set_argv0_path() unless the arg is NULL;
tell upload-pack etc. to stuff (other setup_path() callers) their
argv[0] into setup_path(). Junio, is that what you meant?

Michael
