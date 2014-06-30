From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated Plaintext
 files
Date: Mon, 30 Jun 2014 14:56:04 +0200
Message-ID: <53B15E64.9030005@gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>	<xmqqegya2qgu.fsf@gitster.dls.corp.google.com> <CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Jarrad Hope <me@jarradhope.com>, git <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 14:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1b87-0003NH-KK
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 14:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbaF3M4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 08:56:16 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33216 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaF3M4P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 08:56:15 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so5943936wib.15
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2D6pon67Rb2UyXTclUIcdBOX0McAVzbY5JqYN0+ynjY=;
        b=EvWygpC+IzvGKdCpsIe1NeFM0IG/QcvB++lGjJ2Ui68/lT19Z0GIwm1sn6ES2A3zaF
         CfKnLdbjl5OnNnTypk36rtPv92AyGICzElXR/1V2ibtfl096RlA7U9wJZssVWN6siOjM
         piqU1VoVyH93rnxwtwy9upA/fHEAw1Vv4q+2rIa7Tk8DeDHSw/nhHuk8wP7BW/LQp3of
         zlcGiI9NCJ8AaiNSR5j6V+XFls5uTeYqYopVD94ok7nOYN6E0cDtoIGWI8GaDhHtXOqU
         fYPp3pppRE/FP9MLOUJVB/3yis39EGVgwOvMDZDFwWRgnHZLTL26c8AB6yKvQf6ekrng
         Hxmg==
X-Received: by 10.180.83.200 with SMTP id s8mr28936239wiy.2.1404132973827;
        Mon, 30 Jun 2014 05:56:13 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id i4sm31160299wib.21.2014.06.30.05.56.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 05:56:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252665>

Linus Torvalds wrote:
> On Fri, Jun 27, 2014 at 10:48 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>> Even though the original question mentioned "delta discovery", I
>> think what was being asked is not "delta" in the Git sense (which
>> your answer is about) but is "can we diff two long sequences of text
>> (that happens to consist of only 4-letter alphabet but that is a
>> irrelevant detail) without holding both in-core in their entirety?",
>> which is a more relevant question/desire from the application point
>> of view.
>
> .. even there, there's another issue. With enough memory, the diff
> itself should be fairly reasonable to do, but we do not have any sane
> *format* for diffing those kinds of things.
>
> The regular textual diff is line-based, and is not amenable to
> comparing two long lines. You'll just get a diff that says "the two
> really long lines are different".
>
> The binary diff option should work, but it is a horrible output
> format, and not very helpful. It contains all the relevant data ("cop=
y
> this chunk from here to here"), but it's then shown in a binary
> encoding that isn't really all that useful if you want to say "what
> are the differences between these two chromosomes".

There is also --word-diff[=3D<mode>] word-based textual diff,
and I think one can abuse --word-diff-regex=3D<regex> for
character-based diff... or maybe not, as <regex> specifies
word characters, not words or word separators.

--=20
Jakub Nar=C4=99bski
