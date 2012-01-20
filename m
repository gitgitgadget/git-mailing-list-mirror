From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Fri, 20 Jan 2012 10:18:03 -0800
Message-ID: <7vfwfafdb8.fsf@alter.siamese.dyndns.org>
References: <8739bacpql.fsf@thomas.inf.ethz.ch>
 <1327079011-24788-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:18:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoJ2S-0005r4-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 19:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab2ATSSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 13:18:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab2ATSSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 13:18:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 495206BF4;
	Fri, 20 Jan 2012 13:18:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3dUEjhCIo1PrEL+2QHVHQdb6vCc=; b=UFYi76
	lE6hCiF+oEMLn0NsZp5+7JGWl3XIy9E6fvnhx0OVdezL/MQB9YoKA6ECnxHEUP7x
	v8pph4Q+RlozRry+LsJnrXr1KZXIAepBs8anbyLxP9dERSErIAtb7P/rmD73MweT
	X150lk18dkef3vLQGbF1daWo2nOAoSYCvjvXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ddURKWTqBkMZNuXOAGFyt8Mi8FFbcLYI
	VqKIQ9NIFCOZwhOulZZe1KWB7NGx6y78BYEl5oEkWLjy9GrEIv1F2xHBq/NE2/JU
	ddgVWeLTYSt9gIO3ncQ3NHtecTZDss6xiaYT1912/yoRjsaTB0vnbEgvl2rOMzdf
	adU30Ww5x6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 412B66BF3;
	Fri, 20 Jan 2012 13:18:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B512D6BF2; Fri, 20 Jan 2012
 13:18:04 -0500 (EST)
In-Reply-To: <1327079011-24788-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Fri, 20 Jan 2012 09:03:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1876D7DA-4393-11E1-9169-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188891>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Always print a blank line after the send-pack process terminates,
> ensuring the helper status report (if it was output) will be
> correctly parsed by the calling transport-helper.c. This ensures
> the helper doesn't abort before the status report can be shown to
> the user.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---

Thanks; let's do the following on top of this patch, so that:

 - We won't miss a "git push" that errorneously succeeds; and

 - We won't be affected by any future change in the sideband #2
   demultiplexor of the amount of "padding".

 t/t5541-http-push.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git b/t/t5541-http-push.sh a/t/t5541-http-push.sh
index d3e340e..b8f4c2a 100755
--- b/t/t5541-http-push.sh
+++ a/t/t5541-http-push.sh
@@ -101,8 +101,8 @@ exit 1
 EOF
 chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
-printf 'remote: error: hook declined to update refs/heads/dev2        \n' >exp
-cat >>exp <<EOF
+cat >exp <<EOF
+remote: error: hook declined to update refs/heads/dev2
 To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
  ! [remote rejected] dev2 -> dev2 (hook declined)
 error: failed to push some refs to 'http://127.0.0.1:5541/smart/test_repo.git'
@@ -115,8 +115,9 @@ test_expect_success 'rejected update prints status' '
 	git add path4 &&
 	test_tick &&
 	git commit -m dev2 &&
-	git push origin dev2 2>act
-	test_cmp exp act
+	test_must_fail git push origin dev2 2>act &&
+	sed -e "/^remote: /s/ *$//" <act >cmp &&
+	test_cmp exp cmp
 '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 

   
