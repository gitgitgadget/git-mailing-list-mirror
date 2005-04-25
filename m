From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 14:36:00 -0700
Message-ID: <426D62C0.40104@zytor.com>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:37:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBFG-0003Hs-Ca
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDYVjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDYVhb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:37:31 -0400
Received: from terminus.zytor.com ([209.128.68.124]:28369 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261228AbVDYVgQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 17:36:16 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3PLa6dH015238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 14:36:07 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> Anyway, I decided that my original model for tags was the right one, with 
> a trivial extension. Notably, if you want to tag a single file or a tree 
> object, go wild. The tag object format is:
> 
> 	object <sha1>
> 	type <type>
> 	tag <tag>
> 	.. free-form commentary and signature of this all ..
> 
> and the "git-mktag" program verifies that the three first lines are valid 
> before it accepts it and writes it as a git object.
> 
> Right now the tags don't do anything, except fsck can verify them (not the
> signature - git doesn't even specify any particular format, and you may
> validly have unsigned tags in your tree), and will print out something
> like
> 
> 	tagged commit e83c5163316f89bfbde7d9ab23ca2e25604af290 (v2.6.12-rc2)
> 
> if you were to have such a tag-object in your object database (you don't, 
> because I've not generated one, but hey..)
> 

It would be good if the tag object could permit junk lines before the 
start of the header; in particular, the standard PGP/GPG signed message 
format looks like:

-----BEGIN PGP SIGNED MESSAGE-----

object aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
type commit
tag foo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUBQm1hyWx5eAAqlgcFAQEShgf+P/PNJu5h1uAVPp9+xSy8QtIIC/1Zpl6a
2Tp22Bw0hfXUNYoJ7O9TH35wttYbcx8ArXl6JhlMIEcV7rS48H/vmTJgtBwnhLSb
epDPbOriLbCl9E0XXPHqrlmQE07H0iZn2dmLyg2REmtdffi3hjSQIkvFSHy72kOe
Ho6H+s2hzs/u/ypkQ8Cl82Saqn/Drahj9ehdXLRQ5Nsslr71MhwRCD5M0x+0Uy0B
KPjBiyyx6g/qWzIRLZOdkdbSUdXjczlGnm2wwC6/RdBDjeagDBGafaiuNQH8W3sx
psfmqKgKZkCBFFlSvwJQAsRFgnVl2vYUAftRaxMnQlCG7COIjNAsdg==
=lsn0
-----END PGP SIGNATURE-----

As an alternative, the signature can be a separate object, since the 
object SHA-1 itself acts as a verifier of its self-content; thus, all 
that is really necessary is an authorized verifier.

	-hpa
