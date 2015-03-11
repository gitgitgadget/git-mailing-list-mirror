From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [JFF] "-" and "@{-1}" on various programs
Date: Wed, 11 Mar 2015 13:38:47 +0100
Message-ID: <55003757.8090004@drmicha.warpmail.net>
References: <xmqqy4n4zjst.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 13:38:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVfuY-000255-VB
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 13:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbbCKMiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 08:38:50 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34033 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367AbbCKMit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 08:38:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 8EEAB205EF
	for <git@vger.kernel.org>; Wed, 11 Mar 2015 08:38:47 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 11 Mar 2015 08:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=yuEhWuZUfb1/BzLFc8hGzs
	sT/XQ=; b=VYFBjbLpzs+xQhE8OvQ1K0dcO6P0bpCvOnCthG+awDOGpaoJ30r4jq
	fPFREJDuIvJt7FsUUh/b23SN4X5X9mxdMkw8t3wwXmekrXj4/DJvMPy4AXGItAgr
	iiE1pVx58KOaVbXVzESfNiuGMa+hULT0WHMEzmlK6kKG9iXm7ijN4=
X-Sasl-enc: BqHGI9dcOQY3W2HCDNk8REMXELoZOdkU1wPiNSbveq5q 1426077528
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B20B0C00297;
	Wed, 11 Mar 2015 08:38:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqy4n4zjst.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265323>

Junio C Hamano venit, vidit, dixit 10.03.2015 21:20:
> JFF stands for just for fun.
> 
> This is not meant to give out a model answer and is known to be
> incomplete, but I was wondering if it would be a better direction to
> allow "-" as a stand-in for "@{-1}" everywhere we allow a branch
> name, losing workarounds at the surface level we have for checkout,
> merge and revert.
> 
> The first three paths are to remove the surface workarounds that
> become unnecessary.  The one in sha1_name.c is the central change.
> 
> The change in revision.c is to allow a single "-" to be recognized
> as a potential revision name (without this change, what begins with
> "-" is either an option or an unknown option).
> 
> So you could do things like "git reset - $path" but also things like
> "git log -" after switching out of a branch.
> 
> What does not work are what needs further tweaking in revision.c
> parser.  "git checkout master && git checkout next && git log -.."
> should show what next has on top of master but I didn't touch the
> range notation so it does not work, for example.
> 
>  builtin/checkout.c |  3 ---
>  builtin/merge.c    |  3 +--
>  builtin/revert.c   |  2 --
>  revision.c         |  2 +-
>  sha1_name.c        | 57 +++++++++++++++++++++++++++++++++---------------------
>  5 files changed, 37 insertions(+), 30 deletions(-)

Like it :)

It removes the special casing and makes a shorthand available
systematically. I'd say it's useful even without extending it to ranges.

Michae
