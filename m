From: Teemu Likonen <tlikonen@iki.fi>
Subject: Extremely simple Vim interface for Git
Date: Sat, 6 Sep 2008 22:37:44 +0300
Message-ID: <20080906193744.GA3122@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 21:38:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc3cX-0001Dw-Dx
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 21:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbYIFThs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYIFThs
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 15:37:48 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:56431 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYIFThr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 15:37:47 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F153401CFE048 for git@vger.kernel.org; Sat, 6 Sep 2008 22:37:46 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Kc3bM-0001x9-MQ
	for git@vger.kernel.org; Sat, 06 Sep 2008 22:37:44 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95096>

Here's a very simple idea for using Git from Vim editor. Add these lines 
to your ~/.vimrc file:


    command! -complete=file -nargs=* Git   call s:RunShellCommand('git '.<q-args>)
    command! -complete=file -nargs=* Svn   call s:RunShellCommand('svn '.<q-args>)
    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

    let $EDITOR = '/usr/bin/gvim --nofork'

    function! s:RunShellCommand(cmdline)
        botright new
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
        setlocal nowrap
        call setline(1,a:cmdline)
        call setline(2,substitute(a:cmdline,'.','=','g'))
        execute 'silent 2read !'.escape(a:cmdline,'()%#')
        setlocal nomodifiable
        1
    endfunction


Now, command :Git works just like "git" from shell except that the 
output is displayed in a Vim scratch buffer/window. The buffer will be 
wiped out from memory when the window is closed. Filename completion and 
piping works. Examples:

    :Git diff --cached
    :Git help merge
    :Git branch | column

(I am aware that there are VCS plugins for Vim. I happen like this 
approach better because it works just like the command line Git which 
I'm familiar with.)

As a "side effect" this also adds similar :Svn command as well as :Shell 
command which can be used to run any shell command and have its output 
displayed in a Vim window. Using the first two letters of :Shell is 
enough in my system because I don't have other custom commands which 
start with letters "Sh".

    :Sh ls -l
