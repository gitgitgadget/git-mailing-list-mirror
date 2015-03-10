From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [v2 PATCH 2/2] reset: add tests for git reset -
Date: Tue, 10 Mar 2015 18:23:25 +0100
Message-ID: <54FF288D.3000304@web.de>
References: <1426001883-6423-1-git-send-email-dyoucme@gmail.com> <1426001883-6423-2-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sundararajan R <dyoucme@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 18:23:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVNsp-00009M-L5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbbCJRXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 13:23:39 -0400
Received: from mout.web.de ([212.227.17.12]:62078 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbbCJRXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:23:37 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MQ6PP-1YQBD21jgx-005GLm; Tue, 10 Mar 2015 18:23:35
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1426001883-6423-2-git-send-email-dyoucme@gmail.com>
X-Provags-ID: V03:K0:56lpU18a+CP1Jc65XomdC+MYxFdLtYT3Jra2b98Eb3yj5mSAhHb
 9SRLQpp1237+WmG/Kbo2ndxfCTQCIYqVaESK7trwBVqg9OqSpJaJETZ8Be9kxOCcOWWEF79
 m493EnZijJnVR6DbNfudOX91Y9aZKbKl0fA2GuRs0owScai7FjZmMLmWgT4EahYGH0ewnSu
 hMd+JdFnCZUAjLgBVOYDg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265244>

On 2015-03-10 16.38, Sundararajan R wrote:

> Helped-by: Torsten B=C3=83=C2=B6gershausen <tboegi@web.de>
There seems to be an issue that the mail is encoded
from (what ? Latin-1) into UTF-8 2 times

The easy solution is to remove the line,
I'm OK with that, since a review-comment is not necessarily  motivating
a Helped-by, at least not for me.
Mentioning it in the comments good and is enough.


But why is the mail "encoded twice" ? (this what the header says:)
  X-Mailer: git-send-email 2.1.0
  Content-Type: text/plain; charset=3DUTF-8

Can somebody help out with a good explanation ?

Another (minor) thing:
There is nothing wrong with the test, but we can make it 3% more "Git-s=
tyle" and
easier too read when it is more similar to the rest of the code base:

test_expect_success 'reset - with @{-1} and no file named - or @{-1} sh=
ould succeed' '
+	git init new &&
+	(
+		cd new &&
+		echo "Hey" >new_file &&
+		git add new_file &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>new_file &&
+		git add new_file &&
+		git reset - &&
+		git status -uno >file1 &&
(Side-question: why "status -uno")
typically "file" (or "file1") is used for user files, not for the "expe=
cted" or "actual" output.

Then we can compare the files directly in new/.
And if we use new1, new2, new3, we don't need the explicit cleanup, as =
all tests
are run in a "trash directory" which will be removed anyway.

In other words, we can write like this:
(But this is for discussion, please read it as a suggestion)

+test_expect_success 'reset - with @{-1} and no file named - or @{-1} s=
hould succeed' '
+	git init new3 &&
+	(
+		cd new3 &&
+		echo "Hey" >new_file &&
+		git add new_file &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>new_file &&
+		git add new_file &&
+		git reset - &&
+		git status -uno >expected &&
+		git add new_file &&
+		git reset @{-1} &&
+		git status -uno >actual
+		test_cmp expected actual=20
+	)
+'
