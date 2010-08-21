From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 3/5] fmt-merge-msg: Update command line options to
 sync with config options
Date: Sat, 21 Aug 2010 11:21:54 +0530
Message-ID: <20100821055152.GH6211@kytes>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-4-git-send-email-artagnon@gmail.com>
 <20100821040203.GA2636@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 07:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omh1d-0001hk-O3
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 07:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab0HUFxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 01:53:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52800 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0HUFxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 01:53:48 -0400
Received: by pzk26 with SMTP id 26so1526918pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 22:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DJQmZ2nfbZwhqaMginpBpdChzVPlPmb2cG+dX1JJObM=;
        b=gY2kT6fQq5CtB0RyCeWcaa/ZGxcOxbKTETX2QV6RPa5kGPWmVbB9adHPB7Sw65z1Jh
         cZvq7S4XXKhgsVtjVB//wgevCQ0AsM6dvuZF+ZdPaD4mox9Qy6BKLRdEqEvynif56MhS
         SFam/ZgRi8gcsD052iiL0GsK8Phmtm4G4kr8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pVGajuttwiVU6sRFt7dZEgkDr6ANostzGDaPu05tpTZrhy14bS/2EVXNoR/D2c+f4g
         Awa15ZNUotd0LKr18rVQMOj1B22vgvNLPpaf8SdUmiv+UhtB/Dy0QlN91fGfj2l9XFNi
         lC9kbym+nuBdmKhIZMSQoWhnaJ4/Da1JZKgEY=
Received: by 10.114.88.17 with SMTP id l17mr2578455wab.218.1282370028028;
        Fri, 20 Aug 2010 22:53:48 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id q6sm6453975waj.10.2010.08.20.22.53.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 22:53:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100821040203.GA2636@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154112>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > +++ b/builtin/fmt-merge-msg.c
> > @@ -7,11 +7,10 @@
> >  #include "string-list.h"
> >  
> >  static const char * const fmt_merge_msg_usage[] = {
> > -	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
> > +	"git fmt-merge-msg [-m <message>] [--log=[<n>]|--no-log] [--file <file>]",
> 
> [--log[=<n>]], no?

Right, my bad.

> > @@ -328,10 +326,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
> >  	const char *inpath = NULL;
> >  	const char *message = NULL;
> >  	struct option options[] = {
> > -		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
> > -		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
> > +		{ OPTION_INTEGER, 0, "log", &log_limit, "n",
> > +		  "populate log with <n> entries from shortlog",
> > +		  PARSE_OPT_NOARG, NULL, 20 },
> > +		{ OPTION_INTEGER, 0, "summary", &log_limit, "n",
> >  		  "alias for --log (deprecated)",
> > -		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
> > +		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 20 },
> 
> OPTARG, I think.

OPTARG works. Sorry for the NOARG confusion.

-- Ram
