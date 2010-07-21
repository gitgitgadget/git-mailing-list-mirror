From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] gitweb: clarify search results page when no matching
 commit found
Date: Wed, 21 Jul 2010 14:50:36 -0500
Message-ID: <20100721195036.GA1825@burratino>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
 <AANLkTinhyFD4RhLLxS-jj-oX5VWqGyy7AiXJ3VJlcU2W@mail.gmail.com>
 <20100721152311.GA12726@burratino>
 <201007211951.18439.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Erick Mattos <erick.mattos@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 21:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObfKh-0005R2-AX
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 21:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759064Ab0GUTvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 15:51:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60035 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758957Ab0GUTvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 15:51:45 -0400
Received: by ewy23 with SMTP id 23so2600270ewy.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zhSUMi5t59tyM0GF/IrPb7JLOK3SccOK/KFdNDbithI=;
        b=mfGNJW1ZZaHMKmtpwpyLbGoDz4LCPQ8VSbSoZVk+OGW6IPflXGIubscyPWwlzD/Fnh
         V/GOupfCEMPJWbiad1+Q9ctkdAay20/3F+7x61xE/PtlygYWMKDVN0jouII0XTz2jhQG
         cdRNFZtEcGRkvFSjMiDlYJuvlyZtwGjAwVjrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=x8v/PXoMHUET8Cjs+Fkx71e1cwcDyLwpWIOgyayrCUgYCB8g3RGiC4DzREckZYxUbO
         zz9roA5lbem3d/bWBX2Um8cFjy/QcCoHHrwb0WYLUXZzPN0sgKFcXXpmzSV/byn6IAUF
         qPCJF9HfxVz+Io/APx2TjKUes2QD4f97ZYUO0=
Received: by 10.227.138.76 with SMTP id z12mr700283wbt.60.1279741903625;
        Wed, 21 Jul 2010 12:51:43 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id u32sm3597903weq.35.2010.07.21.12.51.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 12:51:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007211951.18439.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151414>

When searching commits for a string that never occurs, the results
page looks something like this:

	projects / foo.git / search                                 \o/
	summary | ... | tree          [commit] search: [ kfjdkas ] [ ]re
	first =E2=8B=85 prev =E2=8B=85 next

	Merge branch 'maint'

	Foo: a demonstration project

Without a list of hits to compare it to, the header describing the
commit named by the hash parameter (usually HEAD) may itself look
like a hit.  Add some text (=E2=80=9CNo match.=E2=80=9D) to replace the=
 empty
list of hits to avoid this confusion.

While at it, remove some nearby dead code, left behind from a
simplification a few years ago (v1.5.4-rc0~276^2~4, 2007-11-01).

Noticed-by: Erick Mattos <erick.mattos@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:

> Very good idea

Shoddy implementation, though.  Apparently (yes, I should know this;
and testing reminded me before I sent the wrong patch) the index of
the last element ($#array) of an empty array is -1, not 0.

Sorry about that.

 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cedc357..801575d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6522,12 +6522,13 @@ sub git_search {
 			$paging_nav .=3D " &sdot; next";
 		}
=20
-		if ($#commitlist >=3D 100) {
-		}
-
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-		git_search_grep_body(\@commitlist, 0, 99, $next_link);
+		if ($page =3D=3D 0 && !@commitlist) {
+			print "<p>No match.\n</p>";
+		} else {
+			git_search_grep_body(\@commitlist, 0, 99, $next_link);
+		}
 	}
=20
 	if ($searchtype eq 'pickaxe') {
--=20
