From: "Michael Wookey" <michaelwookey@gmail.com>
Subject: Re: Extremely simple Vim interface for Git
Date: Sun, 7 Sep 2008 20:32:48 +1000
Message-ID: <d2e97e800809070332t35e4ed46u7af4653ea768b39b@mail.gmail.com>
References: <20080906193744.GA3122@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Sep 07 12:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcHae-0004fA-Ea
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 12:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbYIGKcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 06:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbYIGKcu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 06:32:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:48539 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbYIGKct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 06:32:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1016563rvb.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oObGbazczcnKSF/vsRwgXBORS3Q6t/i5QfT2N5cmAgo=;
        b=Uo/xiA/WPTOupB/hRzSFvF7nlmLTHL92WTyZZ9BJRDWWBqzMb4hDyzUYU9BhU4pIGM
         hLlP3eajI5+7uQR0v72T8+u+a61zTL3/kpuNh6oG1nKNJJw+2qItElxI3QXoTFtfvPsS
         /5krxS3O4zKdptBqQnYOCh/OuQah/FQvU6Y28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vmQpjnnVRli7kba/GHskVcyg67M+kbvCkqdfJ4VHJffbcNUZ3muwDIv/li342SlhP6
         7t3KUbVs8iuYod+WNMjGyCa/gLP1Hvxa4J7LVX5dL5CsTbyqIfs67veovPmCU1ZNPmeD
         WlfXEIX7dTK33bvfZ/uPGtddKKVu7bWitOvXE=
Received: by 10.140.201.4 with SMTP id y4mr8025167rvf.86.1220783568628;
        Sun, 07 Sep 2008 03:32:48 -0700 (PDT)
Received: by 10.141.115.15 with HTTP; Sun, 7 Sep 2008 03:32:48 -0700 (PDT)
In-Reply-To: <20080906193744.GA3122@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95132>

> Here's a very simple idea for using Git from Vim editor. Add these lines
> to your ~/.vimrc file:
>
>
>    command! -complete=file -nargs=* Git   call s:RunShellCommand('git '.<q-args>)
>    command! -complete=file -nargs=* Svn   call s:RunShellCommand('svn '.<q-args>)
>    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
>
>    let $EDITOR = '/usr/bin/gvim --nofork'
>
>    function! s:RunShellCommand(cmdline)
>        botright new
>        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
>        setlocal nowrap
>        call setline(1,a:cmdline)
>        call setline(2,substitute(a:cmdline,'.','=','g'))
>        execute 'silent 2read !'.escape(a:cmdline,'()%#')
>        setlocal nomodifiable
>        1
>    endfunction

If you alter the RunShellCommand() function to the following -

  function! s:RunShellCommand(cmdline)
      botright new
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
      setlocal nowrap
      if stridx(a:cmdline, "diff") > 0
          set filetype=diff
      endif
      execute 'silent 0read !'.escape(a:cmdline,'%#')
      setlocal nomodifiable
      1
  endfunction

Then Vim will apply diff syntax highlighting to the scratch buffer
when a "diff" command is executed.

For example:

  :Git diff
  :Git diff --cached

etc..
