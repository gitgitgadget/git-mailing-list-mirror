From: Bryan Turner <bturner@atlassian.com>
Subject: Re: git rev-list %an, %ae, %at bug in v1.7.10.1 and beyond
Date: Tue, 22 May 2012 15:13:09 +1000
Message-ID: <CAGyf7-Gj8YynENrnkZMT4WSEDtYpmUL5qaS4TEuvfaa_YcXxOw@mail.gmail.com>
References: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
	<20120522043221.GA6859@sigill.intra.peff.net>
	<20120522043509.GB6859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 07:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWhPJ-0001N5-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab2EVFNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 01:13:13 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42412 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753454Ab2EVFNM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 01:13:12 -0400
Received: from mail-yx0-f171.google.com ([209.85.213.171]) (using TLSv1) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT7sgZyohTP2FM+tkWCvP1oZBeAcz7PWl@postini.com; Mon, 21 May 2012 22:13:11 PDT
Received: by yenq11 with SMTP id q11so6380002yen.30
        for <git@vger.kernel.org>; Mon, 21 May 2012 22:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=ow7V2lYC7moTFBX9iSaeW5+9mfccRPJPiGQq807I2JM=;
        b=BiBz94WZAFJi1Vbn6vhsd7w9bQ4bUY+hK7BDLXBQAVD8CrkPFZAQY1AgVTCreZtjUL
         P1MjO/+oNQxTvi+0CGNKgfXFIwlJFx+XklYvQxpFRzLKSYj2RDCRa6zPK6NOchoemuiw
         SIW9pX6XjYe1J6Jru32SkOegtQKKjpJsrkeN520vPjrFpqfeGgtX0PHkXUiM2h1PCACB
         2fi7zoxYLbN4gEoOx1FBmnMC1B3oKeoHWiaSxUmefp93kIuKPd+Yqh0nIxwrVFYqMk3f
         AzJKtW5fgBQ4dtWw//TI3JGZk+9VzGNFeMpiOXfUgF0HgK2t8QUZ7ta3/C18M0Rpxox8
         AJ8w==
Received: by 10.50.187.137 with SMTP id fs9mr8461553igc.50.1337663589334; Mon,
 21 May 2012 22:13:09 -0700 (PDT)
Received: by 10.231.65.12 with HTTP; Mon, 21 May 2012 22:13:09 -0700 (PDT)
In-Reply-To: <20120522043509.GB6859@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmP7AuUKGYHgtSlIZRja20kWJVK0lDE+rqpYO36eaEsByaJvDpSKTS17xzDhxskHagLz41/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198174>

Peff,

Thanks for taking the time to respond! I appreciate it.

I went and spoke to the tester who made the original commit, and it
sounds like what he did was open .git/config with a text editor and
update the user.name directly. He then saved the file. His operating
system's code page was UTF-16LE, so I believe the file was saved in
that format. He then did the commit.

That sort of behavior is pretty far outside the scope of anything git
can realistically be expected to handle (and I told the tester that as
well). That said, I'm interested that it "suddenly" broke, and also
that cat-file still appears to not think there's any problem.

I piped the output through xxd, for cat-file and rev-list. The
cat-file output is the same in both versions of git, and looks like
this:
auri:qa-resources.git bturner$ git cat-file -p
5c1ccdec5f84aa149a4978f729fdda70769f942f | xxd
0000000: 7472 6565 2064 6431 3733 6362 3730 6261  tree dd173cb70ba
0000010: 6161 6330 3762 6466 3430 3566 3465 3364  aac07bdf405f4e3d
0000020: 6231 3130 6537 6661 6664 3138 300a 7061  b110e7fafd180.pa
0000030: 7265 6e74 2030 3263 3738 6263 3339 6163  rent 02c78bc39ac
0000040: 3631 3932 3632 3362 6630 3830 6533 6532  6192623bf080e3e2
0000050: 6163 3839 3261 3466 3537 3634 630a 6175  ac892a4f5764c.au
0000060: 7468 6f72 2061 203c 6661 726d 6173 4061  thor a <farmas@a
0000070: 746c 6173 7369 616e 2e63 6f6d 3e20 3133  tlassian.com> 13
0000080: 3237 3837 3632 3232 202b 3131 3030 0a63  27876222 +1100.c
0000090: 6f6d 6d69 7474 6572 2061 203c 6661 726d  ommitter a <farm
00000a0: 6173 4061 746c 6173 7369 616e 2e63 6f6d  as@atlassian.com
00000b0: 3e20 3133 3237 3837 3632 3232 202b 3131  > 1327876222 +11
00000c0: 3030 0a0a 636f 6d6d 6974 2077 6974 6820  00..commit with
00000d0: 756e 6963 6f64 6520 6e61 6d65 0a         unicode name.

