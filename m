From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Tue, 15 Feb 2011 17:11:36 -0500
Message-ID: <AANLkTinV+cY-fND2bemDGdShnfqQGMG3eUmZPXrpKayt@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com> <AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpT82-0005M5-1P
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab1BOWMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 17:12:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52046 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab1BOWMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 17:12:07 -0500
Received: by iyj8 with SMTP id 8so552274iyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=OV2dRfaIQiIZDpTNC4S6fMj+wMM+SijfKZsA05waPQc=;
        b=N2Q1u0LY7GtfvrU3PoxefvbbZG5PbIRFX051b8BEoWlw31D2ssIu/N/H7ApHePBzJZ
         uPk4VIJQgvgIrgpKXnlNNGFvyasvUDZ5y5HmovfLGcUBRztZymVwyYT+5t+FcQFEgOVO
         45rJgXaL0XjjRSAvOYOT+giwqmxcpTT2o/lRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AbtzgXZrn8MgRIRnqSvGQ7G8AASoTNRGJaTkC+1e9dcegJS5DHXZ5UdlpnZYLN9a8H
         +URjKTYsD5z102sU2CaoWqzbF8Wf+xUMjWgxIzMZFS53eTGZNlJK32yafnBn6uLcxsnr
         Nf14VApJdO8fcuiComgzP35Qat/9oND4EyG5Y=
Received: by 10.231.36.69 with SMTP id s5mr4297863ibd.167.1297807926484; Tue,
 15 Feb 2011 14:12:06 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 14:11:36 -0800 (PST)
In-Reply-To: <AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166884>

On Tue, Feb 15, 2011 at 4:51 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I've read this over, haven't run it, but I really like the idea. It
> sucks that you have to save away the commit sha1 somwhere after a
> failed cherry-pick to use it again. It should just behave like `git
> rebase --continue`, which this implements.

I agree and I said as much. The problem is that cherry-pick has two
modes of behavior:

1. Given a single commit. Historically this was the only way to use
it. In this case, the behavior after a conflict should be the same as
after a merge conflict. You resolve the conflicts then use git commit.

2. Given a rev-list. This is relatively recent addition to cherry-pick
(7e2bfd3 revert: allow cherry-picking more than one commit,
2010-06-02). Here's where I'd expect to have a more rebase-like
behavior, using --continue/abort to work through the sequence. But
frankly, I consider 7e2bfd3 a mistake. I think a better implementation
would be to make cherry-pick be plumbing, and re-use rebase's logic
for walking through the series of commit.

I'd like to do (2) eventually[*] but I think in the mean time this is
a nice incremental improvement.

[*] is the sequencer project dead?

> It'll need some tests as a non-RFC, but otherwise it looks good.

Yep, I wanted to make sure I wasn't off in the weeds first. :-)

Thanks,

j.
