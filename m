From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Fri, 13 Nov 2015 16:47:25 -0800
Message-ID: <CAEtYS8T9kZo6J3ZTQn210xRFPvNVew3oqV3fWMXf2CdKh4we-Q@mail.gmail.com>
References: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
	<1447459853-28838-2-git-send-email-dougk.ff7@gmail.com>
	<CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 01:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxP05-0002oi-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbKNAr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:47:26 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37185 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbKNAr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:47:26 -0500
Received: by igcto18 with SMTP id to18so20286igc.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W64gEI1p65XHTBzafysZMpWpVe94xVQtTPOIfoYgV1g=;
        b=coLCsWycFTSqITGr71IBFNPbYHLpZfgCxtLvjMosUt0ZJ4ecp9pjNyyd/7enToDQP4
         1E0fHJbMpQPglGzLZYize7rXKx5tBWkFyzr2gOPSAMaYC/9l1gn8GfWR25ZITo9cWNqo
         QjhwVS9zoDwVlLQGP4v5nPWRT2/pwGcaQPvYD3NQLdyBJz00/UPD4mnoXIugj8GrNnIn
         o1st98ae187pOCSfZgmo1+W47BtyO/8pBSTNJvZ+1xxzBTtmxb+3nZX7k7cagdAtbHFx
         rNSpMc8waoCgQCUgjTHKDNZAYcYHjZ19ztipzWEy1ETxBoE7lUq4zchs/vnNcReaRb6f
         aSkw==
X-Received: by 10.50.61.37 with SMTP id m5mr6645427igr.4.1447462045388; Fri,
 13 Nov 2015 16:47:25 -0800 (PST)
Received: by 10.79.38.129 with HTTP; Fri, 13 Nov 2015 16:47:25 -0800 (PST)
In-Reply-To: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281288>

Yes, without a doubt.  I think I'm blaming this one on being late on a
Friday afternoon, and really not thinking out the logic clearly. :)

On Fri, Nov 13, 2015 at 4:43 PM, Stefan Beller <sbeller@google.com> wrote:
>> +       else if (seen_bits & PACKDIR_FILE_PACK && seen_bits ^ ~PACKDIR_FILE_IDX)
>
> as just talked about: did you mention && !(seen_bits & FILE_IDX)
>>
>> +       if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP))
>> +               return;
>> +
>> +       if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_KEEP))
>> +               return;
>> +
>> +       if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP|PACKDIR_FILE_KEEP))
>> +               return;
>
> I wonder if this should be rewritten as
>     if (seen_bits & FILE_PACK && seen_bits & FILE_IDX
>         && (seen_bits & FILE_KEEP || seen_bits & BITMAP))
>             return;
>
> to dense it a bit. ;)
