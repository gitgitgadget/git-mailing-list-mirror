From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: git show doesn't work on file names with square brackets
Date: Sat, 6 Feb 2016 16:16:35 +0300
Message-ID: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS2jo-0005Vg-Jn
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 14:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbcBFNQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 08:16:41 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34893 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbcBFNQk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2016 08:16:40 -0500
Received: by mail-lf0-f51.google.com with SMTP id l143so72647567lfe.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 05:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=GPTWh+G4GykZxuYZAIBGo4zEoIAzLyUF8oHf3IvB8ME=;
        b=W5Y1v3FLpkIe1+rggoPhZPNR+msG36JDWSt31Hdwvwe/sKc/N2vpUvbLmwf3gAis7v
         0GNfrebonfSnCpCiKe+g6wLbdXRiSC6mpX7A1bmo7zDGwXFGDG/I3bCJuIiYpm6kkPoj
         p+gWFk33z3LhM1yIYza9BfgQshOFOGSv92NOm4qpnFJg9AkRd2qTdPz8P/c1e2IRa7DB
         kSPRzGGmcuJD8Tz+coFEUZO7oZTgJ27989MYzweeeGsaD91qCHZmCa9ah0eDHx6YXvTw
         iDYyt1LEcgDjquXzFvYuqKVafvF4t7ivKhSC77s+kNYfhkYhCjrXhcob9faA4ViBvAfP
         uQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=GPTWh+G4GykZxuYZAIBGo4zEoIAzLyUF8oHf3IvB8ME=;
        b=dpYE4pfuFNHv//AnloCrwaf1OAplEve79eNDtWlWNftUl7fk56vdvtMkUjDR0qve5U
         GNj4Iaue4tFU9uTFCgUesBlafli3H2K4Lr8MqQ3N77aUBv8jVlugFe5CcduHbIUHl5SI
         Ay8eMMKwKXiXvoXwpCeN5dm2IKkBJnc7+MrbDAv2h7aVaxREOpl7pDOzvPgM2uCGL5HM
         2J6JwXXCbCsew9BmJHSAtXpb3zQh6j463LdJGEUchAyDMkWPTjqcKDUMYL9yd7uZasyT
         QKbyF2JA6WHWZkVJAO05AluCxTzn+PYzgWAjmDfAJRj2O4/IN6sauFQsEHqIbSYCoPpj
         D2oA==
X-Gm-Message-State: AG10YOQ4kQ6H3K8nXdUJ2v5kL123kmDODg8bs2fv1zPTtMB4A0phSxcvMo2NJN+KQVuHUNFq
X-Received: by 10.25.154.20 with SMTP id c20mr6956088lfe.79.1454764598122;
        Sat, 06 Feb 2016 05:16:38 -0800 (PST)
Received: from loki.labs.intellij.net ([80.76.244.114])
        by smtp.gmail.com with ESMTPSA id rx3sm2732352lbb.35.2016.02.06.05.16.36
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Feb 2016 05:16:37 -0800 (PST)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285686>

I=E2=80=99ve faced a problem that `git show <rev>:<filename>` returns a=
n error when <filename> contains square brackets.

Interestingly, the problem is reproducible on "GNU bash, version 3.2.57=
(1)-release (x86_64-apple-darwin15)", but not on "zsh 5.0.7 (x86_64-pc-=
linux-gnu)=E2=80=9D. The problem is also reproducible when called from =
a Java program by forking a process with given parameters.

Is it a bug or I just didn=E2=80=99t find the proper way to escape the =
brackets?=20

Steps to reproduce:

    git init brackets
    cd brackets/
    echo =E2=80=98asd=E2=80=99 > bra[ckets].txt
    git add bra\[ckets\].txt
    git commit -m initial
    git show HEAD:bra[ckets].txt

Error:
fatal: ambiguous argument 'HEAD:bra[ckets].txt': both revision and file=
name
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]=E2=80=99

Neither escaping, not quoting doesn=E2=80=99t help:
    git show HEAD:bra\[ckets\].txt
returns the same error

    git show "HEAD:bra\[ckets\].txt=E2=80=9D
returns empty output

Thanks a lot!
-- Kirill