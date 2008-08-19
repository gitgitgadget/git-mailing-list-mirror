From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 11:08:19 -0400
Message-ID: <32541b130808190808g79bb53a1l9ea7f2ea4c1e5ed3@mail.gmail.com>
References: <48AA4263.8090606@gmail.com>
	 <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
	 <32541b130808190754l43f053abnc4e3c5c064d6ade7@mail.gmail.com>
	 <e1dab3980808190802r202aadc0p2cf8431f645354e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pat LeSmithe" <qed777@gmail.com>, git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSpp-0007DW-AW
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYHSPIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYHSPIV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:08:21 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36679 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYHSPIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:08:20 -0400
Received: by gxk9 with SMTP id 9so5127908gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UpxJ9pQTE5lzdC9STc1TyhcQr5Ef+Lect86WzcUDNm8=;
        b=uR01+ltspM1NgN3BgprgZ3C6Si4uPEwCJ/5kJRo058AzdUdzqyi8BCCPWw4qzzrbJr
         KPTIr+c3L8qHSzD/U64Nd5L+i9TJKsCFSucB0BZDZzqjIpGkpmjhsXUeM8Fie7vVHDbG
         S5DHjC/V+TvZql/PLS6M2/JSR8LMKlYHDQJXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DCmD5rWGW8Om1YlaCXu1M8LweTwJMuORyxbWU0dORURr5UfkrBY4TvvrCHmU4CC/9w
         8iQh+t9EZSEJsSv/8uXYBsyAtud+mYwo24nA1OhzUPRoOizIJntTeH6xJXodPHZlsAyy
         fziUgUkq80mncsnS/H02+CPKSK18PzvDmo288=
Received: by 10.150.217.14 with SMTP id p14mr12003819ybg.83.1219158499710;
        Tue, 19 Aug 2008 08:08:19 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Tue, 19 Aug 2008 08:08:19 -0700 (PDT)
In-Reply-To: <e1dab3980808190802r202aadc0p2cf8431f645354e3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92876>

On Tue, Aug 19, 2008 at 11:02 AM, David Tweed <david.tweed@gmail.com> wrote:
> On Tue, Aug 19, 2008 at 3:54 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>> You could just have a makefile rule or bash alias that does something
>> like "make && git commit -a -m temp".  Then remember to always run
>> that instead of 'make' when you're building.
>
> As ever, I wanna do something more deviant than that :-) . The idea is
> to take a snapshot (if any tracked file has changed) roughly every ten
> minutes. If there happens to have been a successful compile around
> that time (+/- 1 minute say), grab the snapshot (including detecting
> potential newly created files) then. But if there hasn't, I still want
> a snapshot roughly on that 10 minute interval. I could try doing
> something like "git reset --soft HEAD~1 && git commit -a" if a make
> succeeds within 1 minute, on a strictly chronological snapshot but
> scripted resets make me a bit nervous.
>
> It's not hyper-important, just something I'm thinking about.

Doing the 10-minute snapshot doesn't preclude the on-make snapshot.
Just commit at *both* times.  But commiting "around the time there was
a successful build" is kind of pointless since you might change a file
two seconds later.  (Or maybe only I'm that idiosyncratic. :))

Shawn's GIT_INDEX_FILE script seems like a good place to start.  If it
were me, I'd use *two* branches here: one for every time I build, and
one for the periodic commits.  Then the build branch would always be
bisectable, and the periodic branch would always have up-to-date data.
 Commits on the periodic branch would use *both* branch heads as
parents, so you'd be able to easily see and diff the full history.

Have fun,

Avery
