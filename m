From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitignore.5: Clarify matching rules
Date: Fri, 5 Mar 2010 09:56:39 -0600
Message-ID: <20100305155639.GA25080@progeny.tock>
References: <4B90C701.3070308@gmail.com>
 <4B90C974.2050405@viscovery.net>
 <20100305151248.GA24748@progeny.tock>
 <4B912469.8060705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiri Slaby <jirislaby@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 05 16:56:46 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnZtJ-0008Pj-Ab
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 16:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab0CEP4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 10:56:33 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:54688 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0CEP4c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 10:56:32 -0500
Received: by ewy4 with SMTP id 4so2530356ewy.28
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JDNFyTbC9XgXmIgppB/4golsgXLFoFybeqfN1s6L7q0=;
        b=wRMw8rQ5bTRn1Y2gxhS8HNTIqt0Y12a0KCxFzTeOalci3wxMukRvTvWuMK23qmAKGV
         qLt5L+IpY6fBMzcEjh/bsPagC1vJODpBJGXFM822aeye6WbyM8euO1samQ5b04wRGZku
         TTmDfrO5w/lRYjbrjCuVDIzUYKciXN17zD9wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ueUZjsxf1RP3wsB3dT93vmivGUQVjeOI2N33Uj3+VB717vqidDKsZObnQ+XdI+WrCA
         es/1W8y4G+BHDPbbAecvBxXsvYAnjbMsf9e6WHtVn+P434CB98OLejyh2yyLtZBWaywy
         ji5b23g6/Sw+M2MVOrz5Ec+2e+bZMvvLF5Dxs=
Received: by 10.213.104.72 with SMTP id n8mr586688ebo.13.1267804590620;
        Fri, 05 Mar 2010 07:56:30 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 5sm4726999eyf.3.2010.03.05.07.56.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 07:56:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B912469.8060705@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141585>

Patterns containing a / are implicitly anchored to the directory
containing the relevant .gitignore file.

Patterns not containing a / are textual matches against the path
name relative to the directory containing .gitignore.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Johannes Sixt wrote:

> When the pattern "Documentation/*.html" matches
> "Documentation/git.html", then it cannot match
> "tools/perf/Documentation/perf-diff.html". This is because patterns that
> contain a slash (after stripping a trailing slash) are anchored at the
> directory that contains the .gitignore.

Oh!  The documentation could definitely use clarification here.

Thanks.

 Documentation/gitignore.txt |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 98c459d..e10fa88 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -83,16 +83,20 @@ Patterns have the following format:
 
  - If the pattern does not contain a slash '/', git treats it as
    a shell glob pattern and checks for a match against the
-   pathname without leading directories.
+   pathname relative to the location of the `.gitignore` file
+   (relative to the toplevel of the work tree if not from a
+   `.gitignore` file).
 
  - Otherwise, git treats the pattern as a shell glob suitable
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
    wildcards in the pattern will not match a / in the pathname.
    For example, "Documentation/\*.html" matches
-   "Documentation/git.html" but not
-   "Documentation/ppc/ppc.html".  A leading slash matches the
-   beginning of the pathname; for example, "/*.c" matches
-   "cat-file.c" but not "mozilla-sha1/sha1.c".
+   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
+   or "tools/perf/Documentation/perf.html".
+
+ - A leading slash matches the beginning of the pathname.
+   For example, "/*.c" matches "cat-file.c" but not
+   "mozilla-sha1/sha1.c".
 
 An example:
 
-- 
1.7.0
