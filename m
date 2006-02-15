From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 15:07:52 +1300
Message-ID: <46a038f90602141807s468c421dm5c4b68cfcf87e7@mail.gmail.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	 <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
	 <43F113A5.2080506@f2s.com>
	 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
	 <43F249F7.5060008@vilain.net>
	 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org>
	 <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net> <43F27878.50701@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 03:08:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9C5P-0005Yu-Vl
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 03:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWBOCHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 21:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBOCHz
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 21:07:55 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:8746 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932448AbWBOCHy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 21:07:54 -0500
Received: by wproxy.gmail.com with SMTP id i23so1213794wra
        for <git@vger.kernel.org>; Tue, 14 Feb 2006 18:07:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wo1F1e7pTUnhBUjMzzHEjqWLsUX/sIfbpummIH4dhVhLBhLFsXZEvc5q4sZ3KJeYCmXnykN/8XGUKAGZLoi6rLrwJqmXdVSbgQmRgn01kwSRUV/zt9FZhXxLLCCZT7ipEV23ggn6jRNspPJVqufsG2R6VFXw+gwRhrWkTmQIiLU=
Received: by 10.54.71.3 with SMTP id t3mr3676439wra;
        Tue, 14 Feb 2006 18:07:52 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Tue, 14 Feb 2006 18:07:52 -0800 (PST)
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <43F27878.50701@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16204>

On 2/15/06, Sam Vilain <sam@vilain.net> wrote:
> Excellent.  Any speculations on where they might fit?  Clearly, it needs
> to be out of the "tree".

I think Junio & Linus are talking about alternative mergers, something
that can be called instead of git-read-tree -m (which is the way
merges seem to kick off). Or perhaps an additional flag to
git-read-tree to be used in conjunction with -m, something like
--optimize-for-identity that lets git-read-tree know to do a first
pass keying things on file identity rather than file path.

So we are _not_ touching the object database, at all. Only optimising
merges for very large trees there mv is a popular operation. All the
cases you discuss can be tackled very efficiently without making *any*
change to the object database.

> Martin, is that enough for your CVS case?

Oh, I don't need it at all. It's just that there's been some lazy talk
of tracking mboxes and maildirs with git, and look where it's led.
Blame Roland Stigge who got me started down this track.

I'm sure it's because the other optimisations are a lot harder to
tackle ;-) though Linus mentions that it'd be trivial for
git-read-tree -m to detect unchanged directories and perhaps do things
a bit faster. Not as revolutionary as an --optimize-for-identity but
not as risky either.

In any case, don't count in me for any of this git-checkout hacking. I
know better than start learning C posting patches to *this* list.

cheers,


martin
