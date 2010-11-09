From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 9 Nov 2010 08:06:15 -0600
Message-ID: <20101109140615.GA18960@burratino>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 <1285649702-24773-1-git-send-email-pclouds@gmail.com>
 <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
 <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
 <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 15:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFoqS-0002a2-IN
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 15:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab0KIOGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 09:06:37 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0KIOGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 09:06:36 -0500
Received: by ywc21 with SMTP id 21so4259188ywc.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tfIQhn8zXSIys7q+XKVqKfV7n+8MXnI24s7EaU6k1R4=;
        b=HPTVorUszy1sxsezwNHVoOGAkh4TK4OApQCIhwSveozFOydmT75vS6PKY3BmBo66Ec
         uthMiwuUWsRa4/SLNDMvr+f5waUZtz1b51nnsvx2G67IpelO+q75TGZBPAO0zEgYc/Mg
         lrmbhOcBS/3e6J9jJQ9elnzrJZYjWUxxTjwLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JXYiaVDDc8LZZoVTPDwZPIJKNuYUZaMPDfLqb9a4kjb9V02yxtckku6gw85VsL8JS6
         kvpUC84+iNFinfY2mg0kk4/+i7nnHR3wJah7xH1nxNtxApI+rM0S59BLTPM1U+g6ISC+
         12Nvubu2OL3JyGWXk5XZumW09dFKfdIQewtc0=
Received: by 10.42.229.133 with SMTP id ji5mr717099icb.128.1289311594914;
        Tue, 09 Nov 2010 06:06:34 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i16sm1397288ibl.0.2010.11.09.06.06.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 06:06:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161048>

Nguyen Thai Ngoc Duy wrote:

> Another approach is to let checkout work as usual, but refuse update refs:
> 
>  - after rebase starts, HEAD can only be updated either by rebase, or
> any commands that keep HEAD a headless ref.
>  - the branch being rebased is locked. No commands but rebase can update it.
> 
> I think the second point is good for all interactive commands like
> rebase. Create a .lock file with a signature inside (e.g. command
> name). If update_ref() callers do not give correct signature, refuse
> to update.

I like it.  Would it be possible to make sure the (widespread?) practice
of using

	rm -fr .git/rebase-merge

to terminate a rebase without going back to the original branch
still works?  I think it should be.
