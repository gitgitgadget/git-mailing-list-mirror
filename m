From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [GETTEXT BUG] xgettext(1) can't extract "gettext -- foo"
Date: Tue, 5 Jun 2012 11:05:50 +0200
Message-ID: <CACBZZX7rhA23k5Mz=dY6G_75hwBMgWbKrkAGJv4rd9URAh4vHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: GNU gettext is full of bugs <bug-gettext@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbpiS-0003FI-SA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 11:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab2FEJGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 05:06:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49156 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab2FEJGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 05:06:11 -0400
Received: by obbtb18 with SMTP id tb18so8486469obb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=0iB179Ef4i8s0QC3UZiygmYLjH2q8qPJGtHxdz7KMOg=;
        b=K5cklp9Mr/+LSjy3cfNE4gA6tZDva35/axt/idG1TB5vuvmsjZ3tNaLr9dKX3AgEl+
         aAfgiOEdsmTvbDuUeTMmX8aDFUgLquLcZqEO84GMeklYPOzgw5iB/NTNXxmx9rAEWjVA
         OZILMchQBd6lb3+/UNtmM1V1G1bYS6TMXKH3mTHiTVYvrP3cpCidOTBh02lGlI1ozJbo
         muqspb3kFcdoU4GB6CCZ6KLwi8v78AfxLqXsAfrhd0uTSOgv5tEgqUMbu4yQZGu7JqMv
         t4IrnM0xZIqkDut8SNmhX45uV8yUXjt5bvLqe9/vOoWVTuJvlhL3ryW0uIRppPc2PJeO
         eh6w==
Received: by 10.182.47.105 with SMTP id c9mr15217186obn.49.1338887170910; Tue,
 05 Jun 2012 02:06:10 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Tue, 5 Jun 2012 02:05:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199220>

The Git project is having issues with xgettext being unable to extract
msgid's provided to gettext(1) where the first argument is --. Here's
a minimal testcase:

    $ cat /tmp/xgettext-tesh.sh
    #!/bin/sh
    . gettext.sh
    gettext "hello "
    gettext -- "world"
    echo

If that's extracted with xgettext(1) the message on line 4 is presumed
to be "--", when in fact it should be "world":

    $ xgettext --omit-header --force-po --output=/tmp/xgettext.po
--language=Shell --debug /tmp/xgettext-tesh.sh ; cat /tmp/xgettext.po
    #: /tmp/xgettext-tesh.sh:3
    msgid "hello "
    msgstr ""

    #: /tmp/xgettext-tesh.sh:4
    msgid "--"
    msgstr ""

There's currently a proposed patch to hack around this using something
like:

    gitgettext () {
       gettext -- "$1"
       echo
    }

Is there a better way to handle this, and is this a bug the gettext
project is aware of and might be fixing sometime soon?
