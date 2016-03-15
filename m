From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 15 Mar 2016 18:56:55 +0700
Message-ID: <CACsJy8Cgz0zTryCCXoPMh40Rq4yOCy1L8Nih-YbKaZLyV=Gi-w@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-5-git-send-email-dturner@twopensource.com> <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 12:57:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afnbP-000339-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 12:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934369AbcCOL52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 07:57:28 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36202 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932706AbcCOL50 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 07:57:26 -0400
Received: by mail-lb0-f176.google.com with SMTP id x1so19196933lbj.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AZTZWUzVyQEsVbdZ7E+OcOUpjTCDnNF7JsYp0XOXmtE=;
        b=et68c8cWR1TcvhmoLtGXE6mXAh4LdUaG4SCeY7UXSy743vMiMWOgooe5FENKaCdm9p
         5TuJlt2xfoneh9cw2niyaryH54jvYDK0WyVr3xoRBwMAMO8jEjsG5c0kC8Vmt1i9o95p
         6pj1YgFamSw74wxt5D/1vscsHZqJSOyKYZwKccuq/dV+6krGGn2jVBaphIwsvLVTn3b+
         kIXslOPwzH0jk/R7/7Pv5NDtacfmFKHxqm+SZ10/+FLZDVflp4SKDvj23rL6CGITYHJl
         PHJbvGA8J4iiZSmLucBNXJgm4sM5e57NYqoNKHmalYSxPwTWbeXAWHZVrMdi6t/xSaqJ
         aYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZTZWUzVyQEsVbdZ7E+OcOUpjTCDnNF7JsYp0XOXmtE=;
        b=LZTV6cZGmuip/I56FZx851Qmu/5KlHVLBKtwpcvxRwzT2WvzcUbJJoRXGIrnUS2oj3
         DJ5dYp+9f7iCkd56etC34L5zw4lerJMI1GYKofXpc/8TIAvry5yvy0RiRqgXbknlL8ao
         Pm5K2UM+H9eOLI10O2tJnMV/GsgfI+W9fIcGknzdsRaeyrelv728CmaGi3yiWrHH3lUq
         bt3SCDChKSQwbC6qViHDWF6EeSSGUN1/3u48GrAUKeZLMjBI2NHtSzjK9aXQ6p9zVB2j
         DeUhZg7ThfXu5KNCvzyvcpMqPamw5NpY1Rrg7JIQQTpn37lWiSnLd2FnRModPpzjI6lG
         4c9g==
X-Gm-Message-State: AD7BkJJ4noLVHbqAmkxjCz8H6Yby0P5Y3A9YEfx3eoi8sMGZZSIFDtqC6UT2ThRSilmpqMzH/WWGDNFQSONrig==
X-Received: by 10.112.54.132 with SMTP id j4mr2743103lbp.3.1458043044914; Tue,
 15 Mar 2016 04:57:24 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 04:56:55 -0700 (PDT)
In-Reply-To: <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288850>

On Thu, Mar 10, 2016 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Turner <dturner@twopensource.com> writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> Instead of reading the index from disk and worrying about disk
>> corruption, the index is cached in memory (memory bit-flips happen
>> too, but hopefully less often). The result is faster read. Read time
>> is reduced by 70%.
>>
>> The biggest gain is not having to verify the trailing SHA-1, which
>> takes lots of time especially on large index files. But this also
>> opens doors for further optimiztions:
>>
>>  - we could create an in-memory format that's essentially the memory
>>    dump of the index to eliminate most of parsing/allocation
>>    overhead. The mmap'd memory can be used straight away. Experiment
>>    [1] shows we could reduce read time by 88%.
>>
>>  - we could cache non-index info such as name hash
>>
>> The shared memory's name folows the template "git-<object>-<SHA1>"
>> where <SHA1> is the trailing SHA-1 of the index file. <object> is
>> "index" for cached index files (and may be "name-hash" for name-hash
>> cache). If such shared memory exists, it contains the same index
>> content as on disk. The content is already validated by the daemon a=
nd
>> git won't validate it again (except comparing the trailing SHA-1s).
>
> This indeed is an interesting approach; what is not explained but
> must be is when the on-disk index is updated to reflect the reality
> (if I am reading the explanation and the code right, while the
> daemon is running, its in-core cache becomes the source of truth by
> forcing everybody's read-index-from() to go to the daemon).  The
> explanation could be "this is only for read side, and updating the
> index happens via the traditional 'write a new file and rename it to
> the final place' codepath, at which time the daemon must be told to
> re-read it."

Another aspect that's not mentioned is, we keep this daemon's logic as
thin as possible. The "brain" stays in git. So the daemon can read and
validate stuff, but that's about all it's allowed to do. It's not
supposed to add/create new contents. It's not even allowed to accept
direct updates from git.
--=20
Duy
