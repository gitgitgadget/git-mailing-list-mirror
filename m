From: larsbj@gullik.org (Lars Gullik =?iso-8859-1?Q?Bj=F8nnes?=)
Subject: [PATCH] git-contacts: do not fail parsing of good diffs
Date: Sat, 15 Feb 2014 18:24:50 +0100
Organization: LyX Developer http://www.lyx.org/
Message-ID: <m3wqgw2srh.fsf@black.gullik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 18:25:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEiz5-0006ZI-AC
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 18:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbaBORYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 12:24:54 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:34259 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbaBORYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 12:24:54 -0500
Received: by mail-ea0-f169.google.com with SMTP id h10so6445743eak.28
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 09:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:organization:date:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=WOI2Kb4qHEII/zq3Fru+jBGiQoQ+Q0MuTgHL41hHTB8=;
        b=iBA0qt0TJLDIhR7y1eFdIk6JD7YOoej5D1Z29J284t5oTuu49g0sVLIUAJqWkKqR5m
         fM79m4gZ8ttAMX15XX11rEX+YmVTAL6e6jRzmOOJF5C2gj+bVdhyPwcJw4PC6wJVW2Vg
         53nmDIph7BOzMNZx9woSSdIN6jZRJMbjH2xgHPdA7WQLk6vh26g4MuHazZutHpSUW/UY
         Lu9/vi1QCnGzoIypzwnFZAtZ5iMVwYrjT1SuyWOrsGR8cktDKL6fJKfuv1P98aLYDQQJ
         +2zM06HCArrTnVb8ccoUqbsr27aOS7dj7pJGDcK7ZxM/iPG9pRF6Su6Lq5LIUvHFh3ZX
         7Jug==
X-Gm-Message-State: ALoCoQlZiyev8M6u7b07/XmMkuLGr2gm1w5kru350QuzPTSz/yr0ZYuErxdwa2+N3CRFIfUyI1Ac
X-Received: by 10.14.0.132 with SMTP id 4mr386313eeb.95.1392485092737;
        Sat, 15 Feb 2014 09:24:52 -0800 (PST)
Received: from black.gullik.net.gullik.org (cm-84.208.110.57.getinternet.no. [84.208.110.57])
        by mx.google.com with ESMTPSA id j42sm34551124eep.21.2014.02.15.09.24.51
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2014 09:24:52 -0800 (PST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242195>


If a line in a patch starts with "--- " it will be deemed
malformed unless it also contains the proper diff header
format. This situation can happen with a valid patch if
it has a line starting with "-- " and that line is removed.

This patch just removes the check in git-contacts.

Signed-off-by: Lars Gullik Bj=F8nnes <larsbj@gullik.org>
---
 contrib/contacts/git-contacts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-conta=
cts
index 428cc1a..dbe2abf 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -96,8 +96,6 @@ sub scan_patches {
                next unless $id;
                if (m{^--- (?:a/(.+)|/dev/null)$}) {
                        $source =3D $1;
-               } elsif (/^--- /) {
-                       die "Cannot parse hunk source: $_\n";
                } elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
                        my $len =3D defined($2) ? $2 : 1;
                        push @{$sources->{$source}{$id}}, [$1, $len] if=
 $len;
--=20
1.9.0

--=20
	Lgb
