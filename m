From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Sun, 25 Apr 2010 22:38:13 -0500
Message-ID: <20100426033813.GA30544@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <20100426033147.GB14421@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:37:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6F8i-0000ka-RK
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab0DZDh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:37:28 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:36156 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab0DZDh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:37:26 -0400
Received: by qyk9 with SMTP id 9so16645177qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BehacTn9g4zeY+Jo2ygYz5KmxOGcudQlQH6oUUBhGNM=;
        b=ALCLxeux3P0y7ReviNhgSva7vwjMznZpXNkm9GZfhCUkSXUtkMfZpMHaRQyHnq5SKa
         qghgD/zc444VGUK57SjcpcKTelMtN9/Nhru40KV1/MEHgjv2WsKuxVV4ab00bWL2sN8G
         EWNDjivyDxqxSx6EXi4iVvcTIWc2mHDFSegVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PFaWsU9xZ032hYX609JIBidAAzBdbPS8PV0/G7+ypT2RoJ/ltPD2W2UO1/8D1huWMO
         th0320xCT53AXJX3UBaKPBSq/fZydmQwUpmVZkTe2pwgt66aFoHHHj0vVDdnN5lmet1J
         7d2GvGgkbi4T2TSpl6oeeIMCKJvtHsisdVA14=
Received: by 10.224.117.198 with SMTP id s6mr1012164qaq.371.1272253045376;
        Sun, 25 Apr 2010 20:37:25 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2751006iwn.15.2010.04.25.20.37.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 20:37:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426033147.GB14421@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145783>

Jeff King wrote:
> On Sun, Apr 25, 2010 at 10:11:37PM -0500, Jonathan Nieder wrote:
>
>> Here=E2=80=99s an alternative implementation of the more controversi=
al half of
>> your patch, for your amusement.  The big downside is that it require=
s
>> one to specify --abbrev-commit before the --format option.
>
> That is not insurmountable, as we could just check after the parsing
> stage. But there is a worse problem:
>
>> +static void abbreviate_commit_hashes(char *fmt)
>> +{
>> +	char *p;
>> +	for (p =3D fmt; p !=3D NULL; p =3D strchr(p + 1, '%')) {
>> +		p++;
>> +		switch (*p) {
>> +		case 'H':
>> +			*p =3D 'h';
>> +			break;
>> +		case 'P':
>> +			*p =3D 'p';
>> +			break;
>> +		case 'T':
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>
> You parse '%%H' incorrectly.

I=E2=80=99m pretty sure I don=E2=80=99t.

> I would really rather not see ad-hoc
> parsers for the format like this, but rather use or extend strbuf_exp=
and
> as appropriate. That would make things less painful if and when we
> decide to tweak the syntax.

However, this point still applies.

Jonathan
