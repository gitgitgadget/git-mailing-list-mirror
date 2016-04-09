From: "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sun, 10 Apr 2016 00:29:45 +0200
Message-ID: <57098259.1060608@jupiterrise.com>
References: <570965B9.9040207@jupiterrise.com>
 <20160409210429.GB18989@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 10 00:38:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap1WK-0007gq-5i
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 00:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbcDIW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 18:29:51 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:44347 "EHLO
	homiemail-a112.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbcDIW3v (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 18:29:51 -0400
Received: from homiemail-a112.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a112.g.dreamhost.com (Postfix) with ESMTP id 4F2A32005E803;
	Sat,  9 Apr 2016 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
	:to:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=jupiterrise.com; bh=q
	6UhPmVOt8w1zC6oKfFsLOabGzA=; b=Ci/hxNgoe37NBcuuqVOl3z7XBeorbqmvP
	XhyBZchnYcEnAxNC2+HQArjJqMmAirLYyv9wAkT8XfDS8aSJ5J1aZKv6b5vJFzry
	UoCBXPjzzj+XJAm9BegvCk1k07ff0bCOq2u+YX1fzk++YOxJsl18bSh8wd1YtFnP
	1mjlIaHeHA=
Received: from localhost6.localdomain6 (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tgc99@jupiterrise.com)
	by homiemail-a112.g.dreamhost.com (Postfix) with ESMTPSA id D9EAF2005E802;
	Sat,  9 Apr 2016 15:29:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u39MTj3c008901;
	Sun, 10 Apr 2016 00:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160409210429.GB18989@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291135>

On 09/04/16 23:04, Jeff King wrote:
> I did some quick grepping around, and I suspect you may run
> into the same thing in other places (e.g., t3404.40 looks
> like a similar case).

There are only a few tests that fail and just t5532.3 seems affected by 
this issue.

> Subject: [PATCH] t5532: use write_script
>
> The recent cleanup in b7cbbff switched t5532's use of
> backticks to $(). This matches our normal shell style, which
> is good. But it also breaks the test on Solaris, where
> /bin/sh does not understand $().
>
> Our normal shell style assumes a modern-ish shell which
> knows about $(). However, some tests create small helper
> scripts and just write "#!/bin/sh" into them. These scripts
> either need to go back to using backticks, or they need to
> respect $SHELL_PATH. The easiest way to do the latter is to
> use write_script.
>
> While we're at it, let's also stick the script creation
> inside a test_expect block (our usual style), and split the
> perl snippet into its own script (to prevent quoting
> madness).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   t/t5532-fetch-proxy.sh | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>

I applied this to 2.8.1 and as expected the test now passes on Solaris.

-tgc
