From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Mon, 2 Mar 2015 20:36:43 +0100
Message-ID: <CACBZZX7O77zfn75vJXsSyR58UjC_bfTu-DWwJC8n2fhemVBn2w@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
 <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
 <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
 <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com> <xmqqa908z44h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 20:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSW9T-0007nf-Sl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbbCBThH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2015 14:37:07 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:59902 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbbCBThE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 14:37:04 -0500
Received: by mail-oi0-f44.google.com with SMTP id a3so28978954oib.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 11:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HTsgMbR6FTvmwkaVPJXWVTk0ETu4VVRJp7wuW7Sqi0U=;
        b=bZjcyvXxd9kB+ytSe+LxmeecJt7/VnXbIHZRC5CrJUBiaV79lsd8F+LXIDoyZK8E/5
         ZM1yGu3wt8C8j+05TmIrtMo5kpDQlAv77NVNLn7HcFDUumuvl4y6Y3mhk0Ynj1Ot90PP
         95cIfxwHypqP1WDgOP3bod7oVRh35suyIAOP/lK0QDrzmtDjqHcBDJDcWvjbhajkCJEx
         JfKbzutO+gwjRCSRCOPBXHmOkow7s0NBuuMshUwWoLNZl5DMbxZHEFiTMTfcop124n6o
         It7WXmHZch6JA+bQ60vPtOUzmwf/EEssplGJIywXOInhodRJZtbjtXrj+2HojoOJZgUQ
         B9/A==
X-Received: by 10.202.176.4 with SMTP id z4mr19226728oie.43.1425325023327;
 Mon, 02 Mar 2015 11:37:03 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Mon, 2 Mar 2015 11:36:43 -0800 (PST)
In-Reply-To: <xmqqa908z44h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264610>

On Fri, Feb 20, 2015 at 10:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I actually ran this a few times while testing it, so this is a befor=
e
>> and after on a hot cache of linux.git with 406 tags v.s. ~140k. I ra=
n
>> the gc + repack + bitmaps for both repos noted in an earlier reply o=
f
>> mine, and took the fastest run out of 3:
>>
>>     $ time (git log master -100 >/dev/null)
>>     Before: real    0m0.021s
>>     After: real    0m2.929s
>
> Do you force --decorate with some config?  Or do you see similar
> performance difference with "git rev-parse master", too?

Yes, I had log.decorate=3Dshort set in my config. With --no-decorate:

    $ time (git log --no-decorate -100 >/dev/null)
    # Before: real    0m0.010s
    # After: real    0m0.065s

>>     $ time (git status >/dev/null)
>>     # Around 150ms, no noticeable difference
>
> This is understandable, as it will not look at any ref other than
> HEAD.
