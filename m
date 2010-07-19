From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 08:12:03 +0100
Message-ID: <1279523523.3077.8.camel@dreddbeard>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <201007181355.36691.jnareb@gmail.com> <1279484847.8999.22.camel@dreddbeard>
	 <201007190119.04873.jnareb@gmail.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 09:12:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OakWX-0005vW-Hc
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 09:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab0GSHMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 03:12:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53107 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0GSHMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 03:12:07 -0400
Received: by wyb42 with SMTP id 42so4087485wyb.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=IY7NcxggtxYH1UO/Pf9DT5oqBMZg1c6e/dgJ1eRBTPo=;
        b=czoeaBPCbdJOwrljI/QxpEuARK+uVmGzuNWdTREUuvK9a/qy/SDycdhl4ITSHwSivC
         wAy4crqLUg8PUdkAy2ukbh3eGvlvtFXdoV4LUhVTrQ8GZmT7CZI8LREif8Mpxme1F6m4
         KFC18a0TT+bPXjIYvKm3ziWijQ+qSA+Q9QUfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=xx7kw4SnAphtsSb9bjuUVL5hObPrMMFwUEwu5kn4jg3xUovB6p3K27LS4Zzq744EEW
         DCnQBoQe28XbE7t+gMa8ZEPvQ/nSfPcT6NetOK7VPi1mOaK01YeRAIloIACyWvMmUMPi
         lnKgJeuEcgi4nVR55xfKhPBB322YPgSWbXeMg=
Received: by 10.227.157.68 with SMTP id a4mr3597094wbx.208.1279523526244;
        Mon, 19 Jul 2010 00:12:06 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id w29sm2072595weq.18.2010.07.19.00.12.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 00:12:05 -0700 (PDT)
In-Reply-To: <201007190119.04873.jnareb@gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151246>

On Mon, 2010-07-19 at 01:19 +0200, Jakub Narebski wrote:
> On Sun, 18 Jul 2010, Will Palmer wrote:
> > On Sun, 2010-07-18 at 13:55 +0200, Jakub Narebski wrote:
> > having any kind of suffix like refs~/heads~/bar is just asking for
> > someone to delete a branch twice.
> 
> I don't understand what you wanted to say here.  Using the
> 
>   $GIT_DIR/logs/refs~/heads~/bar
> 
> (and not $GIT_DIR/refs~/heads~/bar) as a reflog for a deleted branch
> 'bar' is an implementation detail.  You wouldn't see refs~/heads~/bar
> when listing branches... well, perhaps 'git branch --list-deleted'
> could be used to list deleted branches (by scanning for reflogs).
>  

git branch -d integration
# git renames refs/heads/integration to refs~/heads~/integration
git co -b integration sometopic
# git creates refs/heads/integration, unrelated to the old one
(do some work)
(merge into the main branch)
git branch -d integration

Now what?
git renames refs/heads/integration to ... what?
- does the old refs~/heads~/integration get clobbered? If that's ever
okay, why are we even having this discussion?
- does the "old reflog" stuff get combined? If that's ever okay, why
even have an extra reflog, instead of just using the reflog we already
have?
- do we move everything else one step down, so refs~/heads~/integration
becomes refs~2/heads~2/integration? (ie: 2-dimensional reflog, which
sounds rather too fancy, to me)


-- 
-- Will
