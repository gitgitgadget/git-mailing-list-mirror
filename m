From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pulling without any local commits deletes stages files without warning.
Date: Sat, 28 Apr 2012 21:21:29 -0700
Message-ID: <xmqqk40z88xi.fsf@junio.mtv.corp.google.com>
References: <CAHzj05Uy-zofirgnhqK_t+jdD41J8yG5OJk-QCHmQ+OZLWfMqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jem <jem.mawson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 06:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOLdt-000338-Bs
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 06:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab2D2EVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 00:21:39 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:55952 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab2D2EVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 00:21:31 -0400
Received: by eaaq10 with SMTP id q10so99535eaa.1
        for <git@vger.kernel.org>; Sat, 28 Apr 2012 21:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=LPPDTExVvsX0pxOXKiI1J1dJYy2itVUfxd8K42jcBWI=;
        b=hQY3EYshb9sIHsW1fR+WpDN6latPdI5TsTr0ls1orjUIfxwKp4QzgHm0REdbGFg9ag
         nxAnYqUyKSFHRj0OMS2j7OvOWLXIgYU8EU9Qk9kBfxaXBkL4ixJSg7EFXyMuqPR+fUGE
         z/Rxi3x/ujPPRf0QEksP9kClJO4GfsrMGgM0zx9PcRm+QNyMhppdca2ppZsy40spKrLH
         7i2W973M8iWaDXpy+kiCgDFQwkyjNVJ4ZxO/Ep1aUow2Jj6wTXJWTezq9ywywf3DOwp9
         JeEMkUEbTCGi+OWhap3dGinyxnORyd8VAlDusEY7H7xATGGi7yMQ2Szg0SBeWX10XDpx
         vvpg==
Received: by 10.213.26.206 with SMTP id f14mr872621ebc.15.1335673290578;
        Sat, 28 Apr 2012 21:21:30 -0700 (PDT)
Received: by 10.213.26.206 with SMTP id f14mr872609ebc.15.1335673290442;
        Sat, 28 Apr 2012 21:21:30 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si11421990eef.2.2012.04.28.21.21.30
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 28 Apr 2012 21:21:30 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 4006420004E;
	Sat, 28 Apr 2012 21:21:30 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 832B8E175F; Sat, 28 Apr 2012 21:21:29 -0700 (PDT)
In-Reply-To: <CAHzj05Uy-zofirgnhqK_t+jdD41J8yG5OJk-QCHmQ+OZLWfMqw@mail.gmail.com>
	(Jem's message of "Sun, 29 Apr 2012 10:29:09 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlkbqDzRU00oK0zJanEoKKzspBFFEzwgpsatA+RDndSXbIgwTwt80Qgxx0mEUrr2wsU57qU0Bqky//OEwZsPQE/96a4l4ss9W2QcEiPBMCvuL/WS/RKuldXke4TfW0ZkK90deGsaJ+y2jN5KPkhQhJcn2ucv09M0Fy1M53rtccT1U2fu90=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196503>

Jem <jem.mawson@gmail.com> writes:

> Pulling without any local commits deletes staged files without
> warning. Is this intended behaviour?

It is an unanticipated corner case interfering our attempt to be too
nice that backfired.

For a long time, having no history and asking to pull was forbidden,
because "git pull" is is about combining two (or more) histories
together and pulling when you have no history is a nonsense --- you only
have one history (the history from the other side) and there is nothing
to combine.

Later we tried to be nicer, as some new users triggered an error when
doing "git init" in an empty directory followed by "git pull", by
redefining "merge" into no history to mean resetting to the other
history.

This solved "git init && git pull", but we did not anticipate anybody
would do a "git init && git add && git pull" sequence, to which there is
no sane outcome other than just erroring out.

A patch to give that only sane outcome may look like this.

 git-pull.sh |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-pull.sh b/git-pull.sh
index 2a10047..da102d0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -261,6 +261,9 @@ esac
 
 if test -z "$orig_head"
 then
+	test $(git ls-files | wc -l) = 0 ||
+	die "$(gettext "Uncommitted changes in the index")"
+
 	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
 	git read-tree -m -u HEAD || exit 1
 	exit
