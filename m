From: Alexey Dobriyan <adobriyan@sw.ru>
Subject: Re: [PATCH] Tweak git-quiltimport to allow more flexible series format
Date: Tue, 27 Nov 2007 19:52:20 +0300
Message-ID: <20071127165220.GA6220@localhost.sw.ru>
References: <20071122134849.GB6240@localhost.sw.ru> <7vsl2x26di.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, adobriyan@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 17:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix3hm-0005Zn-7p
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423AbXK0Qxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759416AbXK0Qxt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:53:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:14196 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759400AbXK0Qxs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 11:53:48 -0500
Received: from sw.ru ([192.168.0.16])
	by relay.sw.ru (8.13.4/8.13.4) with SMTP id lARGqLpi032364;
	Tue, 27 Nov 2007 19:52:24 +0300 (MSK)
Received: by sw.ru (nbSMTP-1.00) for uid 1000
	adobriyan@sw.ru; Tue, 27 Nov 2007 19:52:24 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vsl2x26di.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66240>

On Thu, Nov 22, 2007 at 03:43:53PM -0800, Junio C Hamano wrote:
> Alexey Dobriyan <adobriyan@sw.ru> writes:
> 
> > Make quiltimport also understand comments following patch name.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>
> > ---
> >
> >  git-quiltimport.sh |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/git-quiltimport.sh
> > +++ b/git-quiltimport.sh
> > @@ -63,7 +63,7 @@ tmp_info="$tmp_dir/info"
> >  commit=$(git rev-parse HEAD)
> >  
> >  mkdir $tmp_dir || exit 2
> > -for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
> > +for patch_name in $(sed -e 's/#.*//' < "$QUILT_PATCHES/series" ); do
> >  	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
> >  		echo "$patch_name doesn't exist. Skipping."
> >  		continue
> 
> Is this consistent with the way quilt groks the series file?
> 
> IOW, does quilt forbid patchfile whose name contains a hash, and
> anything after a hash on the line is taken as comment?

It looks like hash inside a patch name is legal.
 
> Can a line in a quilt series file name more than one patchfile?

No. Which means we can probably do sed -e 's/^#//' -e 's/[ \t]#.*//'
... let me experiment bit more.

> If so, are they whitespace separated?
