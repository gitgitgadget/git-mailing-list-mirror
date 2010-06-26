From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] git --paginate: do not commit pager choice too early
Date: Sat, 26 Jun 2010 14:22:03 -0500
Message-ID: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 21:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSaxN-0007Su-Pk
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 21:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0FZTWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 15:22:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43845 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0FZTWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 15:22:19 -0400
Received: by iwn41 with SMTP id 41so3105102iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=iM3xGVe6aHpAhNc/BXGwK08BWUfeGBCgOC6iPMDGSYE=;
        b=rwuroN11TAl/36H2+0osuY6JekZuyFMvYyksoOIEdJEJsdN0ZxHDx/0THkzeER3nBX
         Dgyydq3XuwDhdNt2QUYc4OOB8i+HanJp4GHUW27G8I4SctVehCqAJjmUaytqYinHQau6
         WFLr7V2KIdG+ILC+JtwdTw6qUQXK+BYQy0RgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=mU/TGzNa9I2WpqHQOyJFQHleua5jSkTEavyLWd5E3hiWIiE+9eZg5qMH6UJzKRYrMk
         Han2Vf3vBIOXQkPO93OTSDojMz9cIv2ZvtAbtKBDAAPnd9O7yuWlwGFEEnWZObI6FEoC
         v84iH0ZJaJ+suok6naBtUaHOGRMp+Ev7k208I=
Received: by 10.231.12.76 with SMTP id w12mr2546305ibw.83.1277580138813;
        Sat, 26 Jun 2010 12:22:18 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm5529944ibh.20.2010.06.26.12.22.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 12:22:18 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149771>

Here=E2=80=99s a fix from the famous setup cleanup series[1].

The problem it fixes is somewhat obscure: =E2=80=98git -p foo=E2=80=99 =
is not paying
attention to the repository-local =E2=80=98[core] pager=E2=80=99 config=
uration when
run from a subdirectory.  But it is a real bug, and the fix gives
an example of how to deal with repository setup and should be safe.

Patch is against master.  There is a small semantic conflict with
jn/grep-open: SIMPLEPAGER should be changed to SIMPLEPAGERTTY in the
prerequisites for the test_default_pager function.  Please let me
know if I should push a merge commit to help resolve that.

Thoughts?
Jonathan Nieder (3):
  t7006 (pager): introduce helper for parameterized tests
  t7006: test pager configuration for several git commands
  tests: local config file should be honored from subdirs of toplevel

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  git --paginate: do not commit pager choice too early

 git.c            |    2 +-
 t/t7006-pager.sh |  234 +++++++++++++++++++++++++++++++++++++++++-----=
-------
 2 files changed, 182 insertions(+), 54 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/144778
