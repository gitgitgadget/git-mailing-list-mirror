From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v12 06/41] refs.c: add an err argument to repack_without_refs
Date: Tue, 3 Jun 2014 13:55:02 -0700
Message-ID: <CAL=YDW=WvBH3TEzvgaFd=FzbQPcQZOTxDZw9U-5wcv5e2RDFfA@mail.gmail.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
	<1401379676-9307-2-git-send-email-sahlberg@google.com>
	<20140529181732.GF12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:55:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrvjj-0002d1-MH
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 22:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702AbaFCUzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 16:55:05 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:36143 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073AbaFCUzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 16:55:04 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so7585538veb.24
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C/6oj5T3HDVCLmGN4t0FVCF+Yc/Gfx4h5Zs68IrEj10=;
        b=gtDWqsVme3qV3ptW7X/1on8T0UfrFe9cYsTSGaTuEWlnmabVrpUZTjCbCpYnGEsNaJ
         wasecBnSc/fL3DeZ3+nls3cwKFM0ANxXkyx7oC4BxY1cF6leQKENA1BEVPsiOtQApDRk
         z6NfTH5GarYUkT4Xsu5i3L6ugK30ByKgMM3ufw4Iz22lvhh13B9J3vEbUiE+sXIvYZRf
         PjSdzWXneau/R+6xPOFT6oh56xUgFWEWwg00x9rc3VxHUTjslQ7/5TJIVw3hgh6c+/F+
         WmuoDXw6AKa34VrPLG8djfz6h7st6WuX0sxt3e0CnL+oD9wWuCoVLhCnP90OBWpp82+T
         KGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C/6oj5T3HDVCLmGN4t0FVCF+Yc/Gfx4h5Zs68IrEj10=;
        b=lcQ3gCLyX+R5LmbPj5chUOSxABeVqQtEK3n9GuTDNRV+2L1NVjjzLjGTbgo3y8VYWa
         dbObej7hgaTk7xl9cTbE3LQQPK5pQZCK8B8mEF6WrpGToQlfjFWHIFQHxc1aK9TBipV0
         Z1TrsvMiQnl6Ftc4rzEWwfK2xJ7+MKyMr/a82GMptoczlSsB0zDOqzLxFsgfa4dG24q2
         4+RnWOdZGAUct0EqiH1eyzTxfvc94DO35erodYX4Vcdi9YIrl/rx0IASwRX2k2Or9o2b
         BdGy0PM0K239yrpDpEfGRhzL64BS6jrPSzqKMJvvSO3U039IqK/1l3g+7fIpX5Z5J25Y
         evVA==
X-Gm-Message-State: ALoCoQnZ01XpjKo+hajMIpxaXCujsWbEhRVtr25JA3scETTlew27epqJEqyGfJdTdRpMI3gQtwp6
X-Received: by 10.220.53.72 with SMTP id l8mr39617544vcg.16.1401828902902;
 Tue, 03 Jun 2014 13:55:02 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 13:55:02 -0700 (PDT)
In-Reply-To: <20140529181732.GF12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250643>

Thanks.

I have done all the additions of save_errno you suggested.


On Thu, May 29, 2014 at 11:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Ronnie Sahlberg wrote:
>
>> Update repack_without_refs to take an err argument and update it if there
>> is a failure. Pass the err variable from ref_transaction_commit to this
>> function so that callers can print a meaningful error message if _commit
>> fails due to a problem in repack_without_refs.
>>
>> Add a new function unable_to_lock_message that takes a strbuf argument and
>> fills in the reason for the failure.
>>
>> In commit_packed_refs, make sure that we propagate any errno that
>> commit_lock_file might have set back to our caller.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  cache.h    |  2 ++
>>  lockfile.c | 21 ++++++++++++---------
>>  refs.c     | 25 +++++++++++++++++++------
>>  3 files changed, 33 insertions(+), 15 deletions(-)
>
> I don't want to sound like a broken record, but this still has the
> same issues I described before at
> http://thread.gmane.org/gmane.comp.version-control.git/250197/focus=250309.
>
> The commit message or documentation or notes after the three dashes
> above could explain what I missed when making my suggestions.
> Otherwise I get no reality check as a reviewer, other reviewers get
> less insight into what's happening in the patch, people in the future
> looking into the patch don't understand its design as well, etc.
>
> As a general rule, that is a good practice anyway --- even when a
> reviewer was confused, what they got confused about can be an
> indication of where to make the code or design documentation (commit
> message) more clear, and when reposting a patch it can be a good
> opportunity to explain how the patch evolved.
>
> What would be wrong with the line of API documentation and the TODO
> comment for a known bug I suggested?  If they are a bad idea, can you
> explain that so I can learn from it?  Or if they were confusing, would
> you like a patch that explains what I mean?
>
> Jonathan
