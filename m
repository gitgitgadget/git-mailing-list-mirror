From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 22:43:54 +0530
Message-ID: <CALkWK0nv7On34g-zE5uHAH69TT-KcEt8z-LxhveNp1b4b+NHsg@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <1372048388-16742-7-git-send-email-gitster@pobox.com> <CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
 <7vhagndis4.fsf@alter.siamese.dyndns.org> <CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
 <7vy59zbjns.fsf@alter.siamese.dyndns.org> <CALkWK0=a40hACGYApN7odrTytDmoRG_00_Q=EuaHuQ_=h8LBkg@mail.gmail.com>
 <7vbo6vbgbs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrALf-0002cb-NO
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3FXROf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:14:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:54456 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3FXROe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:14:34 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so23886366ief.26
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FeGxtzGoyYNSnKdvc0MVI41oRv3E5JrZKWLbZx7NPVw=;
        b=zX5QEy7jSdKdK+KWCLriy3pAJt020uUp6yyH7GnTSFbvVNZF90HWISfd9V/E5U4dYn
         /tZ2utAwG2ja17gjj9YII8LJZSJn/95tUc6m2djh8jjX6fQX8X36ktDnWnmH9TAG83AA
         Gt8tLvR+TxnZXwyXrlViAgFabNzaFEiOKih519ImiXPIwVx989dyYt9I6WcFgFPGCeGN
         2jxB/95hfcLGFpiKWe06wK8X0Yf1chGDbQc9aGfZkgtz6oA/1AW8kBRZ5Hojufzt6q1j
         cdY6THQRrB6qAF+qAeVijJz0144rEr7XqnEU863qecYlclL8vDgdmW3N6CN9/CFSn1kG
         bJVQ==
X-Received: by 10.50.87.71 with SMTP id v7mr6305938igz.29.1372094074514; Mon,
 24 Jun 2013 10:14:34 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 10:13:54 -0700 (PDT)
In-Reply-To: <7vbo6vbgbs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228877>

Junio C Hamano wrote:
> If you do not set anywhere (like branch.master.pushremote or
> remote.pushdefault) to push to "ram", and if you did not say "git
> push ram" but just said "git push", we will not push to "ram"
> (otherwise it is broken).  So if the push is going to "ram", the
> user must have asked us to push there, either via the command line,
> or these explicit configuration variables.  And why do you need to
> differenciate between the command line "ram" and configured "ram"?
> After all, isn't the configuration merely a typesaver?  If you know
> often push to "ram", you configure to push there.  If you don't, you
> don't.

Yes, you're talking about configuration variables in general.  If the user says

  $ git status

expecting long-form output, but gets short-form output, the world
hasn't ended.  But if the user does

  $ git push -f

expecting the push to go to one place, when it actually goes to
another place, she would have killed a few co-workers.

I'm not saying that we need to differentiate between configuration
variables and CLI options; what I _am_ saying is that we need to think
twice about moving a CLI option to a configuration variable, precisely
because we do not differentiate between the two cases.

As I have said earlier, my philosophy to prevent disasters does not
involve erroring-out or denying for the most part; rather it focuses
on giving the user immediate feedback like:

  $ git push -f
  # pushing master:next to ram (press ^C to abort)

Another form of feedback is the refspec @{p[ush]}, which I'm
struggling to complete.

> The push.default is meant to be in effect only when there is no
> other stronger clue from the user for what to update (e.g. command
> line refspec, remote.*.push).

Yes, I know what it does currently.  With your patch, the list becomes
"push.default will be in effect only when there is no CLI refspec,
remote.<name>.push or branch.<name>.push in effect".  I'm wondering if
there's a more elegant way to do it.

> Of course, that requires, as you earlier pointed out, that the logic
> to read from branch.*.push need to be moved out of the push.default
> logic (in the weatherbaloon patch) and hosted to do_push() where it
> checks if there is remote->pushrefspec[].  If branch.*.push wants to
> defeat remote.*.push, then it should be checked before deciding to
> use that configured remote.*.push.

I suspect there's a better way to do this.

> As I already said, I personally do not know what branch.*.push buys
> us, and will happy to drop 6/6.  It is merely a weatherbaloon patch.

I hope we come out with a better version soon.
