From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 00/10] update-index: migrate to parse-options API
Date: Wed, 1 Dec 2010 17:27:29 -0600
Message-ID: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:27:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw5V-0000C3-AO
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab0LAX1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 18:27:44 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35116 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0LAX1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:27:43 -0500
Received: by vws16 with SMTP id 16so759173vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=d5M+iVHfN85ZOjc5fEz09VCD5Kdp1DehllA+ofrZi7Y=;
        b=rDyxF+1/f6QIS/O4he0uOQj+rc7VYwguZH1AwjiQka9oGyFg3L6hDr7nzgvJHcmIWv
         c5LYLbUUyVNjc1tkWZgXhH8szveZ/26d0LjDYvUR3xbPVYXVLuNDawxqqNLTYdm4D3IZ
         /jYlvKLqYkABfa/YRISzXdSALeHH9aViKKEFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=CSGDtQ55lOKgRHE/ryyabmoUawOdC60WbEE0KYLenxJ/+Q0j045kYY2BfGZR5B1WC9
         ZryWU9z2QA4gcfq4N6g1qKXRivOz6qwDpgFICIKrxvj86uU5lOzJd8Ym4kUoDWcGMkmh
         XsqCl75L57tU5t2vBrpPMpovR9YnaifgUHEho=
Received: by 10.220.180.138 with SMTP id bu10mr2355475vcb.265.1291246060143;
        Wed, 01 Dec 2010 15:27:40 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id y14sm152659vch.28.2010.12.01.15.27.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:27:38 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162638>

This adapts "git update-index" to use the parse-options API
(with resulting perks like nice "-h" output).  Doing so reveals
some potential improvements to parse-options infrastructure, too.

See [1] for the previous version.  This version incorporates the
last few suggestions by Stephen.  The iffiest bit is still
handling of the --cacheinfo option.

Thanks to Stephen and Junio for advice.  Patches applies to maint,
for no particular reason.

[1] http://thread.gmane.org/gmane.comp.version-control.git/159386/focus=
=3D162463

Jonathan Nieder (7):
  parse-options: clearer reporting of API misuse
  parse-options: move NODASH sanity checks to parse_options_check
  parse-options: sanity check PARSE_OPT_NOARG flag
  parse-options: never suppress arghelp if LITERAL_ARGHELP is set
  parse-options: allow git commands to invent new option types
  parse-options: make resuming easier after
    PARSE_OPT_STOP_AT_NON_OPTION
  update-index: migrate to parse-options API

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  setup: save prefix (original cwd relative to toplevel) in
    startup_info

Stephen Boyd (2):
  parse-options: Don't call parse_options_check() so much
  parse-options: do not infer PARSE_OPT_NOARG from option type

 builtin/blame.c        |    2 +-
 builtin/shortlog.c     |    2 +-
 builtin/update-index.c |  392 ++++++++++++++++++++++++++++++----------=
--------
 cache.h                |    1 +
 parse-options.c        |   85 +++++------
 parse-options.h        |   11 +-
 setup.c                |    4 +-
 7 files changed, 299 insertions(+), 198 deletions(-)
