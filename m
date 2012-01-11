From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 10:56:03 +0530
Message-ID: <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino> <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino> <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 06:26:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkqhm-0000V6-5X
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 06:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab2AKF00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 00:26:26 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44280 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab2AKF0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 00:26:25 -0500
Received: by werm1 with SMTP id m1so244184wer.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 21:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m6yJ65FBXJS3eEA9Q94wBjwZ3nfTK+cCHdAz8zC6UBM=;
        b=pYHYHIHO0y2iXXg9lZ9yRZ4Y6VSVzUGBBKRLJJWGQHuZLD5joflo5+9ESo8Z1Dtxxk
         q3trVCLB2kkwKY1jN2aTN6+ihm1Y4/nxcQqxbi7tbnXWY62+K4hzTDyoOeR9UuFfvsZl
         wbgmiM1v1Kg8cSkXJy2BwjYDSELDaSc2CF6vQ=
Received: by 10.216.139.153 with SMTP id c25mr2074364wej.25.1326259584180;
 Tue, 10 Jan 2012 21:26:24 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 21:26:03 -0800 (PST)
In-Reply-To: <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188332>

Hi Jonathan,

I wrote a new commit message for this patch.  Perhaps it can help clarify?

  revert: decouple sequencer actions from commands

  Currently, we have two actions "pick" and "revert" that directly
  correspond to the action of the commands 'git cherry-pick' and 'git
  revert' respectively.  Since we would like to permit mixing different
  actions in the same instruction sheet inspired by the way 'git rebase
  --interactive' works, a future instruction sheet would look like:

    pickle next~4
    revert rr/moo^2~34
    action3 b74fea

  where the actions "pickle", "revert" and "action3" need not directly
  correspond to the specific commands.  So, instead of using the same
  representation for both the command executed and the sequencer action
  (the "replay_action" enum), store the command separately as a
  "replay_command" enum.

  Since we don't allow mixing actions yet, the entire operation of 'git
  cherry-pick'/ 'git revert' relies on the command, with the
  exception of the instruction sheet parser which converts a
  "replay_action" to a "replay_command".  As we support mixing actions
  in future patches, more portions of the code will rely on the
  action, demoting the command to a string used in error reporting.

-- Ram
