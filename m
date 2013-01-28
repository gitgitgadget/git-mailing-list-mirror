From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo operations
Date: Mon, 28 Jan 2013 19:35:21 +0100
Message-ID: <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
	<1359290777-5483-2-git-send-email-hjemli@gmail.com>
	<7vk3qywiqf.fsf@alter.siamese.dyndns.org>
	<CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
	<20130128081006.GA2434@elie.Belkin>
	<7vham1xktx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:35:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztYW-0004wt-NS
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab3A1SfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:35:24 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:47345 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab3A1SfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:35:22 -0500
Received: by mail-bk0-f41.google.com with SMTP id q16so1426412bkw.0
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xVr4KG548CIVR1TWTytDOSNd/CJgG8GTuGqDGjQQcnE=;
        b=EmasR3bCTwCVYH84QbyLDujJ2xaA6kk32VQklBf6XLpdSKejqZY6bJ07qP5Bp4Bgyn
         KlKpor+mES8Mjelvfy21XJdGhZaXcUM+WqSa0dkfKbgVzUwGOKf8+ogD2nADfSQJ884J
         pcNddVGF7wRuKBIJcA2S+9AoxNEX5NiKD5AYc9BJ6dfbhBzACfrp5Un8KQEslfPcboTC
         IE8476E2bbH/1DE1USKX9M0FN6ew8qj2DDT4TpTRprB1YPCmI2eonZQUGndcdkBGQYuE
         mzG8SM3lyAwsrR00NCT7H3JfpRYqX5EydfJLBvdh8WJzgeOE9LnV5oKu40gBUObLMhMp
         a4fw==
X-Received: by 10.204.4.215 with SMTP id 23mr3387953bks.110.1359398121355;
 Mon, 28 Jan 2013 10:35:21 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Mon, 28 Jan 2013 10:35:21 -0800 (PST)
In-Reply-To: <7vham1xktx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214855>

On Mon, Jan 28, 2013 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As to the pathspec limiting to affect the loop itself, not the
> argument given to the command that is run, I don't think it is
> absolutely needed; I am perfectly fine with declaring that
> for-each-repo goes to repositories in all subdirectories without
> limit, especially if doing so will make the UI issues we have to
> deal with simpler.

Good (since the relative path of each repo will be exported to the
child process, that process can perform path limiting when needed).


> As to the "option to the command, not to the subcommand, -a option",
> I have been assuming that it was a joke patch, but if "git -a grep"
> turns out to be really useful, "submodule foreach" that iterates
> over the submodules may also want to have such a short and sweet
> mechanism.  Between "for-each-repo" and "submodule foreach", I do
> not yet have a strong opinion on which one deserves it more.
>
> Come to think of it, is there a reason why "for-each-repo" should
> not be an extention to "submodule foreach"?  We can view this as
> visiting repositories that _could_ be registered as a submodule, in
> addition to iterating over the registered submodules, no?

Yes, but I see some possible problems with that approach:
-'git for-each-repo' does not need to be started from within a git worktree
-'git for-each-repo' and 'git submodule foreach' have different
semantics for --dirty and --clean
-'git for-each-repo' is in C because my 'git-all' shell script was
horribly slow on large directory trees (especially on windows)

All of these problems are probably solvable, but it would require
quite some reworking of git-submodule.sh

-- 
larsh
