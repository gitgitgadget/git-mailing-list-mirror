From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 10 Mar 2016 18:17:30 +0700
Message-ID: <CACsJy8CqOOB6C6bWkVSEvtPuHxZR_avSb7z7hgo-vtv3gu44Cg@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-5-git-send-email-dturner@twopensource.com>
 <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com> <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adybZ-0004wu-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 12:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965675AbcCJLSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 06:18:06 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35177 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895AbcCJLSC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 06:18:02 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so106885747lbc.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 03:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ln1F/KQs72Aw63vh06IMiopadajt8+HMhDIJ+SFFexI=;
        b=TaCXKafO59FGtcrDgXfwnjC0oVyUzw48JrrevDSwE8/TJmMuojR1QNhUNtm3Tz0tIe
         tT23YzH+P/40GWSF/us8OV9uXYeNpiX9rA49t9bfNt3HZ0s/AySZNjTmjzZlBW/41tSF
         snKRnHhOok5Hcd7uHqv2+nZZrlxAOFYD7iS3GJEa4eahO/dhm1tTH5u50ypbIA1rbYxS
         0ovVkQcvMqVE/uNa5Mbdhjeb56JM+4fR9EuT1NWURXa4FQrAG8Bj3KeHNxhtWnyg2Lr/
         TWA51j1rULJVECmiiRZs87PTscRIRJTmHTqMjeF9SifdFcJkTp4hsO8N71fQ5Bfk+SQU
         1gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ln1F/KQs72Aw63vh06IMiopadajt8+HMhDIJ+SFFexI=;
        b=Y+264tLmkT1xpdxbELiS/HfewopHaIzKD6sWHSyr5w1Xpub/oPxGRc6r5rTQljfTXw
         Y0CRRFzMDKppnE8Ov9UsAcWkQMEQ3dcpdvUtdf0h2hF547Gn2IEk3qkpbVYHjkKJ9nFb
         uoEjIJtPYlffrhM75ibqNCRpfCFWqfyYrCWA6SmpgSKbs3NT4s1Qwg+J4Zy4qr5l13I4
         p8ZmEL6GG0q+NnVO3IZ18VpEGoHy6zOeE4mR2gf3bGaFGXZHyX7pidDjk6ESTvG8stnR
         86g9tyVGRHsrTnam64aDEQOHfLaFdc0TmBM8XUhOimQjLxPQtyi8O/KwbvapV62d6E64
         zsqw==
X-Gm-Message-State: AD7BkJIsudAnPViAt8JgJgFsOV9uoAw3v7LWSH1v8YBaRnj8nO6enZQ18vsj9whPaFFAV8rGbINOgVjWl2Kuvg==
X-Received: by 10.112.130.41 with SMTP id ob9mr966283lbb.81.1457608680483;
 Thu, 10 Mar 2016 03:18:00 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 03:17:30 -0800 (PST)
In-Reply-To: <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288613>

On Thu, Mar 10, 2016 at 6:21 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Turner <dturner@twopensource.com> writes:
>>
>>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>>
>>> Instead of reading the index from disk and worrying about disk
>>> corruption, the index is cached in memory (memory bit-flips happen
>>> too, but hopefully less often). The result is faster read. Read tim=
e
>>> is reduced by 70%.
>>>
>>> The biggest gain is not having to verify the trailing SHA-1, which
>>> takes lots of time especially on large index files.
>
> Come to think of it, wouldn't it be far less intrusive change to
> just put the index on a ramdisk and skip the trailing SHA-1
> verification, to obtain a similar result with the same trade off
> (i.e. blindly trusting memory instead of being paranoid)?

I'm straying off-topic again because this reminded me about lmdb :)
=46or the record when I looked at lmdb I thought of using it as an inde=
x
format too. It has everything we wanted in index-v5. Good enough that
we would not need index-helper and split-index to work around current
index format. Though I finally decided it didn't fit well.

On the good side, lmdb is b+ trees, we can update directly on disk
(without rewriting whole file), read directly from mmap'd file and not
worry about corrupting it. There's no SHA-1 verification either (and
we can do crc32 per entry if we want too). It's good.

But, it does not fit well the our locking model (but we can change
this). And we sometimes want to create temporary throw-away indexes
(e.g. partial commits) which I don't think is easy to do. And the
reading directly from mmap does not give us much because we have to do
byte endian conversion  anyway.

Hmm.. on second thought, even though lmdb can't be the default format
(for a bunch of other limitations), it can still be an option for
super big worktrees, just like index-helper being an optional
optimization. Hm.. hm.. if we can support lmdb as index format in
addition to the current format, bringing back some work from Thomas..
We may still need a daemon or something to deal with watchman, but the
underlying mechanism is exactly the same... David, Junio, what do you
think?
--=20
Duy
