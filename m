From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WRONG/PATCH 1/3] revisions: clarify handling of --no-walk and
 --do-walk
Date: Thu, 21 Apr 2011 15:03:32 +0200
Message-ID: <4DB02B24.4030503@drmicha.warpmail.net>
References: <20110421102241.GA16185@elie> <20110421103926.GA16260@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCtXq-0000Zo-OM
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 15:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab1DUNDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 09:03:38 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34847 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752124Ab1DUNDh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2011 09:03:37 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 19C1120D1C;
	Thu, 21 Apr 2011 09:03:36 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 21 Apr 2011 09:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=apizyZO2F27WgrKLkKMTH7FQEPc=; b=RKWGCZM/DMcBYRJffRCRsz2rlpE8+/9NcGVZonE6HOd3z6wQMYF81JGHFD8iYb5ZzNc+Tn2rIdQYvks1it/SZdFpmPuvmuqNTcOKvsCU7hFgGjUXlg7NCNbfwTMxX9IVIfdgGw1c6/NZt245utoGVBOb5VIu/7fTjyJuk55AnS0=
X-Sasl-enc: HcI1Lacj6QYkE7taVsTFMfaGOsq5pZBOlFoebidmQNVq 1303391015
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6AB084445E4;
	Thu, 21 Apr 2011 09:03:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110421103926.GA16260@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171904>

Jonathan Nieder venit, vidit, dixit 21.04.2011 12:39:
> As v1.6.0-rc2~42 (Allow "non-option" revision options in
> parse_option-enabled commands, 2008-07-31) explains, commands which
> use parse_options() but also call setup_revisions() do their parsing
> in two stages:
> 
>  1. first, they parse all options. Anything unknown goes to
>     parse_revision_opt() (which calls handle_revision_opt), which
>     may claim the option or say "I don't recognize this"
> 
>  2. the non-option remainder goes to setup_revisions() to
>     actually get turned into revisions
> 
> Some revision options, like --all and --not, are "non-options" in that
> they must be parsed in order with their revision counterparts in
> setup_revisions().  It would be nice if --no-walk and --do-walk fell
> in this category and set a flag only for revs coming after them on the
> command line, but they do not, so move parsing of --no-walk and
> --do-walk to the first "global options" stage for clarity.
> 
> ---
> Wait, the above is not actually the full story.  If I do
> 
> 	git show maint..master
> 
> then this turns on walking automatically, to give the commit range
> meaning.  Likewise
> 
> 	git log --no-walk maint..master
> 
> will, in fact walk, but
> 
> 	git log maint..master --no-walk
> 
> will not.  Which I should have understood from v1.6.0-rc2~42
> (2008-07-31) already.  Will think more; sorry for the nonsense.

This is not unrelated to the tip of gitster/mg/show-without-prune, i.e.

0c738b6 (builtin/show: do not prune by pathspec, 2011-04-01)

See http://permalink.gmane.org/gmane.comp.version-control.git/170461

We should rethink the ui balance between deviating from the usual log
option processing and the usefulness here.

Michael
