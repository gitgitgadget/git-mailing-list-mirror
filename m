From: Alexander Usov <a.s.usov@gmail.com>
Subject: Empty name in fast-import stream.
Date: Tue, 30 Oct 2012 00:16:30 +0000
Message-ID: <CAH_EFyZc3gjOVDKKeVAFuU_KMtf9utr=jEaiRfjujtkTZAGoAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 01:17:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSzWM-0005Ei-LB
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 01:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab2J3ARL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 20:17:11 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53915 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab2J3ARL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 20:17:11 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so5907802vcb.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=iqRCof6C2nTWmuhDw6PTO7cfgmo+adaErJ666e3U+Tc=;
        b=hsOsMk68AVpJl5ZQqi7gNfqeItf3DdxLv93eUWep/adCN7UljDgksMvcanktaX0qAn
         AnMYaDFpSySnWq/lRNbcmPGuTOue5pC/GDaTbq3NFBc1feLF/vWifqQ1T4+oxqCXSHlA
         xQlluehjcoigIwWaCsWMIVR9v0uoi/aZsTlkT5yiRfwN7DLZTbONueMrPTArRt/IKlDw
         zP9av86LhbzOOI/vWtx/OmeuolkHPJKoXMs9693NRHAZ8/59mNfNuQaKu13KDgyP//eI
         KS0tQ7dkq8L1R2IBzpPlRud5ScclHvTlOFdn/JLcvzwgFwgbLofRhTlsufirTkJU7uSc
         Yszw==
Received: by 10.58.33.229 with SMTP id u5mr4764465vei.0.1351556230180; Mon, 29
 Oct 2012 17:17:10 -0700 (PDT)
Received: by 10.220.58.11 with HTTP; Mon, 29 Oct 2012 17:16:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208660>

Hi,

I'm working now on converting large repo to git, and stumbled upon a
case where fast-import from old git creates incorrect commit objects.
The case is following: when exporting the commit where the only thing
I know about committer is email, fast-import spec dictates following
format:

committer <foo@bar.com> 123456789 +100

with just 1 space between committer and opening brace. Apparently
git-fast-import in 1.7.1 would produce a commit object with just 1
space in there too. And git-fsck in newer versions of git would
complain about this commit object.

The workaround I found is to emit 2 spaces between committer and
opening bracket. Such stream is accepted by both 1.7.1 and 1.8 and
they both produce correct commit objects.

I'm wondering if it is worth changing git-fast-import manual page to
have following rule for committer (and author):

('author' SP <name>? SP LT <email> GT SP <when> LF)?
'committer' SP <name>? SP LT <email> GT SP <when> LF

This format results in the fast-import streams which are correctly
handled by both old and newer git versions.

-- 
Best regards,
  Alexander.
