From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 20:23:45 +0100
Message-ID: <CAMP44s3tnK+uc0YEEq=Q=2nOoFrkc1ooNPcHMShtcXzpxXhRfQ@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
	<7vfw43pmp7.fsf@alter.siamese.dyndns.org>
	<20121121194810.GE16280@sigill.intra.peff.net>
	<CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
	<7v7gp9udsl.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info>
	<7vd2z0tfhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:24:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td4Hi-0000FB-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 20:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab2KZTXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 14:23:47 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58785 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab2KZTXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 14:23:46 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so8049394vcm.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 11:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ssM1xPX8SW6z8fnoMr2CN3M0C/dKExT92TEO2xoFU6U=;
        b=G1fj6K9spw+MokFPQ9QUvmzXWbqGiCBY8ULJKEJN6DJ0lwfJJjq/cmnKnWsp0WtdFP
         rfG4FPrXpKXGCl7RsO1gj5EtQ85qTSdiZ65DOpTuUnack7UIVPX9e5FKH3G4+4yoHdrw
         Ek6z1jPHWjIAmVJj9BA23o9fJDuw2bUdns+0QIUK5JKSP6O5Nw/bKSRgH+lDkjowqW3S
         gxyltVawouKvxyC7o5ANwwWRdRepYcLK6ARtkWX82aFwmYAGqTEPGumJKxfp2TdTUrUv
         RwN1HzB6jYNv5dXi1T5xX7pDGCr8ofeTzFkMQTBDUjTcTCPSP7r4YUN269LWXbWCyGWz
         wG0A==
Received: by 10.52.88.175 with SMTP id bh15mr6487598vdb.34.1353957825918; Mon,
 26 Nov 2012 11:23:45 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Mon, 26 Nov 2012 11:23:45 -0800 (PST)
In-Reply-To: <7vd2z0tfhz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210470>

On Mon, Nov 26, 2012 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> If you changed your stance on the patch Sverre and I sent to fix this, we
>> could get a non-partial fix for this.
>
> This is long time ago so I may be misremembering the details, but I
> thought the original patch was (ab)using object flags to mark "this
> was explicitly asked for, even though some other range operation may
> have marked it uninteresting".  Because it predated the introduction
> of the rev_cmdline_info mechanism to record what was mentioned on
> the command line separately from what objects are uninteresting
> (i.e. object flags), it may have been one convenient way to record
> this information, but it still looked unnecessarily ugly hack to me,
> in that it allocated scarce object flag bits to represent a narrow
> special case (iirc, only a freestanding "A" on the command line but
> not "A" spelled in "B..A", or something), making it more expensive
> to record other kinds of command line information in a way
> consistent with the approach chosen (we do not want to waste object
> flag bits in order to record "this was right hand side tip of the
> symmetric difference range" and such).
>
> If you are calling "do not waste object flags to represent one
> special case among endless number of possibilities, as it will make
> it impossible to extend it" my stance, that hasn't changed.

The problem with those patches is that they were doing many things at
the same time.

You are correct that one of the problems being solved was the fact
that we wanted to differentiate B from A in B..A independently of the
object, because it might have been referenced by ^C. My latest patch
series deals with that by using rev cmdline_info.

But there's another problem that series tried to fix: weather or not A
was exported by fast-export, which is not strictly the same as SHOWN.

This becomes a non-issue if my patch series is applied because it
properly identifies when an object has been marked or not. But it's
not when marks are not used.

For example:

% git branch A v1
% git branch B v0
% git branch C v0
% git branch D v1
% git fast-export B..A ^C D

A would be updated through a 'commit refs/heads/A' command, D would be
updated through 'reset refs/heads/D'.

But what if C points to v1? The code will assume A will be exported,
and it will be skipped, and there will be only one reset: 'reset
refs/heads/D'. Either way it doesn't matter, because the reset would
be to mark :0, so even if there was a 'reset refs/heads/A' (because A
was never exported), a mark :0 would be useless.

When marks are used my patch fixes the problem because it doesn't care
if A was exporeted or not; by knowing it was marked, it knows it was
never intended to be exported, so we get resets for both A and D, with
real marks.

> We added rev_cmdline_info since then so that we can tell what refs
> were given from the command line in what way, and I thought that we
> applied a patch from Sverre that uses it instead of the object
> flags.  Am I misremembering things?

No, the patch from Sverre was never merged.

-- 
Felipe Contreras
