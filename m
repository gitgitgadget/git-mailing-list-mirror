From: "Alexey Mahotkin" <squadette@gmail.com>
Subject: [PATCH] more dependencies in doc generation
Date: Fri, 21 Sep 2007 00:43:22 +0400
Message-ID: <bb5b640b0709201343j5a04a554ib91785b43464d4d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 22:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYSrz-0005XT-N8
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbXITUn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbXITUnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 16:43:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51883 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXITUnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 16:43:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so575879nfb
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=KMqjXA8pXlOCqQ6xn/Stst3yqCugyataOVH+DYmwj8Y=;
        b=GOADqOK3/jFXloPEalfd97ZZpfvdMLobFaCyjBBtIX22VAgr/Fa9qP7CYpNMqOFtuFUC2k0UywcDpTnpCiV746qrGdgR7sUL2aXii55W9DleDVUKm6kLuRnSb+v+slb2BPh09GfK50JOQqOgDzbYZLLSH0olQNQUKndYx2o5jMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=niqkRoY2DZz4tzTF4TVAtkgS1yw4PO2C91xe77m40Z9pR11i9XEN9b5OtE+Aoo8h4Te7ixO1mVMcLkChNGgTikDsTef9qohV/4EcLkBu6IRb4RqfVAW22QXfG/UTQZP0frVfph0LJa+W+SGpMvUg8VVGB5kYljTSQKjHPf+X6UQ=
Received: by 10.86.28.5 with SMTP id b5mr1688597fgb.1190321002526;
        Thu, 20 Sep 2007 13:43:22 -0700 (PDT)
Received: by 10.86.66.18 with HTTP; Thu, 20 Sep 2007 13:43:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58803>

Hi,

I'm trying to solve the problem with `man git-diff' (unescaped troff
sequences in manpage), and the first thing that will obviously help is
the following patch:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fbefe9a..310d6a5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -135,11 +135,11 @@ clean:
                $(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
        mv $@+ $@

-%.1 %.5 %.7 : %.xml
+%.1 %.5 %.7 : %.xml callouts.xsl
        $(RM) $@
        xmlto -m callouts.xsl man $<

-%.xml : %.txt
+%.xml : %.txt asciidoc.conf
        $(RM) $@+ $@
        $(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
                $(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<

It helps to regenerate things correctly when the stylesheets change.
Please apply.

Thank you,

-- 
Alexey Mahotkin
http://www.versioncontrolblog.com/
