From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t5400-send-pack: Use POSIX options to cp for
 portability
Date: Mon, 08 Oct 2012 10:45:49 -0700
Message-ID: <7vvcekluwi.fsf@alter.siamese.dyndns.org>
References: <1349683681-18978-1-git-send-email-bdwalton@gmail.com>
 <7vlifgncq8.fsf@alter.siamese.dyndns.org>
 <7vd30snbtk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 19:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHP0-000521-D3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab2JHRpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 13:45:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab2JHRpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:45:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E428A04;
	Mon,  8 Oct 2012 13:45:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WMnom+WLK5UMo4TdexAw7KVwn6g=; b=SsrD/M
	sPf889/saPaQ3ePKGY65LfpaBhYJldxHnvSWOfGli1XpAUQ1PS/LhjMCvHQPsvoY
	OtAV74uYVO0CDuF6ek9Bt4KHtVwiHo+GOk1iKHJB8N9uoBC+3X7oKoPGz+z40yZP
	PUeKoqQ5BKUxGDN03QWIjApgRgMpB3KxHC7uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3dzXr7mbtlvAw8XuEM/Nid//iMj2lIW
	9KmwXcVrjaWMYLmFDIRtyPsUa0T5PYr55pC/R11H9OtdUbqZMD/WJHX9PQ5kjtmY
	Sllybnz9ocgPbcpmCKK0EnMDAQTszPco7Tok37iVM1OwKaFuuYZHG28eVjwNyfL4
	rU6NV6SHnIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F76F8A03;
	Mon,  8 Oct 2012 13:45:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2D4F8A02; Mon,  8 Oct 2012
 13:45:50 -0400 (EDT)
In-Reply-To: <7vd30snbtk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 09:55:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFF88DBA-116F-11E2-92FD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207248>

Junio C Hamano <gitster@pobox.com> writes:

>> Thanks, but is "-p" essential for this test to pass, or can we get
>> away with just "-R"?
>
> Besides, when you spot a potential problem, please ask "git grep"
> to catch them all.

In other words, how about doing this instead?

-- >8 --
Subject: tests: "cp -a" is a GNUism

These tests just wants a bit-for-bit identical copy; they do not
need -H (there is no symbolic link involved) nor -p (there is no
funny permission or ownership issues involved).  Just use "cp -R"
instead.
---
 t/t5400-send-pack.sh      | 2 +-
 t/t5550-http-fetch.sh     | 2 +-
 t/t5800-remote-helpers.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 250c720..418f515 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -159,7 +159,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	    git commit -a -m "Second commit" &&
 	    git repack
 	) &&
-	cp -a parent child &&
+	cp -R parent child &&
 	(
 	    # Set the child to auto-pack if more than one pack exists
 	    cd child &&
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 16ef041..80d20c8 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup repository' '
 '
 
 test_expect_success 'create http-accessible bare repository with loose objects' '
-	cp -a .git "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	cp -R .git "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 git config core.bare true &&
 	 mkdir -p hooks &&
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 5702334..e7dc668 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -76,7 +76,7 @@ test_expect_success 'pushing to local repo' '
 # git-remote-testgit, but is too slow to leave in for general use.
 : test_expect_success 'racily pushing to local repo' '
 	test_when_finished "rm -rf server2 localclone2" &&
-	cp -a server server2 &&
+	cp -R server server2 &&
 	git clone "testgit::${PWD}/server2" localclone2 &&
 	(cd localclone2 &&
 	echo content >>file &&
-- 
1.8.0.rc0.95.g9b3a052
