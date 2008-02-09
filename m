From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce the config variable pack.packSizeLimit
Date: Sat, 9 Feb 2008 13:15:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091312350.11591@racer.site>
References: <alpine.LSU.1.00.0802051423530.8543@racer.site> <7vfxw2g0gb.fsf@gitster.siamese.dyndns.org> <7vbq6qfz94.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torarvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpYR-0003Cl-0a
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYBINPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbYBINPF
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:15:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:52459 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753564AbYBINPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:15:03 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:15:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 09 Feb 2008 14:15:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uIKpq+OIuEI8yLhXOl/NZzxMRpevtnnUGPE2cx6
	vc1NNEZW1bUsnG
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq6qfz94.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73221>

Hi,

On Fri, 8 Feb 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> +test_expect_success \
> >> +    'honor pack.packSizeLimit' \
> >> +    'git config pack.packSizeLimit 200 &&
> >> +     packname_4=$(git pack-objects test-4 <obj-list) &&
> >> +     test 3 = $(ls test-4-*.pack | wc -l)'
> >> +
> >
> > Where does "3" come from, and what could break it?

It was in my test, and as I do not expect the obj-list (as well as the 
contents it references to change), I just fixed it to 3.

> How about doing it like this, instead?
> 
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 4f350dd..3eea478 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -268,4 +268,12 @@ test_expect_success \
>      'make sure index-pack detects the SHA1 collision' \
>      '! git-index-pack -o bad.idx test-3.pack'
>  
> +test_expect_success 'honor pack.packSizeLimit' '
> +     limit=200 &&
> +     git config pack.packSizeLimit $limit &&
> +     packname_4=$(git pack-objects test-4 <obj-list) &&
> +     bigger=$(find test-4-*.pack -size +${limit}c) &&
> +     test -z "$bigger"
> +'

Sure (with minor modifications).  I was not certain if I could rely on 
find being available everywhere, and understanding -size.

Minor modification that is necessary: MacOSX' find does not accept a find 
call like that.  It must be

	bigger=$(find . -name test-4-*.pack -size +${limit}c) &&

Ciao,
Dscho
