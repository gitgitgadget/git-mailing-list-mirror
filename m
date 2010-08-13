From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: git rebase -i exec merger broke t3404-rebase-interactive.sh
Date: Fri, 13 Aug 2010 16:37:09 +0000
Message-ID: <AANLkTinzBuR+9=+PwejJVwSkUiGODaP-RC7=agyLOgMt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 13 18:37:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjxFw-0005Fc-Af
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 18:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761790Ab0HMQhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 12:37:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39481 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0HMQhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 12:37:10 -0400
Received: by gyg10 with SMTP id 10so1010245gyg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Q10o349vFZaOvVSRFHOA0KX0m32Pc5eoZUwtUzx2vuw=;
        b=MXd0z1i/RJwEp4lp3gzySLDzLyEA2nzbByt60vJNXCO4e9viooWT77AqjL+LMHCBRs
         sI7wXQISdr2AgcLyeZS2yiShZ7j6CpoCJEvhlG1ykZ37kHowwK8t51yRuJQ7F1zwEh35
         81xPDE22FyKmjW2cUknOk65yOoxklZ8pThjgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aWsjeNh1b7i87DJKwjjqg443e5k2aTPEYXT8NHxjm4pPQmNgJ5HrySxUrKSq4jvsr3
         vdSwJ8EZiNWnXa1B4RLxhjzvpjZ27YVVO8D45UvOtvG9PtJjp4ZZc80GBR5MK4DkmHoH
         0l4Tt+SjZ5mPvtirSpnihxRmsMhy2pzVtyxEg=
Received: by 10.150.53.21 with SMTP id b21mr2253747yba.350.1281717430054; Fri,
 13 Aug 2010 09:37:10 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 09:37:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153475>

39e388728 (merging git rebase -i exec support) broke the funny names
test in t3404-rebase-interactive.sh:

    expecting success:
            git rev-list A..funny >expect &&
            test_tick &&
            FAKE_LINES="1 2 3 4" git rebase -i A &&
            git rev-list A.. >actual &&
            test_cmp expect actual

    rebase -i script before editing:
    pick f6fec15 end with slash\
    pick 4f2ade4 something (\000) that looks like octal
    pick f95dfbf something (\n) that looks like a newline
    pick 0e82af6 another commit

    rebase -i script after editing:
    pick f6fec15 end with slash\
    pick 4f2ade4 something (\000) that looks like octal
    pick f95dfbf something (\n) that looks like a newline
    pick 0e82af6 another commit
    Unknown command: ) that looks like a newline
    Please fix this in the file /home/avar/g/git/t/trash
directory.t3404-rebase-interactive/.git/rebase-merge/git-rebase-todo.
    not ok - 50 rebase-i history with funny messages
    #
    #               git rev-list A..funny >expect &&
    #               test_tick &&
    #               FAKE_LINES="1 2 3 4" git rebase -i A &&
    #               git rev-list A.. >actual &&
    #               test_cmp expect actual
    #

This one breaks under bash too, does it work for you Matthieu? If so
what sort of environment are you executing it in?
