From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Thu, 4 Sep 2014 12:46:43 +1200
Message-ID: <CAFOYHZCcAwHwRy50kE8=rRwEOtrXovNkkKSQo2Gwcfvbve1Qwg@mail.gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-2-git-send-email-judge.packham@gmail.com>
	<xmqq38c8waub.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 02:46:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPLCR-0001Mc-OM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 02:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbaIDAqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 20:46:44 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36591 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237AbaIDAqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 20:46:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id ft15so12276254pdb.19
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r/tea9mlj0k5YkI2lv+opH2EjNzkcWjkA1yCcsUkuFo=;
        b=fS0Zapkth3tW1+D8eBdobaSkYblvIL7noYP3R1hkMkAcqyfbUf4xfDVsOoU2kl6GrW
         RowOhOno+Z2zSKiDh/muYemG2SL18JbnAynfBCZaBpSNqsUl2B+O+PfVFKIaUWmp/TaE
         7vjvhtc6a+YfPmYxMTY361rTVub198/3a6veTT0BlCrCvzpfDixl8z4xnkB3MvHl3VP+
         l8IvA0puonE9MDO7Xx0raGzVSR7K+x8OtQIEgw88HPPj9Z9Hl3j/fSpMSiNCyChFMeQR
         aDX+swUyUPYR2YCuX/+MzbROe00u/2POrcf7FMJMqDXU0EiPsjTQXFd6dTM3+RHg/TGE
         gdzg==
X-Received: by 10.70.35.207 with SMTP id k15mr1865454pdj.5.1409791603662; Wed,
 03 Sep 2014 17:46:43 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Wed, 3 Sep 2014 17:46:43 -0700 (PDT)
In-Reply-To: <xmqq38c8waub.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256432>

On Thu, Sep 4, 2014 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> Patches created using gitk's "write commit to file" functionality (which
>> uses 'git diff-tree -p --pretty' under the hood) need some massaging in
>> order to apply cleanly.
>
> Shouldn't that output routine be the one to be corrected, then?  We
> really do not need yet another format to express the same thing,
> especially from the same suite of programs.

That's an option. It shouldn't be too hard to make gitk use 'git
format-patch --stdout' instead. The problem for me is that it's easier
for me to update my git installation to get git am to accept the
current format than it is for me to ask the people generating these
patches to change their git/gitk installation to generate a different
format.

Another thing that I've since realised is that this 'gitk' format is
also what you've get from git show or git log -p. So this is actually
allowing (for better or worse) things like 'git show $sha1 | git am
--patch-format=gitk'[*1*]. That may mean that we should call the
format something else ("pretty" perhaps?) and note that this is what
gitk, git show and some incantations of git log generate.

--
[*1*] - Although I've just found a bug that affects the existing
--patch-format=hg|stgit where reading from stdin is not currently
supported. I'll send out a v3 of this series that includes some tests
for those a bit later.
