From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 14:45:04 -0400
Message-ID: <32541b130804161145y5f377d27yecfb193fc378613b@mail.gmail.com>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
	 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
	 <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
	 <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com>
	 <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, "Sam Vilain" <sam@vilain.net>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:04:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmCdr-0003iM-FE
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 20:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbYDPSpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 14:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYDPSpI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 14:45:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:50956 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYDPSpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 14:45:07 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1728168mue.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3W5Ll0vwhhtMVfb2YA3ZB4Vlg//y8EbMBn3OxRwcu7k=;
        b=vA7vljDASKMp6+TDfoadFya7d1KEcpdXkNFVL2es4yGLXCjCMKBnLZ6sSdFyG8k/FPseVLJyIHHAfoU1DuSI04oVudyU6rYw8y8Q6JOvpC974aJlhfuqmD2gItqrxhQ1C9wbgoh+J/3qqQTEuz7dpj3FeG9d5gV4L3Q/q4kiW4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWfIB9ssqBiE8YRbOSFndDQjxFSSZZ2CO+yyDPWoqHWTQfozdF0CV6pPGF/T4ylGKnURgItqgawgX5opEccjsv6qSFLgjeHl8iiiUPeI9K0w1VRgLBZNFAWYtkaio+DEHEH/dkFEr8vvsBmugQNLpqxU98a32TPcoOj9COHCWpE=
Received: by 10.82.162.14 with SMTP id k14mr514316bue.42.1208371504517;
        Wed, 16 Apr 2008 11:45:04 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 11:45:04 -0700 (PDT)
In-Reply-To: <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79723>

On 4/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> Let me rephrase that to see if I understand what you are saying.  If you
> look at the "svn log" output (not "git svn log"), you see that the result
> of "git-svn dcommit" does not record the same 'author' as git side does;
> instead it uses whoever ran git-svn to propagate the commit to the SVN
> side.

Yes.

> Ah, that is because the way the commit is propagated is (1) you read git
> commit; (2) you make a corresponding SVN commit using the log message you
> read in step (1); (3) you read that SVN commit back, and create a _new_
> git commit and replace what you read in step (1).  The new git commit is
> marked with the authorship information you obtain from the SVN side,
> unless the commit log message you read back from the SVN side has these
> special markers (and you are using the --use-log-author option).

Correct.

> And your solution is to add these markers in step (2).
>
> If that is the case, I understand how and why this would work around the
> issue.  A possible downside with this approach is that such a commit in
> SVN (from SVN person's point of view) has extra information that is
> unusual in the log message part (namely "From: ").

Yes, that is a downside, although it's relatively harmless to us here.

> For example, CVS honors LOGNAME to allow you to "lie" who the author of a
> change was, which is the behaviour inherited from RCS.  I have to wonder
> if SVN has a similar mechanism to tell it "Excuse me, but I am just a
> secretary recording changes for my boss."

I'm not sure if such an official mechanism actually exists; I do know
that we're writing to the svn repository via ssh and group folder
access, so any attempt to prevent faking of usernames is not actually
secure.

I'd be happy to use such a method if it exists, although this patch
solves my problem too (as well as acknowledging the difference between
the "committer" and the "author" as git does; theoretically it might
be *better* with this separation).

> But perhaps there isn't and that was why you did it this way (and that is
> why --use-log-author was invented 5 months ago).  And the issue that the
> commit on the SVN side has unusual (again, from SVN person's point of
> view) information not in the original commit on the git side might not be
> so grave, so it probably is Ok.

Especially since it's optional.

Thanks,

Avery
