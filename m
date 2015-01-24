From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 6/6] refs.c: enable large transactions
Date: Fri, 23 Jan 2015 16:24:25 -0800
Message-ID: <CAGZ79kYbCBHVhL+FvKu-yKMinxGCMwGfqG96rSp+0-7frgO2wQ@mail.gmail.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-7-git-send-email-sbeller@google.com>
	<xmqqy4otnigf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEoWd-0000MM-3v
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 01:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbAXAY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 19:24:27 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38163 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbAXAY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 19:24:26 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so382656iec.8
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 16:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rlgZ1dBJrWOY33X+38Fp851Kt4mHlK9qVB1gbLqL810=;
        b=I1JNGYNyClz1vSxI9ccYCJnz7o+A0ri3Nvk2sTnQOnFAHabDh4fmplOjgi7CQUnn4y
         knz87GAv66Pbmw4HIRJF6aTC9rB3rrimCaEjnSNbB3E5H4sPVrgFRJQzfYt70oYcA+mN
         ldyLbDKzQT4ctd7TH1UDvJYdOxmo/jyRRzNZDq1Mysg+0HURgQ+G4BRiMoHUPLkBkO8i
         xBOKYnkmbCo3c75ueBGGYPvMAWpHK71y6rLoYyg47brUrInLjFZSR7DzQshz00+vFwl2
         skXDdIBPkcKgxFt/aze5aeVvzPlxQAkqZIaYtHtCkDXYvwnpxEaIHilYuRH6GJ4SxQjL
         CESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rlgZ1dBJrWOY33X+38Fp851Kt4mHlK9qVB1gbLqL810=;
        b=Ho+x5LgQEvGGzLlR6NkIohaVSFkmHhNMnisAyazZIOP4r5tVbKggntxJ87fzLaoBTo
         4rDVDMCi2Nu0YL45z2WZ72cFjk4mrrD6MFfrpS6GbNp+ArpnWDxT3eMcehS6/ZsfC7KL
         UG0nnUyO/Xz1i+TKA2BvpQ1cU8ObDnazX2uOy5Ylbj5uZvUv6yU+9g4FYhLzxD+n+O1B
         rixjg3ufIL6PUqD6DBniy74d/EIp90Oga4GW8UifGBhpQlNJC9wUCsfyKdVpglMvQnt9
         MXEbtWdaZueLT3CKfipnCJ1SSyAovMZo/Up/Mv5e5GFvZE6NZBlsjoO4i6cY1oCOTXia
         TZ0w==
X-Gm-Message-State: ALoCoQmOdgvpftldHKySaITLFYKlypmWKJlf/2pGU1fkpwyHAI98evuv631uvTqlfUJqXRkDsbx6
X-Received: by 10.50.85.44 with SMTP id e12mr5112393igz.48.1422059065369; Fri,
 23 Jan 2015 16:24:25 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 16:24:25 -0800 (PST)
In-Reply-To: <xmqqy4otnigf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262979>

On Fri, Jan 23, 2015 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> By closing the file descriptors after creating the lock file we are not
>> limiting the size of the transaction by the number of available file
>> descriptors.
>>
>> When closing the file descriptors early, we also need to write the values
>> in early, if we don't want to reopen the files.
>
>
> I am not sure if an early return in write_ref_sha1() is entirely
> correct.  The unlock step was split out of write and commit
> functions in the previous step because you eventually want to be
> able to close the file descriptor that is open to $ref.lock early,
> while still keeping the $ref.lock file around to avoid others
> competing with you, so that you can limit the number of open file
> descriptors, no?

yeah that's the goal. Though as we're in one transaction, as soon
as we have an early exit, the transaction will abort.

>
> If so, shouldn't the write function at least close the file
> descriptor even when it knows that the $ref.lock already has the
> correct object name?  The call to close_ref() is never made when the
> early-return codepath is taken as far as I can see.
>

The  goto cleanup; will take care of unlocking (and closing fds of) all refs
