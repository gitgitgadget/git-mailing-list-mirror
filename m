From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 23:38:20 +0530
Message-ID: <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com> <7vr4ibu14j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:09:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnq0-0004kX-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab3DOSJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:09:03 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:46949 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab3DOSJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:09:02 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so2515459bkc.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qgKuAH2T8LVwr5fjDsFwfeg4s9yHKLGIgBClzQS7T30=;
        b=bcvZDsmKUUEnoQxXS/vhVGBGQ0SX8TyDmh9fFdjWMuYp2DEMLWzdYSItM3w50p81ze
         h6cubwZ9GX8z1DkBcg4VukBJTuUAiHkh4o7Mo48T7w2SqK6Qc0Au2RfAil0jvxxVQU52
         c8P6AbX5zBeOsgy6lG8NF7jMtBa2jQXXnMc89JXS8KSfMArP29j6NG+GMl3vFah4I3mB
         kHHp0O73pp+RLRxbJDQJwX7ksB6aiPiQAhQ1YFGBVqPO9U6HBGLrbiSqCVMlv2aEPZ7+
         hv9ZhdjA+kes3FIk9aBcQfgQjscIXPGqkLAw+U7v0xzNxMC17aAOok+jRX6qASA+LJtR
         8fVw==
X-Received: by 10.204.163.135 with SMTP id a7mr5568113bky.62.1366049340161;
 Mon, 15 Apr 2013 11:09:00 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 15 Apr 2013 11:08:20 -0700 (PDT)
In-Reply-To: <7vr4ibu14j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221278>

Junio C Hamano wrote:
> If "rebase -m" were to be taught to do this, the natural way to do
> so is to
>
>   (1) Prepare the todo the usual way
>   (2) Do those two commits for index and working tree
>   (3) Append two insns (exec reset HEAD^ and exec reset --soft
>       HEAD^) at the end of the rebase todo file.

Er, no.  I don't want to touch the instruction sheet.  It becomes
especially problematic in -i, when the instruction sheet is
user-editable.

> "rebase--am" could also be told to generate (on the preparation
> side) and notice (on the application side) a pair of patch files at
> the end that represent the index state and the working tree state
> and apply them without making the WIP part into a commit.

Ugh, no.  I don't want to leak the implementation detail of autostash
into specific rebases.  Why can't I wrap the last statment in
git-rebase.sh in git stash/ git stash pop like I did with git-pull.sh?
