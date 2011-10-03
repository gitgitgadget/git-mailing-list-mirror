From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Support ERR in remote archive like in fetch/push
Date: Mon, 03 Oct 2011 13:45:14 +0200
Message-ID: <4E89A04A.1060907@lsrfire.ath.cx>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com> <20111003074250.GB9455@sigill.intra.peff.net> <20111003110159.GA13064@LK-Perkele-VI.localdomain> <20111003112649.GA12874@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 13:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAgxc-0007xl-4D
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 13:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab1JCLpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 07:45:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:55968 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab1JCLpW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 07:45:22 -0400
Received: from [192.168.2.104] (p579BE686.dip.t-dialin.net [87.155.230.134])
	by india601.server4you.de (Postfix) with ESMTPSA id A9D182F807D;
	Mon,  3 Oct 2011 13:45:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <20111003112649.GA12874@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182655>

Am 03.10.2011 13:26, schrieb Jonathan Nieder:
> Ilari Liusvaara wrote:
>=20
>> Oh, and adding interpretation of ERR packets to git archive is easy
>> (and I even happen to have git:// server that can send those to
>> test against):
>>
>> $ git archive --remote=3Dgit://localhost/foobar HEAD
>> fatal: remote error: R access for foobar DENIED to anonymous
>>
>> (I also tested that remote snapshotting of repository that should be
>> readable succeeds, it does).
>=20
> Sounds like a good idea to me.  Let's see what Ren=C3=A9 thinks; also
> changing the subject line to attract other reviewers.

Looks good to me, but I'm not too familiar with the remote protocol.

>> --- >8 ----
>> From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>> Date: Mon, 3 Oct 2011 13:55:37 +0300
>> Subject: [PATCH] Support ERR in remote archive like in fetch/push
>>
>> Make ERR as first packet of remote snapshot reply work like it does =
in
>> fetch/push. Lets servers decline remote snapshot with message the sa=
me
>> way as declining fetch/push with a message.
>>
>> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>> ---
>>  builtin/archive.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/builtin/archive.c b/builtin/archive.c
>> index 883c009..931956d 100644
>> --- a/builtin/archive.c
>> +++ b/builtin/archive.c
>> @@ -61,6 +61,8 @@ static int run_remote_archiver(int argc, const cha=
r **argv,
>>  	if (strcmp(buf, "ACK")) {
>>  		if (len > 5 && !prefixcmp(buf, "NACK "))
>>  			die(_("git archive: NACK %s"), buf + 5);
>> +		if (len > 4 && !prefixcmp(buf, "ERR "))
>> +			die(_("remote error: %s"), buf + 4);
>>  		die(_("git archive: protocol error"));
>>  	}
>> =20
>> --=20
>> 1.7.7.3.g2791de.dirty
>>
