From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 11:27:18 -0700
Message-ID: <20131028182718.GA4242@google.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
 <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
 <526EA7C8.2020607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bdwalton@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 19:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VarXS-0005F5-5A
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 19:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425Ab3J1S1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 14:27:38 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:49376 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841Ab3J1S1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 14:27:37 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so7414822pdj.21
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UYXCzWE3VoK681kIG2Il70b7Le8Av5FP7rSN1rIQFZY=;
        b=fn4iWK8U3mO4z5M+UPdullm31wL3Idmo5MNGBaeZhUCjUS8aTv3d5/UXORgEwHSGbK
         jVa4ezVWDZ5oN7OIu6+SixEhwtxD2xAR65xnUV9B4ltnkh7LCUh4xnXaq4YKVVOHqyev
         pOceVLtfJVpX1ZjrM+X3SBKIwhDpLi2KHtZ2yZ4Mfw+nS7kEyjv0Dssj885kH+y57JF9
         54oHZ6a9G2UBAwb/om8wM1qPNxcF+Fghkrc9Pi06Tt2/FZUS4zUXW41ay/SweaXiyTyh
         ADVP2fcjn0rOwD5viN6KuQ6H52RhEhowzo3q1oIo+hR4I7MOe6nxxE03UUGfMGGIpb0J
         S27Q==
X-Received: by 10.67.30.100 with SMTP id kd4mr27129092pad.24.1382984856941;
        Mon, 28 Oct 2013 11:27:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ye1sm36859605pab.19.2013.10.28.11.27.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Oct 2013 11:27:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526EA7C8.2020607@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236846>

Johannes Sixt wrote:

> In other tests, we check for prerequisite PERL, i.e., we are prepared
> that perl is not available. Shouldn't we do that here, too?

I think the tests assume there's a perl present even when the PERL
prereq isn't present already.  E.g.:

	nul_to_q () {
		"$PERL_PATH" -pe 'y/\000/Q/'
	}

So in practice the PERL prereq just means "NO_PERL wasn't set", or
in other words, "commands that use perl work".  Maybe something
like the following would help?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/t/README w/t/README
index 2167125..54cd064 100644
--- i/t/README
+++ w/t/README
@@ -629,11 +629,20 @@ See the prereq argument to the test_* functions in the "Test harness
 library" section above and the "test_have_prereq" function for how to
 use these, and "test_set_prereq" for how to define your own.
 
- - PERL & PYTHON
+ - PYTHON
 
-   Git wasn't compiled with NO_PERL=YesPlease or
-   NO_PYTHON=YesPlease. Wrap any tests that need Perl or Python in
-   these.
+   Git wasn't compiled with NO_PYTHON=YesPlease. Wrap any tests that
+   need Python with this.
+
+ - PERL
+
+   Git wasn't compiled with NO_PERL=YesPlease.
+
+   Even without the PERL prerequisite, tests can assume there is a
+   usable perl interpreter at $PERL_PATH, though it need not be
+   particularly modern.
+
+   Wrap tests for commands implemented in Perl with this.
 
  - POSIXPERM
 
