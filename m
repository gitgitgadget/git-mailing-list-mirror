From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sat, 28 Nov 2009 23:37:40 +0000
Message-ID: <3f4fd2640911281537m3a3d7f5dl7836a613b48128f2@mail.gmail.com>
References: <4B1168D4.5010902@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 00:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEWrT-0002b1-Nh
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 00:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZK1Xhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 18:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZK1Xhf
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 18:37:35 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:37830 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZK1Xhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 18:37:34 -0500
Received: by vws35 with SMTP id 35so722939vws.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=RYGVs/qcPE8x8uHyOuqouo4bMTbi9HrnzJQT9pGtYeo=;
        b=fA0dQqkBvXJMNxUJ69B+7cz1edfxMVlsHpVUg0jL6aWYlMWWAViuEfpaRZJ8N+wy5o
         DQ6ClygfVqKQ+kd9WZ9geh9/b/hq9kqmb/xx0eW5elpzFxtd1OSSBC8AyxDc2lPS/7FT
         Zmnv33vGACwpYfDmDR5ndy1jETcz/zHl0Rs/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LlhIUSLTGCGqOGjRyEbQJx3Pn7phJQx0Xqa0dp69YAJ1v778tdxcpGuTTYb7CkAETQ
         SqfjLJIH3KCTWYBbm4NoBrUih5cPi3M4V6T2Ock/rNu549cREa6CJz2Idgd0suqu1I5J
         50YXU90kpOTbcFTLSKPD+b8qfjPNmXEd6TV/8=
Received: by 10.220.122.100 with SMTP id k36mr3074573vcr.98.1259451460585; 
	Sat, 28 Nov 2009 15:37:40 -0800 (PST)
In-Reply-To: <4B1168D4.5010902@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133983>

2009/11/28 Thomas Singer <thomas.singer@syntevo.com>:
>
> When launching 'git status' from the git shell (msys 1.6.5.1.1367.gcd48 from
> 7zip-bundle) it only shows me 4 question marks. I would have expected to see
> the non-displayable characters escaped like it did with the umlauts on OS X.
>
> Even adding fails:
>
> $ git add .
> fatal: unable to stat '????': No such file or directory
>
> What should I do to make Git recognize these characters?

This is a bug in git's character encoding/conversion logic. It looks
like git is taking the source string and converting it to ascii to be
displayed on the console output (e.g. by using the WideCharToMultiByte
conversion API) -- these APIs will use a '?' character for characters
that it cannot map to the target character encoding (like the Hiragana
characters that you are using).

SetConsoleOutputCP can be used to change the console output codepage
[http://msdn.microsoft.com/en-us/library/ms686036%28VS.85%29.aspx] and
SetConsoleCP is the equivalent for input
[http://msdn.microsoft.com/en-us/library/ms686013%28VS.85%29.aspx].
e.g.

    SetConsoleCP(CP_UTF8);
    SetConsoleOutputCP(CP_UTF8);

should make the console process UTF-8 characters, so git shouldn't
need to do any character conversions on Windows when reading/writing
it's data.

NOTE: I have not tested this, just noting what I have found via Google.

- Reece
