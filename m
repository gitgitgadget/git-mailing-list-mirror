From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] The move to sequencer.c
Date: Mon, 9 Jan 2012 01:21:50 +0530
Message-ID: <CALkWK0=xhnXq4_uEAri74Kk9zbAgiS+z-nG7Etm3MCo2cXaNPw@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com> <20120108192853.GE1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjyn1-0001oN-LE
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab2AHTwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 14:52:13 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35302 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab2AHTwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 14:52:11 -0500
Received: by wgbdr10 with SMTP id dr10so1048464wgb.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QFEYTV+UWyPjOMWV1p9T/uO2N6ak3DC1PtZqFSvEO68=;
        b=ZqXGyOMgQg8r9oZQr7vBq1ZgW+zJpBuU5EKuEJHuXU3OUlVgPF04i74Wp37aabvVEA
         /+ZUEGs9ptc4vCVLvCmY04ECQc6f+ZA+4lPgq+807vmQcL5XpJ5vFjFiD1uMoBN+ClJp
         CIMCUGJMuQs1GStIaZpjQg3RE94fr4yvcrqzU=
Received: by 10.180.106.165 with SMTP id gv5mr22964931wib.18.1326052330308;
 Sun, 08 Jan 2012 11:52:10 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 11:51:50 -0800 (PST)
In-Reply-To: <20120108192853.GE1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188120>

Jonathan Nieder wrote:
> For the sake of new and forgetful readers: what is that objective?

The objective is to build a generalized sequencer, of which "git
revert" and "git cherry-pick" are two special cases.  We can later
extend it to encompass more builtins and other commands.  Why?  In
general, we want uniform semantics to continue, skip, and abort any
operation that requires user-intervention (example: a conflict that
needs to be resolved before proceeding).  A lot of this work is
inspired by the way "rebase -i" works: it presents the user an
instruction sheet with a sequence of actions to perform.  Example
future use cases:

  $ git cherry-pick moo..foo
  [conflict]
  $ edit problematicfile
  $ git add problematicfile
  $ git continue
  [finishes successfully]

  $ git revert moo..foo
  [conflict]
  $ edit problematicfile
  $ git add problematicfile
  $ git continue
  [finishes successfully]

In these examples, the instruction sheet is uniformly filled with
"pick" or "revert" actions, which is not very interesting.  When we
get an interface to allow easy editing of the instruction sheet and
encompass more builtins, more interesting sequences of operations will
be possible like:

  pick rr/revert-cherry-pick^2~34
  revert master@{12}
  merge next
  am /tmp/jrn.patch

Thanks.

-- Ram
