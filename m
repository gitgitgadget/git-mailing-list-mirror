From: "Michael Wookey" <michaelwookey@gmail.com>
Subject: Re: Extremely simple Vim interface for Git
Date: Mon, 8 Sep 2008 08:47:41 +1000
Message-ID: <d2e97e800809071547m2b2e0f82ycc370f048d826b2d@mail.gmail.com>
References: <20080906193744.GA3122@mithlond.arda.local>
	 <d2e97e800809070332t35e4ed46u7af4653ea768b39b@mail.gmail.com>
	 <20080907131356.GC3387@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Sep 08 00:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcT5C-0007ma-Ql
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYIGWrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbYIGWrm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:47:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:42023 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYIGWrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:47:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1182805rvb.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SPBORXtkvXsZcNDoqeFieQGe+Dp79A4E0SXq95PGkrM=;
        b=M3syhByCffPpx2P7QcvP9Aud/sMXPH9Qcvm463EnET/nN+SUKfwmxerATRubqjzolX
         4iqn4tDnI0xdoUenaETmc0ReLi1LlTmGAS4deYsU64rO1Qdocp4F9Lwhzi591i5tQPB9
         ImoO+j67zGqwh7wINboNzfTwtPerBmv3T/XXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XlQr/uUgWl7jbkEm+SyAkLYnB3obtXrip3OOrC5IoCHFaRmgiWfuXa8owCxPjXVclN
         IYyDxCVA5KIcOD83nvtc7IMeXq5f83gNtcY4yOu/vgPW/5ugB3KTJltIXhz3c+GmmyzH
         z7/78PX4r9eCdtAh8AofoT0dVJGSp+sybYflk=
Received: by 10.141.43.5 with SMTP id v5mr8362619rvj.216.1220827661222;
        Sun, 07 Sep 2008 15:47:41 -0700 (PDT)
Received: by 10.141.115.15 with HTTP; Sun, 7 Sep 2008 15:47:41 -0700 (PDT)
In-Reply-To: <20080907131356.GC3387@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95185>

>> If you alter the RunShellCommand() function to the following -
>
>>       if stridx(a:cmdline, "diff") > 0
>>           set filetype=diff
>>       endif
>
>> Then Vim will apply diff syntax highlighting to the scratch buffer
>> when a "diff" command is executed.
>
> Good idea. I implemented the same thing this way:
>
>    if match(a:cmdline,'\v^(git|hg|svn|bzr) diff') >= 0
>        setlocal filetype=diff
>    endif

Vim 7.2 provides a better alternative.  If the command is specifically
'git' then setting the filetype to 'git' also provides the correct
syntax highlighting.

For example,

  if v:version >= 702
      if stridx(a:cmdline, "git") == 0
          setlocal filetype=git
      endif
  endif

Syntax highlighting is displayed correctly for several commands including:

  :Git diff
  :Git show
  :Git log

And possibly others.  If Vim (7.2) is your default editor when
performing a "git commit" then there is also a new built in Vim
command -

  :DiffGitCached

This opens a preview window with the contents of "git diff --cached".
The :DiffGitCached command is only available when filetype=gitcommit.

Perhaps some of these ideas should be added to the Vim wiki...

http://vim.wikia.com/wiki/Display_shell_commands%27_output_on_Vim_window
