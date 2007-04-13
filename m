From: Greg KH <greg@kroah.com>
Subject: Re: git-quiltimport complaining yet still working
Date: Fri, 13 Apr 2007 14:19:13 -0700
Message-ID: <20070413211913.GA7134@kroah.com>
References: <20070413203837.GA27660@kroah.com> <68948ca0704131413t687c7196h70c6cc8c316b640e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 23:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcTDY-0008RU-UC
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 23:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbXDMVVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbXDMVVb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 17:21:31 -0400
Received: from canuck.infradead.org ([209.217.80.40]:41734 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030367AbXDMVVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 17:21:30 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HcTCv-00083d-4I; Fri, 13 Apr 2007 17:21:25 -0400
Content-Disposition: inline
In-Reply-To: <68948ca0704131413t687c7196h70c6cc8c316b640e@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44432>

On Fri, Apr 13, 2007 at 05:13:58PM -0400, Don Zickus wrote:
> On 4/13/07, Greg KH <greg@kroah.com> wrote:
> >In git 1.5.1 the quiltimport function started complaining in a new way:
> >
> >        libata-clear-tf-before-doing-request-sense.patch
> >        Patch is empty.  Was is split wrong?
> >        /usr/bin/git-quiltimport: line 78: stop_here: command not found
> 
> Sorry about that.  I assumed all the scripts using git-mailinfo had
> the stop_here command.  Not sure why I made that assumption.
> 
> I changed the behaviour of git-mailinfo to allow empty patches and
> have the scripts check if a patch was empty and fail.  Unfortunately,
> I incorrectly applied the change to git-quiltimport.
> 
> Anyway the following should fix it.
> 
> Signed-off-by: Don Zickus <dzickus@redhat.com>

> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index edccd82..0d20dc5 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -75,7 +75,7 @@ for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
>  	(cat $QUILT_PATCHES/$patch_name | git-mailinfo "$tmp_msg" "$tmp_patch" > "$tmp_info") || exit 3
>  	test -s $dotest/patch || {
>  		echo "Patch is empty.  Was is split wrong?"
> -		stop_here $this
> +		exit 3

Are you sure?  This will exit, and yet, there was nothing really wrong
with the patch in the first place (as proven by the fact that it is
applied properly.)

Or did the patch format that can be accepted by git-quiltimport suddenly
change somehow?  I'm passing mbox-like files to it, and have been since
it was created.  To change this, is fine, but let me know what format
is now needed please.

thanks,

greg k-h
