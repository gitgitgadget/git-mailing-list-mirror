From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/3] completion: fix alias listings with newlines
Date: Thu, 08 Oct 2009 00:34:53 -0700
Message-ID: <4ACD961D.9080401@gmail.com>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com> <4ACC6055.1070204@viscovery.net> <4ACCE417.5080907@gmail.com> <20091008042917.GX9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 09:34:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvnW7-0006s5-NB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 09:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbZJHHdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 03:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbZJHHdT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 03:33:19 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:37517 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZJHHdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 03:33:18 -0400
Received: by gxk4 with SMTP id 4so6712588gxk.8
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=3iCRZ421pXK1YIBJ+Xo+GMsBZPnn8XImKHdQmtd2wW8=;
        b=DBSQU0kE0tEiCmNmTfdysoyRQ6/7SEhCPg+4elcpaAALlE7xOe+KdmP9aU6WvWUlt6
         oIQ/Bk2ydfER6fPf7pkHAR8PD2Q41El8ta25dOxrTo/RW/JD8CFMMCeRpi9V9BZYmzkD
         0Mj0hDWeYvky7J17nioPmgPnjuB67omY7gDZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=wVps6hxR/XoW8qa5ZxhZYYmVl6Xpr956ZRTKk5kXPBv1i8vGxts1Af2/bTpgtIxFEj
         Le6tAuUFRPYwPsMrFcwgOlsAUBGtZpn0W6v1ttNl1goPowKgc3T/+NFnJhwRvS2z0qdt
         cDKi4D3PVN7oONLveibt4t0P6lglRKlk/Xr8w=
Received: by 10.150.19.4 with SMTP id 4mr1715312ybs.216.1254987162311;
        Thu, 08 Oct 2009 00:32:42 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 16sm429657gxk.15.2009.10.08.00.32.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 00:32:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <20091008042917.GX9261@spearce.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129679>

Shawn O. Pearce wrote:
>
> Yes, we should try to avoid spawning a process here, it fires on
> each completion attempt if I recall.
>

Ok. It looks like it fires on every completion with no command (i.e. git
<TAB><TAB>). I don't particularly like my solution anyways, and this has
existed for a long time (56fc25f maybe?) with no one noticing. A fix for
it is probably not too pressing.

I found another problem, [ARGS] and COMMAND show up in git <TAB><TAB>.
Looks like it's due to the wrapping of git's usage string.

>
> Or a format string with a language based escape like for-each-ref
> supports?  Might make it easier to use git config in scripts if we
> can write things like:
>
>   git config --format='$data{%(key)}=%(value);' --perl

This sounds reasonable, but also like more work ;-)
