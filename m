From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 09/15] t5602 (clone-remote-exec): add missing &&
Date: Fri, 1 Oct 2010 06:34:13 -0500
Message-ID: <20101001113412.GH6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-10-git-send-email-newren@gmail.com>
 <7vzkv0mkn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:37:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1dvf-0006L3-Ut
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab0JALhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 07:37:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33701 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab0JALhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 07:37:19 -0400
Received: by iwn5 with SMTP id 5so3719413iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=coGsvWdcScIJRBcxvuF9dmppbCTcO/hvLlAsr3kS90A=;
        b=ZojVUvwDRAocHpl+1XdDKnrRWJun0jLiOXY2Vqy2S5Ms9dE6OkSnexBb3MMdGhTrnS
         /PMiGjBYD9wz3OvXg3NkmZKNyqSyOdAWKZXx8Acs+bsiPg+1dV+/c1hyPYwfXH0TC/Xh
         3Otylpv7Gqyt+FgzOyHRWXGxXv8jKjQKU4dXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SJDAfJBSogyHS+ZhKaKunVlIl97Fjpyt/ryGCOXL50StELOMNSPi3hNp9Epa4xOLii
         idb9FY+nWnO3lHzvhR5YEE4A0sG5Eg6OkWJTPiI8rpieFduoWbQZGCoQiesel+yY87fe
         A2n8UYCSjA9SA9WkaUZ++XUjPDVqOyK2HBktM=
Received: by 10.231.191.6 with SMTP id dk6mr5522108ibb.51.1285933038764;
        Fri, 01 Oct 2010 04:37:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm1115330ibu.6.2010.10.01.04.37.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 04:37:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkv0mkn5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157747>

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:

>> +	GIT_SSH=./not_ssh test_must_fail git clone localhost:/path/to/repo junk &&
>
> I think this suffers from the same issue that have been fixed with 09b78bc
> (t7502-commit.sh: rearrange test to make more portable, 2008-07-22) and
> 2d60615 (tests: Avoid single-shot environment export for shell function
> invocation, 2009-01-26).

Here's a patch for squashing.

Thanks again.

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index 6aa6e0d..3f353d9 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -12,13 +12,21 @@ test_expect_success setup '
 '
 
 test_expect_success 'clone calls git upload-pack unqualified with no -u option' '
-	GIT_SSH=./not_ssh test_must_fail git clone localhost:/path/to/repo junk &&
+	(
+		GIT_SSH=./not_ssh &&
+		export GIT_SSH &&
+		test_must_fail git clone localhost:/path/to/repo junk
+	) &&
 	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
 test_expect_success 'clone calls specified git upload-pack with -u option' '
-	GIT_SSH=./not_ssh test_must_fail git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk &&
+	(
+		GIT_SSH=./not_ssh &&
+		export GIT_SSH &&
+		test_must_fail git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk
+	) &&
 	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
-- 
