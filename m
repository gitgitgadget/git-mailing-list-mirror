From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 10:09:17 -0500
Message-ID: <20100706150917.GA1558@burratino>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
 <20100706080322.GA2856@burratino>
 <DD1E6EE4-1196-4FCA-87DA-EB9EBCA3AC83@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:10:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9me-0003Gx-6c
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab0GFPJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 11:09:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33168 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0GFPJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:09:57 -0400
Received: by iwn7 with SMTP id 7so6750512iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s+mXOOf3xYbmII5ud+4nOdCK8TlCd8oTc9+g2aLtJtQ=;
        b=LFpJkgH5wYL0WeJh3tKFEUHinI6VR4LumtLKz60bylyLt7f9eS7ThFWVn02ZEqeGNs
         liis4jL6PV6BWvxFGigTvL9SL+hAsrjzO7vAPJpbUY4iEMbYfaby5GYyt8dGEZ1lICv0
         4ZD01BW4/qa+RbwPcZ2BNUHCQwdkvEwIPgDqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CGCul9su355cIztN0EhJdg6xTMWeqIuFKgnZPyUK+Ht5lUFcRUtcAL0ArnM8hhV+zt
         XQ9LiOkdfHoSQTcVTRln8rz2EfJzooCIjmYftyDYUEJS9lrgyoGlCY6fhLx06zJ3Xaiz
         0sfG7ZHG/9dvYtNJl7pEFM1+sDuAIehnLzyxE=
Received: by 10.42.0.3 with SMTP id 3mr1503902ica.47.1278428996729;
        Tue, 06 Jul 2010 08:09:56 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm23822095ibh.22.2010.07.06.08.09.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 08:09:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DD1E6EE4-1196-4FCA-87DA-EB9EBCA3AC83@mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150362>

Theodore Tso wrote:

> You're right that it's been a while since git has run into problems w=
ith=20
> mild forms of clock skew (even Debian Stable is shipping v1.5.6) but
> I think it's better to times in the future if we can at all help it, =
and it's not
> like we're talking about a lot of extra complexity to guilt to test f=
or this.

Sorry, I=E2=80=99m a little lost.  There are five phenomena one could
forbid:

 1. Commits with timestamp equal to or before a parent
 2. Commits with timestamp before a parent
 3. Commits with timestamp unreasonably long before a parent
 4. Commits with timestamp unreasonably long before an ancestor
 5. Commits with timestamp in the future

Git has always been able to cope with #5 (timestamps in the future).
I see no reason to avoid it, except that it is hard to assign a
timestamp for commits on top of that one.

Git=E2=80=99s problem today is #4 (long-term slop).  Maybe as Jeff sugg=
ested
"unreasonably long" should defined per repository.  Or we could
measure the kernel=E2=80=99s maximum (something like 120 days?) and mak=
e that
a hard limit.

Do #3 a few times, and you get #4.  So =E2=80=98commit=E2=80=99 should =
warn
about it (where =E2=80=98unreasonably long=E2=80=99 could be as short a=
s 0 or
1 days).

#2 (nonmonotonic commits) was broken in ancient git; I think it=E2=80=99=
s too
rigid of a rule to worry about it on that account.  But a variant of
the rationale for avoiding #3 applies to it.

I have never heard of any version of Git copying poorly with #1
(commits with the same timestamp).  Avoiding it artificially leads
inevitably to timestamps in the future when you somehow try to assign
100 timestamps for the series you have rebased on top of a patch
committed a few seconds ago.

Incrementing the timestamp to ensure strictly monotonic commits seems
like a recipe for trouble to me.

=46or guilt, I think the best thing to do would to save a Date: line
for the author date with the From: and Subject: and then touch
patches with the _current_ date when appropriate to avoid skew.

HTH,
Jonathan
