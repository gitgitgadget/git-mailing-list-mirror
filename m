From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [updated PATCH] Same default as cvsimport when using --use-log-author
Date: Tue, 29 Apr 2008 23:13:56 +0200
Message-ID: <20080429211356.GA6825@cuci.nl>
References: <20080427173246.10023.5687.stgit@aristoteles.cuci.nl> <7vbq3vf2k4.fsf@gitster.siamese.dyndns.org> <20080429061823.GE24171@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:14:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqx9z-0001nn-4j
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbYD2VN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbYD2VN6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:13:58 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:46400 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbYD2VN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:13:57 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 17BD7545E; Tue, 29 Apr 2008 23:13:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080429061823.GE24171@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80734>

Eric Wong wrote:
>Junio C Hamano <gitster@pobox.com> wrote:
>> "Stephen R. van den Berg" <srb@cuci.nl> writes:
>> > git-svn supports an experimental option --use-log-author which currently
>> > results in:

>> > Author: foobaruser <unknown>

>> I have a question about this.  Is the "<unknown> coming from...

I have to correct myself here.  What happens is that if in the commit
message there is no From: or Signed-off-by: to be found to parse, that
results in an empty $name_field, and causes $email to stay undefined,
which eventually results in the same silly generated UUID-domain I'm
trying to get rid of.

So it's not triggering the 'unknown' above.

>> I would think not -- if that is the case, the codepath you added as a fix
>> would not trigger.  Which means in some other cases, the 'unknown' we see
>> above in the context also still happens.  Is it a good thing?  Maybe we
>> would also want to make it consistently do "somebody <somebody>" instead,
>> by doing...

>I don't think Stephen's patch ever gets triggered, either.

Well, it is triggered, but rather because $name_field is empty, and
consequently $email is never set.

>$email does appear to get set correctly for the first two elsifs cases
>here in the existing code:

>So I propose the following one-line change instead of Stephen's:

>diff --git a/git-svn.perl b/git-svn.perl
>@@ -2432,7 +2432,7 @@ sub make_log_entry {
>-			($name, $email) = ($name_field, 'unknown');
>+			($name, $email) = ($name_field, $name_field);

That is a good change (IMO), but I still need my patch (or something
similar) to cover the undefined $name_field case.  Proposed new patch
follows.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.

"There's a lot to be said for not saying a lot."
