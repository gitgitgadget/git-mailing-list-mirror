From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: /* in .gitignore
Date: Tue, 25 Sep 2012 17:03:22 -0700
Message-ID: <CAE1pOi2kU0dAqZVDwJAG9frG4Oq4rswtE85AL2Mk9eNCjRHhGg@mail.gmail.com>
References: <CAE1pOi1vEGVcg5wn9VjkSVmMO_hparmYP0hn86XwpSpMmB=Peg@mail.gmail.com>
 <7vobktvgq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGf7H-0006bz-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 02:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab2IZADo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 20:03:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33614 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2IZADo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 20:03:44 -0400
Received: by bkcjk13 with SMTP id jk13so5793bkc.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 17:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SQJLxn7S87XxfZoeSVentOTxHf6mNUCtFOfLM88YPDk=;
        b=B/cJ9ue6ZdSxvby20Kl3vXcEOmCmcNx/5KZD4rdhYHzY0RjyMBPG9I3KP+MtgdHgFk
         +TeNsoqTwX7A6dPStrBjJ0F+ekXbQFnz/ytwrsNkBzsraaU9uSGbcPTtE/bWiAblN9ND
         JcMnQAGz87VgajKbynLkfNFhYjnpTWuumOGePSnFtQwgROQEkMxwWXqY/6cRak9/QfeJ
         uBLUzCjMHJOWZcRYzZ/h+ErUqq0DsycIuwsrhw1IAcR4H1r8Q7HrskfpOTeiFBkaRxBm
         az5m2a5FHJOrjfcOIn8/ZZ3tq+bzP48du2ZHjXf7EtBC4/D1BOIve87X2yfRxgo2806p
         w7Kw==
Received: by 10.204.130.152 with SMTP id t24mr452005bks.138.1348617822603;
 Tue, 25 Sep 2012 17:03:42 -0700 (PDT)
Received: by 10.205.32.15 with HTTP; Tue, 25 Sep 2012 17:03:22 -0700 (PDT)
In-Reply-To: <7vobktvgq8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206387>

On 25 September 2012 16:13, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> Naturally, this behaviour makes perfect sense: "/*" means everything.
>> Still, I was wondering whether it might be a good idea to make an
>> exception for '.gitignore' itself? Then if somebody *really* wanted to
>> ignore '.gitignore' they could add "/.gitignore" to '.gitignore'?
>
> If somebody is sick enough to ignore "everything", he can add "/*"
> to the .gitignore file and in order to make sure he knows what he is
> doing and he is doing what he thinks is doing, he would check with
> "git diff --stat HEAD" etc. before committing, and double check with
> "git show --stat" etc. after committing.

Ignoring everything is not quite so "sick". :-) My use case is
Eclipse's .metadata directory. This directory is *huge* but only
.metadata/.plugins/org.eclipse.core.runtime/.settings/*.prefs is
really of interest (and not even all of those files). The subset of
*.prefs that we are interested in will allow us to share Eclipse
configuration settings (things like formatting settings and which
warnings we care about). So I have several '.gitignore' files with
"/*" + "!/some-dir/". [To make things even more interesting, the
".settings" directory should be ignored in all other places (so it's
in our top level '.gitignore').]

I would be very happy to find out better ways to handle this
particular scenario. I had quite a struggle getting it to work.

> ".gitignore" (or ".gitattributes" for that matter) shouldn't be any
> different from your ordinary tracked contents.  If you have "*.o" in
> the ignored pattern list, you would need an extra care to defeat the
> pattern to add vendor-supplied binary-only object file with "add -f"
> and live with the fact that a new vendor-supplied binary-only object
> file not appearing on untracked list.  It is exactly the same deal.

I do not entirely agree. I think '.gitignore' *is* different. This
file is special and affects Git's behaviour. And it does so *before*
it has been committed. Or even added. The fact that '.gitignore'
itself is not listed in the output of, e.g., "git status" is easy to
miss.

I have not really used '.gitattributes' but I assume the same applies.

> Having said that, I guess you could add "!.git*" to your
> $GIT_DIR/info/exclude and see if it gives an improved user
> experience.

Mmm, that does not seem to help. I did

git init && touch file.txt && echo '/*'>.gitignore && echo
'!.gitignore' >>.git/info/exclude && git status

it lists nothing (Git 1.7.12). I had expected to see '.gitignore'. Did
I misunderstand you?

Even so, this would only improve *my* user experience, wouldn't it?
This would not get pushed to the central repository so it would not
help anyone else.
