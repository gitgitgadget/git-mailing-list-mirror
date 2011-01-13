From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC/PATCH 0/2] unpack-trees: handle lstat failures in
 verify_absent
Date: Thu, 13 Jan 2011 21:20:23 +0100
Message-ID: <20110113202023.GA15912@localhost>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
 <20110113022415.GA8635@burratino>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 21:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdTee-0000t3-FG
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 21:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933745Ab1AMUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 15:20:15 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49866 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646Ab1AMUUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 15:20:12 -0500
Received: by fxm20 with SMTP id 20so2058086fxm.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ddwXFnVSkk6iBJDqUBuLLZEHzIiRXg0pfrIGAH2sfbQ=;
        b=b5Iu3y9IZSacCu2ntGuGg9Pmvj/yk5rN/RTyYcyOc9BgyVdI08JccLeRWYdd7JB/Ka
         8NNpCytH0n3GCAaqqY4KYk6ipjsRPluh+CzFwdK8Kc4dTTP0CCAfsFT4pSRcNVAh7uSA
         wam4VE59pw1XcdhDs6BYm+Yh+BPR2k3B/3YWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=T48nyTMRbpwFz9wedfdOT8XiRi1/w4AkDbulBN8lkQOqNjCvdJbwIEmSCNWtVvfolf
         Vlz2hbVpNdn7wdV7D2D/WZW4RMrReuPd4LEOczRept2BIm7eTWDqDSxNArRDPCwO6Q+f
         ffWBw82IvV34HIV4bH1ji6QaklYi+d3kktY74=
Received: by 10.223.71.206 with SMTP id i14mr2832395faj.1.1294950011614;
        Thu, 13 Jan 2011 12:20:11 -0800 (PST)
Received: from darc.lan (p5B22EFAA.dip.t-dialin.net [91.34.239.170])
        by mx.google.com with ESMTPS id f24sm220370fak.24.2011.01.13.12.20.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Jan 2011 12:20:09 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PdTeh-0004AH-Ve; Thu, 13 Jan 2011 21:20:23 +0100
Content-Disposition: inline
In-Reply-To: <20110113022415.GA8635@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165066>

On Wed, Jan 12, 2011 at 08:24:15PM -0600, Jonathan Nieder wrote:
>
> Here are two cases where we ignore the result from lstat in
> unpack_trees.  I think we rather shouldn't ignore it.  Sane?

Looks good. Thanks.

But in addition to the ones you fixed, lstat errors returned by
lstat_cache_matchlen() in check_leading_path() are also ignored.
I was actually hoping to restructure this into two functions.

 1) check_path() to see if we need to overwrite anything (leading
    directory _or_ file of the same name)
 2) check_ok_to_remove() to check if we can safely overwrite that
    directory or file

All the lstat handling would go into check_path(), and
check_ok_to_remove() can reuse the stat returned by check_path().

But right now I can't say when I will find the time.

Clemens
