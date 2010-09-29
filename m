From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Wed, 29 Sep 2010 01:16:41 -0400
Message-ID: <20100929051640.GA26324@sigill.intra.peff.net>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
 <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 07:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0p2S-00034E-0M
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 07:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab0I2FQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 01:16:58 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab0I2FQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 01:16:57 -0400
Received: (qmail 5477 invoked by uid 111); 29 Sep 2010 05:16:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 29 Sep 2010 05:16:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Sep 2010 01:16:41 -0400
Content-Disposition: inline
In-Reply-To: <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157529>

On Tue, Sep 28, 2010 at 10:38:04PM +0200, Michael J Gruber wrote:

> +help:
> +	@awk '/^# Help:/ { l=substr($$0,8); \
> +		getline; \
> +		j=index(l,":"); \
> +		print substr(l,1,j-1), substr($$0,1,index($$0,":")), substr(l,j+2); \
> +		}' <Makefile | sort | while read category target text; \
> +	do \
> +		test "$$category" = "$$currcat" || printf "$$category targets:\n"; \
> +		currcat="$$category"; \
> +		printf "    %-20s%s\n" "$$target" "$$text"; \
> +	done

Surely this is why we have perl?

help:
	@perl -n0777 \
	  -e 'push @{$$h{$$1}}, [$$3, $$2] while /^# Help: (.*?): (.*)\n(.*?):/mg;' \
	  -e 'for (sort keys(%h)) {' \
	  -e '  print "$$_:\n";' \
	  -e '  printf("    %-20s%s\n", @$$_) for (@{$$h{$$_}});' \
	  -e '}' Makefile

Note that mine will actually print the targets in a heading in the order
in which they appear in the Makefile, which I consider slightly more
useful (especially in that we can tweak the order easily). It would also
be easy to sort the headers in some more meaningful way, but here I just
did it lexically.

-Peff
