From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with
 no-done cap
Date: Thu, 6 Feb 2014 14:42:59 -0500
Message-ID: <20140206194249.GD14552@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:43:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUqs-00041F-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbaBFTnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:43:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:45933 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755150AbaBFTnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:43:04 -0500
Received: (qmail 24367 invoked by uid 102); 6 Feb 2014 19:43:03 -0000
Received: from mobile-032-128-012-224.mycingular.net (HELO sigill.intra.peff.net) (32.128.12.224)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Feb 2014 13:43:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Feb 2014 14:42:59 -0500
Content-Disposition: inline
In-Reply-To: <1391699439-22781-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241718>

On Thu, Feb 06, 2014 at 10:10:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> In smart http, upload-pack adds new shallow lines at the beginning of
> each rpc response. Only shallow lines from the first rpc call are
> useful. After that they are thrown away. It's designed this way
> because upload-pack is stateless and has no idea when its shallow
> lines are helpful or not.
>=20
> So after refs are negotiated with multi_ack_detailed and both sides
> happy. The server sends "ACK obj-id ready", terminates the rpc call
> and waits for the final rpc round. The client sends "done". The serve=
r
> sends another response, which also has shallow lines at the beginning=
,
> and the last "ACK obj-id" line.
>=20
> When no-done is active, the last round is cut out, the server sends
> "ACK obj-id ready" and "ACK obj-id" in the same rpc
> response. fetch-pack is updated to recognize this and not send
> "done". However it still tries to consume shallow lines, which are
> never sent.
>=20
> Update the code, make sure to skip consuming shallow lines when
> no-done is enabled.

Thanks for a nice explanation.

> +# This test is tricky. We need large enough "have"s that fetch-pack
> +# will put pkt-flush in between. Then we need a "have" the the serve=
r

s/the the/the/

> +# does not have, it'll send "ACK %s ready"
> +test_expect_success 'add more commits' '
> +	(
> +	cd shallow &&
> +	for i in $(seq 10); do

This probably needs to be test_seq for portability.

-Peff
