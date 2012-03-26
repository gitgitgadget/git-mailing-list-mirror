From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 26 Mar 2012 23:41:32 +1100
Message-ID: <CAKTdtZnsiP9VO2Us6dF760SFnEbpVgsAhcuOjOxuzBZxDODizQ@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
	<CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
	<CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
	<CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
	<CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 14:41:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC9Ev-0008CA-U9
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 14:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab2CZMld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 08:41:33 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55961 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab2CZMld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 08:41:33 -0400
Received: by vbbff1 with SMTP id ff1so2568367vbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=CAEiTfHdCcRhSKBcxUbpJZ2xOG7wG4+mIlQXy8NJ6vQ=;
        b=LSygMJAlvJrmTxfGGqmfD6aSr5CQ8lyg6X+u1ONDKkS5xTkp5i8ohR3CRjgYProQ79
         nRM1iihqDFN4E9wanOZH4tRgMc1kqZJG91zlbne79c64cWrLspLK4yykj+S51Lu597Fx
         pWnQJHCEqTC8Oa4Eln5s/V36wfRW7WBvVaWdavwafvvRD5LY8YEJiT4PtMuD0YyRTNHP
         pj1DLgZ88bShCL7JFKaOpQjZxtWjoVlD1tgEqC+bSoCDHeSOdFqR+GO2VEWh1Zpw450d
         b2mvPm2hpRAbsk+CFA00OVyAgnHEN9WoN0DQCfM6clNlCmUpm13S2G4++3+rl9oAvc3C
         vWFQ==
Received: by 10.52.64.234 with SMTP id r10mr8391834vds.39.1332765692254; Mon,
 26 Mar 2012 05:41:32 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Mon, 26 Mar 2012 05:41:32 -0700 (PDT)
In-Reply-To: <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193910>

As the previous email is hidden in the trimmed area, just resend it:


About the new format:

The index is a single file. Entries in the index still stored
sequentially as old format. The difference is they are grouped into
blocks. A block contains many entries and they are ordered by names.
Blocks are also ordered by the name of the first entry. Each block
contains a sha1 for entries in it.
=46or using a binary search to locate the block for an entry, the
offsets of blocks are stored in the header of the index. We reserve
100 spaces for block offsets in the header. More offsets are stored in
a meta block (see below) afterwards. An offset of the first meta block
is stored.
The checksum is computed on block. After we locate the block, the
checksum is recomputed for the block. And only the this block will be
read and write back later. As the block is read into ram, it is easy
to do a binary search for entries in a block when they are in ram.
When the index doesn't have many entries, it works very similar with
current format. When more entries git-added, blocks will come into
play.

=46ormat:

Head:
- 4-byte signature
- 4-byte version num
- 4-byte num of entries blocks
- 4-byte offset for new block
- list of offsets for blocks (e.g. 96, 14096, 8192, ..) : For binary
search. Each offset is 8 bytes, we reserve 100 x 4 =3D 400 bytes for
first 100 blocks. More offsets (if applicable) will be stored in a
meta blocks.
- 4-byte offset to the first meta block
- 20-byte sha1 for above and meta blocks

List of Blocks:
- sha1 for all entries
- list of entries

Meta block:
- offset to next meta block
- list of offsets

Extensions:
=A0 =A0 =A0 TBD. Have not hacked cache tree yet. Need more knowledge of=
 cache tree...


Block Split & Delete:
=A0 =A0 =A0 TBD.

Regards,
Elton
