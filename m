From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] git: submodule honor -c credential.* from command
 line
Date: Fri, 26 Feb 2016 17:05:54 -0500
Message-ID: <20160226220553.GA1835@sigill.intra.peff.net>
References: <1456514328-10153-1-git-send-email-jacob.e.keller@intel.com>
 <1456514328-10153-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:07:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQXW-00008P-NC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbcBZWF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 17:05:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:50350 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752825AbcBZWF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:05:57 -0500
Received: (qmail 5572 invoked by uid 102); 26 Feb 2016 22:05:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 17:05:56 -0500
Received: (qmail 8051 invoked by uid 107); 26 Feb 2016 22:06:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 17:06:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 17:05:54 -0500
Content-Disposition: inline
In-Reply-To: <1456514328-10153-3-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287625>

On Fri, Feb 26, 2016 at 11:18:48AM -0800, Jacob Keller wrote:

> +test_expect_success 'sanitize-config keeps credential.helper' "
> +	git -c credential.helper=helper submodule--helper sanitize-config >actual &&
> +	cat >expect <<-EOF &&
> +	'credential.helper=helper'
> +	EOF
> +	test_cmp expect actual
> +"

This can (and should) be "<<-\EOF", right?

I happened to be writing a test with the exact same problem (embedded
single-quotes) today, and realized we have another solution which is
used elsewhere in the test suite:

  sq="'"
  test_expect_success '...' '
	echo "${sq}credential.helper=helper${sq}" >expect &&
	...
  '

that is slightly more verbose, but it does let us keep the main body
inside single-quotes, without restoring to confusing backslash escaping.

-Peff
