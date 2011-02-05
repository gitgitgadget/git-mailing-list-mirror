From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Sat, 5 Feb 2011 04:14:12 -0600
Message-ID: <20110205101412.GB1685@elie>
References: <1296894611-29398-1-git-send-email-pclouds@gmail.com>
 <1296899427-1394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 11:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plf9t-0007rZ-0a
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 11:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab1BEKOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 05:14:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33286 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1BEKOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Feb 2011 05:14:18 -0500
Received: by iyj8 with SMTP id 8so539951iyj.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 02:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1aAj1jof5aVBV/jXt2DQhz2nt9HbpjCgrO8U6k5aFCE=;
        b=M0pjitojK0Cd7FSGTw244J1OhM+N95dP2pW7Ib3ePyVqohJee9r/WK+OB/ilBrLxJM
         bPJIpwWxUFVJLsqokW3yrI9cBvSpu3pr8Ub+4xe2FGFKZCwDBpq2i9YIbh14BPOmhHhk
         RNyzWxtFLkR8F7nPx8nzSW9sk8H+1+tqgGQVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kkQfrWdsuyCesEQvWspYz5+pSCETcm25gLMN9Q4VC/gfjZYIHBygFKRinxSVd1LHnl
         YCNqkMfda1z8PIH3eAsVXiJLzMUah9QFnQPyFZIxZ5RCZdRZZBzuF5VspTn869ZOqBjI
         HE8/jHYQOu25qGvlsojT0oOYMmdVyquedB/Qg=
Received: by 10.42.226.66 with SMTP id iv2mr1572519icb.78.1296900857358;
        Sat, 05 Feb 2011 02:14:17 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id i16sm1499875ibl.18.2011.02.05.02.14.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 02:14:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166084>

Hi,

Some quick nits to save myself time.  The basic idea of the patch
seems sound.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- /dev/null
> +++ b/t/t1013-read-tree-empty.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description=3D'read-tree with empty trees'
> +
> +. ./test-lib.sh
> +
> +T1=3Df4ec99e8174c01eab488469b4c2680500bbb18da
> +T2=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904

What are these trees?  Do they need to be hardcoded?

> +
> +test_expect_success 'setup' '
> +	printf "40000 empty\0\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60\xe5\x=
4b\xf8\xd6\x92\x88\xfb\xee\x49\x04" >newtree &&

printf '\xab' is unfortunately unportable.  I suppose
this should rather say something like

 test_unequal () {
	printf '%s\n' "$1" >bad &&
	printf '%s\n' "$2" >actual &&
	! test_cmp bad actual
 }

	empty_tree=3D$(git mktree </dev/null) &&
	tree_with_empty_subtree=3D$(
		echo "040000 tree $empty_tree	empty" |
		git mktree
	) &&
	test_unequal "$empty_tree" "$tree_with_empty_subtree"

> +test_expect_success 'ls-tree T1 (with empty tree)' '
> +	git ls-tree $T1 >actual &&
> +	cat <<EOF >expected &&
> +040000 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904	empty
> +EOF
> +	test_cmp expected actual
> +'

	echo "040000 tree $empty_tree	empty" >expect &&
	git ls-tree "$tree_with_empty_subtree" >actual &&
	test_cmp expect actual

> +
> +test_expect_success 'write-tree removes empty tree' '
> +	git read-tree "$T1" &&
> +	git write-tree >actual
> +	echo $T2 >expected
> +	test_cmp expected actual
> +'

	git read-tree "$tree_with_empty_subtree" &&
	...

Sane?
Jonathan
