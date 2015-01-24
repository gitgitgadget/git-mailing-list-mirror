From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 5/6] refs.c: remove unlock_ref and commit_ref from write_ref_sha1
Date: Fri, 23 Jan 2015 17:04:14 -0800
Message-ID: <CAGZ79kZ0EBRgSuc4Wupaa9t85xcF79SizvGbjD9OC3+Jq=XbFA@mail.gmail.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-6-git-send-email-sbeller@google.com>
	<xmqq61bxoxs8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYPCFBNNkYV0C_XeCEaqfz=Mh3Zy=L-vAWsmZBFgebqNQ@mail.gmail.com>
	<xmqqppa5nhab.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEp99-0003cv-Ip
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 02:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbbAXBEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 20:04:16 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:39014 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbAXBEO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 20:04:14 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so484835igb.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 17:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lN+lraO3VhvLMO2ApyHzEIAtah55K2nkNN+IXxXReRI=;
        b=E+xEI+A/kRZl1Rc3AbRRGscTHr/yXrrj/QNZFeMSnYM1gnle50aqTueymoXKwyXJ4m
         qDb9qehFd7BXfrytvBbUAy9KsfjMdZ3Wm1hMtCa/15t1haSZ4nRgMx/v1TsGTG/BFsjh
         yHIi2xeKetYRRaESb6Jb5M6aXe/GO+v+FSftT4kPXvV6wZc0n4NtTFlpjd2VUFUIo0B0
         sl1xYyvUasMvtteCTeE8T5clWY+TMNm9h2IbBF9zr56AEUGx8AgMwNpGU5f2AFzoO5vn
         /opxQ9jECdr5hQUD10Rv9wyyLFV2V+DxFB15ITHEtZrPqXRj1LdzoRIcbQHw1+CWlhTt
         Zvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lN+lraO3VhvLMO2ApyHzEIAtah55K2nkNN+IXxXReRI=;
        b=dDLCoOGsaQkFAJTDe0aiSZ77013vcLiNA8MssDWEHHqwTzdYqeqEWZLywFh8ZrHIO1
         omMB0jgKNFiGFxLNpzLYAgx+X/UPGnwx90il6YvQ/XNZEFPXcL+bJKlpNY1OBaODnVTa
         oMjx9LYj6O6cgMoOdMSEgelOh25pYD/BDoSC8GKYE3bZrjlUETSHAMgUgq5ebfOuq3Zr
         IcGzuxLFjOc7RSgTHIVHWfG1LTl+GUUWvf1R2wz79j3RKmLovG+QhpcaHYH2v2NNrbCY
         PUyF1ViGQ1+Qjo9eCA+ycEDPg0dFERV89nxZwVZ2TESc2t+IwIX5d/VSW7aJIE3KUi3i
         6TIQ==
X-Gm-Message-State: ALoCoQnRpx05b0KQg+/SihC2GUzXQnNAbJQ29AbX/43ojUZaIWm7hGqL1ReNOC4ZkSoUCmP9WpFH
X-Received: by 10.107.16.138 with SMTP id 10mr6834812ioq.33.1422061454212;
 Fri, 23 Jan 2015 17:04:14 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 17:04:14 -0800 (PST)
In-Reply-To: <xmqqppa5nhab.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262983>

On Fri, Jan 23, 2015 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Jan 23, 2015 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> -static int commit_ref(struct ref_lock *lock)
>>>> +static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
>>>>  {
>>>> +     if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>>>> +             return 0;
>>>>       if (commit_lock_file(lock->lk))
>>>>               return -1;
>>>>       return 0;
>>>> @@ -2879,10 +2882,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>>>       }
>>>>       lock->force_write = 1;
>>>>       hashcpy(lock->old_sha1, orig_sha1);
>>>> -     if (write_ref_sha1(lock, orig_sha1, logmsg)) {
>>>> +     if (write_ref_sha1(lock, orig_sha1, logmsg)
>>>> +         || commit_ref(lock, orig_sha1)) {
>>>> +             unlock_ref(lock);
>>>
>>> This is not a new problem, but the two lines in pre-context of this
>>> patch look strange.
>>
>> Which (not new) problem are you talking about here? Do you have
>> a reference?
>
> These two lines in pre-context of the hunk:
>
>>>>       lock->force_write = 1;
>>>>       hashcpy(lock->old_sha1, orig_sha1);
>

So these 2 lines (specially the force_write=1 line) is just there to trigger
the valid early exit path as you sent in the other mail :

> if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>             return 0;

when we have the same sha1?
and you're saying that's a problem because hard to understand?

I am confused as well by now.
