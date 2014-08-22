From: Jonathan Nieder <jrnieder@gmail.com>
Subject: check-ref-format: include refs/ in the argument or to strip it?
Date: Fri, 22 Aug 2014 08:41:51 -0700
Message-ID: <20140822154151.GK20185@google.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 17:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKqyZ-0007iU-F4
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 17:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbaHVPl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 11:41:57 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:55618 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbaHVPl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 11:41:56 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so16245325pdj.14
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZlN+x96yr5hTYCHuuN6U3C7AZxdb65nOSxtGAGXKx2w=;
        b=0USi/ItUjSvw8gSywijHV4XsLhCVV8vJqJmNqxB02rY3GVk8t82QFWbiuM1z7Su2YY
         zqkUDr7QuagVNjOjvB12z7tVoueV04lSuOdbKGXC7BzheG8SSRHLORREe0jrJou95Qio
         XkBRqTh4DY4wlrblmPxwt0aH4AACmDiyBMroDrH8wpk9nN+TIJGYkbVWQ0G4SqQl27dR
         ZuIx+G+19E3VSvWal7N7yuhDlmYM6b1Ykmj9cHb577sJ3uJjS07aGLt4jjR9eyEgXJ1p
         RfJppUdg5c2hP4JKCBuS+nOY6DwLKA9tcOFUDDtPl988FBFpKWC5ecHCKEi8W/6Xu0sL
         D2kw==
X-Received: by 10.68.162.227 with SMTP id yd3mr7461381pbb.19.1408722116035;
        Fri, 22 Aug 2014 08:41:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c57b:d378:4566:1b8f])
        by mx.google.com with ESMTPSA id un15sm103475078pab.14.2014.08.22.08.41.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Aug 2014 08:41:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <047d7b624d36142d46050131f336@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255678>

Hi,

Michael Haggerty wrote[1]:
> Jonathan Nieder wrote:

>> The check-ref-format documentation is pretty unclear, but the
>> intent is that it would be used like
>>
>>	git check-ref-format heads/master
>>
>> (see the surviving examples in contrib/examples/). That way, it can
>> enforce the rule (from git-check-ref-format(1))
>>
>>	2. They must contain at least one /. This enforces the presence
>>	of a category like heads/, tags/ etc. but the actual names
>>	are not restricted.
[...]
> Thanks for the explanation and the pointer.
>
> I suppose that was a usage that was more popular in the past than
> now. I can hardly remember anyone talking about references like
> "heads/master" or "tags/v1". It seems to me that when somebody wants
> to be unambiguous they usually use the whole reference name
> "refs/heads/master" or "refs/tags/v1". When they want to be succinct
> they usually use just "master" or "v1".
>
> To me it seems incongruous to have the "heads/master" syntax
> supported at this deep level of plumbing. In most cases, the caller
> could get the same effect by prepending "refs/" to the string and
> then calling check_refname_format with a new
> REFNAME_REQUIRE_CATEGORY option that requires both a "refs/" prefix
> and a total of at least *three* levels.

I agree that this piece of UI is pretty weird.  Worse, it's
underdocumented.

I wonder if it would make sense to have the check-ref-format commandline
utility require two slashes when its argument begins with "refs/" (still
requiring only one slash when it doesn't, for backward compatibility)
and to start encouraging people to pass refnames with refs/ to it.

The alternative would be something like the following, which doesn't
seem too appealing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[1] https://code-review.googlesource.com/1017

 Documentation/git-check-ref-format.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index fc02959..447e9fb 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Checks if a given 'refname' is acceptable, and exits with a non-zero
-status if it is not.
+Checks if refs/<refname> is an acceptable ref name, and exits
+with a non-zero status if it is not.
 
 A reference is used in Git to specify branches and tags.  A
 branch head is stored in the `refs/heads` hierarchy, while
@@ -91,14 +91,14 @@ OPTIONS
 	components).  The default is `--no-allow-onelevel`.
 
 --refspec-pattern::
-	Interpret <refname> as a reference name pattern for a refspec
-	(as used with remote repositories).  If this option is
-	enabled, <refname> is allowed to contain a single `*`
-	in place of a one full pathname component (e.g.,
-	`foo/*/bar` but not `foo/bar*`).
+	Interpret refs/<refname> as a reference name pattern
+	for a refspec (as used with remote repositories).
+	If this option is enabled, <refname> is allowed
+	to contain a single `*` in place of a one full pathname
+	component (e.g., `foo/*/bar` but not `foo/bar*`).
 
 --normalize::
-	Normalize 'refname' by removing any leading slash (`/`)
+	Normalize <refname> by removing any leading slash (`/`)
 	characters and collapsing runs of adjacent slashes between
 	name components into a single slash.  Iff the normalized
 	refname is valid then print it to standard output and exit
@@ -118,7 +118,7 @@ $ git check-ref-format --branch @{-1}
 * Determine the reference name to use for a new branch:
 +
 ------------
-$ ref=$(git check-ref-format --normalize "refs/heads/$newbranch") ||
+$ ref=$(git check-ref-format --normalize "heads/$newbranch") ||
 die "we do not like '$newbranch' as a branch name."
 ------------
 
-- 
