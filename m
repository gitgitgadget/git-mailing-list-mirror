From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 04/16] upload-pack-2: Implement the version 2 of upload-pack
Date: Tue, 2 Jun 2015 16:08:12 -0700
Message-ID: <CAGZ79kbe+1okiUL5bGcfykyn7MmhALF+3ANY9k-ycadk0RNAuw@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-5-git-send-email-sbeller@google.com>
	<xmqqfv6a2ayx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzvIB-0000NV-AK
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 01:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbbFBXIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 19:08:15 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:32873 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbFBXIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 19:08:13 -0400
Received: by qcmi9 with SMTP id i9so66526833qcm.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=azKTCFiFptyVsC+12YfYSPK/COMZqmgyomaetS245iw=;
        b=hp9gHUjoFvm97PzS6sDRpyJEP85rY9dd4q489nwqqnIms2pVT2ykFYIg4ljBwkRvHF
         HCHnx9JgB3EamNJvjNdMbmD1dAA5HCSe3L6HIkbQfKVvWdpMpOPiKLOu6OWICYtui5gG
         ipgX4+uilAawFn+E64bv0YdLdghBKhsee32QYYf6oQfoRls2sc7HkfK+7nK9eI+VEyaK
         0xJKG3UxJQxVCOzL0/pCanxIFD4ZY9Kis6UZYdMJ/051VOVvkdmX+E1lPiiqrCH5LXHF
         5RMjn931aD9trM4BH776szorjAs9sF1I+3EMMFmzCt4CPsc9qXtFV8YDx12cyIwbwQfD
         Uyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=azKTCFiFptyVsC+12YfYSPK/COMZqmgyomaetS245iw=;
        b=UMrPXHY+OWZcwH3byu6Zp7Ukww/RwxAQ9oIhs1kNWqCsDMoD2ibxPasD1Ydxqe1pKp
         qUUzR4YivvHRwPoWW0yR/rDPsul2yA25RWboUTUg9tHfaLbpVEkimzzazBnqr+Z68wCk
         V+fDI/W2vxq1VB9Bdj6tLBdprXBCWAAsBfi8exQjvom3zDDod6dl9/LpyYl91YDqblMy
         pgwKsavPeHoq0AyRLX9yBakf4j05CqezNJkvDsJHs00Byp/BNkZefEFb2WZXzedtidHb
         Jhz8q1VhrFLixdKhnqN6LAMqqObWEV92YLBzD1yzgxhi0YblTkkVj+Y7lfbxVdISBJ8b
         rLfQ==
X-Gm-Message-State: ALoCoQnI/4WZQO+lnuMjOiYgGWqh8lqYxw1ZjYEO1Q97Zn95m9OWT6tzdHk8LjHKYYEDEgagOf4v
X-Received: by 10.55.22.143 with SMTP id 15mr53273998qkw.85.1433286492592;
 Tue, 02 Jun 2015 16:08:12 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 16:08:12 -0700 (PDT)
In-Reply-To: <xmqqfv6a2ayx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270619>

On Tue, Jun 2, 2015 at 11:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Subject: [RFCv2 04/16] upload-pack-2: Implement the version 2 of upload-pack
>
> Nit; s/I/i/, to match others in the series, I think.
>
>> In upload-pack-2 we send each capability in its own packet buffer.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     Moved the capabilities into a struct containing all the capabilities,
>>     and then we selectively cancel out unwanted capabilities.
>
>> diff --git a/upload-pack-2.c b/upload-pack-2.c
>> new file mode 120000
>> index 0000000..e30a871
>> --- /dev/null
>> +++ b/upload-pack-2.c
>> @@ -0,0 +1 @@
>> +upload-pack.c
>> \ No newline at end of file
>
> Yuck.
>
> Can't we do an equivalent without this symbolic link, i.e. a new
> Makefile rule to compile upload-pack.c in two different ways to two
> different object files?

Ok I changed that and it works now (only one upload-pack.c file no
upload-pack-2.c and no corresponding object either.)

However we don't want to have the version used in upload pack depending
on the file name at run time, which is why I am reverting to this state
and depending on the file name at compile time. Instead of a symlink we
could use an option passed into the compiler as well, but I am not sure if
that is as easy to add to the Makefile as this way.

>
> The way this patch is organized makes it unclear which part is what
> was added for v2 and which part is shared with v1 (and changes can
> be possible breakage to the existing code), leading to a patch that
> is hard to review.

ok :(

Changed in a reroll.
