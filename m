From: Charles Bailey <charles@hashpling.org>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 09:16:11 +0000
Message-ID: <20090129091611.GB10490@hashpling.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129081438.GA10490@hashpling.org> <7vbptqh60w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 10:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LST28-00061X-KQ
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 10:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbZA2JQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 04:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbZA2JQS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 04:16:18 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:50265 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767AbZA2JQP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 04:16:15 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACcCgUnUnw4R/2dsb2JhbADLBoQOBg
Received: from pih-relay04.plus.net ([212.159.14.17])
  by relay.pcl-ipout02.plus.net with ESMTP; 29 Jan 2009 09:16:12 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1LST0N-0005W2-Q2; Thu, 29 Jan 2009 09:16:12 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0T9GBeo011599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Jan 2009 09:16:11 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0T9GBn2011598;
	Thu, 29 Jan 2009 09:16:11 GMT
Content-Disposition: inline
In-Reply-To: <7vbptqh60w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 3906e480fc918c705863074e1f28b3a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107649>

On Thu, Jan 29, 2009 at 12:26:39AM -0800, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> > On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:
> >> * cb/mergetool (Wed Jan 21 22:57:48 2009 +0000) 1 commit
> >>  + mergetool: respect autocrlf by using checkout-index
> >> 
> >
> > Can you hold off on merging this one? I now think that there's a
> > cleaner way of doing this and I would like the opportunity for a
> > rethink.
> 
> Sure, it is not in 'master' yet.
> 
> But it's in 'next', so incremental updates from now on, please.
> 

OK, I've thought again and I still think that this patch is good.

Just so you know what I was thinking...

I felt that the new shell function that calls git checkout-index was a
bit clunky. git checkout-index --temp creates its own temporary file
and then the git mergetool renames this file to the temporary filename
that it had already decided on.

An earlier patch to mergetool was careful to ensure that mergetool
temporaries maintained the file extension of the target file in order
to help syntax highlighting merge tools. For this reason, just using
checkout-index generated filenames is not a sufficient solution.

I had two ideas, the first was that perhaps git mergetool could choose
a temporary naming scheme that could be matched by the appropriate use
of checkout-index --prefix. This would obviously preserve the file
extension but it's fairly obvious that it would have surprising
behaviour for merging files in subfolders.

My last idea would be to add an explicit --to-path= to git
checkout-index. It would make the mergetool code simpler but I'm not
sure how useful it would be in any other circumstance.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
