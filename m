From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Tue, 25 Dec 2012 08:09:17 +0700
Message-ID: <CACsJy8ChvEMt7FMs-zdyF9SOhL8U01x266OebEk3SHR+19908g@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712> <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
 <1356327291-ner-6552@calvin> <CACsJy8DkA-J+ds1eHBqrRyiZrOigORTtxVeEQpZjGHrBR+QjCQ@mail.gmail.com>
 <7vmwx4newy.fsf@alter.siamese.dyndns.org> <CACsJy8DMGrHqgY7himfJA-6f5beZ83Pje+-ex62LQOAARWh=Nw@mail.gmail.com>
 <7vbodjnu5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 25 02:10:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnJ20-0004c7-BF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Dec 2012 02:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab2LYBJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 20:09:51 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35469 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab2LYBJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 20:09:49 -0500
Received: by mail-ob0-f180.google.com with SMTP id wd20so6833080obb.25
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VngIxc1fzaf2G8OezJgIhXkyxV8Rk2q3RVIrla+2t7E=;
        b=RtaJbn4k7ynBgpqVbJ/K/KJvAjf6doeSivn9SEzQv1aaV1tYbIMnWAdVZ6l+Zj+17K
         Wx44ipnr2kordQp7IrqiTz5YdZCGZZN6/bF6jV6CYfwTFid6zllCObN9brfGzSnoiaFr
         u9tIdZOazIuEIA5EgCIu4MvT4SW1RW+lid5D9GhhrABR2gdUu1HUU1lcwl8mxrf1ptdr
         O03JW0fAySet7RI8m7A4nG3P9ya2v7TKhYI9W9ixABvcBF464NkBhQ1qLsbNT2OnrSM5
         cHV5k/6STlVJui9Mbiv6YcMG++rsBW01s8xTLWxoL8mKrNPphBdtA0hv5goABEE5SI1i
         ctpQ==
Received: by 10.60.28.74 with SMTP id z10mr7228744oeg.29.1356397789060; Mon,
 24 Dec 2012 17:09:49 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 24 Dec 2012 17:09:17 -0800 (PST)
In-Reply-To: <7vbodjnu5c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212119>

On Tue, Dec 25, 2012 at 2:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I looked briefly at reflog before writing my previous mail and noticed
>> that when I create a new branch (usually using "git checkout -b branch
>> ref") it does not record the base commit.
>
> Hmph.  Perhaps you are referring to something different than what I
> think "the base commit" with that word.
>
>     $ git reflog mz/pick-unborn | tail -n 1
>     b3cf6f3 mz/pick-unborn@{3}: branch: Created from ko/master

No you're right. My reflogs must be pruned. Creating a new branch does
produce that entry.

>> We could at least invalidate the recorded base in reflog and let user
>> define a new one (I hope).
>
> Please do not even think about going back and rewrite to lose
> information.  If the records have full information, you should be
> able to reconstruct what you want from it without rewriting.
>
> Even more importantly, wish to "invalidate" indicates that you know
> at a newer point that you have more authoritative information than
> the older reflog entries, so you should be able to do the moral
> equivalent by writing the event as establishing a new base at that
> point (e.g. "checkout -B"), and stopping at that point in the reflog
> when reading, without losing the older reflog entries.

Exactly. And when we prune the reflog, we could add the base back so
the base is always in reflog.
-- 
Duy
