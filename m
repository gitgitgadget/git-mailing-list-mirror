From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sat, 1 Mar 2008 23:26:04 +0100
Message-ID: <200803012326.05698.jnareb@gmail.com>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com> <m3d4qejroy.fsf@localhost.localdomain> <alpine.LFD.1.00.0803011010480.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 23:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVaAK-0002lC-O2
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 23:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbYCAW0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 17:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYCAW0L
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 17:26:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:31557 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYCAW0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 17:26:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1083046ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=O+wmZP9A1BA0pwfYEYs3kee6VSER1uie+UY8VeCKB8Q=;
        b=Wj0WhjNQsFWcgN37xMCb9kd6aaHHYZ58oduyF7E9aRhwzoRBM51rMqcGhQ91lIOJqGuz856Fsomt9Xz6Fbr4Jukc2HmpZc4QvwEkKRbQUfCdosjlhRW5OR3d84VuBkMI3wP6u27qQ41GLa2iNM9Rzn5UUWShCudN7ikt15CvTho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jIQn0zMm7FFAGJe+PaxCHDMsCBvl79fzXaE+m27kj2pLo/ZHzmpub5AdctoOOwQZdZ+7YxEIK5o33dI6OwIy//a8Z3AEQkxcBoQIKjBV83F5wYCfB5CCupMBrzdgfowoo/nIRRVIAzEaooCWE6aAkBADQ/9aiouDPubWW9SoXBE=
Received: by 10.67.22.2 with SMTP id z2mr3345635ugi.1.1204410368824;
        Sat, 01 Mar 2008 14:26:08 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.199.142])
        by mx.google.com with ESMTPS id k30sm4363889ugc.53.2008.03.01.14.26.06
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 14:26:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0803011010480.17889@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75708>

On Sat, 1 Mar 2008, Linus Torvalds wrote:
> On Sat, 1 Mar 2008, Jakub Narebski wrote:
> > > 
> > > From what I can tell it seems that dates can be specified relatively,
> > > e.g. "2 hours ago", or with any ISO 8601 or RFC 2822 date syntax. Is
> > > this correct, and are there any docs on specifying relative dates?
> > 
> > I don't know why git doesn't use getdate_r for this, instead rolling
> > out its own date parsing routines: approxidate*, parse_date. From what
> > I remember it should accept any date "date" (from coreutils) accepts,
> > but it does (from comments) for date to be in "C" locale.
> 
> strptime() and getdate() are totally unusable for any real date parsing 
> where you don't already know the exact format(s) of the string. And 
> neither of them can do any of the useful things that approxidate() does, 
> ie handle strings like "two months ago".
> 
> So yes, we do our own date parsing, where the "exact" format is the Unix 
> epoch timestamp (potentially together with explicit TZ information), but 
> we try to parse a wide variety of user-supplied strings that match any of 
> the standard formats (and do that loosely, so that when emails etc 
> invariably get things wrong and don't actually follow rfc2822 exactly, for 
> example, it still tries to make sense of it).

I wonder how it compares with GNU date (from GNU Corutils) inexact date
parsing (and why we couldn't lift the code from GNU date)... I guess that
main goal was to parse correctly "mail" dates, first.


BTW. Git has few other such "reimplementing the wheel" things, like strbuf,
or ALLOC_GROW, or it's own parseopt. I guess main reasons are to avoid
adding yet another dependency, and that existing solutions doesn't fill
all git needs.

-- 
Jakub Narebski
Poland
