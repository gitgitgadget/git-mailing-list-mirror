From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t/README: tests can use perl even with NO_PERL
Date: Mon, 28 Oct 2013 12:22:16 -0700
Message-ID: <20131028192216.GB4242@google.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
 <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
 <526EA7C8.2020607@kdbg.org>
 <20131028182718.GA4242@google.com>
 <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 20:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VasOQ-0002w4-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766Ab3J1TWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:22:22 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36085 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700Ab3J1TWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:22:21 -0400
Received: by mail-pb0-f41.google.com with SMTP id um1so2684584pbc.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aS3IxThjgLXxFkxnRPDaxm3UyNvpjQXzcLsj8tKAXls=;
        b=CDOntDFyWGYnr1InM3afN8pqd+JDaotTyQNgxX/1aJTRtVDow3PsfDfM2HvGlVsoMs
         d4b5bKXqrPzxOdUOD3j3oC+24A6PG6415wKLQSvTHHYfsLbBlMMePH/3iUOO+HmPdm6D
         THNqGjO3iRzb7c7KoiqUWNOmHUuosIPOVI0B2cyQlnRKdkDOHtySDGOs0jUNPZzkWIV/
         QFt9iwxJovRt3ZcN/cSSNcRkGZnNImltrx8nbrN0AIF3b3pszZKSrT3sEB4UNunqIvhx
         RU7hQCa84jcFmSzDS+uguzTWWIz+46JvktyoXntpHm11O7VswndBgX8+lP9anTl9tJeC
         GQzw==
X-Received: by 10.66.66.42 with SMTP id c10mr26783839pat.98.1382988140002;
        Mon, 28 Oct 2013 12:22:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ho3sm30283220pbb.23.2013.10.28.12.22.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Oct 2013 12:22:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236851>

The git build system supports a NO_PERL switch to avoid installing
perl bindings or other features (like "git add --patch") that rely on
perl on runtime, but even with NO_PERL it has not been possible for a
long time to run tests without perl.  Helpers such as

	nul_to_q () {
		"$PERL_PATH" -pe 'y/\000/Q/'
	}

use perl as a better tr or sed and are regularly used in tests without
worrying to add a PERL prerequisite.

Perl is portable enough that it seems fine to keep relying on it for
this kind of thing in tests (and more readable than the alternative of
trying to find POSIXy equivalents).  Update the test documentation to
clarify this.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> + - PERL
>> +
>> +   Git wasn't compiled with NO_PERL=YesPlease.
>> +
>> +   Even without the PERL prerequisite, tests can assume there is a
>> +   usable perl interpreter at $PERL_PATH, though it need not be
>> +   particularly modern.
>> +
>> +   Wrap tests for commands implemented in Perl with this.
>
> Sounds like a sensible thing to address, but I first parsed it as
>
>     Wrap (tests for (commands implemented in Perl)) with this.
>
> while I think the readers are expected to parse it as
>
>    Wrap ((tests for commands) implemented in Perl) with this.

I meant the former --- that is, tests for commands like "git add -p"
should be skipped in a NO_PERL build.  Probably clearest to leave out
the third paragraph entirely, like this:

 t/README | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 2167125..0a939eb 100644
--- a/t/README
+++ b/t/README
@@ -629,11 +629,18 @@ See the prereq argument to the test_* functions in the "Test harness
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
 
  - POSIXPERM
 
-- 
1.8.4.1
