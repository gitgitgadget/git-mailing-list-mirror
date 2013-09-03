From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 03:12:56 -0400
Message-ID: <20130903071256.GD3608@sigill.intra.peff.net>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:13:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGknQ-0005ag-3I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab3ICHM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:12:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:52850 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab3ICHM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:12:59 -0400
Received: (qmail 20161 invoked by uid 102); 3 Sep 2013 07:12:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 02:12:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 03:12:56 -0400
Content-Disposition: inline
In-Reply-To: <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233689>

On Mon, Sep 02, 2013 at 01:30:38AM -0500, Felipe Contreras wrote:

> Just as 5 == X is weird, so is comparing first the expected value, and
> then the value we are testing. So switch them around.

Actually, our normal comparison order for test output is "test_cmp
expect actual", as it shows a test failure as a diff with the expected
output as the base (i.e., the diff shows what went wrong).

That reasoning does not apply to "test a = b", which shows no output at
all. However, if you want to clean up and modernize these tests, it
would probably be better to simply convert them to use test_cmp.

I wonder if we should have a:

  test_cmp_args () {
          echo "$1" >expect &&
          echo "$1" >actual &&
          test_cmp expect actual
  }

to let these remain one-liners like:

  test_cmp_args "$(git rev-parse start)" "$(git rev-parse final^1^1^1)"

-Peff
