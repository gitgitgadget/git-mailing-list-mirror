From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote: handle pushremote config in any order order
Date: Mon, 24 Feb 2014 15:39:47 -0500
Message-ID: <20140224203946.GB25506@sigill.intra.peff.net>
References: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
 <20140224085903.GA10698@sigill.intra.peff.net>
 <xmqqvbw49z0f.fsf@gitster.dls.corp.google.com>
 <xmqq7g8k8d5r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jack Nagel <jacknagel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:39:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2Jd-0005Nf-QT
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbaBXUjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:39:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:56262 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753261AbaBXUjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:39:49 -0500
Received: (qmail 21501 invoked by uid 102); 24 Feb 2014 20:39:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 14:39:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 15:39:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7g8k8d5r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242645>

On Mon, Feb 24, 2014 at 12:32:32PM -0800, Junio C Hamano wrote:

> >> +test_expect_success 'branch.*.pushremote config order is irrelevant' '
> >> +	mk_test one_repo heads/master &&
> >> +	mk_test two_repo heads/master &&
> >> +	test_config remote.one.url one_repo &&
> >> +	test_config remote.two.url two_repo &&
> >> +	test_config branch.master.pushremote two_repo &&
> >> +	test_config remote.pushdefault one_repo &&
> >> +	git push &&
> >> +	check_push_result one_repo $the_first_commit heads/master &&
> >> +	check_push_result two_repo $the_commit heads/master
> >> +'
> >> +
> 
> This test however does not pass in the Git 2.0 world, without having
> this line:
> 
>        test_config push.default matching &&
> 
> immediately before "git push".
> 
> Am I missing something?

No, you are not missing anything. I was copying and paring down the
pushremote test above, and I accidentally pared out the push.default
setting. It should definitely have a

  test_config push.default matching &&

before the "git push" line, as the test above does. Can you mark it up
as you apply?

-Peff
