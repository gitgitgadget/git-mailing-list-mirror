From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 05/12] ref-filter: introduce parsing functions for each valid atom
Date: Sun, 31 Jan 2016 23:12:49 +0530
Message-ID: <1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1v-0000Ku-Lr
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbcAaRnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:43:00 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35001 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbcAaRma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:30 -0500
Received: by mail-pa0-f67.google.com with SMTP id gi1so6165726pac.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPzOx7/bZUin3FKZnSaV5j5DZUIKXkGlTgjjg2J01wo=;
        b=OodEN/igb/NQgJuXuDzdaWzm/N5fhZ/AkZxpNKMSYOmGf5R9DYV9Zvk8X0GWNtt4E8
         59sGkg7qIxOZheiOYuaclFBdsLKtuD9S+5Ol8xJy0ey6ikolCzu0xCUp2mZhfFh4OFvy
         2hc3CLAD/3wOUZjMVqaxClBU5NAem7jSIkyAPuaSHtdJ1+gBvLstDmHWwdpaucINHmJ+
         pdpI4YtVIHPgaT+NVvq1dMfmNS4JZui9Sk+wQhc9LXAL/ywNsfLOkNa937uBzabo9QxB
         cCakMdpml44dLA54cJBhNW5//J/6tErmuIO//W/lWMHlyBiX/L0xHqvoDNaF/MA2tuJG
         Dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPzOx7/bZUin3FKZnSaV5j5DZUIKXkGlTgjjg2J01wo=;
        b=TVwOKp2rWx9y4wTz/8EyccXE2fx7Oto8xTkDuutIoKopQq1WGQ9E1YV7smaVLCDHOk
         BPuKwiKHuHj9LuKLl6xI1dhTgTkejNgqVnlT1bImwfcVFlU5VvPz8hffyZPnvDPZIoCl
         s8mFfLBy6U97BT9WTwB+kWC44yvJEafl/YjAC+FHTZ1GZKKrFrzwf0LYRdnIAW8m61Zb
         tzBt1E7RKrOjO/bwwcWz1i9RcetGZxO0KkrKXkqmrDAMrRfLISW3bA2nglzQFctYKbJv
         Gi58pP3PqjNgHEqWhyc6jp1RReaOT/DFwuGwbH8u4hJ1gcfm9xAZ1YCO2O2DyWXo9s3v
         AXJQ==
X-Gm-Message-State: AG10YOTC3ktBvwyFo1MdJmu5fv92Qs/kT4lPrVgdWw1vPaJsz25v1PklPfq09wH5gUMLaQ==
X-Received: by 10.66.235.162 with SMTP id un2mr31224924pac.17.1454262150198;
        Sun, 31 Jan 2016 09:42:30 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:29 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285165>

Parsing atoms is done in populate_value(), this is repetitive and
hence expensive. Introduce a parsing function which would let us parse
atoms beforehand and store the required details into the 'used_atom'
structure for further usage.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3736dc3..92b4419 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -36,6 +36,7 @@ static int need_color_reset_at_eol;
 static struct {
 	const char *name;
 	cmp_type cmp_type;
+	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
 	{ "refname" },
 	{ "objecttype" },
@@ -114,6 +115,7 @@ struct atom_value {
 int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
+	const char *arg;
 	int i, at;
 
 	sp = atom;
@@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		 * shouldn't be used for checking against the valid_atom
 		 * table.
 		 */
-		const char *formatp = strchr(sp, ':');
-		if (!formatp || ep < formatp)
-			formatp = ep;
-		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
+		arg = memchr(sp, ':', ep - sp);
+		if ((!arg || len == arg - sp) &&
+		    !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
@@ -154,6 +155,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	if (arg)
+		arg = used_atom[at].name + (arg - atom) + 1;
+	if (valid_atom[i].parser)
+		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(used_atom[at].name, "symref"))
-- 
2.7.0
