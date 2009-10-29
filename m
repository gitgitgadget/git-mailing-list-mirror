From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Thu, 29 Oct 2009 07:37:02 -0700
Message-ID: <20091029143702.GU10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-27-git-send-email-spearce@spearce.org> <7vpr86dgyj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:37:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3W7j-0006RM-FG
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 15:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbZJ2Og5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbZJ2Og5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 10:36:57 -0400
Received: from george.spearce.org ([209.20.77.23]:53566 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbZJ2Og5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 10:36:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1D4BF381D3; Thu, 29 Oct 2009 14:37:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vpr86dgyj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131594>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +test_expect_success 'clone http repository' '
> > +	GIT_CURL_VERBOSE=1 git clone $HTTPD_URL/git/repo.git clone 2>err &&
> > +	test_cmp file clone/file &&
> > +	egrep "^([<>]|Pragma|Accept|Content-|Transfer-)" err |
> > +	egrep -v "^< (Server|Expires|Date|Content-Length:|Transfer-Encoding: chunked)" |
> > +	sed -e "
> > +		s/
> > //
> > +		s/^Content-Length: .*$/Content-Length: xxxx/
> > +	" >act &&
> 
> This chomped line is so unlike you---what happened?

I was getting different Content-Lengths on different runs of the
test.  I don't know why.  Here the Content-Length is of the gzip'd
request, it shouldn't be varying with each run, but it seemed to be.
 
> Also, when the last downstream is sed, why would you even need two egrep
> process?

That's a really good point.  This is just stupid, I started with
the two egreps to filter the lines, then found I needed to strip
CRs, and then had to munge the Content-Length, and I just forgot
to merge the egrep cases into the sed script.

I'll fix this.  Thanks.

-- 
Shawn.
