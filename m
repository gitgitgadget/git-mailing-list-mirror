From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 5/8] sequencer: run post-rewrite hook
Date: Mon, 3 Jun 2013 16:01:44 -0500
Message-ID: <CAMP44s09aczdrObG2ZQxOXx_AodsfYRv1N9efLEg6Dj3Y7Fv9A@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-6-git-send-email-felipe.contreras@gmail.com>
	<7vhahfdnu6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujbt0-0001xo-6U
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab3FCVBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:01:47 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:37526 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3FCVBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:01:45 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so191403lab.15
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/LYFkK4dDszLX81DolKolgfrLtp29+K3U1s8toFwvuI=;
        b=skVD9j6sVdU2299Vw8qulUduQb97lYgdD/QT0ZbHcD8JVPaPJTVCk6OiGu1Nt7jG3J
         iEGelesQqgl5OwW8SYT3srNy/3Lmb499FXt2U75N7yKQBYSt3nCWl+JekFvhtGDbDLDW
         Vkv/ylhX2NNObwZH9D+MsewPvNnNHKLexVc19zb+FKRSfH/H+jxT5uQAkQdXQvVbPGD3
         Gw1zSr5FO5BPLpRRlkVVO9FPEj7orhJ5qjuL/OvvfkJbec5IAswxiQlxXJYXZaG0RRra
         v1mViehoRXXCiPgq05M3TzqGuvujZRv/prIGtNoVh1nyuykQf7c5TW5Yo+InzDeE/Xeu
         XRRg==
X-Received: by 10.112.88.166 with SMTP id bh6mr11736703lbb.47.1370293304123;
 Mon, 03 Jun 2013 14:01:44 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 14:01:44 -0700 (PDT)
In-Reply-To: <7vhahfdnu6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226290>

On Mon, Jun 3, 2013 at 1:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> As we should.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  sequencer.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index c217716..3aa480e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -127,6 +127,37 @@ static void add_rewritten(unsigned char *from, unsigned char *to)
>>       rewritten.nr++;
>>  }
>>
>> +static void run_rewrite_hook(void)
>> +{
>> +     struct strbuf buf = STRBUF_INIT;
>> +     struct child_process proc;
>> +     const char *argv[3];
>> +     int code, i;
>> +
>> +     argv[0] = find_hook("post-rewrite");
>> +     if (!argv[0])
>> +             return;
>> +
>> +     argv[1] = "rebase";
>> +     argv[2] = NULL;
>
> When the end-user action is "git cherry-pick A..B", shouldn't
> the rewrite hook be called with "cherry-pick" not "rebase" as its
> first argument?

Indeed.

> More importantly, doesn't "git revert A..B" also trigger the
> codepath for [4/8] and hence this function?

True.

> I think [3/8] --skip-empty makes sense also for revert, but I do not
> think this one does as-is.  As what [4/8] introduces is a record of
> "rewrite", the patch does not make sense either.  These two steps
> would want to limit themselves to cherry-pick only, no?

Probably.

-- 
Felipe Contreras
