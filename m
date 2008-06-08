From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] Modified test-lib.sh to output stats to /tmp/git-test-results
Date: Sun, 8 Jun 2008 21:02:47 +0200
Message-ID: <bd6139dc0806081202l48953181q7d337455c85bbe2c@mail.gmail.com>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
	 <m3tzg4vvgw.fsf@localhost.localdomain>
	 <bd6139dc0806080745i2ff2489bv70a1596bcc83f700@mail.gmail.com>
	 <7vabhvkbbi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 21:03:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5QBB-0003jV-KA
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 21:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbYFHTCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbYFHTCs
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 15:02:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10016 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbYFHTCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 15:02:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1776988wfd.4
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=1iehyRjgsOiAsAHTDQBLIYEpnHj5Ib5eeoHBVFKvSQs=;
        b=F6R3aexZyNFj6Teje7ATOSblLlHoz5TRqtiuLTxzMzozvyVjC7WLbNz24Uw095Mdx7
         4zJuYY13VFFI/ysha4kYzMXDEodkrrg1/ytAr4wKdQkZRgPpkDFhKC26o8qxVmkazzfo
         ApkDyF0WhQ6AQ6qJ59ZoV2MR+KP/OS1tfBuUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=n6xzOyuRIo/TnA+NCl0sbA31ahxI5NZSfZmQGUoRSc4SO2PkAMbJHFsylI13QN3uVZ
         0cDBrc+OoRzg29UJfUBiPgrBJIp1CuHywBOrArN9iiZ5LAyN0169LbkTUQgINXBSIaU+
         AL+drdJd83vSBeB2KZVsUM4rVFZG8j0KNvDW0=
Received: by 10.142.133.8 with SMTP id g8mr1054270wfd.253.1212951767284;
        Sun, 08 Jun 2008 12:02:47 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sun, 8 Jun 2008 12:02:47 -0700 (PDT)
In-Reply-To: <7vabhvkbbi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: dc5816c128e2de3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84310>

On Sun, Jun 8, 2008 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Some tests may chdir around and when you hit test_done they may not be in
> the directory directly under t/ anymore.  I'd say that such a test is
> ill-mannered, but we would want to protect ourselves against such mischief
> somehow.

Ah, I guess logging to /tmp/git-test-result was more reliable then.
Any suggestions as to what is the best solution here? (We could for
example save $PWD at the beginning of test-lib.sh.)

> Also, this won't be an immediate issue, but we may want to lift the
> ".NOTPARALLEL" limitation in t/Makefile sometime in the future.  A handful
> tests need to be adjusted for this change, as they currently refer their
> test vectors in t/tXXXX/ as ../tXXXX, and with such a change, we would run
> each test in "t/trash directory/t$$" where $$ is the pid, or something
> like that.  A single "test-results" file everybody races to append would
> become unwieldy at that point.  Something to keep in mind.

Ah, yes, I was going to have each test log to their own file
(test-results-$$) and then cat the result together, but I figured that
since we are .NOTPARALLEL anyway it would be more efficient not to. I
reckon that whenever we decide to make such a change it will be then
that we modify this script, if it is included?

-- 
Cheers,

Sverre Rabbelier
