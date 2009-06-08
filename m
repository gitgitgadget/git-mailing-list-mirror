From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Makefile: introduce SANE_TOOL_PATH for prepending
	required elements to PATH
Date: Mon, 8 Jun 2009 18:11:17 -0400
Message-ID: <20090608221117.GC29942@sigill.intra.peff.net>
References: <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHMfucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@ciph
 er.nrlssc.navy.mil> <20090608114351.GA13775@coredump.intra.peff.net> <7v4ouq1xv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDn41-000490-Qf
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbZFHWLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756564AbZFHWLR
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:11:17 -0400
Received: from peff.net ([208.65.91.99]:36451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755889AbZFHWLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 18:11:16 -0400
Received: (qmail 24471 invoked by uid 107); 8 Jun 2009 22:11:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Jun 2009 18:11:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 18:11:17 -0400
Content-Disposition: inline
In-Reply-To: <7v4ouq1xv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121123>

On Mon, Jun 08, 2009 at 09:41:49AM -0700, Junio C Hamano wrote:

> We could further uglify the patch like this.
> [...]
> +git_broken_path_fix () {
> +	case ":$PATH:" in
> +	*:$1:*) : ok ;;
> +	*)
> +		PATH=$(
> +			SANE_TOOL_PATH="$1"
> +			IFS=: path= sep=
> +			set x $PATH
> +			shift
> +			for elem
> +			do
> +				case "$SANE_TOOL_PATH:$elem" in
> +				(?*:/bin | ?*:/usr/bin)
> +					path="$path$sep$SANE_TOOL_PATH"
> +					sep=:
> +					SANE_TOOL_PATH=
> +				esac
> +				path="$path$sep$elem"
> +				sep=:
> +			done
> +			echo "$path"
> +		)
> +		;;
> +	esac
> +}

Wow. That _is_ ugly, but it actually addresses exactly both my concern
and Brandon's. I kind of like it.

-Peff
