From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH 1/5] bisect: read bisect paths with strbuf_getline()
Date: Sat, 30 Jan 2016 19:03:47 +0100
Message-ID: <56ACFB03.3020000@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 19:06:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPZuj-0007JI-G7
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbcA3SGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:06:10 -0500
Received: from moritzneeb.de ([78.47.1.106]:48375 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932979AbcA3SGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:06:04 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id 13A481C02A
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 19:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454177163;
	bh=bw8gWORyb1nQlnhSxzAv1E4UsgHN++Wu2MOy++VDsY4=;
	h=From:Subject:References:To:Date:In-Reply-To:From;
	b=WYE6dwAaaHRQvfkew8l8nvDdQuRqS77aWkZh1O/c4Kjm7BR9nhVk9msEWJp2d5Kap
	 ngFemm6lTRmIaHqjZF1c/hluwKp0gsJtPJAnZZ6L9cvhzEkUN+3Efw+L6RmF5PlAtU
	 OOd+oJu8NEL07z4Atjp9cpjos7i62r4a4UZuB4hM=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACF82B.2030005@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285120>

    The lines read from BISECT_NAMES are trimmed with strbuf_trim()
    immediately. There is thus no logic expecting CR, so
    strbuf_getline_lf() can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 06ec54e..bf7c885 100644
--- a/bisect.c
+++ b/bisect.c
@@ -440,7 +440,7 @@ static void read_bisect_paths(struct argv_array *array)
 	if (!fp)
 		die_errno("Could not open file '%s'", filename);
 -	while (strbuf_getline_lf(&str, fp) != EOF) {
+	while (strbuf_getline(&str, fp) != EOF) {
 		strbuf_trim(&str);
 		if (sq_dequote_to_argv_array(str.buf, array))
 			die("Badly quoted content in file '%s': %s",
-- 
2.4.3
