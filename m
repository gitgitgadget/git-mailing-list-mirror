From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add missing test file for UTF-16.
Date: Tue, 6 Aug 2013 18:59:10 +0700
Message-ID: <CACsJy8ACqB5qRLFCerACEQrK8QXH+n=tAxdutAGT6JeijDvJUQ@mail.gmail.com>
References: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
 <CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com> <7vtxj4kry1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 13:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6fvd-0007eZ-OD
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 13:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab3HFL7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 07:59:42 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33364 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab3HFL7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 07:59:40 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so569370obc.31
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SoHRs/pm4Mq/j83sL9xYfXdr8zoByIb61IIA84FWEN4=;
        b=fR0YNhYjFkxwW4eKD3b3zZBYH9lioXP0CQYTf+5LDddbgAgRiBCMuhmTSVbV4ovEsr
         KZydhJobAr1CR80YwkvUWRz30lKcTKrhzGAyZ0QUxsU3N6Fme7I5tfD6gSFy+JPE+W2L
         5L+5nGUYB/dhWxOl9xjNb0qZ/mCkcKHaKz0mNN/rvCg0t7c5TudQph8lS64zD/nT7gk+
         q8B7nIfppBs+oLdjVOXE/yllqo7fVORyEMPbD2o1b8xMxwaOHmr68msWZv25/vqjlNZX
         SGDfL7j1K6pry2V3/GqE9DNlkKEh/qnEwTRElKHaMkZqHI0AP/ivYqT4Cz38tgH4+/z2
         eA+A==
X-Received: by 10.60.45.138 with SMTP id n10mr623278oem.101.1375790380372;
 Tue, 06 Aug 2013 04:59:40 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 6 Aug 2013 04:59:10 -0700 (PDT)
In-Reply-To: <7vtxj4kry1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231735>

On Mon, Aug 5, 2013 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Aug 4, 2013 at 12:26 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>> The test file that the UTF-16 rejection test looks for is missing, but this went
>>> unnoticed because the test is expected to fail anyway; as a consequence, the
>>> test fails because the file containing the commit message is missing, and not
>>> because the test file contains a NUL byte.  Fix this by including a sample text
>>> file containing a commit message encoded in UTF-16.
>>
>> Tested-by: Duy Nguyen <pclouds@gmai.com>
>>
>> and sorry, my bad. I think we need your sign-off in this patch.
>
> I think 37576c14 (commit_tree(): refuse commit messages that contain
> NULs, 2011-12-15) that marked this test with "test_expect_failure" is
> broken with or without this fix.  It should be more like so:
>
> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index 37ddabb..5e72d72 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -34,9 +34,9 @@ test_expect_success 'no encoding header for base case' '
>         test z = "z$E"
>  '
>
> -test_expect_failure 'UTF-16 refused because of NULs' '
> +test_expect_success 'UTF-16 refused because of NULs' '
>         echo UTF-16 >F &&
> -       git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
> +       test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
>  '

The intention was "UTF-16 is not supported yet but we want to". But I
don't think we (at least I) will put any effort on that front to allow
NUL in commit message, so the patch, as in "we do not support UTF-16",
is fine.
-- 
Duy
