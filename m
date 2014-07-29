From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] difftool: don't assume that default sh is sane
Date: Tue, 29 Jul 2014 00:53:29 -0700
Message-ID: <20140729075328.GA20724@gmail.com>
References: <1405787717-30476-1-git-send-email-charles@hashpling.org>
 <1405787717-30476-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 09:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC2DT-0005Um-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 09:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbaG2Hww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 03:52:52 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61931 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaG2Hww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 03:52:52 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so11248197pdj.16
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R1uEO2ohQ+FP36Q5CsNz3ZlNqDUnrAE3tQC9EBMqWPo=;
        b=BqKfZKnNYHyIgbvma9/pXAtTGcZhifjfTwnVEwPlemvOaLSCHXr8m5glXs3Pb/S3Uh
         bDBSRTqFlXSIdBkfFqI4O/7e2vW1nsANmlW3z40ZhxvvbrjFX3yFq/UPEzoHVK+GqdQ1
         VbRWmZuqT9fJxvVju5ZgQ4Kj6kyhypVRZlnUZ0cQCIFaGsczfA/l3MaSXQQyqdrgkTKa
         03cVAyseGxT06dPn+wZcTKLEFZvpcuzWLQ0qRmd4l0z8X/mysTr0pgZn2R2y+cKfREgQ
         BqRnhc8Q022URisYLIXrlnZfwocZUfsCP5e14c/nVkFpalXjXWviNIojoCQnVv3JzFIf
         OUog==
X-Received: by 10.66.142.42 with SMTP id rt10mr326890pab.1.1406620371540;
        Tue, 29 Jul 2014 00:52:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id xq3sm75071256pab.0.2014.07.29.00.52.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 00:52:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405787717-30476-2-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254400>

On Sat, Jul 19, 2014 at 05:35:17PM +0100, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> git-difftool used to create a command list script containing $( ... )
> and explicitly call "sh -c" with this list.
> 
> Instead, allow mergetool --tool-help to take a mode parameter and call
> mergetool directly to invoke the show_tool_help function. This mode
> parameter is intented for use solely by difftool.
> 
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> ---
> Another issue for Solaris. Originally I had a fix for this that
> substituted "@SHELL_PATH@" even inside perl scripts but I felt that
> having an interface for show_tool_help was a little neater all round but
> I welcome alternative views.

I definitely agree that having an interface is nice and tidy.

>  git-difftool.perl |  6 +-----
>  git-mergetool.sh  | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 18ca61e..598fcc2 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -47,13 +47,9 @@ sub find_worktree
>  
>  sub print_tool_help
>  {
> -	my $cmd = 'TOOL_MODE=diff';
> -	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
> -	$cmd .= ' && show_tool_help';
> -
>  	# See the comment at the bottom of file_diff() for the reason behind
>  	# using system() followed by exit() instead of exec().
> -	my $rc = system('sh', '-c', $cmd);
> +	my $rc = system(qw(git mergetool --tool-help=diff));

I believe qw() in list context is considered deprecated.

cheers,
-- 
David
