From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 0/2] Make some functions thread-safe
Date: Tue, 23 Mar 2010 18:31:01 +0100
Message-ID: <20100323173101.GA4218@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 18:31:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu7wh-0003wW-6A
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab0CWRbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 13:31:09 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:55461 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab0CWRbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 13:31:08 -0400
Received: by ewy8 with SMTP id 8so702013ewy.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=+z5qdw8DUwuynChyfVBzOXEwtb7GrLMPEemfDhAuUHw=;
        b=EJqKEg1Tg0P1wOXSEXBO7Q5RA296RiHQdCfJ0L3HjlSKDNU5EaCZ5WXr+Oz9nFFEKf
         nQ9GUuIkmWn6HYM54baE29+05jcwHGUVTRA1CQG3QQfWZ9VXo/cXLiJwDlLEcNsxnFsi
         /VEGAqwOeUFYHEkGsVY0GJwTs0TzHwyKLI7O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=UbcnrzfdUuGn7Hv0BO2BThbOXxFyO5bN5tm/HoiyDay34aoP5ZF1mDK/q2vc+eIAnk
         CBJP3qZagjhHKgrrOP7i/TADK0fubDiUmPWdwRScb8+FPS+zmQlGnSPmXMNCqQbbX8YV
         CCYgNms2VoQ5IAkMJJHXomG1lZMu17Snc7s7E=
Received: by 10.213.109.131 with SMTP id j3mr9520722ebp.36.1269365466312;
        Tue, 23 Mar 2010 10:31:06 -0700 (PDT)
Received: from fredrik-laptop (c83-250-159-169.bredband.comhem.se [83.250.159.169])
        by mx.google.com with ESMTPS id 15sm3913954ewy.12.2010.03.23.10.31.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 10:31:05 -0700 (PDT)
Content-Disposition: inline
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143032>

Here are two patches which makes xmalloc, xrealloc and sha1_to_hex
thread-safe.

I think the xmalloc/xrealloc patch is a clear improvement compared to
the current situation.

The sha1_to_hex patch is a bit complicated and is more of an RFC. It
makes use of pthread_once which is not (yet) implemented in our
pthreads win32 compatibility layer.

---

Fredrik Kuivinen (2):
      Make sha1_to_hex thread-safe
      Make xmalloc and xrealloc thread-safe


 builtin/grep.c         |    2 +-
 builtin/pack-objects.c |    4 ++--
 git-compat-util.h      |    8 +++++++
 hex.c                  |   53 ++++++++++++++++++++++++++++++++++++++++++++++++
 preload-index.c        |    2 +-
 run-command.c          |    3 ++-
 wrapper.c              |   22 ++++++++++++++------
 7 files changed, 83 insertions(+), 11 deletions(-)
