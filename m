From: Charles Bailey <charles@hashpling.org>
Subject: Re: merge, keeping the remote as a new file?
Date: Mon, 2 Mar 2009 06:36:04 +0000
Message-ID: <20090302063604.GA17245@hashpling.org>
References: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com> <20090302041113.GA3094@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 07:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le1mU-0001rr-Cc
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 07:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbZCBGgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 01:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZCBGgJ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 01:36:09 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:12464 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752253AbZCBGgI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 01:36:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAJcNq0nUnw4U/2dsb2JhbADUQ4QaBg
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.pcl-ipout02.plus.net with ESMTP; 02 Mar 2009 06:36:05 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1Le1kz-0006eo-1S; Mon, 02 Mar 2009 06:36:05 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n226a4Ec017825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Mar 2009 06:36:04 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n226a4AR017824;
	Mon, 2 Mar 2009 06:36:04 GMT
Content-Disposition: inline
In-Reply-To: <20090302041113.GA3094@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 29319d73048b15d8fe90c9f605e454b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111903>

On Sun, Mar 01, 2009 at 11:11:13PM -0500, Jeff King wrote:
> On Sun, Mar 01, 2009 at 07:16:10PM -0500, Caleb Cushing wrote:
> 
> >  I have an unmerged file... the resolution I'd like to have is
> > checkout the local one for the current file name. take the remote
> > version and give it a new file name. what's the best way to do that?
> 
> I would use:
> 
>   $ git show :2:file >file
>   $ git show :3:file >newfile
>   $ git add file newfile
> 
> You can do the first with "git checkout --ours", but I don't think there
> is a way with "checkout" to say "checkout this path, but put it in a
> different place".
> 
> -Peff

You can use git checkout-index --temp --stage=3 and then move it from
the auto-generated temporary name into its new place.

The shell function checkout_staged_file in git-mergetool.sh does this
programmatically, it's not very beautiful as the output of
checkout-index --temp requires a bit of expr magic to get the
temporary file name out.

Using a checkout variant instead of a show or a cat-file might be
important if you are doing autocrlf or some other smudging.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
