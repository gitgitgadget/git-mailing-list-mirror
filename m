From: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Tue, 24 May 2016 14:48:14 -0500
Message-ID: <20160524194814.GA12479@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 22:05:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5IZc-0007eD-GW
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 22:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbcEXUEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 16:04:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34839 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbcEXUEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 16:04:47 -0400
Received: by mail-it0-f66.google.com with SMTP id z123so2997627itg.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zPdzGFMvjZ8aONPp9MqoKIgHDVm6FGRebV+wepcY6ic=;
        b=KKaM/Z44wGssooUA4rdzB8dnkT0cR/U4e4cv8oRkvddHE90seTMPOfqaSmDH57bBuD
         E3MIplrdtvHPLuDTVVeivYoQQZbyJTNncaue2z8kpkwGDFkXOI4HPv9hkFp4U+rmduul
         Z+0sBO6fQZKMM5y4u5gUeafHcOU+WiM6x7ktwTalp7kRMgD8o8lIJdlOYg7+RkcbbGBy
         EdvPqNEQX5lLiR49kqZ8L9hmzL9Thf0etrxC0qpV3KBWq8qmSuNQOeg6h1qVUedPNMIG
         PinZ3XgB9akLCF2U4suSEFEwN17ukbhWjm0W/qv1fOukgTIPnDud1l57UQOrg3zpaQk4
         tqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zPdzGFMvjZ8aONPp9MqoKIgHDVm6FGRebV+wepcY6ic=;
        b=Vwz7ln90HUD11yDAnYx6NHuknZc/pRoI+WDy0H1pULTvWtvS9FcQZwlreT+D+SvoZY
         A6zznf2gGVBC3t4ijWKtuZ58WVaq/lUsYFNp6beQEtnXt8BjGGARFU+dnX8jmVQhuAkm
         P9t7kaZehpVMpAmkcALIXbOxjYSyO+slz+h6SG+DXOdpkm+yiQQQeh1U18ZBpa9EDkH6
         QYD9VP3HsGu1lK+VLYoyHfC60FELe1joLSINGHgo4woLWRGz77SuVmsYR75b8V/7b8cs
         HoSVePGd8T08iNpqrWh71g26bli8OhWYuIFrLl0D94FDbWn3ouYjTSzxgzSzTG9dIA4P
         9M+g==
X-Gm-Message-State: ALyK8tKVYBw62CdNeqa3lm6xUptm8w3oKGIaNKw7aZHzod7JOUAVKdWcn1hg1F+NeWO1MA==
X-Received: by 10.36.155.84 with SMTP id o81mr459700itd.55.1464119298040;
        Tue, 24 May 2016 12:48:18 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:518c:7508:4f1a:1942])
        by smtp.gmail.com with ESMTPSA id l123sm5524353ita.1.2016.05.24.12.48.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 12:48:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295530>

Check that we are configured to display colors in the given context when
the user specifies a format string of `%C(auto)`, instead of always
displaying the default color for the given context.  This makes
`%C(auto)` obey the `color=auto` setting and brings its behavior in line
with the behavior of `%C(auto,<colorname>)`.

This allows the user the ability to specify that color should be
displayed for a string only when the output is a tty, and to use the
default color for the given context without having to hardcode a
color value.
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
