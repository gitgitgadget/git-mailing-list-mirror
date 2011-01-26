From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/3] trace: omit noisy repository discovery report
Date: Tue, 25 Jan 2011 18:49:15 -0600
Message-ID: <20110126004915.GA11230@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 01:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhtZi-00005F-QA
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 01:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab1AZAt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 19:49:26 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56487 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1AZAtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 19:49:25 -0500
Received: by qwa26 with SMTP id 26so406467qwa.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wy54Qf0dfx1+P+DRXNJYBelVW3teFU1MOK9GE8Ul4S4=;
        b=IbGOCRQ8upk9W7iSoPuHcDPmK4mZnHvshT7Hwb8t+DZpb7OA+wup+KKUA3m44ItZLk
         WkC4Xhi4K47GBv9L+8NdZvr61risSJoTniRCKBUq11NK+ZaQtzRRioqhzneRALcoZ5kC
         hWPaPYEjU6377kcmLl3G38jngdtX7PesmRMI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qFeoevHC2io5erjgu8JYFEh8feQ54I6xFCBZxyhoJGVIzH6fT302dX+VGuN0tDlcj9
         6KvI+mi+lGm1oVXK6cUtCWg51xNXjJO50NzGeRiuTfb9EfgdxeJKVOVEXfWY/8+rLv7e
         WR4rfr7Za3guXKoMEIZoQY584e3BLkapDj/7Y=
Received: by 10.229.95.8 with SMTP id b8mr5106782qcn.156.1296002964718;
        Tue, 25 Jan 2011 16:49:24 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.sbcglobal.net [69.209.75.28])
        by mx.google.com with ESMTPS id w12sm9539308qco.44.2011.01.25.16.49.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 16:49:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290785563-15339-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165490>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> +++ b/trace.c
[...]
> +	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
> +	trace_printf("setup: worktree: %s\n", quote_crnl(get_git_work_tree(=
)));
> +	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
> +	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
> +}

A few days ago I was tracing something or other and decided that these
extra lines are annoying.

Patch 1 moves this code from trace.c to git.c, to contain its impact
to a single translation unit (that is, it let me experiment without
touching cache.h after that).

Patch 2 removes the repo-setup tracing code, introducing a
test-repo-setup helper to take its place in the repo setup tests.

Patch 3 does some cleaning up made possible by patch 2.

Thoughts?
Jonathan Nieder (3):
  setup: do not expose tracing code
  setup: move debugging code to test-repo-setup helper
  setup: stop using GIT_TRACE in tests

 .gitignore            |    1 +
 Makefile              |    1 +
 cache.h               |    1 -
 git.c                 |    4 ----
 t/t1510-repo-setup.sh |   12 +++++-------
 test-repo-setup.c     |   32 ++++++++++++++++++++++++++++++++
 trace.c               |   49 -----------------------------------------=
--------
 7 files changed, 39 insertions(+), 61 deletions(-)
 create mode 100644 test-repo-setup.c

--=20
1.7.4.rc3
