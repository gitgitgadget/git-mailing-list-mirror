From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: Remove mc parameter from proc show_error
Date: Sat, 2 May 2015 22:24:33 -0600
Message-ID: <CAMMLpeQj2N9Qa+KKiaCRUOjx_=cAf=GTW6QADBySE9VsY_Xg=w@mail.gmail.com>
References: <1430536400-22008-1-git-send-email-alexhenrie24@gmail.com> <20150502100513.GA19038@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bernt Hansen <bernt@norang.ca>,
	Git mailing list <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun May 03 06:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YolSm-0005PI-Tn
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 06:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbbECEY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 00:24:57 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37679 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbECEYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 00:24:55 -0400
Received: by widdi4 with SMTP id di4so80492044wid.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 21:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ToJTClz8TtqU8mKOznINQ+Cm4EU2PMXetkXvukv4gKc=;
        b=kU1NatXEP+JlGI73aSbGTBjvr2aEHmk56gRx8sVnLuoqkZrblTUSfsOEhUX1qcaZBn
         HcdPUODMFBhADLc+HlaI9bnPxnefKxl4fDLEJ+wt5SWSighEvYpUWAzQCDsatdKXLNem
         ccXaL6kb8OQzhLdJ3T8CPS5y+8sGqyFlL8t5mHzCy4f8d23BAWpjjPjgIKF+d+e2euO5
         hyH+zp4NdA3jQUmF++BR9hfER4pDTSWSd8O04RNILbWISceO48+tLKFGVC1PCYgTEe8c
         POH0NPlkNJ9+g0WElPidVXX/aK4x9IPFOApwWA7p2MCcOZNpXG+WODLyyhdLHQckZM8/
         IAlg==
X-Received: by 10.180.91.77 with SMTP id cc13mr9020176wib.88.1430627093729;
 Sat, 02 May 2015 21:24:53 -0700 (PDT)
Received: by 10.28.182.84 with HTTP; Sat, 2 May 2015 21:24:33 -0700 (PDT)
In-Reply-To: <20150502100513.GA19038@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268258>

2015-05-02 4:05 GMT-06:00 Paul Mackerras <paulus@samba.org>:
> To test this, I changed {package require Tk 8.4} to {package require
> Tk 8.7}, in order to deliberately trigger the error.  When I run gitk
> with that change (and your patch applied), I get this in the xterm
> where I run gitk:
>
> $ ./gitk
> Error in startup script: invalid command name "mc"
>     while executing
> "mc OK"
>     (procedure "show_error" line 7)
>     invoked from within
> "show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n Gitk requires at least Tcl/Tk 8.4.""
>     invoked from within
> "if {[catch {package require Tk 8.7} err]} {
>     show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
>                      Gitk requires at least ..."
>     (file "./gitk" line 12012)
>
> and no pop-up window.  So this patch still isn't quite right.

Good point. We can fix this by importing ::msgcat::mc earlier.

> Given that old versions of tcl/tk probably don't have [mc], I think
> it's inevitable that "OK" will have to be untranslated for that
> particular error path.

msgcat and ::msgcat::mc were added in Tcl 8.1a2, released Febuary 23,
1998. See the "changes" file in
<ftp://ftp.tcl.tk/pub/tcl/tcl8_1/tcl8.1.tar.gz>. Surely you are not
trying to support Tcl 8.0 and earlier, so we should be able to use mc
all we want.

-Alex
