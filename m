From: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Tue, 24 May 2016 20:56:49 -0500
Message-ID: <20160525015649.GA13258@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:57:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5O4W-0003Jf-Sf
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 03:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbcEYB4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 21:56:55 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36294 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbcEYB4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 21:56:54 -0400
Received: by mail-ig0-f196.google.com with SMTP id c3so3706505igl.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7yBFVU7MNbgx78UXKEh0ibQa6Ll397PS63w+PaRsHsg=;
        b=E1WMahJ8V2p6/Uvsrz2I4oI4NxsdUe2cHCsD4DyOWrCkl9rOEbAXCt4dpepJYMgF5k
         D3RB1fsJFDJUJn1ilol6hGqqCMMqT9Fdxa9rkGkh3xWyNZasSM3vJsGMo5fo6ubV87oF
         EltXwutn/Ep+zTYWi6c6iuzZbIOtrcphscqImXRY+0KJPnI6WQj0OH1xUNxBKjyfZAVW
         wBb2InKGG0JaNN+BhnJueMVNZOXg1uW0fpFcSha3u+FTTyti2ZxHigCQOsKKiGb5Ofxr
         /YG0zF2JutQKKqbkIoZNY+lLhNDKYL9pJYT8PhJZKO63sTrv0TMcjO7lPFM5+8sF5fZ5
         zv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7yBFVU7MNbgx78UXKEh0ibQa6Ll397PS63w+PaRsHsg=;
        b=OT3ignqCinaN3HFhl74KfkJZZNymhxZ8Pk6TQhLBMsmfpeUxMz19/uYH/Bby/rILZC
         haWxAU4HxFq4zfo+x139aGoNJKtboyoEliufYnNgG2j37JH0FddxTxuO5hVnregu1A04
         jxJ3i27oCfTZWBtDEbG5UtmfOeso6ljurfDqvwsktS23sPC0pRVCkyHmnq77Ti7ZtqxA
         MXsEjntKlBI6RdrzxGgGpTUK7KjBi+PEvw5skuvsD1zAeuJttWyzwbuHQqoNbRh7BTUB
         XBrocWPX59t7QKs2qrxTPQwZZil5J7AZ/K68YgCIo3nDGbmfQqlJ1pLUu2dPrzwHhGML
         oErA==
X-Gm-Message-State: ALyK8tL8Edh0tQtFuXZ/2FMMmI5YO6hGDOC0VHx677KkCvgyz7zwnLE5g8lQx1l+xnae/A==
X-Received: by 10.50.13.106 with SMTP id g10mr1678595igc.65.1464141413278;
        Tue, 24 May 2016 18:56:53 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:6d00:4a6d:6eb7:3a46])
        by smtp.gmail.com with ESMTPSA id mx2sm2106524igb.0.2016.05.24.18.56.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 18:56:51 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295551>

Check that we are configured to display colors in the given context when
the user specifies a format string of `%C(auto)`.  This brings that
behavior in line with the behavior of `%C(auto,<colorname>)`, which will
display the given color only when the configuration specifies to do so.

This allows the user the ability to specify that color should be
displayed only when the output is a tty, and to use the default color
for the given context (instead of a hardcoded color value).

Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 87c4497..c3ec430 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1063,7 +1063,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	switch (placeholder[0]) {
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
-			c->auto_color = 1;
+			c->auto_color = want_color(c->pretty_ctx->color);
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
 			int ret = parse_color(sb, placeholder, c);
-- 
2.6.4 (Apple Git-63)
