From: Adam Lee <adam.lee@canonical.com>
Subject: [Closed] git-email: sendemail.bcc in config file overrides command
 line option "--bcc"
Date: Sat, 10 May 2014 00:26:08 +0800
Message-ID: <20140509162608.GA25057@adam-laptop>
References: <20140509081331.GC3145@adam-laptop>
 <20140509154509.GE18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 18:26:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Winco-0007OM-PD
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895AbaEIQ0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:26:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40305 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbaEIQ0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 12:26:14 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so3303759pad.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 09:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/H8Wcp5IGVQhcJZqylKzumJQKD5O71WXfuD+7pzwOBg=;
        b=T+WRk8CgJyUhQskc2vAa0FaYE4PCDZiLDtGuoq0DqMI+efIaa6mu8htSglEQB//QRw
         pg5jzCPQEa//BueXIAtdoVjNMsSCh1HfKbiqKsQ3l2dybIZhxEjpPFes4OEylznp25K/
         /iExPvpJxMUpsH0x34B1r8953UJCRKBmkY7OmFeUFCkBJYjqYi1elnroNJxqZ5unr5bA
         N13cAYsbA+fGUpiMxGgMK56xRoC0wXw0fnDLvs5WQuvqJ4JMS7Kvcbsjvh9+KQsq9bnf
         cUprjQ30+r17s5HCo/sKfWjyCkPhltpwsfcI0r00K3qS4z4o5mUR0siD2LSVr6t1mqsO
         PBjQ==
X-Gm-Message-State: ALoCoQlExlZpb2NTAl533UnRlnAhvTRun+DbRus5RLIHEIg7Jf2GLYqaG19ltsWkJYowlN+4sNIO
X-Received: by 10.66.140.104 with SMTP id rf8mr22081162pab.107.1399652773588;
        Fri, 09 May 2014 09:26:13 -0700 (PDT)
Received: from localhost ([202.108.52.194])
        by mx.google.com with ESMTPSA id ff4sm9922045pad.24.2014.05.09.09.26.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 09:26:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140509154509.GE18197@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248582>

On Fri, May 09, 2014 at 11:45:09AM -0400, Jeff King wrote:
> On Fri, May 09, 2014 at 04:13:31PM +0800, Adam Lee wrote:
> 
> > BugLink: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=747068
> > 
> > "--bcc" should have higher priority than sendemail.bcc.
> > 
> > > --bcc=<address>
> > >     Specify a "Bcc:" value for each email. Default is the value of sendemail.bcc.
> > >
> > >     The --bcc option must be repeated for each user you want on the bcc list.
> > 
> > Reproducing steps:
> > 1, set sendemail.bcc in .gitconfig.
> > 2, git send-email --bcc with another address.
> 
> Hrm, I cannot reproduce at all here:
> 
>   $ git config sendemail.bcc config-bcc@example.com
>   $ git send-email --dry-run --to=to@example.com -1 origin
>   (mbox) Adding cc: Junio C Hamano <gitster@pobox.com> from line 'From: Junio C Hamano <gitster@pobox.com>'
>   Dry-OK. Log says:
>   Sendmail: /usr/sbin/sendmail -i to@example.com gitster@pobox.com config-bcc@example.com
>   > [...]
> 
> OK, so our configured bcc works. Now let's override it:
> 
>   $ git send-email --dry-run --to=to@example.com \
>       --bcc=cmdline-bcc@example.com -1 origin
>   (mbox) Adding cc: Junio C Hamano <gitster@pobox.com> from line 'From: Junio C Hamano <gitster@pobox.com>'
>   Dry-OK. Log says:
>   Sendmail: /usr/sbin/sendmail -i to@example.com gitster@pobox.com cmdline-bcc@example.com
> 
> That looks like it's working as expected. Can you show us similar
> commands that demonstrate the failure?
> 
> -Peff

I can't reproduce it now, there might be something wrong in my command
lines, let's close it first. Thanks, Jeff.

-- 
Adam Lee
