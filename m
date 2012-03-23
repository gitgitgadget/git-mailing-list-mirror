From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 0/8] gitweb: Highlight interesting parts of diff
Date: Fri, 23 Mar 2012 23:56:49 +0100
Message-ID: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQ0-00063W-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab2CWW5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:05 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab2CWW5C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:02 -0400
Received: by wejx9 with SMTP id x9so2998508wej.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TMoaMYc7Ew7FKqfUj7PDQJEp1o4T1lIvCm6wN88FBvM=;
        b=StWBgg3k1D64x87oP7kIsk5IZ95GgQPYCas7Ks6rnie1G/lNTxketzmVTc4spPIZxS
         qhKrJKwsz6M6GI87Ej8Oxedu4ViyIXDgF8zAqqCF983Uiu0du0cBwNskw6jNCxU89weW
         8ALvge4hd55ByL2du2KFC8DcHdjohTtNCfI9B/q7XgjxTzjycOiLofkEZrx/9J4xxy7g
         arcM2VaEOTYfVyzwyB/e3Pma/PGCBNqjjjqwBPvdeNCuva5q5KNdVGIB+dR4VGzPD/cl
         bRZidT+ToFx3Shr8zsFthRheuz7M0PBCr0fYVHigYUYZj/UhPR0ymxqD8rs1jJBSS9v0
         irIg==
Received: by 10.180.80.70 with SMTP id p6mr671536wix.21.1332543421231;
        Fri, 23 Mar 2012 15:57:01 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id k6sm17628916wie.9.2012.03.23.15.57.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193804>

Reading diff output is sometimes very hard, even if it's colored, espec=
ially if
lines differ only in few characters. This is often true when a commit f=
ixes a
typo or renames some variables or functions.

This patch series teaches gitweb to highlight fragments that are differ=
ent
between old and new line. This should mimic the same feature in Trac or=
 GitHub.

Changes since v1:

* Rebased on origin/master.

* Added two patches at the beginning of the series.  First one is a sma=
ll fix
  and second one adds a feature to esc_html_hl_regions() that will be n=
eeded
  by later patches.

* Squashed patch "gitweb: Format diff lines just before printing" and r=
eworked
  changes to format_diff_line().  Now it accepts both raw line that nee=
ds to be
  html_esc()'ed and already escaped line.

* Squashed changes in CSS with previous patch as proposed by Jakub.

* Dropped esc_html_mark_change() and started using esc_html_hl_regions(=
)
  because it was merged to origin/master.

* Fixed highlightning for combined diffs with more than two parents.

* Fixed indentation (tabs -> spaces) in conditions.

* Ensured that patches with "\ No newline at end of file" are properly
  displayed.

* Ensured that binary patches are not supported in HTML format, thus th=
is
  series canot break it :) (answering Jakub's questions)=20

* Reworded some commit messages and fixed typos.

* Renamed few variables after comments from Jakub.

* Added some comments to the code.

* Added Acked-by from Jakub for few patches.

Micha=C5=82 Kiedrowicz (8):
  gitweb: esc_html_hl_regions(): Don't create empty <span> elements
  gitweb: Pass esc_html_hl_regions() options to esc_html()
  gitweb: Extract print_sidebyside_diff_lines()
  gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
  gitweb: Move HTML-formatting diff line back to process_diff_line()
  gitweb: Push formatting diff lines to print_diff_chunk()
  gitweb: Highlight interesting parts of diff
  gitweb: Refinement highlightning in combined diffs

 gitweb/gitweb.perl       |  299 +++++++++++++++++++++++++++++++++-----=
--------
 gitweb/static/gitweb.css |    8 ++
 2 files changed, 225 insertions(+), 82 deletions(-)

--=20
1.7.8.4
