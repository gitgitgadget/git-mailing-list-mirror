From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Wed, 1 Dec 2010 09:49:59 -0600
Message-ID: <20101201154959.GA26120@burratino>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
 <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
 <AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com>
 <AANLkTik9R2dRDDBUHBZ_OKPKto0wDAxr1V0uL=q4bU+4@mail.gmail.com>
 <AANLkTik-OKsUK2aJCDR0Q-FyQM=rrFQmx=Hwdyr5NzYt@mail.gmail.com>
 <AANLkTinzCeaiFoL4a-+c6wuJoUQ68zC9vE8AoHfmvN-F@mail.gmail.com>
 <AANLkTikfAr-KUVyqeTooxYKvKWYM4pRmw51if+349dpJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNowl-0006Ad-7r
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab0LAPuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:50:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38668 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab0LAPuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:50:10 -0500
Received: by vws16 with SMTP id 16so369452vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gTLuiGV2Xy4/H1F+jG7DSd9Foe+oBgTb1lpSubQwMC0=;
        b=OjIVPk3isIJLQ4cRTeCvbulOXsJIxCAFJAjqjqnkKVN4v0uDWkkZYlXmQgiLOqaWk+
         SLOI6Sg0FaQOJiFa1NdjoCxQ3fFwRbsSrTkNQbqimBPDuGIaMpe4R3EGa5bTKEDJkGcP
         Eil+WWzgvMOuaRF/USLV1dqzu2n0eO5MaEnos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ab2uiW3GjILT4BS/H7vwPyo7CxCdHtv95X3qH3DSydCWKaKtXH4F/vMsKIxap47dbV
         pcNrbWV5afUBHFWmyDs/dLiyKzGIt+eTWPmsma97xna5qWW9B/zLvMvy4UDBBEDMG15N
         9wgiVaKFaslFttoCjatstOiw+KF28r4mt+61U=
Received: by 10.220.190.3 with SMTP id dg3mr1730592vcb.254.1291218609829;
        Wed, 01 Dec 2010 07:50:09 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id j21sm31710vcr.10.2010.12.01.07.50.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 07:50:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikfAr-KUVyqeTooxYKvKWYM4pRmw51if+349dpJ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162538>

Giuseppe Bilotta wrote:

> I will look into adding support for the BROWSER environment variable
> to select the browser if no browser is defined

Thanks, that sounds excellent.

BTW, the semantics of quoting characters/shell metacharacters in
$BROWSER are not well defined (well, they're well defined in one way
by the original spec, which is ignored by xdg-open and some other
tools).  xdg-open's semantics are probably the most reliable standard
here but thought I should give a heads up.

Thinking out loud: longer term, it would be nice to just use xdg-utils
and drop most of this logic from git.  Presumably the ideal behavior
for most apps opening web pages is already "new tab", so the cases of
"new window" not explicitly configured that way by the user are bugs.
Otherwise a request to portland@lists.freedesktop.org (subscription
required) for xdg-open --new-tab/--new-window might be useful.

Regards,
Jonathan
