From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: importing mercurial patch
Date: Tue, 11 Nov 2008 11:59:43 +0100
Message-ID: <85b5c3130811110259x5d659f7ah74e7774773bdcc58@mail.gmail.com>
References: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzqzV-00085Z-Fv
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbYKKK7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 05:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYKKK7q
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 05:59:46 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:45936 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbYKKK7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 05:59:45 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3808973fkq.5
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 02:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=PVI7ax93aRf5y3ONNvlk1HWl2LxLuz7H1gc7dfJUG2Y=;
        b=guwv2aV3yw2xO2ECPjfbGJaurs1h8KLxnCqjmJpges+k6GpJrChSjbc86f6ogQHqWx
         D7PAiBtvO0fbMWiOmObQh0yMjMDE/pt1p2BsiBDYp0wbedW99pWSp3NzgcDVChqIVGSV
         Mg+bENZtSFTw8kCxFCGzFN5mp8tAMCLSRjXAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=uldZaEw6h8juRwU90sQ+gRTG8ncrvuu1QNxoIcXmgFcnNWfm8aI500ogcXc+Hal7ba
         89RDiuChOy8fVLGNqY/ErTasSnLJYPJLzrTNBS6/sRuWNm4IkuCmsv6CemHt0+0lpQHT
         Y6Atd5fsJcr1qYI2GagJgkuhfSgcp5r7zjB6w=
Received: by 10.181.197.2 with SMTP id z2mr2459342bkp.65.1226401183424;
        Tue, 11 Nov 2008 02:59:43 -0800 (PST)
Received: by 10.86.99.20 with HTTP; Tue, 11 Nov 2008 02:59:43 -0800 (PST)
In-Reply-To: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e2ccccbe35a6ada3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100637>

On Tue, Nov 11, 2008 at 11:58 AM, Ondrej Certik <ondrej@certik.cz> wrote:
> Hi,
>
> I'd like git to be able to import mercurial-exported patches. This
> short Python program does it:
>
>
> -------------------------------------
> #! /usr/bin/python
>
> import os
> import sys
> import re
> import tempfile
>
> def run(cmd):
>    print cmd
>    os.system(cmd)
>
> patch = sys.argv[1]
> p = open(patch).read()
> author = re.search("# User (.+)", p).groups()[0]
> p = p.split("\n")
> while not p[0].startswith("# Parent"):
>    del p[0]
> i = 1
> while not p[i].startswith("diff -r "):
>    i += 1
> commit_message = "\n".join(p[1:i])
> _, filename = tempfile.mkstemp()
> f = open(filename, "w")
> f.write(commit_message)
> f.close()
>
> run("git apply %s" % patch)
> run("git ci -a --author='%s' -F %s" % (author, filename) )
> ---------------------
>
>
> How should this be implemented in git? Should I try to extend
> "git-am.sh" to handle it?

Just to make it clear --- I will of course use sh or C with git, I
only used Python above because that's the language I know the best.

Ondrej
