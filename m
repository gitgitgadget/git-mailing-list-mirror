From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/4] ls-remote: introduce symref argument
Date: Sun, 17 Jan 2016 12:03:58 +0100
Message-ID: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:03:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKl7e-000505-R8
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbcAQLDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:03:46 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35123 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcAQLDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:03:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so3885025wmz.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NcV45ghfYJeOONCACLUcXpEmTaiyDhIPx1odBHD4Bmo=;
        b=rWf941nX266VS1jU655E/CM1f6c3NP8JCbspnf8RZS+yrD9bUsS4Hq66w3e5K4WJ0a
         LDigQqnZXP9kRZK9vWL4kpkm2EiyPhJvvcNanD/R3T99u5ND9FEH2SkFxnjjsPDQioNL
         QeSdel9rHxOCTdJYZkULYPU0yy7fA9Qx+fnPrVleXvJCcNlp66RhWBLLC/bnKZZFl77g
         4nnaKEwynswAp07dB2dpFERF0DGDy79C0FsmvanD8DowvArGAp0+1LSyHgzNksTKHB9f
         97DuefwfHtvVZLR+Ufrb1I4XDPDDFQUxMK7+crf5XMsBoTNuGWGtAcjWmBU7hW+wpDni
         F8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NcV45ghfYJeOONCACLUcXpEmTaiyDhIPx1odBHD4Bmo=;
        b=li7dFCF2BhLdAEolxOd2v/ulMYFJfiaJ6kPLIin8s9orO+pMTTEFyTnRGHunXbZWyv
         PCF0MJjAq0wXywICXl0yAElX16ioXOl1R0AsbphhwXRXlId6vfSAwIhozauPvQ+XfvmX
         lxbP5HAc9qkSCoZlIOaKJUNP957lZGph5Ek5ah+8EIGZ5MwGqi5ArWUc6qEs/DyNLkNG
         5axtAVqRSGLYbcIbOA2zYEkJ0MEYEMWMZgCNuyvvl+S2IQWXjeVrGfB7887o+ROEOm0a
         aDGGxOl9cy82T3jYNu9oIRvObHpdxgMpcE+O1kvz3IHu1dU5MsgKrI20bURumQyJjiU9
         HflA==
X-Gm-Message-State: AG10YOTKLYUyZ/wfN0RZSYzDaHcaWFareJqUiJms4ru0saMFLa938cL4KoFEVqCHBxi3Tw==
X-Received: by 10.28.47.213 with SMTP id v204mr7238257wmv.69.1453028624803;
        Sun, 17 Jan 2016 03:03:44 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id ka4sm18780560wjc.47.2016.01.17.03.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:03:42 -0800 (PST)
X-Mailer: git-send-email 2.7.0.14.g2b6d3d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284248>

> I thought it might be nice for any porcelain which tries to wrap
> `ls-remote`, make some decision based on the capabilities, and then
> invoke another plumbing command. But I guess that is probably slightly
> crazy, and nobody is doing it.
> 
> Something like `ls-remote --symrefs` probably would be a better place to
> start.

Turns out adding this is pretty simple.

The first two patches are documentation, which I noticed when reading
up about the command.  Patch three is a cleanup patch, which makes
ls-remote use the parse-options api instead of the hand-rolled option
parser.  Patch four is actually adding the option.

Thomas Gummerer (4):
  ls-remote: document --quiet option
  ls-remote: fix synopsis
  ls-remote: use parse-options api
  ls-remote: add support for showing symrefs

 Documentation/git-ls-remote.txt | 12 +++++-
 builtin/ls-remote.c             | 90 +++++++++++++++++------------------------
 t/t5512-ls-remote.sh            | 20 +++++++++
 3 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.7.0.14.g2b6d3d6
