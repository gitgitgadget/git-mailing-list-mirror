From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix overlap
Date: Thu, 28 Feb 2013 23:22:05 +0100
Message-ID: <CALWbr2y7d5kGQpF=gBCkVx2ZgZR-9mmdhj17f2QcZZTaMPM_4w@mail.gmail.com>
References: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
	<1362088540-14564-1-git-send-email-apelisse@gmail.com>
	<874ngw2ii0.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBs2-00075K-Hw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 23:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab3B1WWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 17:22:10 -0500
Received: from mail-qe0-f43.google.com ([209.85.128.43]:62341 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab3B1WWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 17:22:07 -0500
Received: by mail-qe0-f43.google.com with SMTP id 1so1738524qee.30
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aHT/eWI8ozUDH+iS6ulw2uQT1waPeO5kO7lO6ClWDDo=;
        b=szvH3VQB5Kmj4PHfWcQpapFEVuF9dATnHFKOqswCXGqBb01lwqe1rkT/gsgG5sSIRw
         ZXtb+gWlBEEu+uPgKIjrgGctm4gK5wgZBSahsM8HrnDZiItG7OivHfCrZnf5/94h8drz
         2sWaHAnRkFAz2Xe6h6o+pmquue9aO7IjFjCBLIp53dBipPwXwKkOMiB6I4pcHNj4J890
         jb6gzJ4FYzZAzgsO2o+3yASBsmFlJ7oNTbSJmBt3bSRTypQNb6BhmgZWLBkn+q71eNsH
         7+KgUdmInkRterg9kpWs6Ph48xpGtHy022NFdplDMN9ZyYlwTK0UdDZt9KLDUcUxPzrV
         44xQ==
X-Received: by 10.49.59.48 with SMTP id w16mr13877546qeq.38.1362090125901;
 Thu, 28 Feb 2013 14:22:05 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Thu, 28 Feb 2013 14:22:05 -0800 (PST)
In-Reply-To: <874ngw2ii0.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217261>

On Thu, Feb 28, 2013 at 11:14 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> diff --git a/diff.c b/diff.c
>> index 9038f19..e1d82c9 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1177,7 +1177,16 @@ static char *pprint_rename(const char *a, const char *b)
>> -     while (a <= old && b <= new && *old == *new) {
>> +     /*
>> +      * Note:
>> +      * if pfx_length is 0, old/new will never reach a - 1 because it
>> +      * would mean the whole string is common suffix. But then, the
>> +      * whole string would also be a common prefix, and we would not
>> +      * have pfx_length equals 0.
>> +      */
>> +     while (a + pfx_length - 1 <= old &&
>> +            b + pfx_length - 1 <= new &&
>> +            *old == *new) {
>
> Umm, you still have the broken version here, and the previous patch is
> already in next.  I think you should decide for one thing ;-)

Thanks ! I had not paid enough attention to that.

> Either: consider this a reroll; Junio would have to revert the version
> already in next (which isn't _so_ bad, because next will eventually be
> rebuilt) and apply this new version.  But if you do that, you should
> squash my change that deals with the underrun issue (I'd be fine with
> that).

I would not have done that without your consent (that's why I kept the
buggy version)

> Or: consider it an incremental improvement on the series, in which case
> you should send only the tests with a new commit message.

That seems like the best solution to me. I will resend later with just
the tests and a new commit message.

Cheers,
Antoine
