From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 15:29:55 +0000
Message-ID: <CALeLG_noUfcOZ8gUjqftz8sfWiWdXP3kZUjkRNJ4W=_J+V70rw@mail.gmail.com>
References: <CALeLG_=xzL1SA0G63FGb5v8K5WQOUg4yaodNm6zwf7kU1pAYvg@mail.gmail.com>
	<757358726.204239.1362669338484.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Mar 07 16:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDcly-0005PN-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 16:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab3CGP34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 10:29:56 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:38251 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab3CGP34 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 10:29:56 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so442802obb.10
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 07:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=bbjZFeJgtTLrQSZhsQwk3T3P8VGE4iFg7dTS5aGQEn8=;
        b=AHUNEGFBeA9ySMWs2Dyys7bM1TqvaKl3Vj+yMaSDkX2Z1njqyTWUYUuhDTiRGUYlK5
         i0OPHtAal8HJj/gVS0jivmp7WVawjcfkGjsJ4SD+ObkZr23WzHJjS13bWFT3Ak8StKNS
         /IK3CGRIqSMQ13qvr6r0TxPKGcGsyUeBbq7mUf6HQamcv47ykbdq7263IYzcgrI7M7Lr
         FqZzq7pb8xV+cT0F3AjTUYw15+xugc3uNzwVvUA7peATKsujzZObWafurUbeVvtXOwkQ
         ASL97w9COb+lAScqRGPFsZHp0R7lAjPLEjtGGik3/r1YUNugQ/cYIxDx7OXy1DFJZ5A5
         NT6w==
X-Received: by 10.60.20.193 with SMTP id p1mr26758432oee.133.1362670195123;
 Thu, 07 Mar 2013 07:29:55 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Thu, 7 Mar 2013 07:29:55 -0800 (PST)
X-Originating-IP: [212.219.195.16]
In-Reply-To: <757358726.204239.1362669338484.JavaMail.root@openwide.fr>
X-Gm-Message-State: ALoCoQka7wJZgFFBqdTHPL5vhK3WIbgV5gX1aUarPdJNDCtvA4kLnbCb2QYTL7p1mnqMQj44oAy+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217598>

On Thu, Mar 7, 2013 at 3:15 PM, Jeremy Rosen <jeremy.rosen@openwide.fr> wrote:
>> >
>> > Ok, I can understand that you don't want to import tags for
>> > namespace reason, but in that case shouldn't
>> > git subtree add refuse to create a subtree when the tag isn't a
>> > commit
>>
>> It shouldn't and tries not to, but is limited in it's ability to
>> identify if a refspec points to a commit or not in the remote repo.
>>
>
> ok, i've studied a little more
>
> * the target for "git subtree add <url> <refspec> can only be a remote branch or tag, since we git fetch
> can only target remote refs.
> * in case of a branch, git subtree forgets the branch and only use the commit linked to the branch. for
> tags, the fetch part is ok, it's the merge part that fail. adding ^{} at the right place would probably fix that

I think I tried adding the ^{} syntax, but I don't think it works on
remote repos. Or I couldn't get the right syntax.

>>
>> I've posted a patch (which is pending a lot of other changes to
>> git-subtree that I'm corralling) that tries to prevent some obvious
>> errors in the refspec. But letting the git fetch used by git-subtree
>> add and git-subtree pull catch the error and report it may be the
>> best
>> option.
>>
>
> that's interesting... do you have a link ?

Latest patch:

  http://thread.gmane.org/gmane.comp.version-control.git/217257

Prior patch with comments from Junio on what was probably going on
with the old tests:

  http://thread.gmane.org/gmane.comp.version-control.git/217227

>>
>> I've never really tried using --squash, I don't see that it adds any
>> value for me.
>>
>
> my project has a git subtree for a linux kernel and another subtree for buildroot,
>
> a default .git is about 1.5G, squashing it reduces it to 200M so it's worth it for me :)

If disk space is the issue, or bandwidth for initial cloning, then
sure, but I thought Git was efficient enough that a large repo
wouldn't give much of a performance hit.  Unless you use git-subtree
split or push, they are slow.

If git-subtree split could be optimised then --squash wouldn't be
needed as much. It does take an age compared to other Git operations.

-- 
Paul [W] Campbell
