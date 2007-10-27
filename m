From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Add NEED_WORK_TREE for more commands
Date: Sat, 27 Oct 2007 12:42:57 +0200
Organization: glandium.org
Message-ID: <20071027104257.GA8876@glandium.org>
References: <20071027081910.GA23381@laptop> <20071027090822.GA6789@glandium.org> <20071027101839.GA26043@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 12:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilj9B-0002D0-Kn
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 12:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbXJ0Kny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 06:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbXJ0Kny
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 06:43:54 -0400
Received: from vawad.err.no ([85.19.200.177]:53195 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbXJ0Knx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 06:43:53 -0400
Received: from aputeaux-153-1-53-36.w82-124.abo.wanadoo.fr ([82.124.139.36] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ilj8t-00086Z-8S; Sat, 27 Oct 2007 12:43:49 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Ilj85-0002Je-Mx; Sat, 27 Oct 2007 12:42:57 +0200
Content-Disposition: inline
In-Reply-To: <20071027101839.GA26043@laptop>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62484>

On Sat, Oct 27, 2007 at 05:18:39PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sat, Oct 27, 2007 at 11:08:22AM +0200, Mike Hommey wrote:
> > On Sat, Oct 27, 2007 at 03:19:10PM +0700, Nguy???n Th??i Ng???c Duy wrote:
> > > 
> > > Signed-off-by: Nguy???n Th??i Ng???c Duy <pclouds@gmail.com>
> > > ---
> > >  git.c |   12 ++++++------
> > >  1 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/git.c b/git.c
> > > index 23a430c..9db40b3 100644
> > > --- a/git.c
> > > +++ b/git.c
> > > +		{ "ls-files", cmd_ls_files, RUN_SETUP | NEED_WORK_TREE },
> > > +		{ "update-index", cmd_update_index, RUN_SETUP | NEED_WORK_TREE },
> > 
> > At least these two work very fine without a working tree (and I *do*
> > need them to work without a working tree).
> 
> How can you do that while both need index and a working directory to
> operate?

For example, ls-files -c and update-index --remove don't need more than
the index, and you don't need a working tree to fiddle with the index
with these commands.

By the way, git-rm has a --cached option that allows it to only work on
the index, but it has a NEED_WORK_TREE which prevents its use without a
working tree in such a case (though I don't know if the implementation
itself relies on the working tree or not, but if it does, it shouldn't).
It's sad to have to do 
git-ls-files -c directory | xargs -d "\n" git-update-index --remove
instead of
git-rm -r --cached directory
when you want to remove a directory in a bare repository.

Mike
