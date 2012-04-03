From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Tue, 3 Apr 2012 10:44:16 +0200
Message-ID: <CABPQNSZzboU+p9UbRBt19WhhxwbwCLDRnGUyDwY_myH2kXbOag@mail.gmail.com>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
 <20120323211001.GA18198@sigill.intra.peff.net> <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 10:45:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEzMM-0004qG-SF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 10:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab2DCIo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 04:44:58 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58048 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab2DCIo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 04:44:57 -0400
Received: by dake40 with SMTP id e40so3437362dak.11
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YAsWK6r3axI7Gm8CHnUE4MvTNOtnXqUL7wUMomWROuk=;
        b=joIkpf/QwFt0GyI7ORGyFNYZdU88mOeYTSfTG/FaCcNlPuwsYVEerk89Upy1a8r/we
         esi/z2IqbvGHiTZDDczVB851xlHf8SlZSZDO/QWACMlmpW7F3crLGgY+7zTBQ3yz5GZX
         RVjfim+1MbvfhZz/eHvEjodqmoeCuEnJ9T4dJ2ZitGlGVJJfrK1S71u1+sZkm2rG4K2+
         GjgdUU11rW9/SH3jVRx2d3XBkBId55KJf++6at0gTgujz9CHSRrdK2kSskT5pKZtFjdE
         mkcwlVM035oAdsKE+yv6XJ98ItnZD1JRAorFb2NjJ6VPLI63VQ3UNsdp6k//bZWhIxgg
         wnRA==
Received: by 10.68.197.65 with SMTP id is1mr4716954pbc.70.1333442696939; Tue,
 03 Apr 2012 01:44:56 -0700 (PDT)
Received: by 10.68.136.40 with HTTP; Tue, 3 Apr 2012 01:44:16 -0700 (PDT)
In-Reply-To: <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194605>

On Mon, Apr 2, 2012 at 5:53 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Fri, Mar 23, 2012 at 10:10 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Mar 20, 2012 at 12:06:54AM +0100, Erik Faye-Lund wrote:
>>
>>> This one pretty much sucks. Mem-leaks and a sketchy deletion-filter.
>>
>> Thanks for moving forward on this. I'm sorry I can't be much help on the
>> Windows-specific knowledge, but I'll answer what I can.
>>
>
> Thanks for following up :)
>
>>> Currently uses "::" as an attribute-separator, but this is not robust
>>> without encoding if the attribute values themselves contains "::".
>>
>> Yeah. Can you store arbitrary bytes? If so, NUL would be a good
>> terminator.
>
> No. TargetName is an LPWSTR, which is supposed to be zero-terminated.
> There's no way of specifying it's length directly.
>
>> Otherwise, newline is a reasonable choice, as the protocol
>> already can't communicate usernames/passwords with newlines (a
>> limitation that I accepted to make the protocol much simpler for
>> scripting use).
>>
>
> This works, but it causes Windows 7's credential manager to glitch in
> rendering the credential (adding all the newlines to the end of the
> line, and stretching an icon - yuck), which is also a bit unfortunate.
>
> So I'm thinking that escaping the string needs to be done. It can't be
> that big of a deal ;)
>

Hmm, but I must have been a complete moron; the credential structure
in windows has a general purpose credential-attribute system, where I
can store the meta-data I want.

So I can probably use that and get away without any sort of encoding. Yay.

I'll look deeper into it when I find the time.
