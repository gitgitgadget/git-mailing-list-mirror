From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 17:38:37 +0200
Message-ID: <4D9C88FD.5080807@drmicha.warpmail.net>
References: <4D9B7A9E.6040902@mit.edu> <1302102336-8800-1-git-send-email-asedeno@mit.edu> <4D9C851A.7070801@drmicha.warpmail.net> <4D9C8803.1000708@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Us7-0006hA-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab1DFPmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 11:42:14 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36254 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932137Ab1DFPmM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 11:42:12 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 107F1203C9;
	Wed,  6 Apr 2011 11:42:12 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 06 Apr 2011 11:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xfHGxkGr2EqwB2bWG1bsohBN28c=; b=SpkkcIidUv7QaBv96z75RE9LMtIAOky4QY2rbR5dSoqyxBuQQJKiFTQtQVZDHBOcQr7Z2ePYbiH2wpDz8rSoCAC/XDeyHVkMzLGcb46822kRd1PRjF+5gqGM+701Yup4aLBBs6cApY1nFXH0YBRkr9FLaGOFKXc/QqsU3EU5ukc=
X-Sasl-enc: FVhRQ+ldqojZfhWyVrJxxEsy1a4lqWi2hB0N+MlYonFh 1302104531
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 458AB408D1B;
	Wed,  6 Apr 2011 11:42:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9C8803.1000708@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170985>

"Alejandro R. Sede=C3=B1o" venit, vidit, dixit 06.04.2011 17:34:
> On 04/06/2011 11:22 AM, Michael J Gruber wrote:
>> Alejandro R. Sede=C3=B1o venit, vidit, dixit 06.04.2011 17:05:
>>> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>>> Reviewed-off-by: James Y Knight <jknight@itasoftware.com>
>>
>> :) So, if that review is off, that means...
>=20
> Um, s/-off//. Oops :)
>=20
> I can send a follow-up, or let Eric deal with that change, however he=
 prefers.
>=20
>>> diff --git a/git-svn.perl b/git-svn.perl
>>> index fa8cd07..184442a 100755
>>> --- a/git-svn.perl
>>> +++ b/git-svn.perl
>>> @@ -531,7 +531,7 @@ sub cmd_dcommit {
>>>  		$url =3D eval { command_oneline('config', '--get',
>>>  			      "svn-remote.$gs->{repo_id}.commiturl") };
>>>  		if (!$url) {
>>> -			$url =3D $gs->full_url
>>> +			$url =3D $gs->full_pushurl
>>
>> Wouldn't we want to do the same $gs->full_pushurl || $gs->full_url f=
all
>> back here as below, or is fullpush_url always set? OK, I see it alwa=
ys is.
>=20
> Yeah, I just went with full_pushurl returning full_url in cases where
> pushurl is not set.
>=20
>>> @@ -2071,6 +2073,8 @@ sub new {
>>>  	$self->{url} =3D command_oneline('config', '--get',
>>>  	                               "svn-remote.$repo_id.url") or
>>>                    die "Failed to read \"svn-remote.$repo_id.url\" =
in config\n";
>>> +	$self->{pushurl} =3D eval { command_oneline('config', '--get',
>>> +	                          "svn-remote.$repo_id.pushurl") };
>>
>> Why eval? We don't do it for url either.
>=20
> Because otherwise it would die with:
>=20
>   $ git svn fetch
>   config --get svn-remote.svn.pushurl: command returned error: 1
>=20
> when pushurl wasn't defined. If that happens with 'url' too, well, th=
at's
> a mis-configured git-svn remote.
>=20
>>> +sub full_pushurl {
>>> +	my ($self) =3D @_;
>>
>> Isn't that a noop?
>=20
> I'm just copying the style of sub full_url here.
>=20

OK, I finally understood the reason for "eval" and "my ($self) =3D @_;"=
=2E I
simply shouldn't look at perl code ;)

Thanks!

Michael
