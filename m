From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Tue, 13 Mar 2012 16:43:44 +0100
Message-ID: <8762e8ld5b.fsf@thomas.inf.ethz.ch>
References: <20120312152004.GB9380@kroah.com> <20120312152453.GB12405@1wt.eu>
	<87aa3l4vqq.fsf@thomas.inf.ethz.ch> <20120312165703.GB18791@burratino>
	<7vvcm9snko.fsf@alter.siamese.dyndns.org>
	<87399dpk48.fsf@thomas.inf.ethz.ch> <20120312215607.GB11362@burratino>
	<874ntto4t8.fsf@thomas.inf.ethz.ch> <20120312222227.GC11362@burratino>
	<87fwdcldqj.fsf@thomas.inf.ethz.ch> <20120313154209.GC1978@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:43:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7TtG-0004YW-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 16:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab2CMPns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 11:43:48 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:9145 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004Ab2CMPnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 11:43:47 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 13 Mar
 2012 16:43:45 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 13 Mar
 2012 16:43:44 +0100
In-Reply-To: <20120313154209.GC1978@burratino> (Jonathan Nieder's message of
	"Tue, 13 Mar 2012 10:42:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193037>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (resetting cc list)
> Thomas Rast wrote:
>
>> Hmm, I had an alternate patch ready in the morning, but Junio beat us to
>> it and applied the old one to master.
>>
>> I don't really think it matters enough to apply *another*, so I'll leave
>> it at that.
>
> May I have a copy?  If it makes the wording better somehow, I would be
> happy to do the work of making a patch on top of master using it.

Sure, but it's nothing magic :-)

------ 8< ------
Subject: [PATCH] git-am: error out when seeing -b/--binary

The --binary option to git-apply has been a no-op since 2b6eef9 (Make
apply --binary a no-op., 2006-09-06) and was deprecated in cb3a160
(git-am: ignore --binary option, 2008-08-09).

We could remove it outright, but let's be nice to people who still
have scripts saying 'git am -b' (if they exist) and tell them the
reason for the sudden failure.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-am.sh |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 0bd290b..e1bdbfc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -379,8 +379,12 @@ do
 	case "$1" in
 	-i|--interactive)
 		interactive=t ;;
-	-b|--binary)
+	--binary)
 		: ;;
+	-b)
+		gettextln >&2 "The -b option (shorthand for --binary, both no-ops) was removed in 1.7.10."
+		die "$(gettext "Please adjust your scripts.")"
+		;;
 	-3|--3way)
 		threeway=t ;;
 	-s|--signoff)


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
