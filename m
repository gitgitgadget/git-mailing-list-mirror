From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] strbuf: create strbuf_humanize() to show byte sizes
Date: Wed, 10 Apr 2013 22:12:00 +0200
Message-ID: <CALWbr2w=q=BkMOeqmSAbi50vNbup+e9GF0gdxNH9-vpyyND5Vw@mail.gmail.com>
References: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
	<1365620604-17851-1-git-send-email-apelisse@gmail.com>
	<7vr4iikvkd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1NJ-0000X2-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936476Ab3DJUME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:12:04 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:55697 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935970Ab3DJUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:12:01 -0400
Received: by mail-qe0-f50.google.com with SMTP id a11so504318qen.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gnStRVbFqcMiIPOrZhhSEeAC5psVjuFl0XJV0Kq6Yoo=;
        b=QSYFppeTOgiX49mTOtuvH5HjJE0JO5hLkvdV9bqiCdD6ogWxTzfSORWJ+a3sBqLNWr
         jLKxUz6nvYQlzJ6cwL/jCAI8QxQA0c5i62mDi1YE8X5erNsWW1KGjlXz7lSKNhQgIri+
         Jg+iaKDyxRyFEn5cYxJOev5giuH4ORTjzieE5ZAjd5lHgkiNyh1fLK5A0SPXNhRoMD1i
         QUwmHr5fz3y6sY9v1Vac3F6Vpdq4PpwhEEuRQG/CRNGitRMzi1tRU/qSVBBIl3VfS6FT
         in/nliULCk9hO55wWEzMmlXgYSVzBh5Px0SGPl/bdeRVsCR1u4A7SDxIK7sDDpGgIpI2
         2Lqw==
X-Received: by 10.229.119.10 with SMTP id x10mr1334289qcq.133.1365624720983;
 Wed, 10 Apr 2013 13:12:00 -0700 (PDT)
Received: by 10.49.118.42 with HTTP; Wed, 10 Apr 2013 13:12:00 -0700 (PDT)
In-Reply-To: <7vr4iikvkd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220749>

On Wed, Apr 10, 2013 at 9:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> Currently, humanization of downloaded size is done in the same
>> function as text formatting in 'process.c'. This is an issue if anyone
>> else wants to use this.
>>
>> Separate text formatting from size simplification and make the function
>> public in strbuf so that it can easily be used by other clients.
>>
>> We now can use strbuf_humanize() for both downloaded size and download
>> speed calculation. One of the drawbacks is that speed will now look like
>> this when download is stalled: "0 bytes/s" instead of "0 KiB/s".
>
> Personally, I do not think the "drawback" is so big an issue.  If
> the caller really cares, we could always add another parameter to
> this formatter to tell it the minimum unit we care about (e.g. pass
> 1024 to say "Don't bother showing scale lower than kibi").

I thought about that, but decided it was not worth it (at least for the moment)

> This is a bit late response, but if we ever want to count something
> in a dimention other than "bytes", like time (e.g. "kiloseconds") or
> number of commits (e.g. "centicommits"), etc., we cannot reuse this
> formatter very easily.  We may want to have "byte" somewhere in its
> name for now to make sure the callers understand its limitation.

I'm not in a hurry.
But it look tough to make it generic: one is binary, another is
sexagesimal, and the last is decimal

> I'll tentatively rename it to "strbuf_humanize_bytes()" while queuing.

I like the idea,
Thanks,
