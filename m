From: Jeff King <peff@peff.net>
Subject: [PATCH v3 0/22] hardening allocations against integer overflow
Date: Mon, 22 Feb 2016 17:41:00 -0500
Message-ID: <20160222224059.GA3857@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160219111941.GA31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:41:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzAC-0002ML-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbcBVWlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 17:41:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:47034 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752159AbcBVWlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:41:03 -0500
Received: (qmail 21410 invoked by uid 102); 22 Feb 2016 22:41:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:41:02 -0500
Received: (qmail 22865 invoked by uid 107); 22 Feb 2016 22:41:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:41:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:41:00 -0500
Content-Disposition: inline
In-Reply-To: <20160219111941.GA31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286970>

On Fri, Feb 19, 2016 at 06:19:41AM -0500, Jeff King wrote:

> Here's a re-roll of jk/tighten-alloc series from:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/286253

And here's v3. The changes this time (and philosophical rationalization
of changes I didn't make) are pretty small:

  - flip the order of arguments to st_mult() in ALLOC_ARRAY, et al, to
    get a probably-irrelevant-but-so-easy-why-not optimization

  - mark new global var in daemon.c as static

  - add argv_array_detach (new patch 6) to avoid gross memory managemen=
t
    when converting line-log to use argv_array in the subsequent patch

So I hope this one is ready for 'next'.  Thanks Ren=C3=A9, Ramsay, and =
Eric
for reviewing.

  [01/22]: reflog_expire_cfg: NUL-terminate pattern field
  [02/22]: add helpers for detecting size_t overflow
  [03/22]: tree-diff: catch integer overflow in combine_diff_path alloc=
ation
  [04/22]: harden REALLOC_ARRAY and xcalloc against size_t overflow
  [05/22]: add helpers for allocating flex-array structs
  [06/22]: argv-array: add detach function
  [07/22]: convert manual allocations to argv_array
  [08/22]: convert trivial cases to ALLOC_ARRAY
  [09/22]: use xmallocz to avoid size arithmetic
  [10/22]: convert trivial cases to FLEX_ARRAY macros
  [11/22]: use st_add and st_mult for allocation size computation
  [12/22]: prepare_{git,shell}_cmd: use argv_array
  [13/22]: write_untracked_extension: use FLEX_ALLOC helper
  [14/22]: fast-import: simplify allocation in start_packfile
  [15/22]: fetch-pack: simplify add_sought_entry
  [16/22]: test-path-utils: fix normalize_path_copy output buffer size
  [17/22]: sequencer: simplify memory allocation of get_message
  [18/22]: git-compat-util: drop mempcpy compat code
  [19/22]: transport_anonymize_url: use xstrfmt
  [20/22]: diff_populate_gitlink: use a strbuf
  [21/22]: convert ewah/bitmap code to use xmalloc
  [22/22]: ewah: convert to REALLOC_ARRAY, etc

-Peff
