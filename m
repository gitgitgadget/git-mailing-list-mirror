From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 17:17:43 +0700
Message-ID: <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com>
References: <56E9F5B3.6030903@fb.com> <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
 <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:18:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agV0W-0004Ar-6D
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 11:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935433AbcCQKSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 06:18:17 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34063 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827AbcCQKSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 06:18:15 -0400
Received: by mail-lb0-f172.google.com with SMTP id k12so65153380lbb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=18dRpL59FScDQ+hxyjPmhJ5N1UTT9B3+sjMA7ds0L4k=;
        b=IuPckC1yGAEyyTxktsLt1iZ1VqEPeHZgEkzP6vreXSJXxTaJTVghSegFehvRPup99b
         HOupWMvInla+mRVKw4C4eDtYfRcA2ZxsBa8Hu6TGeB0b5u17nHxdxmtpIz6kKFlqahr1
         C338o5jJ+kKrho/ypQ80ATzHoVrsAvzTuDbohutOpKGBj8URZYmfvLR7a+MqmM1fJ07Y
         TpmGxBYtQa3XY+sWJeps6p3nRjPO0ACh6XDXDv3zFINmAwaMJrmCDLYmFLviZvAtQ+1I
         QuZMlpnbWwa3MApB8MMQ4XnSQRwp32iXFFYTd1a2tUMsI/clqRGB75sIx4QozIvbHVDW
         XL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=18dRpL59FScDQ+hxyjPmhJ5N1UTT9B3+sjMA7ds0L4k=;
        b=LUm9N4ec11MJHo5+VHp4dk9SNIIq2PQdd8yfvuTN5BZj8HbpkbB58DiubwpjOxoDYa
         O/QuopCv76TU6dzLY+Y0gcbW0A2RlhM+SnQkCaPG5EmebDSs99pn2NDYLZKGaIWCpLrN
         5HYHt78EoMUZJgNHpGEuvQEtwtiGAi3Hf1917msEM+dZlJ3j7cxzgJfhQiuBkDWtHE8f
         X6V+PmG3Y1EETAM1YveubjhBUt4eCXXN5O1roT4W4Zfa9BIufTT5k7cR2uIIbOluSyek
         dLi16cCkmoEaKnhF8DRvfkrczYWgZB/HcNYTHqQJCyOvOxRGKesQN/oaH86UX/p4oE5b
         TC1A==
X-Gm-Message-State: AD7BkJJQumSv/kVE5BwyMqsXHHhjoas91DdSV4ABprIWHV9a5k8pTS6dBoY6aYaC4pZe5UZksARBv8pyZwpElQ==
X-Received: by 10.112.130.41 with SMTP id ob9mr3184485lbb.81.1458209893500;
 Thu, 17 Mar 2016 03:18:13 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 03:17:43 -0700 (PDT)
In-Reply-To: <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289094>

On Thu, Mar 17, 2016 at 2:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Mar 16, 2016 at 05:09:23PM -0700, Durham Goode wrote:
>>> Using git 2.8.0-rc2, given a repo with the following files:
>>>
>>> - one/hideme
>>> - one/donthide
>>> - two/foo
>>>
>>> A sparse config of:
>>>
>>> cat > .git/info/sparse-checkout <<EOF
>>> /*
>>> !one/hideme
>>> EOF
>>>
>>> Results in a repository that only has `one/donthide` in it.  I would
>>> expect `two/foo`to be present as well.  This worked in 2.6, and
>>> bisecting it points to d589a67eceacd1cc171bbe94906ca7c9a0edd8c5
>>> "dir.c: don't exclude whole dir prematurely" (author cc'd).
>>
>> Thank you. This should fix it. I think I understand why it goes
>> wrong. I'm going to run some more tests and post a proper patch later.
>
> I admit that I've always considered "sparse checkout" was an
> uninteresting experimental feature that I do not want to pay too
> much attention to, and the only review I did carefully myself was to
> make sure that patches around that area would not change the
> behaviour of the original code in repositories that do not use that
> feature, so please do not laugh too loudly at me if I ask the
> obvious ;-)

Good news for you is there's "sparse checkout v2" in the work, that
would not rely on exclude engine and should be both faster and more
elegant. That should reduce "sparse checkout v1" usage to really small
cases.

> So the pattern list in that info/sparse-checkout file
> shares the same logic with the gitignore mechanism, and the paths
> that would have been "ignored" if the pattern list were in the
> .gitignore file are the ones that would be included in the checkout?
>
> If so, among the three paths Durham lists:
>
>  * one/hideme matches !one/hideme the last, i.e. it would not be
>    ignored if the pattern appeared in .gitignore, hence it should not
>    be in the checkout;
>
>  * one/donthide matches * the last, i.e. would be ignored, hence it
>    should be in the checkout;
>
>  * two/foo (or really anything) matches * the last, i.e. would be
>    ignored, hence it should be in the checkout.
>
> Am I reading the bug correctly?

Yes that's how I read it too. The patterns basically say "include
everything (/*) except one/hideme (!one/hideme)" so two/foo should be
included.

>> -- 8< --
>> diff --git a/dir.c b/dir.c
>> index 69e0be6..77f38a5 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1027,7 +1027,6 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
>>                               exc = x;
>>                               break;
>>                       }
>> -                     continue;
>>               }
>>
>>               if (x->flags & EXC_FLAG_MUSTBEDIR) {
>> -- 8< --
>> --
>> Duy



-- 
Duy
