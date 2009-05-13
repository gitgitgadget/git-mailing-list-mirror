From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update @version in file
Date: Thu, 14 May 2009 01:02:14 +0200
Message-ID: <200905140102.15578.jnareb@gmail.com>
References: <1242205190383-2879913.post@n2.nabble.com> <200905131856.46344.jnareb@gmail.com> <vpqeiutrl09.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Loewenherz <dloewenherz@gmail.com>,
	Andreas Ericsson <ae@op5.se>, takeshin <admirau@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu May 14 01:05:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4NVh-00064G-Qw
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 01:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbZEMXCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761569AbZEMXCX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 19:02:23 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48805 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762752AbZEMXCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 19:02:22 -0400
Received: by mu-out-0910.google.com with SMTP id i2so356486mue.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZvOLWW76Cyk4usJcvUGKyIaS1fpSs0qb1i2M9UGbdpg=;
        b=w7Kx9lAOzIPukof2XVjQpJQUJT0ylEuRCdMW4m1o33B0J8so3qrllgyVAtcVL/SBs4
         WupZ5Jjr3NOqTI7TKcc5Z4nM5Xl3tC+6xjc8zxFlFny+oY8+RwlryPTYniqZ+5HZs8ml
         vnHAwqZk/0/iQIfMR27Om2ZzlnBvV7gZv5kqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rEjPa1gSiduRThjWcJdz9ApnJc8OPaACI000mEx7i5IbgUGREqXCPIX6A0/HsTRkGH
         Skgu06v22KHwK7L14d65J/lgmFTRVOWAQNRgfUkUIiS+9ie7KHQu/JJo4BBr8R19WZ7a
         yTDg4jHzCecnYhPCJtnqMsjT/FrKFar2rltAE=
Received: by 10.103.214.8 with SMTP id r8mr1088662muq.92.1242255740772;
        Wed, 13 May 2009 16:02:20 -0700 (PDT)
Received: from ?192.168.1.13? (abvo12.neoplus.adsl.tpnet.pl [83.8.212.12])
        by mx.google.com with ESMTPS id 25sm1444355mul.29.2009.05.13.16.02.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 16:02:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqeiutrl09.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119119>

On Wed, 13 May 2009, Matthieu Moy napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > 2. If you wanted however to have *file* version (like in CVS), then=
 it
> >    is impossible because Git doesn't store such info
>=20
> What could make sense is the commit id where the file was last
> modified (i.e. the first item that appears when one runs "git log" on
> the file). Not exactly as simple as it could be because of merge, but
> not completely meaningless either.

=46irst, while it quite neatly solves the problem of cost of commit (on=
ly
changed files needs to have keyword expansion updated), it is also much
more costly (possibly much, much more, especially as Andreas wrote for
files which change rarely) than commit info based keywords (like those
`export-subst` keywords).  Note that Git doesn't store per-file version
info.

Second, you are mistaken thinking that 'commit id where the file was
last modified' is a file-level variable.  It is not, because file could
have arrived independently at given contents (e.g. by cherry-picking
bugfix, or by reverting some change one one branch while other is from
before a change).  See for example sample history below


   .---.---.---a--.---b---.---c     <--- branch_1
                \
                 \--.---d---c'      <--- branch_2

where given file is at the same version (has the same contents) in both
"c" and "c'" commits, but for one 'last changed' would be "b", for othe=
r
it would be "d".

This means that not only rewinding is costly (as per previous point), b=
ut
also switching branches is costly; you have to get history for each and
every file, even if they didn't change in the switch.

Third, files in project are not independent. Last commit the file was
changed doesn't give us much informational value, I don't think. Well,
at least not as keyword expansion; you might want to ask your SCM about
this info.  Whole project tags means that you can get to exact version
you stated.  "File history" revision numbers would not.


I don't know why you need such keyword. Users either browse files via S=
CM
(where they have access to SCM to get such info, or browse files from
tarball, where project revision is embedded (substituted by Makefile)..=
=2E

--=20
Jakub Narebski
Poland
