From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/11] revert: Introduce a struct to parse command-line
 options into
Date: Sun, 10 Apr 2011 14:21:54 -0500
Message-ID: <20110410192154.GB28163@elie>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <1302448317-32387-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90DE-0005Y6-2B
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab1DJTWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 15:22:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49959 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab1DJTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:22:00 -0400
Received: by iwn34 with SMTP id 34so4985581iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZoL/GPkxMxzhem5ifM1QEDt3Dajvh0UrdlmahhOsFeA=;
        b=bLHavgZDJX277HFSYCCBi+Q4q2kzCubBE3WmdlZD9ZVebuuLRfIyOE0tlD2WBWIW8j
         7TmvqrufLFRqZouQxgDF/diwZ2RayXI5eqvjB6jHgDB4ksyYIxCpn6sGZvQ/544yuuE+
         FDs3KTlZRy0Fl4M97P8Es9Zt35OVabeiTA15M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MyCTiBi7xg9Xj4JSHMd9Gqi50LOp4ocAW/WatW5uFmCUECpUpON598yx/6axVKGLkM
         FNXi03FaCN0uLkV47c6kxiV6G1Y8XUmnm9ZR/11DstO8oJ/6810PoFHMrAZIGlEYi/s3
         9KdR8U411U15ytSLwokgkwRxES/xUXPfyEFNo=
Received: by 10.42.227.135 with SMTP id ja7mr6067091icb.489.1302463319204;
        Sun, 10 Apr 2011 12:21:59 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.sbcglobal.net [69.209.51.92])
        by mx.google.com with ESMTPS id xe5sm3269087icb.10.2011.04.10.12.21.57
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:21:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302448317-32387-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171272>

Ramkumar Ramachandra wrote:

> [Subject: revert: Introduce a struct to parse command-line options into]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

This gives a hint of another way to avoid the usage() trouble
mentioned in patch 1: it might be possible to let the caller take care
of parsing arguments.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -35,17 +35,27 @@ static const char * const cherry_pick_usage[] = {
>  	NULL
>  };
>  
> -static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
> -static enum { REVERT, CHERRY_PICK } action;
> -static int commit_argc;
> -static const char **commit_argv;
> -static int allow_rerere_auto;
>  
> +static struct {
> +	enum { REVERT, CHERRY_PICK } action;

That would require giving this struct a name, so it can be passed
around.  Not a bad idea anyway imho since then a person reading
top-to-bottom is not left in suspense:

 struct cherry_pick_opts {
	enum { REVERT, CHERRY_PICK } action;

	unsigned edit:1;
	unsigned no_replay:1;
	...
 };
