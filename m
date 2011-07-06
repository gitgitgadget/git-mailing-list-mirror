From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/14] revert: Separate cmdline parsing from functional
 code
Date: Wed, 6 Jul 2011 04:13:34 -0500
Message-ID: <20110706091334.GE15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:13:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOAy-0005E6-Nl
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab1GFJNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 05:13:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39741 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab1GFJNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 05:13:38 -0400
Received: by iyb12 with SMTP id 12so5924958iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WDEE3CaqSTjU4LbWp4XBw1Z74KRcA7iiKsPB3GgSsVc=;
        b=GNpu5liTUz7EsiZCB5PaSq+xH5JtRm+8p1M9wHoQKhX2awosFePkUzZS92GdSjfvGX
         8OEPRxrmUMT1sFGSx9EaUcIl0MiCRUTU9d1LCLs8LpWZkHSaO6BZbuusVNVw+CS4hqHJ
         iKECjVldYUEf4vJPPWn2ouqibsbaYTsbm5e50=
Received: by 10.42.179.199 with SMTP id br7mr8321463icb.381.1309943618309;
        Wed, 06 Jul 2011 02:13:38 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id f13sm4760171ibe.10.2011.07.06.02.13.36
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 02:13:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176668>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -612,7 +610,10 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  
>  	memset(&opts, 0, sizeof(struct replay_opts));
>  	opts.action = CHERRY_PICK;
> -	res = revert_or_cherry_pick(argc, argv, &opts);
> +	git_config(git_default_config, NULL);
> +	me = "cherry-pick";
> +	parse_args(argc, argv, &opts);
> +	res = pick_commits(&opts);
>  	if (res < 0)
>  		die(_("%s failed"), me);
>  	return res;

I'd put the "me =" line right after "opts.action =" if doing it this
way.  This means callers to pick_commits() are responsible for setting
the "me" variable and in particular it will not make sense to export
that function to callers outside of this file any more, right?
