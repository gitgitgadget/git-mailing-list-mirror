From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Wed, 24 Apr 2013 19:57:42 +0200
Message-ID: <vpqwqrrolpl.fsf@grenoble-inp.fr>
References: <517298D4.3030802@drmicha.warpmail.net>
	<043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
	<7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
	<5177AE7F.1040400@drmicha.warpmail.net>
	<7vehdzesr9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:59:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3yf-0007jP-KM
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab3DXR73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:59:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40935 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755508Ab3DXR73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:59:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3OHveVZ018063
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Apr 2013 19:57:40 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UV3wt-0005Dj-3l; Wed, 24 Apr 2013 19:57:43 +0200
In-Reply-To: <7vehdzesr9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 24 Apr 2013 10:35:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 24 Apr 2013 19:57:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3OHveVZ018063
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367431062.98159@bq71xWEUrmS3GEVqGLfqKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222281>

Junio C Hamano <gitster@pobox.com> writes:

> But diff.<driver>.textconv is to mangle blob contents in preparation
> for comparing with another.

and also in preparation for "blame".

In both cases (diff and blame), we're preparing to show the file content
to the user, and showing the binary makes no sense.

Grepping through the binary, on the other hand, can very well make
sense, like:

$ git grep foo
file.txt: some instance of foo
binary file bar.bin matches

One reason not to run the filter is performance: "git grep" is fast, and
it's cool. My textconv filters are usually slow, and it's not a big
problem because the diff machinery will only invoke the textconv filter
when the files are modified (i.e. hopefully not often for tracked binary
files). OTOH, "git grep" would need to run the textconv filters for each
binary files being searched for.

I tend to agree with Junio that it makes sense to keep it disabled by
default. Perhaps a grep.textconv config option?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
