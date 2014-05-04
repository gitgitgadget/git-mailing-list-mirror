From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 4 May 2014 19:29:21 +0700
Message-ID: <CACsJy8Bb31FNN+aZpX7LgMQkPwC5_p_BMKthUKKPbRJomGwJSA@mail.gmail.com>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
 <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net> <5365D91E.70207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 04 14:30:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgvYK-0000Tr-1p
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 14:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaEDM3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 08:29:52 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:43809 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbaEDM3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 08:29:51 -0400
Received: by mail-qa0-f47.google.com with SMTP id s7so427720qap.34
        for <git@vger.kernel.org>; Sun, 04 May 2014 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YheYHqz7QxzXTP8y/U2se+9KfkVZtQM9wB6n1idi/ps=;
        b=ch2NHW+3eSLGJBFaaYb6NnQMnSn329rTnSs31TqEFk0FpkyrQDqQQyPGK8rjUULx0h
         8nlJdVOgYE5EftPFwElQDT02jGm8zSSDHmde5UnVavrOB3erIy6zptFWM3lfKpPPEZO/
         g2OOD2srap1S3UBMezvJDT/kvVa1XiPUwHFgZJyJ/epJ1+DHaGLdwrIbSBamhnbA1Evn
         NQoAgkcAg1yo2xhtVdGmj2KiCiSwB0H6AQURhdDm2qJItbCNVnsCVRynp3neixpa4/qG
         7d+n/YnSD/FY3hSadjadMrTzdXNpf7sGMXwL4BySZhr5nvXBdEMb9nYP34N3KMcT8Qki
         Zpkg==
X-Received: by 10.140.107.198 with SMTP id h64mr33556358qgf.30.1399206591120;
 Sun, 04 May 2014 05:29:51 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sun, 4 May 2014 05:29:21 -0700 (PDT)
In-Reply-To: <5365D91E.70207@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248095>

On Sun, May 4, 2014 at 1:07 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/03/2014 10:12 PM, brian m. carlson wrote:
>> Many places throughout the code use "unsigned char [20]" to store object IDs
>> (SHA-1 values).  This leads to lots of hardcoded numbers throughout the
>> codebase.  It also leads to confusion about the purposes of a buffer.
>>
>> Introduce a structure for object IDs.  This allows us to obtain the benefits
>> of compile-time checking for misuse.  The structure is expected to remain
>> the same size and have the same alignment requirements on all known
>> platforms, compared to the array of unsigned char.
>
> Please clarify whether you plan to rely on all platforms having "the
> same size and alignment constraints" for correctness, or whether that
> observation of the status quo is only meant to reassure us that this
> change won't cause memory to be wasted on padding.

It's not just about wasted padding. Some structs, like
ondisk_cache_entry, reflect on-disk format. Padding means breakage.
But I don't think this will be a big issue because we can detect if
padding happens, abort to force the user to complain, and deal with it
on case-by-case basis.
-- 
Duy
