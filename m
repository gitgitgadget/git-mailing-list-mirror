From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 12/44] builtin-am: implement --skip
Date: Tue, 14 Jul 2015 09:54:10 -0700
Message-ID: <CAGZ79kYYJughaqBD7hzzDBO4xmrJ7P3VT7m=qG-SRLXiK-f_vA@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<1436278862-2638-13-git-send-email-pyokagan@gmail.com>
	<CAGZ79kaWV-hMEgJ8HJP2Jgq78su+YbyBbcYD3sZ0474UUNw=pA@mail.gmail.com>
	<CACRoPnRri5Nu5rj9O7id+PyiDBJpZkBDk8kB0WCuB3Uef76M3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 18:54:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF3TE-0000Nk-J6
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbbGNQyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 12:54:12 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35211 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbGNQyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 12:54:11 -0400
Received: by ykdu72 with SMTP id u72so13308947ykd.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HuuZSZWWFKer7naBVRgjZgLUojTS1MlA7oR3HOIlFUQ=;
        b=N1Vn8tnOsYpubZGUjf1zYEp9RBzvEX5CaT63UtDo7SRitP7MNKq7sT/YlgfNKzK04Y
         oomfR3zy3jpccZtMSu/ghlNfYGwU6AbBlqIBH63il7nHc0x6ajVfVSEis5z2MtrXQKPw
         n25FWDl1zJvINltZ6lV94yqf2j8Et2QJwq8D80PxwPa/Y7ty5c4Z9bHlyLXFQ+qOHnp0
         EdzsUkMkSBKV3NwI46ZGYwAgSO2LpjMkndlJg1Xf6DD4jePOjY5TUUbrsh8idq/H/iAD
         W+F9RcmUk07ufSKuE6bDvziruHhGN/h+VbVpcBOPRgTizR3MwRilzsyTuSwOhzy+NZkX
         X+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HuuZSZWWFKer7naBVRgjZgLUojTS1MlA7oR3HOIlFUQ=;
        b=fC0WihsNF8E6cMrBcS7skjwaNNBR5JOGyYIBdX5wwLx0hNonidAWZxwi4tDms75Z7a
         VmtrWV9fLFhSzOhXfw7Pdv+M7kfJ6J1TZ0wQ2WJO+U/AUMsHi95jp2FsyM96zc3X4dQr
         wsCxt+Pq5SNjDeiCE4HulLZpoqtwBNc4hM6Odf7AtQdqx6phe2HbInG1P5f/Bz/DP5MF
         ZlMzQLmmr+Bn1p6MSqSAB12pVCdSqJOwoiv/KDO6upDxr84bxD/1X8cKtKGY3ME8Geg+
         1mzDlPTiImRfFqpxvpKxvrf8Cnig8JOr/Q8y6aMRWUdV5HgoHAUIcwD4+SdNDUijFrjd
         grEQ==
X-Gm-Message-State: ALoCoQlGv+XsVNOzRlzecA5cFrHus7nQjJkKmUqvAFYiVs9aFX6sxXfc/pq8ipKeVlWEFt39ZMWJ
X-Received: by 10.129.111.65 with SMTP id k62mr46541447ywc.88.1436892850323;
 Tue, 14 Jul 2015 09:54:10 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Tue, 14 Jul 2015 09:54:10 -0700 (PDT)
In-Reply-To: <CACRoPnRri5Nu5rj9O7id+PyiDBJpZkBDk8kB0WCuB3Uef76M3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273968>

On Tue, Jul 14, 2015 at 2:34 AM, Paul Tan <pyokagan@gmail.com> wrote:
> On Tue, Jul 14, 2015 at 3:05 AM, Stefan Beller <sbeller@google.com> wrote:
>> All returns before this point leak the memory of `lock_file`.
>
> Yeah, it's intentional. From Documentation/technical/api-lockfile.txt:
>
> * Allocates a `struct lock_file` either as a static variable or on the
>   heap, initialized to zeros. Once you use the structure to call the
>   `hold_lock_file_*` family of functions, it belongs to the lockfile
>   subsystem and its storage must remain valid throughout the life of
>   the program (i.e. you cannot use an on-stack variable to hold this
>   structure).
>
> Thanks,
> Paul

So what I meant to suggest, was to only allocate the memory if we really need it
by moving the allocation further down.

static int clean_index(const unsigned char *head, const unsigned char *remote)
{
       struct lock_file *lock_file;
...
... // includes return -1, which would not leak the memory already allocated
...
       lock_file = xalloc (...);
       hold_locked_index(lock_file, 1);
