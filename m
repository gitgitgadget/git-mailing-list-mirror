From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] t7006 (pager): add missing TTY prerequisite
Date: Mon, 16 Aug 2010 03:11:26 -0500
Message-ID: <20100816081126.GC17566@burratino>
References: <20100626192203.GA19973@burratino>
 <20100806023529.GB22369@burratino>
 <20100806031204.GK22369@burratino>
 <201008160921.33198.trast@student.ethz.ch>
 <20100816080709.GA17566@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 16 10:13:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okuol-0004pI-9d
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 10:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0HPINI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 04:13:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56872 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0HPINH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 04:13:07 -0400
Received: by gxk23 with SMTP id 23so1792210gxk.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IGr/zf1hxDpTARf5NyOCl4KYD7MuD2Gd0EnPsnbobOs=;
        b=bhlkvft7kJo2Jyj68bPOl9CShtYd6vmh6+kreIqmFvpjOI1m74HwPUpMp8dZlzs5XQ
         L1vXPMyHqUsRuNQvKakVvNGLHTtjFiWNpD3vecWGO5E3qor8C9Fx6IPRmwx4Qo7tQ0by
         hglPoMLAF4cyxq0V9CjI06GvkIWkpz0e7FeyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Nv8WKpy4bOmx1oo9j15kz69nxaqVIPzRfn4LpUbwPfK5w590u59v/vZQsvV3meS7jv
         1Q6UX/lYabm59QeItjZnWPMGEz67REb9U7c8zGbiuJmvUvHuDPeBFJfz3EIIMDReESKm
         f1edfNawhW4dd/X+Z7lVlfyRzU5mHs6AAipfA=
Received: by 10.151.122.4 with SMTP id z4mr4868075ybm.136.1281946385552;
        Mon, 16 Aug 2010 01:13:05 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm4399525ibh.10.2010.08.16.01.13.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 01:13:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100816080709.GA17566@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153654>

The config pagination test should not run if there is not a tty
available to force pagination on.

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This one fixes for =E2=80=9Cconfig: run setup_git_directory_gently()
sooner=E2=80=9D.

Thanks again for the report.  I=E2=80=99ll think more about how to make
problems like this easily reproducible (a test_mentions_prereq()
function?).

 t/t7006-pager.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fcd846a..fb744e3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,7 +134,7 @@ test_expect_success TTY 'configuration can disable =
pager' '
 	! test -e paginated.out
 '
=20
-test_expect_success 'git config uses a pager if configured to' '
+test_expect_success TTY 'git config uses a pager if configured to' '
 	rm -f paginated.out &&
 	git config pager.config true &&
 	test_when_finished "git config --unset pager.config" &&
--=20
1.7.2.1.544.ga752d.dirty
