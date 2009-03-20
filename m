From: bdowning@lavos.net (Brian Downing)
Subject: Git no longer reads attributes from the index properly
Date: Fri, 20 Mar 2009 02:35:27 -0500
Message-ID: <20090320073527.GC1037@lavos.net>
Reply-To: bdowning@lavos.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Linus Torvalds <torvalds@linux-foundation.org>, msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Mar 20 08:37:05 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f202.google.com ([209.85.217.202])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkZHs-0006NI-C0
	for gcvm-msysgit@m.gmane.org; Fri, 20 Mar 2009 08:37:04 +0100
Received: by gxk26 with SMTP id 26so626081gxk.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Mar 2009 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:received:date:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent:from:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=c+Si3///a8Q3Il8RKgbFnQipDOaCTQXcgidl/IHEEkg=;
        b=VXOOFXo3N+S2btSVrRwb3V1Lmr/N2dMx+DV1/b+NKYbJUGidw3cICS/Dj8izXbuxYJ
         WL7EazS5Z4WyUJTbf43SnUPtkEDUjYEdnBUm5Q5RZZ9sHkPq3mz4CKgZ5ylQgvm2+XD9
         8+m6ooJwbvULMNAM1ImTo0EjT6bkJMEo4sJ48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:from:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=iuO+1FnY8VMx3/IgkuZaz3kW40U8MaszeznkIUlfCvN1GY1qAnyhG4/AwMmZKR/ntg
         yAVkwis/pxYXjZvKMsirNm08izCWqbA/VV/QLw5ReTbSnSbABiC89uOQUXxFc3ZHjj0w
         oTFrfaHOiMcC3IGbwtZEnfdnK4O1GUaQc81SY=
Received: by 10.151.145.12 with SMTP id x12mr147890ybn.16.1237534530530;
        Fri, 20 Mar 2009 00:35:30 -0700 (PDT)
Received: by 10.177.6.2 with SMTP id j2gr4306yqi.0;
	Fri, 20 Mar 2009 00:35:30 -0700 (PDT)
X-Sender: bdowning@lavos.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.94.12 with SMTP id r12mr2368702agb.5.1237534529432; Fri, 20 Mar 2009 00:35:29 -0700 (PDT)
Received: from QMTA04.westchester.pa.mail.comcast.net (qmta04.westchester.pa.mail.comcast.net [76.96.62.40]) by gmr-mx.google.com with ESMTP id 13si520089gxk.6.2009.03.20.00.35.29; Fri, 20 Mar 2009 00:35:29 -0700 (PDT)
Received-SPF: neutral (google.com: 76.96.62.40 is neither permitted nor denied by best guess record for domain of bdowning@lavos.net) client-ip=76.96.62.40;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 76.96.62.40 is neither permitted nor denied by best guess record for domain of bdowning@lavos.net) smtp.mail=bdowning@lavos.net
Received: from OMTA09.westchester.pa.mail.comcast.net ([76.96.62.20]) by QMTA04.westchester.pa.mail.comcast.net with comcast id VKbW1b0010SCNGk54KbWS8; Fri, 20 Mar 2009 07:35:30 +0000
Received: from mnementh.lavos.net ([98.212.138.194]) by OMTA09.westchester.pa.mail.comcast.net with comcast id VKbV1b0024BqYqi3VKbVWd; Fri, 20 Mar 2009 07:35:30 +0000
Received: by mnementh.lavos.net (Postfix, from userid 1000) id EB551309F24; Fri, 20 Mar 2009 02:35:27 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113908>


As of 34110cd4e394e3f92c01a4709689b384c34645d8, (2008-03-06, just over a
year ago), Git no longer reads attributes from the index properly in all
cases.  This breaks initial checkouts where .gitattribute information is
required to get a good checkout.  [I'm also copying the msysgit guys on
this, since they are probably the primary customers of autocrlf and the
crlf attributes, though the problem exists in core Git.]

This support for reading attributes from the index in addition to the
working directory was added in 1a9d7e9b484e77436edc7f5cacd39c24ec605e6d,
on 2007-08-14:

commit 1a9d7e9b484e77436edc7f5cacd39c24ec605e6d
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Aug 14 01:41:02 2007 -0700

    attr.c: read .gitattributes from index as well.

    This makes .gitattributes files to be read from the index when
    they are not checked out to the work tree.  This is in line with
    the way we always allowed low-level tools to operate in sparsely
    checked out work tree in a reasonable way.

    It swaps the order of new file creation and converting the blob
    to work tree representation; otherwise when we are in the middle
    of checking out .gitattributes we would notice an empty but
    unwritten .gitattributes file in the work tree and will ignore
    the copy in the index.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

This worked until the following commit:

34110cd4e394e3f92c01a4709689b384c34645d8 is first bad commit
commit 34110cd4e394e3f92c01a4709689b384c34645d8
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 6 18:12:28 2008 -0800

    Make 'unpack_trees()' have a separate source and destination index

    We will always unpack into our own internal index, but we will take the
    source from wherever specified, and we will optionally write the result
    to a specified index (optionally, because not everybody even _wants_ any
    result: the index diffing really wants to just walk the tree and index
    in parallel).

    This ends up removing a fair number more lines than it adds, for the
    simple reason that we can now skip all the crud that tried to be
    oh-so-careful about maintaining our position in the index as we were
    traversing and modifying it.  Since we don't actually modify the source
    index any more, we can just update the 'o->pos' pointer without worrying
    about whether an index entry got removed or replaced or added to.

    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Unfortunately I don't have the foggiest on how to fix this.  However, I
did write a new test case to catch this bug, as the existing ones were
insufficiently destructive to trigger it.  This test case is ugly, uses
porcelain, and is probably overly-destructive, but it does show the
problem.  It fails on 34110cd4 and succeeds on 34110cd4^.

I don't expect the test case can be accepted as-is, but regardless:

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 t/t0020-crlf.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 1be7446..749cd09 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -429,6 +429,25 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	}
 '
 
+test_expect_success 'in-tree .gitattributes (5)' '
+
+	rm .git/index &&
+	git clean -d -x -f &&
+	git checkout &&
+
+	if remove_cr one >/dev/null
+	then
+		echo "Eh? one should not have CRLF"
+		false
+	else
+		: happy
+	fi &&
+	remove_cr three >/dev/null || {
+		echo "Eh? three should still have CRLF"
+		false
+	}
+'
+
 test_expect_success 'invalid .gitattributes (must not crash)' '
 
 	echo "three +crlf" >>.gitattributes &&
-- 
1.5.6.3
