From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 03/12] t5520: test work tree fast-forward when fetch
 updates head
Date: Fri, 8 May 2015 01:32:47 +0800
Message-ID: <CACRoPnR_T95p+FeLLiQViBiE5z9H3XAEUA5pokuG4B5nns0H0A@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-4-git-send-email-pyokagan@gmail.com>
	<xmqqoalwqpk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:32:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPfK-0003Rt-1p
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbEGRct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:32:49 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35220 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbbEGRcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:32:48 -0400
Received: by lbbuc2 with SMTP id uc2so36260973lbb.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=StqBdykc31EFYIERuRvpidblcBd4Raw0GopHFBTU5C0=;
        b=Kd3buTjVP7INaDuI9/Le/kNNXzivt6mYdMgUKJdIu26E9GcArDPauKyCqITxmhDsiJ
         b810kqRBwQyM+9OVqe/3MhdSKCStAyM07JfFmOFnvfQqPhK8JYYvpTd8b8ovmiAgP0ew
         yy/yRw62rWI4OWxr43gDj/VK9GmCKSLfQOy4CMHV71WK2tom8bGTz66iq9VjJPTChthG
         KGjqlvMlegFNsd4AG6/J554MRYoh/vrt6USvnrKOKoK+wCDTPEqlpV1DcRazzOa4/nGQ
         iVhN7oRXqN1PdnR8tgWdSUSqazdFXsch9E/fmDu/2MB/mg5xjVpcbCQlOClHdcNZB13n
         nZGg==
X-Received: by 10.152.2.38 with SMTP id 6mr4007824lar.80.1431019967303; Thu,
 07 May 2015 10:32:47 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 10:32:47 -0700 (PDT)
In-Reply-To: <xmqqoalwqpk4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268561>

Hi Junio,

On Fri, May 8, 2015 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> +test_expect_success 'fast-forward fails with conflicting work tree' '
>> +     git checkout -b third master^ &&
>> +     test_when_finished "git checkout -f copy && git branch -D third" &&
>> +     echo file >expected &&
>> +     test_cmp expected file &&
>> +     echo conflict >file &&
>> +     test_must_fail git pull . second:third 2>out &&
>> +     test_i18ngrep "Cannot fast-forward your working tree" out &&
>> +     test `cat file` = conflict
>
> At this point, HEAD would match either master^ (as initially checked
> out) or second (as fetch fast-forwarded), but I cannot read what this
> test is expecting to happen.
>
> Should the HEAD move or stay?

Ugh, it was probably me getting confused by all the test dependencies :-(.

Anyway, second^ == master^ == the initial commit at this point, so it
would be clearer to write "git checkout -b third second^", I think.

The HEAD has already moved because git-fetch updated it. I should
definitely add a check to make that clear.

Whether it should or not is something I have an answer to yet though.

Thanks,
Paul
