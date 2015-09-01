From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/6] t6300: introduce test_date() helper
Date: Tue, 1 Sep 2015 23:40:13 +0100
Message-ID: <20150901224013.GJ30659@serenity.lan>
References: <cover.1441144343.git.john@keeping.me.uk>
 <8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
 <20150901223157.GE7862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:40:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuE9-000127-Si
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbIAWk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:40:26 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53985 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbIAWkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:40:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0C3ACCDA547;
	Tue,  1 Sep 2015 23:40:25 +0100 (BST)
X-Quarantine-ID: <OnGzqa-xGZdq>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OnGzqa-xGZdq; Tue,  1 Sep 2015 23:40:24 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 77E80CDA56D;
	Tue,  1 Sep 2015 23:40:15 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150901223157.GE7862@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277066>

On Tue, Sep 01, 2015 at 06:31:58PM -0400, Jeff King wrote:
> On Tue, Sep 01, 2015 at 10:55:41PM +0100, John Keeping wrote:
> 
> > I considered moving the test_expect_success into the helper, like with
> > test_atom earlier in the file, but it doesn't make the code much more
> > concise and we still need either to setup the output outside the test
> > case or to escape SQ inside SQ.
> 
> Moving it inside also makes it harder to test_expect_failure. :)
> 
> >  test_expect_success 'Check unformatted date fields output' '
> > -	(git for-each-ref --shell --format="%(refname) %(committerdate) %(authordate)" refs/heads &&
> > -	git for-each-ref --shell --format="%(refname) %(taggerdate)" refs/tags) >actual &&
> > -	test_cmp expected actual
> > +	test_date "" "Mon Jul 3 17:18:43 2006 +0200" "Mon Jul 3 17:18:44 2006 +0200" "Mon Jul 3 17:18:45 2006 +0200"
> 
> I notice we end up with rather long lines for some of these. Would:
> 
>   test_date "" <<-\EOF
>   Mon Jul 3 17:18:43 2006 +0200
>   Mon Jul 3 17:18:44 2006 +0200
>   Mon Jul 3 17:18:45 2006 +0200
>   EOF
> 
> be more readable?

We could just do:

	test_date "" \
		"Tue Jul 4 01:18:43 2006 +0200" \
		"Tue Jul 4 01:18:44 2006 +0200" \
		"Tue Jul 4 01:18:45 2006 +0200"

I'm not entirely sure why I didn't now that I look at it!
