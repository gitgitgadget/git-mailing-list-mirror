From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 14:49:56 +0530
Message-ID: <CALkWK0=o+KkV08G9JuTaG8Vtb-AzHQVMQPzMy8td_iBVnGX4Dg@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino> <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino> <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com> <20120111054954.GB13507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 10:20:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkuMO-0005m3-II
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 10:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078Ab2AKJUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 04:20:30 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:36777 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab2AKJUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 04:20:18 -0500
Received: by werm1 with SMTP id m1so347358wer.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+w4+WD3tbFx/3mF2MZlQFiaXNSRXIeycf5o113UGzKo=;
        b=fvxB9wmWF2KzHWo05fEWTMZ2mHgJ10UVNHQVXZTa9Oc3tIdaGJyDMFrHiqVlZeahjd
         XfKnFffnwLXHscw72iK2xEDB5M7ZEdnh32tVBz8nNRkdjOqmCn8hOGFsJYNHnjP+DMVU
         6P/aHd+c23KCQ/oM8VBrLyzuf4CvIi27UGMrw=
Received: by 10.180.94.102 with SMTP id db6mr10912126wib.0.1326273617230; Wed,
 11 Jan 2012 01:20:17 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Wed, 11 Jan 2012 01:19:56 -0800 (PST)
In-Reply-To: <20120111054954.GB13507@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188347>

Jonathan Nieder wrote:
> Well, let's start here. =C2=A0The two insns "pick" and "revert" and t=
he
> ability to mix them doesn't have much to do with the picture, does it=
?
>
> I think the actual problem being solved is that insn types, as descri=
bed
> by the replay_action enum, are being abused to refer to top-level git
> commands "revert" and "cherry-pick". =C2=A0The sequencer isn't suppos=
ed to
> care which top-level git command called it, except in some messages, =
so
> we'd certainly like to stop pretending that has something to do with
> insn types.

Exactly.  I'll update the commit message.

> Based on what you've said, correcting this cleanly is complicated in
> some places by the inconvenient fact that the sequencer _does_ care
> which top-level git command called it. =C2=A0(I haven't checked this;=
 I'm
> just taking it on faith from you.) =C2=A0If we want to let other git
> commands (like "git rebase" or "git sequence") call into the
> sequencer, that sounds like a way bigger problem than any conflict of
> terminology.

There's no need to trust me: just think about the problem.  We fill
out a replay_opts structure to call into the sequencer with- how does
the sequencer know what to do with this hypothetical command string
(say "cherry-pick") on a fresh invocation?  It needs to translate this
into a replay_action at some point, right?  There are atleast three
places where this happens: prepare_revs(), walk_revs_populate_todo(),
and single_pick().

-- Ram
