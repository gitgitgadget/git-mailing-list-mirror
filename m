From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: How to use --cc-cmd in git-send-email?
Date: Sun, 19 Jul 2015 21:09:20 -0400
Message-ID: <CAPig+cTQspD+0StY5tneqwekS3xCjdxcidoDA7Ztf26g-tMucg@mail.gmail.com>
References: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 03:10:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGzb8-0002BX-CB
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 03:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbbGTBKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 21:10:06 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35386 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbbGTBJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 21:09:20 -0400
Received: by ykdu72 with SMTP id u72so128569894ykd.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HMTpgqIFHFmIFbHfnrCi3G7vJkl/W7ZzeP2EYgGKI9w=;
        b=VzLsEQ1YqQPdPeq+g0mXqs7XiirDjMIzVynQZMTTJDeoBtyQS3RGAt225VlPrwOJmW
         cCCOC6nG3Pu6NkTby1liOd3N5U4yw566+n6LTgz5Y7RkUr2BpDN69VN3hne5ZwQLb7YW
         9IOL2BfVOGAfN8yG3mihDkKMfGqNGhrphpUgOXO/a0mZhE3sy1uYLAU2e4j+bC91wZZe
         BrugJmysYJxbFNfKrMH63lI8+/jCv2T8d8L+uO0kHKBH08GlGNLzHWt1KwwG4FuEiHBe
         tAbmVgNam9s7euAp2QJyMmcARiT3bhMrBCA/RWV8YsjeyD8bOhSPXx467qmsYYbnl0cc
         gwIg==
X-Received: by 10.129.70.69 with SMTP id t66mr25891429ywa.4.1437354560161;
 Sun, 19 Jul 2015 18:09:20 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 18:09:20 -0700 (PDT)
In-Reply-To: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley>
X-Google-Sender-Auth: pSAWnoBrFibQKpYSD0bnL1foklw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274302>

On Sun, Jul 19, 2015 at 6:02 PM, Philip Oakley <philipoakley@iee.org> wrote:
> I've been using git-send-email with repeated individual --cc="email address"
> parameters on the command line.
>
> I tried putting all the addresses, one per line, into a file 'cc-cmd', so I
> could use if for the --cc-cmd option.
>
> I then tried to use --cc-cmd='cat cc-cmd' to do the send-email (as a
> --dry-run). This produced, as part of the output, a list of the output of
> the cc-cmd, which showed not only the file contents, but this was then
> followed by the full patch, as if it was part of the list of email
> addresses.

git-send-email invokes the cc-cmd like this:

    $cc-cmd $patchfilename

so, when you used 'cat cc-cmd' as the value of --cc-cmd, your invocation became:

    cat cc-cmd $patchfilename

and since 'cat' copies the concatenation of its input files to its
output, that explains why you first saw the names from your 'cc-cmd'
file followed by the content of the patch file.

A quick-and-dirty work-around is to use '#' to effectively comment out
the patch file name:

    --cc-cmd='cat cc-cmd #'

which works, but is very, very ugly.

> Could this have been caused by an extra (blank) line at the end of the
> cc-cmd file?

Nope.

> Also, does anyone have an example of a working --cc-cmd option?

A very simple working solution is to make your 'cc-cmd' file executable:

    #!/bin/sh
    echo <<\EOF
    person1@example.com
    person2@example.com
    EOF
