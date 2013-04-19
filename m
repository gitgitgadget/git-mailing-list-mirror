From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/8] New git-cc-cmd helper
Date: Fri, 19 Apr 2013 00:14:10 -0500
Message-ID: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:15:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3fc-0007r3-5g
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab3DSFPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Apr 2013 01:15:31 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:53234 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab3DSFPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:31 -0400
Received: by mail-yh0-f44.google.com with SMTP id w65so186791yhw.17
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+SZRpGoOSKEQTYhFI8mQvBD5qdIjdCq2CtRG0r1ojgM=;
        b=K4B3t3oCKd/3YuoGkM+8CLM48BDNwzwQ1IBYQTwgQDKyJg5av1C7G3Wy/ayC9UmcXY
         oXcSxuM9ORJzbcYw4rezSO4HjO6XL82NokZiqVMLiiSSKKbHhyTMnKyFROU0qUwHY9vY
         T7hAred3wEJ1SOI9buL/xVX9NFZ5XoWbRdVaOd8jka7+Wj/hONK8nv3XrRoaqhmXVW79
         HvaJxZ0mgkYzh4eJ8/KQzEsVYJVEVG8/gRmzVXlQuNDf2fUqTqqY1gWbnILcjo6JKAWz
         rl3qO13Gq0ujWUmTPLkQEl3591VKniiEBsTBAgrqOaq33DPx5MmJJtAbRdY9FoEK74go
         EVwQ==
X-Received: by 10.236.159.228 with SMTP id s64mr9665459yhk.92.1366348530419;
        Thu, 18 Apr 2013 22:15:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id i44sm22317771yhk.17.2013.04.18.22.15.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221728>

Hi,

This script allows you to get a list of relevant persons to Cc when sen=
ding a
patch series.

  % git cc-cmd v1.8.1.6^^1..v1.8.1.6^^2
  "Henrik Grubbstr=C3=B6m" <grubba@grubba.org> (author: 7%)
  junio (signer: 84%, author: 15%)
  "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com> (auth=
or: 30%, signer: 7%)
  "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> (author: 7%)
  Jean-Noel Avila <jn.avila@free.fr> (signer: 7%)
  Duy Nguyen <pclouds@gmail.com> (author: 7%)
  Michael Haggerty <mhagger@alum.mit.edu> (author: 15%)
  Clemens Buchacher <drizzd@aon.at> (author: 7%)
  Joshua Jensen <jjensen@workspacewhiz.com> (author: 7%)
  Johannes Sixt <j6t@kdbg.org> (signer: 7%)

The code finds the changes in each commit in the list, runs 'git blame'
to see which other commits are relevant to those lines, and then adds
the author and signer to the list.

=46inally, it calculates what percentage of the total relevant commits
each person was involved in, and if it passes the threshold, it goes in=
=2E

You can also choose to show the commits themselves:

  % git cc-cmd --commits v1.8.1.6^^1..v1.8.1.6^^2
  9db9eec attr: avoid calling find_basename() twice per path
  94bc671 Add directory pattern matching to attributes
  82dce99 attr: more matching optimizations from .gitignore
  593cb88 exclude: split basename matching code into a separate functio=
n
  b559263 exclude: split pathname matching code into a separate functio=
n
  4742d13 attr: avoid searching for basename on every match
  f950eb9 rename pathspec_prefix() to common_prefix() and move to dir.[=
ch]
  4a085b1 consolidate pathspec_prefix and common_prefix
  d932f4e Rename git_checkattr() to git_check_attr()
  2d72174 Extract a function collect_all_attrs()
  8cf2a84 Add string comparison functions that respect the ignore_case =
variable.
  407a963 Merge branch 'rr/remote-helper-doc'
  ec775c4 attr: Expand macros immediately when encountered.

But wait, there's more: you can also specify a list of patch files, whi=
ch means
this can be used for git send-emails --cc-cmd option.

=46elipe Contreras (8):
  Add new git-cc-cmd helper to contrib
  contrib: cc-cmd: add option parsing
  contrib: cc-cmd: add support for multiple patches
  contrib: cc-cmd: add option to show commits
  contrib: cc-cmd: add option to parse from committish
  contrib: cc-cmd: parse committish like format-patch
  contrib: cc-cmd: fix parsing of rev-list args
  contrib: cc-cmd: add option  to fetch aliases

 contrib/cc-cmd/git-cc-cmd | 245 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 245 insertions(+)
 create mode 100755 contrib/cc-cmd/git-cc-cmd

--=20
1.8.2.1.790.g4588561
