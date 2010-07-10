From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cutting history
Date: Sat, 10 Jul 2010 20:12:01 +0000
Message-ID: <AANLkTilcw6gpGI1TO_iRmComID3n0w2biox0ac1uzNyU@mail.gmail.com>
References: <20100710032553.GB554@nibiru.local>
	<4C37F24E.30407@workspacewhiz.com>
	<m3tyo7lo6n.fsf@localhost.localdomain>
	<AANLkTikY8RKseD8K4RVrLHnSdW_Su8hVRPRFkzzz1rGv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, weigelt@metux.de,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 22:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXgPC-00084o-39
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 22:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0GJUMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 16:12:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34879 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab0GJUMC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 16:12:02 -0400
Received: by iwn7 with SMTP id 7so3371412iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S2Cf7n+GADYBASLKnQKZIQsVf2VHdZl89tf8BMIXb/s=;
        b=nodiblxUFSBHQpd177tmssMXjSkK5usmSX1Ok1ix+antaZT2aKxTrFEkm3olD3tBu6
         bGz8TXPzeBYM2U/gYW9mF9/q4cF31O2M0j6Yze6hreqRd0NFd2E8s3+r3hhOPKST7qvj
         Eg8By5lJGEFWQlfacJcpE9KXu8C1OhluasqxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jzJRh/Y6gWKrJU739OoY7sKZkr2rSJ7yzaJNZX6S76fRNRw9dd7O9TyVMQUlnW7htM
         t8dACEa3CWaStgG8E0KkjnnISESXfaT0QaGlaNDtKnY869KwjyprNRqx1+jtvzePdvvc
         Ubk1OxATX+AI8jfHkoRUKQ57nc+PYvZbIWVko=
Received: by 10.231.161.68 with SMTP id q4mr12247483ibx.79.1278792721475; Sat, 
	10 Jul 2010 13:12:01 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 10 Jul 2010 13:12:01 -0700 (PDT)
In-Reply-To: <AANLkTikY8RKseD8K4RVrLHnSdW_Su8hVRPRFkzzz1rGv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150729>

On Sat, Jul 10, 2010 at 11:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> As for pruning old history, I thought this *should* work for pruning
> history older than 7 days (given that you dump daily):
>
> =C2=A0 =C2=A0git rebase --strategy=3Dbase --onto master~8 master~7
>
> But of course that deletes new commits. I need to freshen up on my
> rebase understanding. Maybe someone else on list knows how to do
> that. I thought git rebase --interactive might work, but I can't get
> it to display the root commit. Maybe you need git-filter-branch.

Thiago Macieira on #git provided the answer. You can do that with
grafts and git filter-branch. E.g. rewriting the history so that you
only have the 7 latest commits:

    git rev-list HEAD | sed '7q;d' > .git/info/grafts &&
    test -s .git/info/grafts &&
    git filter-branch -f HEAD