In 1.7.9.5, rev-list looks like this:
auri:qa-resources.git bturner$ git rev-list
--format="%H|%h|%P|%p|%an|%ae|%at%n%B%n@@object_end@@" -1
5c1ccdec5f84aa149a4978f729fdda70769f942f | xxd
0000000: 636f 6d6d 6974 2035 6331 6363 6465 6335  commit 5c1ccdec5
0000010: 6638 3461 6131 3439 6134 3937 3866 3732  f84aa149a4978f72
0000020: 3966 6464 6137 3037 3639 6639 3432 660a  9fdda70769f942f.
0000030: 3563 3163 6364 6563 3566 3834 6161 3134  5c1ccdec5f84aa14
0000040: 3961 3439 3738 6637 3239 6664 6461 3730  9a4978f729fdda70
0000050: 3736 3966 3934 3266 7c35 6331 6363 6465  769f942f|5c1ccde
0000060: 7c30 3263 3738 6263 3339 6163 3631 3932  |02c78bc39ac6192
0000070: 3632 3362 6630 3830 6533 6532 6163 3839  623bf080e3e2ac89
0000080: 3261 3466 3537 3634 637c 3032 6337 3862  2a4f5764c|02c78b
0000090: 637c 617c 6661 726d 6173 4061 746c 6173  c|a|farmas@atlas
00000a0: 7369 616e 2e63 6f6d 7c31 3332 3738 3736  sian.com|1327876
00000b0: 3232 320a 636f 6d6d 6974 2077 6974 6820  222.commit with
00000c0: 756e 6963 6f64 6520 6e61 6d65 0a0a 4040  unicode name..@@
00000d0: 6f62 6a65 6374 5f65 6e64 4040 0a         object_end@@.

In 1.7.10.2, it looks like this:
auri:qa-resources.git bturner$ git rev-list
--format="%H|%h|%P|%p|%an|%ae|%at%n%B%n@@object_end@@" -1
5c1ccdec5f84aa149a4978f729fdda70769f942f | xxd
0000000: 636f 6d6d 6974 2035 6331 6363 6465 6335  commit 5c1ccdec5
0000010: 6638 3461 6131 3439 6134 3937 3866 3732  f84aa149a4978f72
0000020: 3966 6464 6137 3037 3639 6639 3432 660a  9fdda70769f942f.
0000030: 3563 3163 6364 6563 3566 3834 6161 3134  5c1ccdec5f84aa14
0000040: 3961 3439 3738 6637 3239 6664 6461 3730  9a4978f729fdda70
0000050: 3736 3966 3934 3266 7c35 6331 6363 6465  769f942f|5c1ccde
0000060: 7c30 3263 3738 6263 3339 6163 3631 3932  |02c78bc39ac6192
0000070: 3632 3362 6630 3830 6533 6532 6163 3839  623bf080e3e2ac89
0000080: 3261 3466 3537 3634 637c 3032 6337 3862  2a4f5764c|02c78b
0000090: 637c 7c7c 0a63 6f6d 6d69 7420 7769 7468  c|||.commit with
00000a0: 2075 6e69 636f 6465 206e 616d 650a 0a40   unicode name..@
00000b0: 406f 626a 6563 745f 656e 6440 400a       @object_end@@.

None of the output indicates a NUL is present. I'm wondering if the
old code that rev-list was running (and maybe the code cat-file
appears to still be running) might be ignoring leading NULs until it
finds the first character, or something similar. If that were the
case, had the tester used a name like "ab" (or anything more than one
character), perhaps the commit would have caused unexpected behavior
all along.

I don't know how to dump the binary for the commit object itself; that
may give us better information on what the author segment actually
contains. Unfortunately, the repository has been packed, so there is
no loose object for the commit anymore.

If there's any other information I can provide, please let me know.

Best regards,
Bryan Turner

On 22 May 2012 14:35, Jeff King <peff@peff.net> wrote:
> On Tue, May 22, 2012 at 12:32:21AM -0400, Jeff King wrote:
>
>> I'm not too surprised this is broken (in fact, I'm surprised it ever
>> really worked). UTF-16, especially representing pure ascii characters,
>> will have embedded NULs. Most of the code assumes that things like names
>> and emails are NUL-terminated and ascii-compatible (so ascii, or some
>> ascii-superset encoding like utf8, iso8859-1, etc). You can store a
>> commit message (and name) in utf-16 if you tell git that you are doing
>> so, but we should be re-encoding it before handling it.
>
> Actually, I take that back. I think storing in utf-16 would probably
> fail. We need to use ascii to even read the headers to get to the
> encoding header to realize that it is in utf-16. So I believe we really
> do only support ascii-superset encodings.
>
> -Peff
