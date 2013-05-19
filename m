From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 19:28:48 +0700
Message-ID: <CACsJy8DhdR-jWQmL1aYSnH=6w9RKGp0_pRnAzvZEPbJ7MSdMtA@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
 <CACsJy8DMF3NzvMRUO56H+EwpXSjmY9qzdNdv9cGJ9XxUO=ekJA@mail.gmail.com> <CALkWK0kYDB+cCsD7Fsymf9ETR2Ymyaf072gCUu6Uh8yFVFJV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2jr-0008JS-7U
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab3ESM3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:29:19 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60822 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3ESM3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:29:18 -0400
Received: by mail-ob0-f179.google.com with SMTP id wd20so4477869obb.38
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vbsJKTgYSnLDzQeZ+Kav4pxxCoUtUQIzgkhYAFIMeL0=;
        b=JxUIhuQsVz6HpX22h0KxltDMCSgG0fMYKITz/fIrmvrBPyIkdUyDnPZB+pomuQasAe
         yTW6uR5Y3p5VvNJOnX2xJ/Z4rBF0W1gu3TeosODKZRpdSwh4UeYr3Q5qDIFET0m68M8t
         9bxnV9+Wy57p4n1ZHy0RhDWvd9VCI9LaqeEh7hPdFwflC+d8UCQFU7GZlwjMSIGYkQMF
         uBehbmVh2nB8bbiFCrTVVHykbXaw4bXHIkIisd2aNh3zX7TiQf6gvB70TqWCK8ptyKCQ
         9wA65eLgLuHEOvG68lc0i/tZu2jDwvMreb8DiI83nRQD3f+jeLLDKXgg7Kk8NSCklCTz
         hoHw==
X-Received: by 10.182.224.162 with SMTP id rd2mr24877128obc.95.1368966558289;
 Sun, 19 May 2013 05:29:18 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 19 May 2013 05:28:48 -0700 (PDT)
In-Reply-To: <CALkWK0kYDB+cCsD7Fsymf9ETR2Ymyaf072gCUu6Uh8yFVFJV2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224882>

On Sun, May 19, 2013 at 7:08 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>> "branch -vv" shows [upstream: ahead x, behind y]. We need a syntax to
>> cover that too.
>
> Can't we construct that using [%(upstream:short): %(upstream:diff)]?
> It's nothing fundamental.

If there is no upstream, [] should not be shown. We don't have
conditional specifiers so [] should be produced by one of the
specifiers. But yes it's nothing fundamental.

>> pretty and for-each-ref format seem to be on the opposite: one is
>> terse, one verbose. Unless you are going to introduce a lot of new
>> specifiers (and in the worst case, bring all pretty specifiers over,
>> unify underlying code), I think we should stick with %(xx) convention.
>
> We can stick to using the existing %(...) atoms: there's no need to go
> as far as %an versus %aN.  The atoms cannot be consistent with
> pretty-formats anyway, because pretty-formats has completely different
> atoms.  For the _new_ stuff like color and alignment, we can be
> consistent with pretty-formats, no?

I don't think you can easily borrow parsing code from pretty-formats
(but I may be wrong). Anyway new stuff with new syntax would look
alien in for-each-ref format lines. Either we bring --pretty to
for-each-ref, leaving all for-each-ref atoms behind in --format, or we
should follow %(..) convention if we add new stuff to --format.

>
>>> Why should we deviate from the pretty case?  What is different here?
>>
>> Laziness plays a big factor :) So again, you want to take over? ;)
>
> It's just a matter of modifying the parsing/printing layer, instead of
> introducing new atoms in the current parser.  Doesn't $gmane/224692
> demonstrate that the former can, in fact, be easier?

Yes it looks so.

>
>> it uses builtin/branch.c:branch_use_color. Eventually
>> fill_tracking_info() should be moved to for-each-ref.c and pass
>> branch_use_color in as an argument. But for now, I just leave it
>> broken.
>
> Auto-color can come later: it's not that urgent.  What's more
> important is that we give users the flexibility to set their own
> colors now.
>
> Can you give me a pull URL to your series, so we can start
> collaborating?  Mine's at gh:artagnon/git (branch: hot-branch).

https://github.com/pclouds/git/tree/for-each-ref-pretty

I merged 07/09 and 08/09 together as they should be one.
--
Duy
