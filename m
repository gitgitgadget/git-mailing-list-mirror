From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/7] test-bzr.sh, test-hg.sh: allow running from any dir
Date: Mon, 11 Nov 2013 12:58:11 -0600
Message-ID: <CAMP44s1wc_1v2f9u0hV5VhjybZtF8tAs8-mxwEa+KuTiroLvsw@mail.gmail.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384142712-2936-3-git-send-email-rhansen@bbn.com>
	<5280c108749d8_6841541e787e@nysa.notmuch>
	<xmqqsiv2lrig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:58:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfwgj-0000Cu-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab3KKS6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:58:13 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:54472 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3KKS6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:58:12 -0500
Received: by mail-la0-f43.google.com with SMTP id n7so3286077lam.16
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OrWQVuJ9OTHrBcCYb5PQ6WnSr/Rd2h2o1tlvbG8BQuM=;
        b=A/vP3SKXQSwX+h5HCqurP/5fTwE2XOjounv+3EsERbj0MUdaUervcfRJMKyrq05+S+
         mvsL0Xim2CWFqo9EfxzFKpX1aILJQ2bbyrBjpW+p1XHEbd/uHHVvWhaSxpZj4dAd/qF7
         Ip9yVl2O6W82XpwqbSGkoC/snPKFLGZQBZBP6C5RlfvmiW2DXh3cyQ6pq9WL25CILOKU
         HGtKhCxfWslv6ytclDrdkvRefwekrG4LedDQzD5E7qZ6SY20QfDYNCSyxjNOYZ0788aA
         GjUC/vtj+UANviZ3O/eK7KRIZHIv5D1232BLffrA0XsIFkei3Oz0lonedtgcqzuaX0px
         d8hA==
X-Received: by 10.112.136.163 with SMTP id qb3mr22910258lbb.14.1384196291120;
 Mon, 11 Nov 2013 10:58:11 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 10:58:11 -0800 (PST)
In-Reply-To: <xmqqsiv2lrig.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237631>

On Mon, Nov 11, 2013 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Richard Hansen wrote:
>>> cd to the t/ subdirectory so that the user doesn't already have to be
>>> in the test directory to run these test scripts.
>>>
>>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>>> ---
>>>  contrib/remote-helpers/test-bzr.sh | 1 +
>>>  contrib/remote-helpers/test-hg.sh  | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
>>> index 5c50251..094062c 100755
>>> --- a/contrib/remote-helpers/test-bzr.sh
>>> +++ b/contrib/remote-helpers/test-bzr.sh
>>> @@ -5,6 +5,7 @@
>>>
>>>  test_description='Test remote-bzr'
>>>
>>> +cd "${0%/*}"/../../t || exit 1
>>
>> I think this should do the trick:
>>
>>   test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$(realpath ${0%/*}/../../t)"
>>   . "$TEST_DIRECTORY"/test-lib.sh
>
> Can we do that without using realpath(1)? I do not think we use it
> anywhere in the main part of the project.

Something like this, probably:

--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -26,6 +26,8 @@ then
        # outside of t/, e.g. for running tests on the test library
        # itself.
        TEST_DIRECTORY=$(pwd)
+else
+       TEST_DIRECTORY=$(cd $TEST_DIRECTORY && pwd)
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then


Then we can do:

 test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="${0%/*}/../../t"
 . "$TEST_DIRECTORY"/test-lib.sh

-- 
Felipe Contreras
