From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Do not unquote + into ' ' in URLs
Date: Sat, 24 Jul 2010 01:04:24 +0200
Message-ID: <201007240104.25341.trast@student.ethz.ch>
References: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com> <db9c97908966fa332be07b2a9f5215679e35b9e0.1279920066.git.trast@student.ethz.ch> <7viq45eswt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	<avarab@gmail.com>, <jstpierre@mecheye.net>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 01:04:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcRI8-0001x2-Vl
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 01:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab0GWXE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 19:04:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4955 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab0GWXE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 19:04:27 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 24 Jul
 2010 01:04:26 +0200
Received: from thomas.localnet (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 24 Jul
 2010 01:04:23 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <7viq45eswt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151584>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Since 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23) the URL
> > logic unquotes escaped URLs.  For the %2B type of escape, this is
> > conformant with RFC 2396.  However, it also unquotes + into a space
> > character, which is only appropriate for the query strings in HTTP.
> > This notably broke fetching from the gtk+ repository.
> 
> Wait a minute.
> 
> > Based on the discussion, I would consider this a bugfix that should go
> > in 1.7.2.1.
> 
> Some form of this may need to be applied to help the client side, but what
> will happen to
> 
>   http-backend.c::get_info_refs()
>    -> http-backend.c::get_parameter()
>      -> http-backend.c::get_parameters()
>        -> url.c::url_decode_parameter_value()
>          -> url.c::url_decode_internal()
> 
> codepath, which is the server-side handing of query strings?

You're right, I forgot about those.  I imagine it would be one of two
cases:

* It should never have dequoted + before the ? query-delimiter, so we
  need to fix that too;

* It should never have dequoted + before the ? query-delimiter, but
  it's too late to change that now.

Shawn, can you help with this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
