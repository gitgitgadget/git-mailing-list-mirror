From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Tue, 27 Feb 2007 14:25:57 +0000
Message-ID: <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com>
References: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 15:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM3HH-0006c3-FE
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbXB0O0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 09:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXB0O0A
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 09:26:00 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:9111 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbXB0OZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 09:25:59 -0500
Received: by an-out-0708.google.com with SMTP id b33so1132568ana
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 06:25:58 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8pKete92oxsvx+diIEHg3EFUOQf9LMwAAW1+Su/DEEUGDMK1V6cVypqgilo9cqFqAwayQUnTUk/ft5HzNCK9A/0rUvUvxhFzmg2RVSkgm7loUGF+ohKBQOIW7JtazyjBD0a7gHDLGfZq1HUyPjhQT0/LNbUqp+NopgpqYuvpGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uueWUlqYLJqS/9gbIKA9Z2YP9JGG2LQnN4dR7qTOkuz+alfb7MEB36BcX2tzDLfrO07rRx5fq5peRabJT6dGNuLlsLi9nsricSsfeYlEUoQ/WPRvJi+aKWFg+Xm0L0elbPY/ca5GfUhB70sJEcV+YnUVNP6FXjXCcsHLPhS3tbo=
Received: by 10.114.52.1 with SMTP id z1mr443724waz.1172586357741;
        Tue, 27 Feb 2007 06:25:57 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 27 Feb 2007 06:25:57 -0800 (PST)
In-Reply-To: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40738>

On 25/02/07, Yann Dirson <ydirson@altern.org> wrote:
> This testcase demonstrates a long-standing problem with the handling
> of conflicts on a rewinding branch, when "stg pull" calls git-pull.
[...]
> diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
[...]
> +test_expect_failure \
> +    'Rewind/rewrite upstream commit and pull it from clone, without --merged' \
> +    '
> +    (cd upstream && echo b >> file2 && stg refresh) &&
> +    (cd clone && stg pull)
> +    '

This fails (with git 1.5), as expected, but probably not for the same
reason. See below.

> +test_expect_success \
> +    'Undo the conflicted pull' \
> +    '(cd clone && stg push --undo)'

This actually fails in my tests because the git-pull failed previously
(and not the patch pushing) and there is no patch on the stack to
undo. BTW, push --undo now requires a status --reset beforehand.

I can merge the patch as it is and you can send me another one for this issue.

Thanks.

-- 
Catalin
