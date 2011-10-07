From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How pretty is pretty? git cat-file -p inconsistency
Date: Fri, 07 Oct 2011 16:50:00 -0700 (PDT)
Message-ID: <m3r52o1hxr.fsf@localhost.localdomain>
References: <4E8EBC00.90909@drmicha.warpmail.net>
	<7v62k0wudg.fsf@alter.siamese.dyndns.org>
	<4E8F6088.8060300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 01:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCKBH-0001GB-M5
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 01:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360Ab1JGXuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 19:50:04 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52902 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab1JGXuC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 19:50:02 -0400
Received: by eye27 with SMTP id 27so39810eye.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 16:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=otruLjeQ1Kt4eKF3jzJqI0ZIpUmlTuCzhL+j59CuuSA=;
        b=Z2Cu6tDCEGSxwGWfyVXG6HyZyw3nhPAjZHeROLOTiSgP4GD5TIYBNIxSSSvL1zXIGD
         lrBDJnknie3Gu2z1sQNYTW7v6+fx/VXfCmQA3jPGIfL/X31gp/MsapBsdFh5bDNogR8P
         9/zbplhwAkSGNbUE71lURrYhUTdKmxNXCnTsQ=
Received: by 10.223.62.15 with SMTP id v15mr14033019fah.22.1318031401241;
        Fri, 07 Oct 2011 16:50:01 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id k26sm15240425fab.12.2011.10.07.16.49.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 16:50:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p97NnQHZ003735;
	Sat, 8 Oct 2011 01:49:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p97Nn5Wi003718;
	Sat, 8 Oct 2011 01:49:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E8F6088.8060300@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183128>

Michael J Gruber <git@drmicha.warpmail.net> writes:

[cut]
> I never knew how ugly the output of "git tag-file tree sha1" is. I gu=
ess
> it's the type of object whose format I don't know... We don't have an
> object format description in Doc/technical, do we? tree.c doesn't tel=
l
> me much.

I had to handle this in my attempt to write "git blame <directory>" in =
Perl,
which was using `git cat-file --batch`, and that gives raw data and not
pretty-printed.

Tree object consist of zero or more entries.  Each item consist of mode=
,
filename, and sha1:

  <mode> SPC <filename> NUL <sha1>

where

1. <mode> is variable-length (!) text (!) containing mode of an
   entry. It encodes type of entry: if it is blob (including special
   case: symbolic link), tree i.e. directory, or a commit
   i.e. submodule.  Does not include leading zeros.

2. <filename> is variable-length null-terminated ("\0") name of a file
   or directory, or name of directory where submodule is attached

3. <sha1> is 40-bytes _binary_ identifier.

HTH
--=20
Jakub Nar=EAbski
