From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 15:41:31 +0530
Message-ID: <CALkWK0mv2jzmDA==pJg5R4jH0yxo=OopYM_WzAWusiffnb+4HQ@mail.gmail.com>
References: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com> <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino> <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com>
 <20120111054954.GB13507@burratino> <CALkWK0=o+KkV08G9JuTaG8Vtb-AzHQVMQPzMy8td_iBVnGX4Dg@mail.gmail.com>
 <20120111095236.GB31670@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 11:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkv9z-0004Cg-Gz
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 11:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab2AKKL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 05:11:56 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53744 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2AKKLy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 05:11:54 -0500
Received: by wgbds12 with SMTP id ds12so378073wgb.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 02:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UvII3bCOW5iCNUAWXcjTpViTGhWWfuhybpgep9dijMA=;
        b=TD05vNUG6q8hSYMQ6DRLlE/eIJKay+Xd95YZOeBX7l94bjOze6B0c931nS5b4+sabz
         Wrf1zwzzro3ioYXyT6o/IK1XJBP3JdijRaF3yLQ19DUkrBqEeQJDCJKOvJfIrlHMF0Du
         XFz+JT0ToDy7aUpDxHbMXayKNwKSmKBjH6XUs=
Received: by 10.180.103.2 with SMTP id fs2mr18185197wib.21.1326276713624; Wed,
 11 Jan 2012 02:11:53 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Wed, 11 Jan 2012 02:11:31 -0800 (PST)
In-Reply-To: <20120111095236.GB31670@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188353>

Jonathan Nieder wrote:
> Perhaps cherry-pick and revert should be different values for
> replay_subcommand, to avoid conflating the mechanics and the command
> name? =C2=A0Resulting in something like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum replay_subcommand {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_PICK_RE=
VISIONS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_REVERT_=
REVISIONS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_EDIT_SE=
QUENCE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_REMOVE_=
STATE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_CONTINU=
E,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_SKIP,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REPLAY_ROLLBAC=
K
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};

We'd be prematurely locking ourselves into a design where we can't
tell which top-level command issued the continue/ abort -- this means
that there's no way to deny a 'git rebase --continue' from running
after a 'git cherry-pick' conflicts (assuming that rebase is
implemented in terms of the sequencer ofcourse).  Even if that
specific objection isn't to your taste, I'm not comfortable about
painting ourselves into such a tight corner so early on.  My sincere
suggestion is to procrastinate the problem until we have a tighter
usecase (a new top-level command or action added, for instance).  I
don't think we have to worry about preserving backward compatibility
in the sequencer API?

-- Ram
