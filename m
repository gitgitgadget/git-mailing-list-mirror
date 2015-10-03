From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 43/43] refs: tests for db backend
Date: Sat, 3 Oct 2015 19:39:31 +0200
Message-ID: <20151003173930.GA25904@spirit>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
 <1443477738-32023-44-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 19:45:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQs1-000893-4M
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 19:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbbJCRpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 13:45:10 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35088 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbJCRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 13:45:09 -0400
Received: by wicge5 with SMTP id ge5so70447774wic.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 10:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NpPo84l80QVZdJCKVYGS7tg34UzSOIBMeUSY8xngx6M=;
        b=NQYX1vTckWKY3g/poc4ciYLka6ZBf3+LqWQvlyO8o/cH2YqJByrpmCLDo7+SrblsRV
         6gXJ/gi+nqP0+ZfuGXO/ax8GeetjbTEXvle2h6jmljyHiSzccpRkGtQzqu0DUjnuNCC1
         ksgaiip0WAsIskRjyt1YYTlJQvfaaSS3Zvt0MBObCQQPm+IlayBF69txOiOV9+Xmqtvd
         itA2U8wViZjlO9t/tsbVEaEFKNPhIfIqQv3yomofPC8RpuZsxldVE2xjQaTPPptBINq7
         7od8PktN+SD73jkTkWEdI7LtpYMyf0zT3Seax47qhMiyBtdfvLP75vF46GfB+ZpiW6dh
         aRmw==
X-Gm-Message-State: ALoCoQlq1a9ObTf+FoZjhalKmS67l3MnJfT/OurjSSnFHwwd1lCo2IH6D1dFXWmhs9r2B1oHAlRl
X-Received: by 10.180.75.176 with SMTP id d16mr3679834wiw.75.1443894308470;
        Sat, 03 Oct 2015 10:45:08 -0700 (PDT)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id p1sm5154686wif.7.2015.10.03.10.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 10:45:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443477738-32023-44-git-send-email-dturner@twopensource.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278980>

On Mon, Sep 28, 2015 at 06:02:18PM -0400, David Turner wrote:
> Add tests for the database backend.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  t/t1460-refs-be-db.sh        | 1103 ++++++++++++++++++++++++++++++++++++++++++
>  t/t1470-refs-be-db-reflog.sh |  353 ++++++++++++++
>  2 files changed, 1456 insertions(+)
>  create mode 100755 t/t1460-refs-be-db.sh
>  create mode 100755 t/t1470-refs-be-db-reflog.sh

These break 'make test' on builds without the db backend. Maybe squash
in something like the following:

diff --git a/t/t1460-refs-be-db.sh b/t/t1460-refs-be-db.sh
index f13b0f0..c8222ed 100755
--- a/t/t1460-refs-be-db.sh
+++ b/t/t1460-refs-be-db.sh
@@ -9,6 +9,11 @@ test_description='Test lmdb refs backend'
 TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
 
+if ! test -e ../../test-refs-be-lmdb; then
+	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
+	test_done
+fi
+
 raw_ref() {
 	test-refs-be-lmdb "$1"
 }
diff --git a/t/t1470-refs-be-db-reflog.sh b/t/t1470-refs-be-db-reflog.sh
index 99a705d..2538a58 100755
--- a/t/t1470-refs-be-db-reflog.sh
+++ b/t/t1470-refs-be-db-reflog.sh
@@ -8,6 +8,11 @@ test_description='Test prune and reflog expiration'
 TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
 
+if ! test -e ../../test-refs-be-lmdb; then
+	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
+	test_done
+fi
+
 raw_reflog() {
 	cat .git/logs/$1 2>/dev/null || test-refs-be-lmdb -l "$1"
 }


Also, test 18 in t1460 is broken:
expecting success: 
    git symbolic-ref refs/heads/self refs/heads/self &&
        test_when_finished "delete_ref refs/heads/self" &&
            test_must_fail git update-ref -d refs/heads/self

test_must_fail: command succeeded: git update-ref -d refs/heads/self
not ok 18 - update-ref -d is not confused by self-reference
#   
#       git symbolic-ref refs/heads/self refs/heads/self &&
#       test_when_finished "delete_ref refs/heads/self" &&
#       test_must_fail git update-ref -d refs/heads/self
#   

-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
