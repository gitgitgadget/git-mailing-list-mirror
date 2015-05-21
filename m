From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 6/8] t5520: test --rebase failure on unborn branch with index
Date: Thu, 21 May 2015 16:51:16 +0800
Message-ID: <CACRoPnSuiN-Q0PY97bEuS5GV2pTqmLoSz-1wk2OdTo6aNsGw0A@mail.gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-7-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbXcWiK-9_NDCERNbi-m1cPiuukZ75r6TWwoUBsnyUGiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 21 10:51:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvMCK-0006pY-JR
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbbEUIvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:51:19 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37632 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbbEUIvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:51:18 -0400
Received: by wibt6 with SMTP id t6so5869521wib.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Glhj3SEWFNRkoS4hMv+/MSSW/C6+SQwD4r5W2ACZXRA=;
        b=TO6GjNZUqVi7b+FHbb7HtuEfTihLvS3Z1d4LzMQhx4nh+h7E2ONB9DV9W90yRbgSA0
         bJAXvO60wrn56nT/vaPDYjqQVPkChXsXcQ7Yga+PrWAcdsoCGiSOKGrm26o5P9sG4SdP
         agKfE2fnMb9g9rDy+K8wb+lS5E9AntgE3sF+Bd9xn/5L6RRinCHXTsu5TjUXb1+qTeKf
         FpKn6sRqyvauuDOtMWGL0B+bnsEDOvOB/lvEGWgVUSll0/KWcDq/lV0Mhoy8sJ8xXzvG
         j+QueQPbDJSUVDojsZ2jULZUJDdPk+SvCrdeqD/WtItixZiPOpay8Pms3vtgZDjvPYKB
         5Epg==
X-Received: by 10.194.188.107 with SMTP id fz11mr3241619wjc.98.1432198276987;
 Thu, 21 May 2015 01:51:16 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Thu, 21 May 2015 01:51:16 -0700 (PDT)
In-Reply-To: <CAGZ79kbXcWiK-9_NDCERNbi-m1cPiuukZ75r6TWwoUBsnyUGiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269573>

Hi,

On Tue, May 19, 2015 at 2:00 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 18, 2015 at 6:32 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index f991439..4d649a5 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -413,6 +413,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
>>         test_cmp expect actual
>>  '
>>
>> +test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
>> +       test_when_finished "rm -rf empty_repo2" &&
>> +       git init empty_repo2 &&
>> +       (
>> +               cd empty_repo2 &&
>> +               echo staged-file >staged-file &&
>> +               git add staged-file &&
>> +               test "$(git ls-files)" = staged-file &&
>> +               test_must_fail git pull --rebase .. master 2>../err &&
>> +               test "$(git ls-files)" = staged-file &&
>> +               test "$(git show :staged-file)" = staged-file
>> +       ) &&
>> +       test_i18ngrep "unborn branch with changes added to the index" err
>
> So when seeing this line outside the parenthesis section, I immediately thought
> there must be a reason you put it outside. The reason is not obvious
> to me though.
> So I'd suggest to move the test_i18ngrep inside the section above.

Right. Fixed.

Regards,
Paul
