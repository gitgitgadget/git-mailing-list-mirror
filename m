From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Tue, 26 May 2015 16:53:14 -0400
Message-ID: <CAPig+cQoUrAhpvyrBTFyDDjaZt8brkhhw3aehC-hNeS7gND6jw@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<CAPig+cTaiZ_PVaGk6n_bsEqqTJEYEMSCWcnC0=MiN2Bf7L4sWw@mail.gmail.com>
	<CAJ80sasp6kNgbJJw-2TzZnPPDVgYdAwwsdh=hNH4xxu1TBtiyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 22:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxLqi-00049E-EF
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 22:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbbEZUxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 16:53:15 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32880 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbbEZUxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 16:53:14 -0400
Received: by igbpi8 with SMTP id pi8so70318779igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WSwQSpmshQ+OFODi2BeJpJ5dhJfFeTsv4UElTMhq1r8=;
        b=zzO36MdobIctk4DxtrvkWNhaWU19JYbq8vYBVYyVLbMK7JWu6quVbfidOk6UoBiR0U
         tgFrTMUjY2VgUrwQn64uFQSeoppIGadFEUnKPto38HZ1lT6D+I2qZW9HPDUmOT1qDNzq
         eafDG8wLE9IkH0YqD1VHCAs+CVl8V8Qpegf2NbVsZOLtokLNkx3p2rcNfVxbqNvwr+/O
         nfVYhuY59yENgfsm69mXzH98pWjMGfKsUnKc0y6VTdBw+z5fMtGOWF2jRTaBfuHR7S9j
         KD7KDUve9mOUnFoCA+WF8tZV4pJLnFW4JKdIjjc1YGNZR5WuPi341QozfyQMF9szJKEn
         78Sw==
X-Received: by 10.107.151.75 with SMTP id z72mr37560933iod.46.1432673594313;
 Tue, 26 May 2015 13:53:14 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 13:53:14 -0700 (PDT)
In-Reply-To: <CAJ80sasp6kNgbJJw-2TzZnPPDVgYdAwwsdh=hNH4xxu1TBtiyA@mail.gmail.com>
X-Google-Sender-Auth: BU9zsxT5UY7rUS-HnYjZDwbBjVU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269974>

On Tue, May 26, 2015 at 3:41 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> On Tue, May 26, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Saturday, May 23, 2015, Allen Hubbe <allenbh@gmail.com> wrote:
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index e1e9b1460ced..ffea50094a48 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -516,6 +518,33 @@ my %parse_alias = (
>>>                           }
>>>                       } },
>>>
>>> +       sendmail => sub { my $fh = shift; while (<$fh>) {
>>> +               # ignore comment lines
>>> +               if (/^\s*(?:#.*)?$/) { }
>>
>> This confused me at first because the comment talks only about
>> "comment lines", for which a simpler /^\s*#/ would suffice. The regex,
>> however, actually matches blank lines and comment lines (both of which
>> get skipped). Either the comment should be fixed or the regex could be
>> split into two much simpler ones. The splitting into simpler regex's
>> has the benefit of being easier to comprehend at a glance. For
>> instance:
>>
>>     next if /^\s*$/;
>>     next if /^\s*#/;
>
> I noticed this too after sending the patch, and I have already changed
> the comment to mention blank lines or comment lines.
>
> Splitting the regex would be more simple, but the regex is already
> quite simple as it is.

To be clear, the reason that I brought up the idea of splitting the
regex was that /^\s*$/ and /^\s*#/ are very common idioms which people
can and do recognize and understand at-a-glance without having to
spend time deciphering them. On the other hand, /^\s*(?:#.*)?$/
doesn't lend itself to that sort of instant comprehension; it requires
a certain amount of mental effort to understand.

Anyhow, it's just an idea put forth in case you or someone favors it;
not an outright request for a change.

>>> +               # recognize lines that look like an alias
>>> +               elsif (/^(\S+)\s*:\s*(.+?)$/) {
>>
>> Observation: Given "foo:bar:baz", this regex will take "foo:bar" as
>> the key, and "baz" as the value, which is probably not what was
>> intended, however, it likely doesn't matter much in this case since
>> colon isn't legal in an email address[1].
>
> That's a keen observation.  I think it would work simply to use a
> non-greedy +? in the first capture group.

Yes, that would work. Alternately: /^([^\s:]+)\s*:\s*(.+?)$/
