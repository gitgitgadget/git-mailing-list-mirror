From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] builtin/verify-tag: move verification code to tag.c
Date: Sun, 3 Apr 2016 04:11:11 -0400
Message-ID: <CAPig+cQzeRk66eptatSy8=1xbnBNrO5ATrfqBX8730t3gOmNQw@mail.gmail.com>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
	<1459638975-17705-4-git-send-email-santiago@nyu.edu>
	<20160403044502.GC1519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Santiago Torres <santiago@nyu.edu>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 10:11:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amd7y-00032J-Pv
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 10:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcDCILR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 04:11:17 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33531 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcDCILM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 04:11:12 -0400
Received: by mail-ig0-f193.google.com with SMTP id nt3so8094222igb.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pbXQuepZiEH0iQBC3lYjh5jVl5J6ic0+GwGWlpkeheU=;
        b=nLuosJieu8SB4wBEt2DlGJTUYtx3a8J0Y8qHLsQssFQxXT2wbdGfRnQmjklL5P0j+m
         /5MNDYnzSQAzGluKUarzHR+4haZpMBFQVCOYR2nngJvVAauJdIasTIFe1ttiRTKKCqUX
         pYl/9paNeUAZUiTb0JFayz0u/zu9HkJ3HhSrgEJWuafY8wxphQthCkmSWyeShRe6uNLC
         MpwWD6EQKprSX0dRAET95Cnlsm2h2LZuJzA5AED5K98TP0Cgt2hcNpdfbdHKJxaGAxEF
         lsM0msq0i6kNzNWS2wlPcapI6E7kx1/+EADrL6uXZFblocpcLUllDGBCNf2JUYSxvTNV
         /D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pbXQuepZiEH0iQBC3lYjh5jVl5J6ic0+GwGWlpkeheU=;
        b=lXYEudXmim3aaUL+OPPBFTRrvjOMtpnoaRy8P3qFt/fRnu4c8EoJvw9iopntpzRByV
         x58vX8V7TcaLxTWdj02EUhlwzGi5Kp8TyKpquEC7HfYSYnXrAjFqCfKBrFiGuz6ktCSM
         kAvsxz/f+p9rMfzPSzEBwM7I2khUHDzUmgjvIF9hzRLrfwYdoVTQ2x83lcS5vnw4Q3+H
         MNqmsje+lVZQbnXCKV8hMg5ZROJPinK3f7jQNCwU/6wmTnvjpGb114a1Hci1uNyXs8aO
         oLHIxLyPxiWP4Fta99t0Axjhl0oazl7apeegmrfbCdbHcrx/6kkWfPRF2/c82Tg4Wjfc
         Cidw==
X-Gm-Message-State: AD7BkJIay+tryDDBXcrU4ShF5wCmuzXqVSCjv7fyuxhoouvzK/1T46PqMgBn9tzAp4jYANKAWVo8IA6CGZUsmA==
X-Received: by 10.107.130.138 with SMTP id m10mr4537903ioi.34.1459671071901;
 Sun, 03 Apr 2016 01:11:11 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 01:11:11 -0700 (PDT)
In-Reply-To: <20160403044502.GC1519@sigill.intra.peff.net>
X-Google-Sender-Auth: LSnizPfDZpidpBYu3v7Iz1M_J7E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290634>

On Sun, Apr 3, 2016 at 12:45 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 02, 2016 at 07:16:14PM -0400, santiago@nyu.edu wrote:
>> -     len = parse_signature(buf, size);
>> -
>> -     if (size == len) {
>> -             if (flags & GPG_VERIFY_VERBOSE)
>> -                     write_in_full(1, buf, len);
>> -             return error("no signature found");
>> -     }
>> [...]
>> +     payload_size = parse_signature(buf, size);
>> +
>> +     if (size == payload_size) {
>> +             write_in_full(1, buf, payload_size);
>> +             return error("No PGP signature found in this tag!");
>> +     }
>
> I'm happy to see the more readable variable name here. I wonder if we
> should leave the error message as-is, though, as this is just supposed
> to be about code movement (and if we are changing it, it should adhere
> to our usual style of not starting with a capital letter, and not ending
> in punctuation).

Agreed it would be nice for this patch to be just code movement since
it's difficult for a reviewer to spot actual changes. A pure code
movement patch was suggested by [1], but perhaps it should also have
explained the reason ("code changes are difficult to spot in
movement").

Such changes could be done as preparatory or follow-on patches.
Alternately, since these are such minor changes, it might also be okay
just to mention them in the commit message (as the function rename is
already mentioned).

[1]: http://article.gmane.org/gmane.comp.version-control.git/289847
