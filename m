From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 22:47:19 +0100
Message-ID: <87399dpk48.fsf@thomas.inf.ethz.ch>
References: <20120312002046.041448832@1wt.eu>
	<1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
	<20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
	<20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
	<20120312152453.GB12405@1wt.eu> <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
	<20120312165703.GB18791@burratino>
	<7vvcm9snko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jonathan Nieder <jrnieder@gmail.com>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:47:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7D5a-0003T2-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab2CLVrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:47:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:36770 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789Ab2CLVrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:47:22 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 22:47:20 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 22:47:19 +0100
In-Reply-To: <7vvcm9snko.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 12 Mar 2012 11:04:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192955>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Thomas Rast wrote:
>>
>>> The problem with -b is that it's a backwards-compatibility shorthand for
>>> --binary, which used to pass --allow-binary-replacement (or --binary) to
>>> git-apply.  However, that option was obsoleted in 2b6eef9 (Make apply
>>> --binary a no-op., 2006-09-06) and has been a no-op for over 5 years.
>>> It has also not been documented since cb3a160 (git-am: ignore --binary
>>> option, 2008-08-09).
>>>
>>> So perhaps we can safely claim -b for --keep-non-patch, like so:
>
> We can delete "git am -b" (as it was deprecated long time ago), wait
> for a cycle or two, and then repurpose it.  I do not mind starting
> the first step (delete, but do not say anything about repurposing)
> before 1.7.10-rc1 happens.

Ok, but if I don't get to say anything about repurposing, can I at least
make it an error message instead of just spewing out the "invalid
option" help?

----- 8< -----
Subject: [PATCH] git-am: error out when seeing -b/--binary

The --binary option to git-apply has been a no-op since 2b6eef9 (Make
apply --binary a no-op., 2006-09-06) and was deprecated in cb3a160
(git-am: ignore --binary option, 2008-08-09).

We could remove it outright, but let's be nice to people who still
have scripts saying 'git am -b' (if they exist) and tell them the
reason for the sudden failure.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-am.sh |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 0bd290b..faae820 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -380,7 +380,9 @@ do
 	-i|--interactive)
 		interactive=t ;;
 	-b|--binary)
-		: ;;
+		echo >&2 "The -b/--binary option was deprecated in 1.6.0 and removed in 1.7.10."
+		die "Please adjust your scripts."
+		;;
 	-3|--3way)
 		threeway=t ;;
 	-s|--signoff)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
