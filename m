From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 0/8] Highlight interesting parts of diff
Date: Wed,  4 Apr 2012 21:57:05 +0200
Message-ID: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWKb-0001W3-Us
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595Ab2DDT5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 15:57:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59188 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586Ab2DDT5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:57:20 -0400
Received: by wejx9 with SMTP id x9so409927wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NMxnNTcituFKpMGq+SG8K6llZp/79UXj0leIcYqJTdg=;
        b=USx9Y0ioyQvqZZvy0JDN9bXIk/COo8nhX30hRzvOngQ+JNVenlEkaKNDOUPkcNUX2v
         fFv7Bon3U3mvv3htn+6tklznkPCeWmLhn47sSArz2w+VRtoqV2073oEDlYhaI1sKs4I5
         8i1xWTZc0ZTzuoHkQTtVneKrk3XiIryENWpbH0rZrGwWsLqxAa7NdfWO/uQ23JDo5H6a
         JeT0pov/pv5ILK1chWtrK73ZkIuPs5LjqY0c2o215cw1kzVcEjLk+qZ8yji7WOmBjIj7
         ChFaVFVk0s8ysYHwwoHBrHqfrs3QDpA/eFuIglihexSxyiTiuC8eguJU7MF7a9jK4pWy
         JPWg==
Received: by 10.216.134.136 with SMTP id s8mr2224761wei.6.1333569438925;
        Wed, 04 Apr 2012 12:57:18 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n20sm6710584wiw.5.2012.04.04.12.57.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:57:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194724>

Reading diff output is sometimes very hard, even if it's colored, espec=
ially if
lines differ only in few characters. This is often true when a commit f=
ixes a
typo or renames some variables or functions.

This patch series teaches gitweb to highlight fragments that are differ=
ent
between old and new line. This should mimic the same feature in Trac or=
 GitHub.

Changes since v2:

* Added first patch (gitweb: Use descriptive names in esc_html_hl_regio=
ns())
  suggested by Jakub.

* Squashed patches (gitweb: Move HTML-formatting diff line back to
  process_diff_line()) and (gitweb: Push formatting diff lines to
  print_diff_chunk())

* Reauthored patch (gitweb: Pass esc_html_hl_regions() options to esc_h=
tml())
  to Jakub.

* Fixed typos in commit messages and added comments based on Jakub's re=
view.

* Added Acked-by from Jakub.

* Fixed minor issues in code pointed by Jakub (hopefully all; I had to =
drop
  few due to overlong lines etc).

* Renamed format_rem_add_line() to format_rem_add_lines_pair().

* Renamed $prefix_is_space and $suffix_is_space to $prefix_has_nonspace=
 and
  $suffix_has_nonspace and simplified a condition

* Moved untabify() and chomp() back to format_diff_line() and introduce=
d in
  format_rem_add_lines_pair().

* Made red and green background a bit brighter.

Jakub Nar=C4=99bski (1):
  gitweb: Pass esc_html_hl_regions() options to esc_html()

Micha=C5=82 Kiedrowicz (7):
  gitweb: Use descriptive names in esc_html_hl_regions()
  gitweb: esc_html_hl_regions(): Don't create empty <span> elements
  gitweb: Extract print_sidebyside_diff_lines()
  gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
  gitweb: Push formatting diff lines to print_diff_chunk()
  gitweb: Highlight interesting parts of diff
  gitweb: Refinement highlightning in combined diffs

 gitweb/gitweb.perl       |  319 +++++++++++++++++++++++++++++++++-----=
--------
 gitweb/static/gitweb.css |    8 +
 2 files changed, 241 insertions(+), 86 deletions(-)

--=20
1.7.8.4
