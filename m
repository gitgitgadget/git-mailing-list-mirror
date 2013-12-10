From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Tue, 10 Dec 2013 20:06:25 +0100
Message-ID: <CANQwDwdoba5SbiiF1ZA2LHCwM-5KnEkVek5ekvrrQ-minLYNew@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
 <1386164583-14109-5-git-send-email-krzesimir@endocode.com>
 <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com> <xmqq4n6gv8n0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 20:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSeJ-0007If-N5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab3LJTHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 14:07:09 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:58690 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab3LJTHH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Dec 2013 14:07:07 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so5939575wib.12
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kbqITW30nIBa/NT3oLIeE3+CmorTpXbJsZXXtcpsXW8=;
        b=D2HkHez3kPtXrGxH5ZPJaERtSyuUJgF2PhgGGbELogIs8nL3zkW5FmIcbGFtlfa0MJ
         TjUanNEDJgA6sVsRWdf+wZLkTkD5iX+h5d0ZoOHk9fHsjh2old4/KrAFcDO/XTcnKkxf
         t0a8pobcavRaZTkVqMIJPeFJVaNdjh0nVvnM0fSppQM87WLcJ8+KUA9vfQOsAzndTfYk
         LXODtInpeTEeuzCbd8K6Wvy5zfy88eX0T0QDBCu8kKDys18bZWiE2Fux5EIkepOgM7FS
         LcAAYO5XI/1kC6lyvLnVDA9UqaQ+G5CDoChuo2gR6yEmlD1joxMJzHMBYp7afOb3xPGg
         b0ng==
X-Received: by 10.180.39.140 with SMTP id p12mr21169073wik.12.1386702426033;
 Tue, 10 Dec 2013 11:07:06 -0800 (PST)
Received: by 10.227.86.201 with HTTP; Tue, 10 Dec 2013 11:06:25 -0800 (PST)
In-Reply-To: <xmqq4n6gv8n0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239151>

On Tue, Dec 10, 2013 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> With multi-valued we won't be able to override earlier / more generi=
c
>> settings... well, unless we add support for no-value, or empty-value
>> as clearer, i.e.
>>
>>   [gitweb]
>>            extrabranchrefs =3D sandbox
>>            extrabranchrefs
>>  # or    extrabranchrefs =3D
>>            extrabranchrefs =3D wip other
>>
>> resulting in ('wip', 'other').
>
> Please don't, unless you are going to change the entire config
> machinery (including config.c bits that are used by the rest of the
> system) to follow such a convention to "clear settings so far read".

Right. Also I haven't noticed that gitweb already uses some
multi-valued config variables, though not for %features.

Please disregard this.

>>> ++
>>> +It is an error to specify a ref that does not pass "git check-ref-=
format"
>>> +scrutiny. Duplicated values are filtered.
>>> +
>>
>> Hmmm... 'snapshot' feature ignores invalid values, but in this case
>> formerly valid compression schemes might get invalid via tightening
>> %known_snapshot_formats, and we don't want existing config getting
>> suddenly invalid.
>
> Sorry, but what does check-ref-format have to do with "formerly
> valid compression scheme that suddenly gets invalidated"???

What I started to write was that 'snapshot' feature ignores invalid
values, but halfway through writing it out I have noticed that the
situation is really different.

In 'snapshot' case one can have formerly valid per-repository config,
made invalid by gitweb admin tightening %known_snapshot_formats
(for example removing some compression format due to bug). We
do not want for repository to stop being displayed because of something
that is outside control of repository owner.

In 'check-ref-format' feature we have ref either valid or not. This doe=
s
not depend on external factors. Something that is valid ref would
remain valid ref.

So 'snaphot' being forgiving doesn't mean that 'check-ref-format'
should be forgiving.

--=20
Jakub Narebski
