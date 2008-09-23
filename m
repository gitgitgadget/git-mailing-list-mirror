From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 01:28:58 +0400
Message-ID: <20080923212858.GU21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <20080923153148.GI3669@spearce.org> <20080923171209.GP21650@dpotapov.dyndns.org> <20080923190637.GJ3669@spearce.org> <20080923200456.GR21650@dpotapov.dyndns.org> <20080923201739.GK3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFSa-00047Q-FS
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbYIWV3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYIWV3G
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:29:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:55302 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYIWV3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:29:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1856500fgg.17
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JBmX981B/5bMO1aIp0Cak5/7URsFjw43FQ5N2lKfsbQ=;
        b=Lltuo2veF82kfaWU6BGX1bcFCciQ4QTbsaRiRESWwp2bT0n6rzi9ve6rdpDYET47uk
         3nxBaCINuXHnRNeV0Or8Vwb0YWlTJRcb5tNG+hOo/YCkXS3dgkzUf00tuik23JPMOt+y
         /4CSRsB7Xc/zT9gp5QoYc3lhb4F4fdApesSZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ly2veZE0mXuxl6siNzU8nQYEDHn2tM+hrq1SetkXFPBg6eCnlCkuCGp+xGEdO0xhot
         YS/AP5eCCJy4ZpVk1tSnRjgc35jjT8MmHRZ5HPtASV4EV5vcF54bs3oVaYnQmJJ6QmUs
         iZO9J1SAkDguY2kpCQbI7bVsV8uVdCyHqJ03M=
Received: by 10.86.92.4 with SMTP id p4mr6708532fgb.45.1222205342795;
        Tue, 23 Sep 2008 14:29:02 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id 3sm8381525fge.3.2008.09.23.14.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 14:29:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080923201739.GK3669@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96604>

On Tue, Sep 23, 2008 at 01:17:39PM -0700, Shawn O. Pearce wrote:
> Dmitry Potapov <dpotapov@gmail.com> wrote:
> > 
> > static void init_stat(void)
> > {
> > 	git_config(git_cygwin_config, NULL);
> > 	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
> > 	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
> 
> if (native_stat < 0 && have_git_dir()) {
> 	native_stat = 0;
> 	git_config(git_cygwin_config, NULL);
> 	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
> 	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
> }

I am not sure that I understand what you are trying to do here.

First, in my implementation, init_stat was supposed to always set
cygwin_stat_fn() and cygwin_lstat_fn(), otherwise the code is going
to hit the NULL pointer call.

Second, the check of native_stat < 0 is absolutely useless, because once
we set cygwin_stat_fn and cygwin_lstat_fn, we are never going to call
init_stat() again.

Did you mean this:

	if (have_git_dir())
		git_config(git_cygwin_config, NULL);
	else
		native_stat = 0
	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;

Or:

if (have_git_dir()) {
	git_config(git_cygwin_config, NULL);
	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
}

and

> > static int cygwin_stat_choice(const char *file_name, struct stat *buf)
> > {
> > 	init_stat();
> > 	return (*cygwin_stat_fn)(file_name, buf);

change the above line to:
	return (cygwin_stat_fn ? cygwin_stat_fn : stat) (file_name, buf);

so init_stat may be called a few times outside of git directory and then
use the default cygwin function, and once we enter to it then load the
configuration option and act accordingly.

Dmitry
