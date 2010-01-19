From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] rev-parse --namespace
Date: Tue, 19 Jan 2010 01:56:09 -0500
Message-ID: <20100119065609.GB3946@coredump.intra.peff.net>
References: <7vk4vfsv64.fsf@alter.siamese.dyndns.org>
 <1263808296-30756-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:56:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX80v-0008Vv-RO
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab0ASG4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218Ab0ASG4M
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:56:12 -0500
Received: from peff.net ([208.65.91.99]:39691 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab0ASG4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:56:11 -0500
Received: (qmail 17111 invoked by uid 107); 19 Jan 2010 07:01:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 Jan 2010 02:01:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2010 01:56:09 -0500
Content-Disposition: inline
In-Reply-To: <1263808296-30756-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137435>

On Mon, Jan 18, 2010 at 11:51:36AM +0200, Ilari Liusvaara wrote:

> Add --namespace=<namespace> option to rev-parse and everything that
> accepts its options. This option matches all refs in some subnamespace
> of refs hierarchy.

Thanks, I think the code in this version looks good, but:

> --- /dev/null
> +++ b/t/t6018-rev-list-namespace.sh
> [...]
> +compare () {
> +	# Split arguments on whitespace.
> +	git $1 $2 | sort >expected &&
> +	git $1 $3 | sort >actual &&
> +	cmp expected actual
> +}

Please use test_cmp instead of regular cmp.

Also, do you really need to sort? The internal ref code keeps the ref
lists sorted by name, and we merge-sort the packed and loose lists in
do_for_each_ref. So your --namespace should always operate on the refs
in sorted order, producing predictable results.

> +test_expect_success 'setup' '
> +
> +	commit master &&
> +	git checkout -b subspace/one master
> +	commit one &&
> +	git checkout -b subspace/two master
> +	commit two &&
> +	git checkout -b subspace-x master
> +	commit subspace-x &&
> +	git checkout -b other/three master
> +	commit three &&
> +	git checkout -b someref master
> +	commit some &&
> +	git checkout master &&
> +	commit master2
> +'

You are still missing some '&&' here to detect setup failures.

-Peff
