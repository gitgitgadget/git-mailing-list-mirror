From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 4/7] add tests for rebasing root
Date: Wed, 29 May 2013 22:51:12 -0700
Message-ID: <CANiSa6hMcBVcpqwbvQkCBq=fnVhUv+Va8Q_5XFQ1bjFEHERh5A@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-5-git-send-email-martinvonz@gmail.com>
	<51A5AECF.6070702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 30 07:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhvle-00009a-38
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 07:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967515Ab3E3FvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 01:51:15 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:57571 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966267Ab3E3FvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 01:51:13 -0400
Received: by mail-wi0-f177.google.com with SMTP id hr14so4140651wib.4
        for <git@vger.kernel.org>; Wed, 29 May 2013 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UNSYpxxDV8kawXoD2u7Skzvj/mT/3sMec3noQHKoDLU=;
        b=mzXo7XdynW3FHyuTi9UgwHRlGANiJIQdDQbSMrHDceJ9nfqvdJ1NU0JO8fh42gJrNn
         hu6x6/1OWUgtRlkzG4ZFLfkx1SRElnTDaQ6gtp67HfP90pJsz06I+q0MsyUr2aDgBey3
         +5eiUYda8yBiwfIrrY7KDGa2jtj5Ol1R53MjoDF4H30RUfC1AJkSHgXoF4tfkG9bCD/0
         vRsYzhw1Urjbagx+hv1wFLcuhmXkvrpjyYk5r5IkxGfCs6jK7HgHjk5JZCPePyLkgAVZ
         p+b8FmjY8eaCL7mSHp9mnOG8WKub99Ou2gh14U9txrN3zuvzYfNI8ZX37PPvo3R1KMID
         ZEvw==
X-Received: by 10.194.120.134 with SMTP id lc6mr2965658wjb.55.1369893072117;
 Wed, 29 May 2013 22:51:12 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Wed, 29 May 2013 22:51:12 -0700 (PDT)
In-Reply-To: <51A5AECF.6070702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225927>

On Wed, May 29, 2013 at 12:31 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>> +test_run_rebase () {
>> +     result=$1
>> +     shift
>> +     test_expect_$result "rebase $* --onto --root with merge-base does not go to root" "
>> +             reset_rebase &&
>> +             git rebase $* --onto m --root g &&
>> +             test_cmp_rev m HEAD~2 &&
>> +             test_linear_range 'c g' m..
>
> Here you check the outcome. There is no explicit check whether the rebase
> attempted to replay a and b. But that check is implicit: If a or b were
> attempted to replay, the rebase would have been interrupted with "no new
> changes". Right?

Because 'm' is a reverted 'b', I think if it had gone to the root, we
would have seen 'b m c g' (I _think_ 'a' would be silently skipped at
least in am mode).

>> +test_run_rebase failure -p
>
> Just curious: Does the last one fail because the result is not correct or
> because it does go to the root?

Because the result is not correct; it first checks out 'm', but
something goes wrong (maybe because 'm' gets written to
/rewritten/root?) and it somehow fast-forwards to 'c' (from 'b'?).
