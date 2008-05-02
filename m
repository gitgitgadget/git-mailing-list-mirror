From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Make boundary characters for --color-words configurable
Date: Fri, 2 May 2008 22:26:45 +0800
Message-ID: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
	 <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Ping Yin" <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 16:27:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrwEh-0000sO-6m
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbYEBO0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 10:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756815AbYEBO0r
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:26:47 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:35506 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbYEBO0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 10:26:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so313378and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m9OWokFr89ONRvuuxxfoqNdfSoirRfvn0MpKSmNZ3qI=;
        b=mYel97YN4NFxHU6pr7934VzgU41yCvcKQOMf/xq4fh/9sccum3Vfs/DbTMhGgumJUmNzhfAjL9HzbRpZ0b43bt0wAAVTXGMpWGkFJ8RbczPdlnQUZabeVK4aovtCv/kt5lGCHNA/C39DlaIa16PNn9RccFFTDIBwx9yPJb3yesk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iHtNtcQe+Yydu3pGB/+FEn487wVID3hvl3Wn6bAtJtRLmNBWQCkmVbnCByRDt7xKv7mM7XSHst9Uu8jC0qzBOAS/7RrbDRMlEmYRtI7Y/X/VMvauN5+yO98zb4UJDFQT/qGxb5W0bPpD+tHlpHhT39Ur+s0OLP1Mg2HU/x9q1v0=
Received: by 10.100.47.13 with SMTP id u13mr4637921anu.125.1209738405900;
        Fri, 02 May 2008 07:26:45 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 07:26:45 -0700 (PDT)
In-Reply-To: <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81002>

On Fri, May 2, 2008 at 9:59 PM, Ping Yin <pkufranky@gmail.com> wrote:
> Previously --color-words only allow spaces as boundary characters.
>  However, just space is not enough. For example, when i rename a function
>  from foo to bar, following example doesn't show as expected when using
>  --color-words.
>
>  ------------------
>  - if (foo(arg))
>  + if (bar(arg))
>  ------------------
>
>  It shows as "if <r>(foo(arg))</r><g>(foo(arg))</g>". Actually, it's the
>  best to show as "if (<r>foo</r><g>bar</g>(arg))". Here "r" and "g"
>  represent "red" and "green" separately.
>
>  This patch introduces a configuration diff.nonwordchars to make
>  --color-words treat both spaces and characters in diff.nonwordchars as
>  boundary characters.
>
>  If we set diff.nonwordchars to "()", the example above will show as
>  "if (<r>foo(</r><g>bar(</g>arg))". It's much better, athough not the best,
>

Oh, there are some problems, assuming "{}" are set as diff.nonwordchars

1. Trailing boundary character lost, for example
----------------------------
$ git diff-
- foo{
+ foo
$ git diff --color-words
foo
----------------------------
With --color-words,  i can't know the trailing '{' is removed. This
problem exists even without my patch. In that case, only trainling
spaces are  lost.

2. Trailing removed words shows at new line instead of the same line
----------------------------
$ git diff
- foo bar
+ foo
(note: no space after foo)
$ git diff --color-words
foo
<red>bar</red>
--------------------------------
bar should show in the same line with bar. This is not related to my patch.


-- 
Ping Yin
