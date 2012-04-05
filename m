From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not
 make sense
Date: Thu, 5 Apr 2012 13:43:45 -0500
Message-ID: <20120405184345.GA6448@burratino>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
 <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 20:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFrf8-0005hd-PT
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 20:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab2DESn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 14:43:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64532 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab2DESn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 14:43:57 -0400
Received: by iagz16 with SMTP id z16so2108346iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9CkHTRIX/dzh6Fbl2bZ07PysnefFhTuXy1v0YxX8HQA=;
        b=RmO9+UtvlxNVv/6JM6miXU6IeQ8fAZbuZ0YEeiye3YetiJrPOarXruKxS3uI7EVh49
         cO1t7eVxi9FmrpVceFQg97Kg06s1PXaqnDMGiLTx1sHEb+la7jeWpgXS+gSxasL1wLbs
         gLzp0RMv6cCgb70kgG+lKpdoayAew6In10wlUEIQXyAiR5VUcBekWGT23cQ9toeD88Cd
         4KNaEpX2lLnvwWxhC/a8Xz4rqKpQ1in/bF000xyYXP022YhI46Mi/r6qwRnF8vPHiNJK
         HGsh23excfcHEiy2c5mauVWajm2PMmDNbr8xiMSMuESu8c4VSjFY+lgnDe/YMZgEgXKD
         f57Q==
Received: by 10.50.158.227 with SMTP id wx3mr6147956igb.31.1333651436627;
        Thu, 05 Apr 2012 11:43:56 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xf6sm13275377igb.13.2012.04.05.11.43.54
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 11:43:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194793>

Junio C Hamano wrote:

> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -65,6 +65,16 @@ static void set_refspecs(const char **refs, int nr)
[...]
> @@ -87,6 +97,11 @@ static void setup_push_upstream(struct remote *remote)
>  	if (branch->merge_nr != 1)
>  		die(_("The current branch %s has multiple upstream branches, "
>  		    "refusing to push."), branch->name);
> +	if (strcmp(branch->remote_name, remote->name))
> +		die(_("You are pushing to remote '%s', which is not the "
> +		      "upstream of your\ncurrent branch '%s'.\n"),
> +		    remote->name, branch->name);
> +

I worry that a beginner seeing this message would think it means that
when "master" is set up to track origin/master that there is no way to
push that branch to any other repository.

Maybe something like

		die(_(
"You are pushing to remote '%s', which is not the upstream of your\n"
"current branch '%s', without specifying a refspec.\n"),
		    remote->name, branch->name);

would be harder to misunderstand.
