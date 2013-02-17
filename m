From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 2/3] contrib/subtree/t: Added tests for .gitsubtree support
Date: Sun, 17 Feb 2013 15:26:30 +0000
Message-ID: <CALeLG_n-WocsMTvRZHm6v-+wrCNVvCh6O2baVDALSE3JB8ibng@mail.gmail.com>
References: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
	<20130215225624.GB21165@google.com>
	<CALeLG_nLz9Gfqcfk4EcWixRXbWC0x0GUVFDAKD20DGbkhRNWvQ@mail.gmail.com>
	<20130217113723.GA9882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 16:26:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U768m-00032m-Aa
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 16:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab3BQP0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 10:26:32 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64248 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483Ab3BQP0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 10:26:32 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so5004385obc.34
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 07:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=AKqx+epYeCnPKDA5wnlq7hYJbiFFCT9YnXDTiRl3f2M=;
        b=fijsm1meHIfYSkLzP0z0My07doUhcaBtiFSZBUXEU0dPBmOznslnChn02JwYrHXBc4
         1z85Gt9T1SqRqUpVldlya3Qb/0gCQLFEcHb1PlKO6BdmdT7dy+A7xGTMI2U6zNmghe9j
         SKk/+bq45L4hLY/Oljyo/fRKvhEbWPld6+uEBmwxkf/CTDxKiELC06Gfa7EGaKesyabv
         IdV+iKWINZEBo0fKq8z5zXsE2QHjq7UFupFk9tS1dsKqDVVC+6y1jamKwmyi/z4qUD4E
         XbmhqT9I+O4h8FXbGavE1t7boosMMHJCgHM7O/oOw62NbjyOiB5ah2hl3RBicQKRw63+
         1pVQ==
X-Received: by 10.182.190.97 with SMTP id gp1mr4923226obc.19.1361114790413;
 Sun, 17 Feb 2013 07:26:30 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Sun, 17 Feb 2013 07:26:30 -0800 (PST)
X-Originating-IP: [2.102.85.14]
In-Reply-To: <20130217113723.GA9882@elie.Belkin>
X-Gm-Message-State: ALoCoQknyROCYtg5Knt6Ffan8eErSuSi5sU5w+OxCWf+kFh70LGJAe15so3c5g1F7FPxOlgLQnYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216397>

On Sun, Feb 17, 2013 at 11:37 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Paul Campbell wrote:
>
>> Is there was a better way to verify that the push operation succeeds
>> then grepping for a SHA1?
>
> IIRC then when a push fails, it will exit with nonzero status (so the
> usual &&-chaining would propagate the error).
>
> Alternatively, one can fetch, ls-remote, or enter the target repo and
> use history inspection tools to check that the result is as expected.
>
> Hope that helps,
> Jonathan

Thanks Jonathan.

Here's the updated version of the tests:

 contrib/subtree/t/t7900-subtree.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh
b/contrib/subtree/t/t7900-subtree.sh
index 80d3399..e7bb911 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -465,4 +465,37 @@ test_expect_success 'verify one file change per commit' '
         ))
 '

+# return to mainline
+cd ../..
+
+# .gitsubtree
+test_expect_success 'added repository appears in .gitsubtree' '
+	git subtree add --prefix=copy0 sub1 &&
+	grep "^copy0 \. sub1$" .gitsubtree
+'
+
+test_expect_success 'change in subtree is pushed okay' '
+	(cd copy0 && create new_file && git commit -m"Added new_file") &&
+	git ls-tree refs/heads/sub1 >output &&
+	! grep "new_file$" output &&
+	git subtree push --prefix=copy0 &&
+	git ls-tree refs/heads/sub1 >output &&
+	grep "new_file$" output
+'
+
+test_expect_success 'pull into subtree okay' '
+	git subtree add --prefix=copy1 sub1 &&
+	git subtree add --prefix=copy2 sub1 &&
+	(cd copy1 && create new_file_in_copy1 && git commit -m"Added
new_file_in_copy1") &&
+	git subtree push --prefix=copy1 &&
+	git subtree pull --prefix=copy2 | grep "^ create mode 100644
copy2/new_file_in_copy1$"
+'
+
+test_expect_success 'replace outdated entry in .gitsubtree' '
+	echo "copy3 . sub2" >>.gitsubtree &&
+	git subtree add --prefix=copy3 sub1 &&
+	! grep "^copy3 . sub2$" .gitsubtree &&
+	grep "^copy3 . sub1$" .gitsubtree
+'
+
 test_done
-- 
1.8.1.3.605.g02339dd


-- 
Paul [W] Campbell
