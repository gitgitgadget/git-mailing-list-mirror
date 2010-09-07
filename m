From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 7/7] t2016 (checkout -p): use printf for multiline
 y/n input
Date: Tue, 7 Sep 2010 03:22:53 -0500
Message-ID: <20100907082253.GY1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100907014135.GA1182@burratino>
 <20100907015509.GH1182@burratino>
 <201009071006.27607.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 07 10:25:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OstUA-0008Ms-KS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0IGIYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 04:24:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33953 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab0IGIYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 04:24:52 -0400
Received: by ywh1 with SMTP id 1so1851189ywh.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZF3IboQiJlqaNONKnCI/rdHEP5tRM7LqKe951wHEpRg=;
        b=vQ5eeX0s4p4yiDS6aIrBN0gqNhhR1SeDwGTqNZpWTynfCfFOrYzrUl4OWI472INla/
         emMvSjK7H3vuhZaabyM1pRt0oRBs0XGB6o8p0Lza3y5XtJjDsOR+DMLGVF7lIJeDBYil
         IytsVeVGargthnPw21LrPYqBNP2vn+qGJYpAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f0vCM7fAZU2JJFyFRpmf1XzdOqupN9WZxFvV7m15TQFQlr+lf4/m3/5r8YdMDIOmRW
         vmEJs2MnphF21nWukZrn4/1JJdHGhXkR07+YjNvdj17ChjHAX5dd1B/IDtcI7e7Bb0n3
         wBWbJmDIt1nHmHD/HusiL1vw6p1lm/5IkcNQg=
Received: by 10.151.49.9 with SMTP id b9mr702618ybk.177.1283847892083;
        Tue, 07 Sep 2010 01:24:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm6922268ibk.21.2010.09.07.01.24.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 01:24:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201009071006.27607.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155687>

Thomas Rast wrote:

> I'm indifferent about this.  It does save a process, but (maybe that's
> just me though) I had to look up a POSIX manpage to verify that the
> repeating behaviour is guaranteed.

If saving a process is the only benefit, let's forget it.

>> While at it, add a missing && to the "git checkout -p HEAD with change
>> already staged" test.
>
> Good catch.

Here's a patch with just that.

-- 8< --
Subject: t2016 (checkout -p): add missing &&

Although the set_state command is not likely to fail, it is best to
stay in the habit of checking for failures.

Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t2016-checkout-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 7657ec1..a463b13 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -52,7 +52,7 @@ test_expect_success PERL 'git checkout -p HEAD with NO staged changes: apply' '
 '
 
 test_expect_success PERL 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index
+	set_state dir/foo index index &&
 	# the third n is to get out in case it mistakenly does not apply
 	(echo n; echo y; echo n) | git checkout -p HEAD &&
 	verify_saved_state bar &&
-- 
1.7.2.3
