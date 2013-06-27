From: David <bouncingcats@gmail.com>
Subject: Re: [BUG] rebase should desambiguate abbreviated hashes before starting
Date: Thu, 27 Jun 2013 19:38:04 +1000
Message-ID: <CAMPXz=pSseQKebNVPVYogTZ2FUc1LqubgmS+pN76sveV=eqC0A@mail.gmail.com>
References: <20130627105513.6bf84060@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 11:38:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us8ea-0007U4-1D
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 11:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3F0JiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 05:38:07 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:44780 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab3F0JiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 05:38:05 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so419956vbg.25
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wu29rVbHGqnxZq/u7/UD+uYj7mgxwH4QH9DCZqfO74s=;
        b=ZKRRxeTa3L8oz0ScTxEtSQq5xhcd7hbZqLuviAGd3mCLVHUu78y06d8y9m9UIfqZy9
         faiCF37NMQrC+Bt0a13703RXpgqgZQMTs6LiFKa0KuRYs1B3LgtbzpPmzCWOwuHg6q+u
         euhdntfhvG0bcIbjiFV+W2KRMhPXc9Fprj0Y2PBWyPW+lupT4WdO+E59XlQhExx1Zqeb
         82bUxMT0CGWqql5Uh8XLVBarV9b9QtSAQxVbw4c0wd1/EV9RusYG0hbXQQXM14BNXOit
         DqKe5Aj3brzzSkrG5pFBRDui9KHLgNiNkbfaPH/HxmMWQsEMCF6cF+yyUP1InR0L2m5H
         J2MA==
X-Received: by 10.58.6.210 with SMTP id d18mr3117520vea.96.1372325884915; Thu,
 27 Jun 2013 02:38:04 -0700 (PDT)
Received: by 10.220.145.145 with HTTP; Thu, 27 Jun 2013 02:38:04 -0700 (PDT)
In-Reply-To: <20130627105513.6bf84060@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229092>

On 27 June 2013 18:55, Yann Dirson <dirson@bertin.fr> wrote:
> I just ran into a funny edge-case when doing a long rebase: one of
> the rewritten commits got a sha1 starting with one of the abbreviated
> sha1's of a commit still to be applied.
>
> As a result, the rebase stopped with a funny-looking "short SHA1 ... was
> ambiguous", which would not have occured if the shortened sha1's presented
> to the user were expanded to full sha1's before starting the rebase.

I do many large rebases, and I have experienced this about a dozen times
in the last few years.

I'm not sure that rebase could predict the new hashes without actually creating
the prior commits? So maybe the "short" SHA1 is "too short"?

When the rebase stops with this message, my workaround is:

The last (failed) entry is in .git/rebase-merge/done
The next todo is the top entry in .git/rebase-merge/git-rebase-todo
I enter the short SHA1 in gitk to find the long SHA1.
I edit both the above files to move the failed entry back into the top
of the todo file, with the long SHA1
And then git rebase --continue
