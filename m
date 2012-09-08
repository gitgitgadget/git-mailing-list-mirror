From: Ori Avtalion <ori@avtalion.name>
Subject: [BUG] 'git show' gives duplicate errors for ambiguous args
Date: Sat, 08 Sep 2012 21:43:03 +0300
Message-ID: <504B91B7.1000406@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 20:43:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQ07-0008KZ-3S
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 20:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab2IHSnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 14:43:19 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40188 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab2IHSnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 14:43:19 -0400
Received: by wibhi8 with SMTP id hi8so657926wib.1
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ZCluocfNT4nk1oa1hhpfvh868vVdyrRCpGJp7sZ3bIY=;
        b=fQzpl3ILdcZjy9pasCGp8if+TGEw6n/PEVxDe/VyXWqbGMFgVpL3o25tdO4lQCE6pE
         540rY9AsoVh+giQOPco+KQHdqTlwG42zsqMF26oZklsmT8NN3wvQMwLVF5UfZqvz8NJv
         uF4uE8s0XncQuILsvIxX6rZCCMm8dxhsrkJ0/DexUDV5SuPGky8Ll6kZ1XrimZvgofOc
         TRideuV8l1gWf2bi8W/E5yoAyNfhOgxOt5EPXHVu85cOi81ATxZNfsgfenpscs+KJ/Vc
         l07KZ6UXfglJOCAVgNIJSlF8gjGxQK4JAeEi5ezvZlUKX09K0+Jy25hkmZ7sx92q/QHf
         PX7A==
Received: by 10.180.96.3 with SMTP id do3mr6069781wib.5.1347129797824;
        Sat, 08 Sep 2012 11:43:17 -0700 (PDT)
Received: from [192.168.1.55] (bzq-79-181-162-188.red.bezeqint.net. [79.181.162.188])
        by mx.google.com with ESMTPS id q4sm6529119wix.9.2012.09.08.11.43.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Sep 2012 11:43:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205023>

With the git.git repository:

  $ git show abcd
  error: short SHA1 abcd is ambiguous.
  error: short SHA1 abcd is ambiguous.
  fatal: ambiguous argument 'abcd': unknown revision or path not in the
working tree.
  Use '--' to separate paths from revisions

The "is ambiguous" message shouldn't be shown twice.

The first error is printed by revision.c:1796 (a call to
handle_revision_arg), and the second by revision.c:1808 (a call to
verify_filename). I don't see an easy way to suppress it.
