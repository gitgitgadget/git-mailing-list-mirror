From: Sam Vilain <sam@vilain.net>
Subject: Re: [BISECTED] git-svn: "Failed to read object ..." during clone
Date: Wed, 28 May 2008 19:28:13 +1200
Message-ID: <483D098D.5010302@vilain.net>
References: <20080528030128.GA28904@atjola.homenet> <7vskw3vsys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 09:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1GXn-00084T-VX
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 09:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbYE1H4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 03:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbYE1H4t
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 03:56:49 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51390 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbYE1H4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 03:56:48 -0400
X-Greylist: delayed 1976 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 May 2008 03:56:48 EDT
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 2FBC221C7B5; Wed, 28 May 2008 19:23:51 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 3C0D521C6E3;
	Wed, 28 May 2008 19:23:43 +1200 (NZST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vskw3vsys.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83075>

Junio C Hamano wrote:
> Heh, I should have been more careful.  The series introduces Git::cat_blob
> that returns the size of a blob but the interface is broken and signals
> error by returning zero.  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 is a
> zero sized blob.
> 
> Would this be enough?
>  		my $size = $::_repository->cat_blob($fb->{blob}, $base);
> -		die "Failed to read object $fb->{blob}" unless $size;
> +		die "Failed to read object $fb->{blob}" if ($size < 0);

Heh.  This sort of thing is why perl has "undef"; you could make that
"unless defined $size" and "return undef" in the functions.

Sam
