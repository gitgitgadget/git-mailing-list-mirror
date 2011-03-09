From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] i18n: add stub ngettext implementation
Date: Wed, 9 Mar 2011 04:46:23 -0600
Message-ID: <20110309104623.GB30980@elie>
References: <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org>
 <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
 <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
 <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 11:46:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxGuZ-0003iN-5V
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 11:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab1CIKqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 05:46:30 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36782 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab1CIKq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 05:46:29 -0500
Received: by gxk8 with SMTP id 8so156257gxk.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v25jfBngdw6/EWjzi9qD7lSO410KLdteJCUkltw6pq0=;
        b=StCqFJjFCGui+cBfSK7iJJX9kkd30WU/i5rMliLKoo2mugFXexqD8YPoca35MgSZCp
         Ld7aCRLL+TuJtKjHmgtrn1pfJPLHc3isACF3ORCKB96jm7AwYCZfBJuR49Tj29swzslr
         GRDv+2Z2DExjz30KaTL4voVGXalKmERPJ58mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UvIDatIf9yrcYEdQvrtrrkoRrSrwWZNWfqZVMBfMCQWKKHWDdEB2xuHQH3/1gQ00ci
         oGn7d8xJxbJCOm7XXrBcnhmLcaxqnYFVagvsHLCljHjR9i+uXa4WwbWlFQGSo3OhrnuA
         FQfLWdwCEcRf4W8LUDvcWPGpnBgJClwC5Ipis=
Received: by 10.150.200.3 with SMTP id x3mr7747179ybf.108.1299667588580;
        Wed, 09 Mar 2011 02:46:28 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.ameritech.net [69.209.61.99])
        by mx.google.com with ESMTPS id r18sm1378594yba.23.2011.03.09.02.46.26
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 02:46:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110309103104.GA30980@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168728>

From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 6 Mar 2011 14:40:05 -0800

The ngettext function translates a string representing some pharse
with an alternative plural form and uses the 'count' argument to
choose which form to return.  Use of ngettext solves the "%d noun(s)"
problem in a way that is portable to languages outside the Germanic
and Romance families.

In English, the semantics of ngettext(sing, plur, count) are roughly
equivalent to

	count == 1 ? _(sing) : _(plur)

while in other languages there can be more variants (count == 0; more
random-looking rules based on the historical pronunciation of the
number).  Behind the scenes, the singular form is used to look up a
family of translations and the plural form is ignored unless no
translation is available.

Add a simple wrapper with the English semantics so C code can start
using it to mark phrases with a count for translation.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is based against a version of gettext.h with the fixup
(s/# GETTEXT POISON #/ GETTEXT POISON /) from
http://thread.gmane.org/gmane.comp.version-control.git/167661/focus=167878
Applying that substitution to the patch should be enough for it to
apply to a gettext.h without that change.

 gettext.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gettext.h b/gettext.h
index 73831aa..03fb340 100644
--- a/gettext.h
+++ b/gettext.h
@@ -26,6 +26,14 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 	return use_gettext_poison() ? " GETTEXT POISON " : msgid;
 }
 
+static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
+const char *ngettext(const char *msgid, const char *plu, unsigned long n)
+{
+	if (use_gettext_poison())
+		return " GETTEXT POISON ";
+	return n == 1 ? msgid : plu;
+}
+
 /* Mark msgid for translation but do not translate it. */
 #define N_(msgid) (msgid)
 
-- 
1.7.4.1
