From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/2] clear environment for submodules
Date: Tue, 23 Feb 2010 09:30:27 +0100
Message-ID: <1266913829-14533-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a1002222355s38fda032g99623f44d6200fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 09:30:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjqAE-0007zz-PN
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 09:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0BWIai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 03:30:38 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-fx0-f219.google.com ([209.85.220.219]:32945 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab0BWIah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 03:30:37 -0500
Received: by fxm19 with SMTP id 19so3486551fxm.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vLeKcFNjCw++INewpCA9tfYRxpdhUZl3kaHjxyBGJnY=;
        b=Yr0Uzj+k0yF2h54TCpe2eR4Pe8hGXALh9Dwth9JaywKehA5WOXOdywSLSoscGeU7wY
         pH+TCO7SS+ykBsEr6TUfhiyNiKk1xhjziWf9r45w8NbLbX/+a0xxYeBgOCZiWfwu/MAZ
         0/nlDMQqhwdp9JBkkQgJ7xK3rpAceHdi7NDcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AnyiAt2kiey51djvP+44BaLI1mgz/M+ysUpkT0DVQODYTesoi13ZSRpHZW22w1FHC1
         fWJ6zthD8dr9+ERB/qwzBtTS0URQ4EjVmUNEHlKpgMIuQOFs3ieGdbQ0BNCyHqC/zQdh
         4NVH9w0R+VLIzvqOuoDRuZkaWZ3EWMBrWEuZQ=
Received: by 10.216.91.16 with SMTP id g16mr374991wef.102.1266913835281;
        Tue, 23 Feb 2010 00:30:35 -0800 (PST)
Received: from localhost ([151.60.177.169])
        by mx.google.com with ESMTPS id t12sm16757403gvd.7.2010.02.23.00.30.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 00:30:34 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <cb7bb73a1002222355s38fda032g99623f44d6200fbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140774>

Second (or maybe actually third) iteration of the series to ensure that
submodules work correctly when repo-local environment is set. The only
thing changed from the previous iteration is an extra variable in
clear_local_git_env() to bring it up in sync with the list in git_conne=
ct(),
and also the addition of CONFIG_ENVIRONMENT in git_connect() itself.

I had considered making a static list of these variables somewhere, but
making it accessible to both the built-ins and shell scripts (something=
 =C3=A0
la git rev-parse --local-git-env maybe?) is a little over my head at th=
e
moment (not much free time to dedicate to git, sadly). Also I'm not sur=
e
the extra git call needed to get the list would be worth it.

Giuseppe Bilotta (2):
  shell setup: clear_local_git_env() function
  submodules: ensure clean environment when operating in a submodule

 connect.c        |    2 ++
 git-sh-setup.sh  |   15 +++++++++++++++
 git-submodule.sh |   20 ++++++++++----------
 3 files changed, 27 insertions(+), 10 deletions(-)
