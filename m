From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 02/73] gettext tests: add GETTEXT_POISON to simulate
 unfriendly translator
Date: Fri, 25 Feb 2011 01:08:35 -0600
Message-ID: <20110225070834.GB23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 08:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsrnE-0002GS-SE
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 08:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab1BYHIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 02:08:44 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64521 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab1BYHIn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 02:08:43 -0500
Received: by vws12 with SMTP id 12so1146299vws.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5oax+jnmNIpm8XmgZwooSlR8f1YXg8FeTMNVFOZHDEM=;
        b=uzNMizRaSQ5aFtwps/TBVKnmb1mysWccPTpgfqFFBIm6hyPbxea22KDQRS2LYSyPjr
         IEjjqt2hlitrAGU0acPAxjpxHsVwZtW51Ru51j8O3n5ZbzxHryKcLWFIvyrIpbZkpAH5
         MXBD8tIFEpTcko61LbX2+AecyAtQSijvRkgjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mu+XQwkyksElNw3MAyZzgWSOO4ETnO1MR61QprmMsxOEiHozoqPa0ZMBfvnvtqvvAP
         KgYy1DZgIdEUjUk+yfcrwhYayNl1UI/Ivo7pe7mO4aR2jclDL0KP+dp65QAasvazqnRT
         hZx8eN2/5YmDraZR9vGrL27tT3SvXREmAt2wA=
Received: by 10.220.177.68 with SMTP id bh4mr499054vcb.63.1298617722479;
        Thu, 24 Feb 2011 23:08:42 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id w26sm216471vcf.45.2011.02.24.23.08.39
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 23:08:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-3-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167878>

Hi again,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Note that the string we're using ("# GETTEXT POISON #") intentionally
> starts the pound sign.

I think I've caused more grief than it's worth complaining about that.
But here's what a fixup (against 77bc5af, i18n: add GETTEXT_POISON to
simulate unfriendly translator, 2011-02-22) would look like, in case
it's wanted.

If this fixup is applied, the last two paragraphs of the change
description (starting with "Note that the string we're using") could
be removed.

Will comment on how later patches in the series would be affected in
separate messages as I apply them.  Patch 1 (i18n: add no-op _() and
N_() wrappers) and patch 2 (gettext_poison) look good to me, for
what it's worth, with or without this fixup.

-- 8< --
Subject: i18n: make the string used by GETTEXT_POISON less meaningful

The idea of the GETTEXT_POISON facility is to simulate a worst-case
translation, so that strings marked for translation that cause trouble
can be noticed and dealt with.

A string starting with "#" does not seem particularly well suited
for that purpose, since it makes '#' characters that mark a comment
and that translators must be careful not to remove harder to find.
Plus it muddles the issue --- is the poisonous string meant to be a
random worst case or not?

The affected strings with a "# " are in wt-status.c, builtin/commit.c,
and builtin/tag.c.  A proof-of-concept patch moving the # signs
outside the translated strings exists and works well.  If we want to
mark those strings for translation without something like that patch,
we can skip the relevant tests or start returning a string starting
with a hash then.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gettext.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gettext.h b/gettext.h
index 11d82b0..361962e 100644
--- a/gettext.h
+++ b/gettext.h
@@ -23,7 +23,7 @@
=20
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return use_gettext_poison() ? "# GETTEXT POISON #" : msgid;
+	return use_gettext_poison() ? " GETTEXT POISON " : msgid;
 }
=20
 /* Mark msgid for translation but do not translate it. */
--=20
1.7.4.1
