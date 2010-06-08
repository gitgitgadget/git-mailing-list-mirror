From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6] gitk: Use git-difftool for external diffs when
	available
Date: Tue, 8 Jun 2010 01:10:42 -0700
Message-ID: <20100608081040.GB14366@gmail.com>
References: <20100417085230.GC6681@brick.ozlabs.ibm.com> <1271751079-18884-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Arcila <thomas.arcila@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 10:10:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLttg-00020c-BE
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 10:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab0FHIKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 04:10:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61922 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0FHIKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 04:10:48 -0400
Received: by pvg16 with SMTP id 16so1775840pvg.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GeQW6x71HdleG5MX0oCng8BWSZzq8Was9v8uWObDNzo=;
        b=vSN14DDYK57JgWAokKM5Gn8jnbD0sK6ff32QdM56kdk9lT+yTegp7+OBx+7PibRUGE
         IQfXgYcVgqiGbA7aFUjQ0fs1swPRDPYLZDu7tnlrqC4JYsolD6Vk8aSiSD7Kd2g9Uxbe
         TsDarwYVHOh7x91LTO9tBSvtRq7ahf8+uc5xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jpOfHLg3lIVzxDSx3+y6AlmRyg/Bs5tvRd+tEx3YIjVdQStkILx64QONgJuOAnO+/m
         e6gapjmc9M933vj35ocSRygLAB8f+6KqVF8ITsVFrZ10ZfRJN4nupAW6VzS0NR3J1ann
         fXXYy9hwYXK99lQGDvf0h3Eb27JXxm7YA8GcA=
Received: by 10.114.32.31 with SMTP id f31mr12718707waf.195.1275984646931;
        Tue, 08 Jun 2010 01:10:46 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c1sm47479351wam.7.2010.06.08.01.10.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 01:10:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271751079-18884-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148652>

Hello,

Is there anything else (besides sending this email) that I can
do to help move this patch along?

I got another "gitk read-only repo broken" email this week,
which is what reminded me... ;-)

It's been a while.  I just rebased the patch against the latest
master and it didn't have any conflicts.  Resend?

On Tue, Apr 20, 2010 at 01:11:19AM -0700, David Aguilar wrote:
> git-difftool's '--extcmd=frotz' was added in 1.7.0 and
> is the mechanism through which gitk launches the
> configured 'extdifftool'.  When 'extdifftool' is
> misconfigured an error dialog is used to display
> git-difftool's stdout and stderr.
> 
> The existing implementation moved into 'proc gitkextdiff'
> for use with git < 1.7.0.
> 
> One benefit of this change is that gitk's external diff
> no longer requires write-access to the current directory.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> Changes since last time:
> 
> * Errors are shown using 'proc error_popup'
> * The existing code moved into a tidy function
> 
>  gitk |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 1b0e09a..0533baf 100755
> --- a/gitk
> +++ b/gitk
> @@ -3361,6 +3361,7 @@ proc external_diff {} {
>      global flist_menu_file
>      global diffids
>      global extdifftool
> +    global git_version
>  
>      if {[llength $diffids] == 1} {
>          # no reference commit given
> @@ -3380,6 +3381,30 @@ proc external_diff {} {
>          set diffidfrom [lindex $diffids 0]
>          set diffidto [lindex $diffids 1]
>      }
> +    if {[package vcompare $git_version "1.7.0"] < 0} {
> +        gitkextdiff $diffidfrom $diffidto
> +        return
> +    }
> +
> +    set cmd [list "git" "difftool" "--no-prompt" "--extcmd=$extdifftool"]
> +    if {$diffidfrom ne $nullid && $diffidfrom ne $nullid2} {
> +        lappend cmd $diffidfrom
> +    }
> +    if {$diffidto ne $nullid && $diffidto ne $nullid2} {
> +        lappend cmd $diffidto
> +    }
> +    lappend cmd "--" $flist_menu_file
> +
> +    set pipe [open |$cmd r]
> +    set stdout [read $pipe]
> +    if {[catch {close $pipe} stderr] != 0} {
> +        error_popup "git-difftool: $stdout $stderr"
> +    }
> +}
> +
> +proc gitkextdiff {diffidfrom diffidto} {
> +    global flist_menu_file
> +    global extdifftool
>  
>      # make sure that several diffs wont collide
>      set diffdir [gitknewtmpdir]
> -- 
> 1.7.1.rc2.5.gddd02
> 

-- 
		David
