From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 0/6] sort tags by date (git tag -l -D)
Date: Sun, 22 Feb 2009 20:06:33 +0200
Message-ID: <e29894ca0902221006s1c1af9f9o8c13ff9e06670d95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIkI-0003rP-SB
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbZBVSGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZBVSGf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:6329 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZBVSGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:34 -0500
Received: by nf-out-0910.google.com with SMTP id d21so367282nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HM72XUuUgyuFqylIQrGOkU5WSiR3xuUI8YElxW8bVU8=;
        b=QpeJ+lxD7VS8tlgnoTf6ObF25H/caPbGsrtMrm8LjROCEpc2T+JbLfKt8scO6JOE/U
         lMgwyAS9AfVtjAHbthuXIcSN8NsL8pgPFwpcybXhBCuWbeAabXlHbAIEDEGRNDDNW/wE
         Xwmv1visLys5d9LHy6G+ICv46usj69H57dzKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=U48zD5fz020POZo1Vh6FcWZYZiQm+MEkOlRORiH4BIf7qLyp+7KiVArLB4x/hv27DY
         4BR5NLdYfUuZzHb71bjIzBbVqpIsDbrcMbYZMynt2Oc2sYGBqxBU01+r0IhB+0FtgYoZ
         Rubb1bLc1Jl5iMTS95boR7n4I17R/r1r7uh/E=
Received: by 10.210.38.17 with SMTP id l17mr2684661ebl.192.1235325993275; Sun, 
	22 Feb 2009 10:06:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111032>

Hi,

I needed to sort my tags by date, and not only the annotated tags. I
was surprised that git tag didn't know how to do that. May be it could
be handled simply by some shell script. Please tell me :)

Take this patch series easy, it's only a RFC. I had some fun hacking
the code, that's the most important for me. I would be happy to take
comment.

Something I wish I could do is also have a better pretty_print_tag()
to have customized format (or may be it should be in git log instead?)

I tried different approach to deal with light tags, and none was
really good. In the end, I decided to use the "object" base type, and
have a private light_tag type. There might be different solutions to
that. I am happy to discuss them.

regards,

Marc-Andre Lureau (6):
  tag: read signature
  tag: parse the date
  tag: copy parsed buffer unconditionnaly
  object: add one bit to let creation of private types (OBJ_MAX + n)
  builtin-tag: add sort by date -D
  test: add simple sorted tag test

 builtin-tag.c  |  162 ++++++++++++++++++++++++++++++++++++++++++++-----------
 object.h       |    2 +-
 t/t7004-tag.sh |   53 ++++++++++++++++++
 tag.c          |   17 +++++-
 tag.h          |    5 ++-
 5 files changed, 201 insertions(+), 38 deletions(-)
