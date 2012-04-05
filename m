From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3 7/8] gitweb: Highlight interesting parts of diff
Date: Thu, 5 Apr 2012 08:25:57 +0200
Message-ID: <20120405082557.7223ff6e@mkiedrowicz.ivo.pl>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1333569433-3245-8-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 08:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFg9g-0006Su-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 08:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab2DEG0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 02:26:18 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41888 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab2DEG0L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 02:26:11 -0400
Received: by wibhj6 with SMTP id hj6so1270382wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=8kpVkItTeHyj8xCzKKTRJwscRmlAGF8BecKdcm0armI=;
        b=GSQMaeC5cKh7Gg+z5VZAlVrD8yi9+p/Sej2Nukc/vVU4JT+K3ZHEfer2WQLSfpGUEv
         MSaPl4K5RfpElYppsr5v9UnXY5fnJrbqomjSBrGwcLecunH8g/biUPL45pj+GfishGwp
         4AwA4o44rh+p0tilMC/rB74kA/mwjxpFE5t0RXrXngoNRsnEEMCbz3RyAGA38d5x77+j
         cRlyOSeNT82n4toYvCaRABvW8czuJuLGL05s3XVvgWaPByf8Vg1IJtSSMMg7ABh/DRqJ
         zRG+Hf8dP+3Ox4iys2KClFY3li+Z52QkUadkY4TR6YlXcisxDAquExh84MRGwqno7B1o
         eTnw==
Received: by 10.180.104.230 with SMTP id gh6mr1760065wib.22.1333607168457;
        Wed, 04 Apr 2012 23:26:08 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id ea6sm11009187wib.5.2012.04.04.23.26.06
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 23:26:07 -0700 (PDT)
In-Reply-To: <1333569433-3245-8-git-send-email-michal.kiedrowicz@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194762>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> wrote:

> Reading diff output is sometimes very hard, even if it's colored,
> especially if lines differ only in few characters.  This is often tru=
e
> when a commit fixes a typo or renames some variables or functions.
>=20
> This commit teaches gitweb to highlight characters that are different
> between old and new line with a light green/red background.  This
> should work in the similar manner as in Trac or GitHub.
>=20
> The algorithm that compares lines is based on contrib/diff-highlight.
> Basically, it works by determining common prefix/suffix of
> corresponding lines and highlightning only the middle part of lines.
> For more information, see contrib/diff-highlight/README.
>=20
> Combined diffs are not supported but a following commit will change
> it.
>=20
> Since we need to pass esc_html()'ed or esc_html_hl_regions()'ed lines
> to format_diff_lines(), so it was taught to accept preformatted lines
> passed as a reference.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

Junio,

can you please fixup this patch?  I just noticed "chomp $rem, $add" bre=
aks
the testsuite.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4351fe..961fbdc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5067,7 +5067,8 @@ sub format_rem_add_lines_pair {

        # We need to untabify lines before split()'ing them;
        # otherwise offsets would be invalid.
-       chomp $rem, $add;
+       chomp $rem;
+       chomp $add;
        $rem =3D untabify($rem);
        $add =3D untabify($add);
