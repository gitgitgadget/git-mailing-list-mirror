From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if --pretty=format:%e%n%s%n is used
Date: Wed, 12 Nov 2008 16:08:38 +0300
Message-ID: <85647ef50811120508j5074f892p1e2a95acfae8c0a8@mail.gmail.com>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com>
	 <20081112104318.GA20120@coredump.intra.peff.net>
	 <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com>
	 <20081112112654.GA20640@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 14:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0FTp-0002Si-KJ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 14:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYKLNIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 08:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYKLNIl
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 08:08:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:14932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbYKLNIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 08:08:41 -0500
Received: by fg-out-1718.google.com with SMTP id 19so388090fgg.17
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 05:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xlyW6aTBHlT2mpLc+2zf0XjM2LMSyuBb3FwE4Pa6xZE=;
        b=faBl5LGYxRu+AuvPBb31CxkKPeOo5859SR6RA1wD62Y6EcDCeS6Dpk4MTkPeccG0Kj
         j5N2iwVzDF7cLbHvBloia2GlSGIcZpoMV2vtpq+Pk0GXLuOS5pexoSSxObuHg1DMwCEA
         jpIxiN8+VZZxLB+2xYNsTN7RsU3qT0yxfusXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TD109U9zwyneOGagBZFWF6TjBlUMRtiWMa6uWXU23YU9d8/VRCKiA+SPWT9ZhDqdSV
         dZSD0Lj58cT41+9OYYkKuFssqYVXbSIR5KcqnyAsbQvIscjFjLQWIA93BTCFrXJ6S/pU
         5MCqBdGUbJEACRq+2Fb2DUjY8kKrX37PI9hps=
Received: by 10.181.146.11 with SMTP id y11mr2845881bkn.60.1226495318918;
        Wed, 12 Nov 2008 05:08:38 -0800 (PST)
Received: by 10.180.230.10 with HTTP; Wed, 12 Nov 2008 05:08:38 -0800 (PST)
In-Reply-To: <20081112112654.GA20640@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100747>

On Wed, Nov 12, 2008 at 2:26 PM, Jeff King <peff@peff.net> wrote:
> [re-adding list to the cc]
>
> On Wed, Nov 12, 2008 at 02:11:46PM +0300, Constantine Plotnikov wrote:
>
>> > I don't actually use any encodings except UTF-8, so maybe there is some
>> > subtle reason not to do so that I don't understand, but I would have
>> > expected all of the format placeholders to respect any --encoding
>> > parameter.
>> >
>> Even if this is the bug, it would be better to leave the old behavior
>> for backward compatibility reasons and introduce new placeholders.
>> Currently tools have to decode messages according to the commit
>> encoding, and changing behavior of options will break these tools
>> that have implemented workaround for this problem.
>
> Are there such tools? I assumed they would have complained about this as
> a bug before writing their own encoding conversion tools. And this is,
> AFAIK, the first bug report.
>
> I don't mind playing it safe to avoid breaking other people's tools, but
> I'm also not excited about adding a second, "respect encoding" version
> of many placeholders (and it's not just %s and %b; I think you would
> need author and committer names and emails, too).
>
The reason for the request was that for IDE integration (I'm working
on the IDEA plugin), we need to work with past versions of the git as
well. However we could write that this is known git bug that will be
fixed in some future version and just to show incorrect data in
history view when non-UTF-8 encoding is used for a while. I hope that
non-UTF-8 encoding for commits is indeed a rare case, so users will
not complain much.

BTW for some reason --pretty=raw is affected by encoding option on the
command line. And this is a bit surprising as from description of the
raw format it looks like it should not be affected, because the
re-encoded commit is not "the entire commit exactly as stored in the
commit object". Possibly the man page should be updated to clarify
this.

Regards,
Constantine
