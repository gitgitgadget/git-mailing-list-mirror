From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Remove all files except a few files, using filter-branch
Date: Wed, 19 Sep 2012 00:01:27 +0900
Message-ID: <CAFT+Tg-4q0mzD6rdY74WBP-0OM_SaZ_wkCAn+Gz2_eDte2a4Nw@mail.gmail.com>
References: <CAFT+Tg_ipyPgNQxx8XsXySzmA3YM3mKe1gB5GyTNqN++gdphnQ@mail.gmail.com>
	<m24nmxkibw.fsf@igel.home>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDzIw-0006hV-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 17:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067Ab2IRPB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 11:01:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36481 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab2IRPB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 11:01:27 -0400
Received: by obbuo13 with SMTP id uo13so10529340obb.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=nuaYGIcgjrsKuJT1MDowgJx9wjoDsEUA7hBIsO627ys=;
        b=sbH0i0dRRhJT2cZFTlm2ghiNv9/Yhi9ZPXLNQ0Nt9h/3TWuUF5+Pirq0l63XSfWLap
         IIL/LoE/V+AoaQ38ElMMU/EgN7+GSxd+PlQ7PIbIxTzVkqLPAkl/wLJGobYRdjm5CLHO
         WxLrTomJcIBkJafLIA4mCTTDu+QwS3gUQuMziYAE8GEEc7n3SiQDc1mRbbvEfRScn+3G
         TL9Glp82WAz2CCBfjaItyRTsEkCzQzizJln15I/KSg0jlGKv3Za22EJIn7gGhgSR+S8R
         etjtjq60K0FFIkgr/07lkF+U47NxOzgzOAxO7ORccYM7sFzLN3fDtwUM8yIbDwKZio0/
         oduw==
Received: by 10.60.24.167 with SMTP id v7mr181372oef.52.1347980487427; Tue, 18
 Sep 2012 08:01:27 -0700 (PDT)
Received: by 10.182.41.97 with HTTP; Tue, 18 Sep 2012 08:01:27 -0700 (PDT)
In-Reply-To: <m24nmxkibw.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205833>

> --index-filter "git rm --cached -qr -- . && git reset -q -- filename"

Hmm... I tried as you said, but it seems to lose history.

In the below example, after rewriting there must be two commits for
'b' file but only one exists.

~$ git init filter-branch2
Initialized empty Git repository in
/home/nori/mysrc/test/git/filter-branch2/.git/
~/filter-branch2$ cd filter-branch2
~/filter-branch2$ echo 1 > a
~/filter-branch2$ echo 1 > b
~/filter-branch2$ git add a b
~/filter-branch2$ git commit -m 'first'
[master (root-commit) ae2b5fd] first
 2 files changed, 2 insertions(+)
 create mode 100644 a
 create mode 100644 b
~/filter-branch2$ echo 2 >> b
~/filter-branch2$ git add b
~/filter-branch2$ git commit -m 'second'
[master a32b84e] second
 1 file changed, 1 insertion(+)
~/filter-branch2$ git filter-branch --index-filter "git rm --cached
-qr -- . && git reset -q -- b"
Rewrite a32b84ed7cec5686e43a47195dfa8114f83619f3 (2/2)
Ref 'refs/heads/master' was rewritten
~/filter-branch2$ git log -- b
commit 19611f9eaf412232e237afcc059d0324a862062f
Author: Yi EungJun <semtlenori@gmail.com>
Date:   Tue Sep 18 23:51:53 2012 +0900

    first

Am I doing something wrong?

On Mon, Sep 17, 2012 at 2:06 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> "Yi, EungJun" <semtlenori@gmail.com> writes:
>
>> Hi, all.
>>
>> I want to remove all files except a few files, in the history of my
>> git repository.
>>
>> I tried to do that as follows:
>>
>>     git filter-branch --index-filter "git rm --cached --ignore-unmatch
>> $(git ls-files | grep -v '^filename$' | tr '\n' ' ')"
>
> Try instead first removing all files, then restoring the files you want
> to keep.
>
> --index-filter "git rm --cached -qr -- . && git reset -q -- filename"
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
