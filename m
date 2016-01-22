From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2 1/2] submodule: port resolve_relative_url from shell to
 C
Date: Fri, 22 Jan 2016 20:03:59 +0100
Message-ID: <56A27D1F.60007@kdbg.org>
References: <xmqqa8o188i0.fsf@gitster.mtv.corp.google.com>
 <1453255396-31942-1-git-send-email-sbeller@google.com>
 <1453255396-31942-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:04:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMh0B-0002cR-VK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbcAVTED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:04:03 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:14199 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbcAVTEC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:04:02 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pn94027dsz5tlB;
	Fri, 22 Jan 2016 20:04:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id C371053A9;
	Fri, 22 Jan 2016 20:03:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1453255396-31942-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284583>

Am 20.01.2016 um 03:03 schrieb Stefan Beller:
> +static char *last_dir_separator(char *str)
> +{
> +	char *p = str + strlen(str);
> +	while (p-- > str)
> +		if (is_dir_sep(*p))
> +			return p;
> +	return NULL;
> +}
> +

I just noticed that we already have this function. Please squash in the
following.

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1484b36..92d7d32 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -51,21 +51,12 @@ static int starts_with_dot_dot_slash(const char *str)
 	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
 }
 
-static char *last_dir_separator(char *str)
-{
-	char *p = str + strlen(str);
-	while (p-- > str)
-		if (is_dir_sep(*p))
-			return p;
-	return NULL;
-}
-
 /*
  * Returns 1 if it was the last chop before ':'.
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
-	char *rfind = last_dir_separator(*remoteurl);
+	char *rfind = find_last_dir_sep(*remoteurl);
 	if (rfind) {
 		*rfind = '\0';
 		return 0;
