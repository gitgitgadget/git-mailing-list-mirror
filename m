From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] grep -O: allow optional argument specifying the
 pager (or editor)
Date: Mon, 14 Jun 2010 01:31:25 -0500
Message-ID: <20100614063125.GA2006@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino>
 <20100612163946.GD5657@burratino>
 <7vvd9mevqy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 08:31:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO3Cz-0006rO-VC
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 08:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab0FNGbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 02:31:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45577 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab0FNGbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 02:31:40 -0400
Received: by iwn9 with SMTP id 9so2960629iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+qpcAOe47M8UQYQ2A4E101/t/nojiD67VqCDTaDBw7s=;
        b=SDDJZXNS6V6pkhICo7ySlJ2Q3Ndt6qGzjeG+//pqycTwH4FDV2nnBq50mQonwwYD3S
         eKY9lQGvZKXdjmI/aIIlqLh3Zx4uCNtZD1ItmyEbKWJJS7ck9czy9ih5ktMtJ4BOH7So
         ZOsz8jPjmWZufpaz+HOGc1/v4WwXW+Q5/2xZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gW63Cotw9+bUELmlEE1bKk5w6OANYb+/5MEMyNgqBq5rsm+OvNSv0Xzua1FBLAbm/D
         ikemoYn8GFc1hxEQNZY2Ok2/1a6DCn+0k9jOunHAMqdWwuHd8KLijlPzVI10kFM8zv8g
         y5qxgyXZfNTf5yCaEGAKywmfdWgyoZ4bAX+gg=
Received: by 10.231.120.76 with SMTP id c12mr5564513ibr.92.1276497098853;
        Sun, 13 Jun 2010 23:31:38 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm19210211ibg.12.2010.06.13.23.31.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 23:31:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvd9mevqy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149079>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -	   [-O | --open-files-in-pager]
>> +	   [(-O | --open-files-in-pager) [<pager>]]
[...]
>
> Hmm, does "git grep -e Heh -O frotz" look for Heh and show in the fro=
tz
> pager, or does it look for Heh in paths under frotz/ directory and sh=
ow
> hits in the default pager?

As Paolo mentioned, it is the latter.  Patch for squashing
is below.

>> +	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
>
> If there were another instance of constant string "dummy" elsewhere i=
n the
> program, is a clever compiler-linker combo allowed to optimize memory=
 use
> by allocating one instance of such a string and pointing default_page=
r
> pointer to it?

=46or a moment, you had me worried: would an (insane) compiler be
allowed to intern strings that appear as arguments, making argv[i]
actually compare equal to default_pager?

Luckily, the answer is no, because the strings pointed to in argv
are guaranteed to be modifiable (see: Execution environments =E2=86=92 =
Hosted
environment =E2=86=92 Program startup).

-- 8< --
Subject: grep -O: do not advertize non-"sticked" form in documentation

To avoid ambiguity in option parsing, the -O option will
only take an argument if it is stuck to the option like
-Ovi or --open-files-in-pager=3Dvim.  The un-sticked form
-O vi means to search paths under 'vi' and show hits in
the default pager.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-grep.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d89ec32..0e12fe4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
-	   [(-O | --open-files-in-pager) [<pager>]]
+	   [-O[<pager>] | --open-files-in-pager[=3D<pager>]]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -106,7 +106,7 @@ OPTIONS
 	synonym for `--files-with-matches`.
=20
--O [<pager>]::
---open-files-in-pager [<pager>]::
+-O[<pager>]::
+--open-files-in-pager=3D[<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
--=20
1.7.1.246.g398e5.dirty
