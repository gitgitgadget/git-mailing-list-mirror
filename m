From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Teach 'git merge' and 'git pull' the option --ff-only
Date: Thu, 29 Oct 2009 07:23:22 +0100
Message-ID: <4AE934DA.7080907@gmail.com>
References: <4AE8C281.50104@gmail.com> <7vk4yfi1dd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3OQg-0005lF-CP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbZJ2GXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 02:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZJ2GXV
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:23:21 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54519 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbZJ2GXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:23:21 -0400
Received: by ewy4 with SMTP id 4so1478244ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7QCNFm/UEVoVSI7bw+o8C/kwqAel6Kq4qsO+qm43GYw=;
        b=i9JfkqFPGnrOC2X8QNu/1ifT7XFpKVpLVj/dK6IZsY2Pf2tnFyYshJtzbx4Zi1iZIG
         A4nf8uWBC2AQI2NdOsy4EhhxPnTXFwESYrnyaXVCCqITky2Rb2XWfLGZr2oTtoi2pp29
         m5HSDDF/cTPAg1hZGpdM8u7iLrUn76Y6zeKKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hWo3khNz9ZFCK3exte5NVZKoKyZOqmSCdxxSjr87oD/oUpZEsBFrAL+2IBg7lb7cyv
         v9PoLXlTjFAwM4mCHuIe5Zw1DA+HUAmcWg7nZZ5/W2OZcd35I5UfLzRFy5tc/tBiw8Tn
         cECO7MdNSBWuNMoaGzTW1WV0mqr1Q1JEi8bG0=
Received: by 10.210.96.1 with SMTP id t1mr5271971ebb.17.1256797404735;
        Wed, 28 Oct 2009 23:23:24 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm4874949eyg.1.2009.10.28.23.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:23:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <7vk4yfi1dd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131556>

Junio C Hamano wrote:
> Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:
>> =20
>> +--ff-only::
>> +	Refuse to merge unless the merge can be resolved as a
>> +	fast-forward.
>=20
> Do you or do you not allow "already up to date"?  I think it makes se=
nse
> to allow it, but it is unclear from these two lines.

I do allow it. I will change the description to the following in the
re-roll:

--ff-only::
	Refuse to merge and exit with a non-zero status unless the
	current `HEAD` is already up-to-date or the merge can be
	resolved as a fast-forward.


>=20
>> @@ -874,6 +877,9 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
>>  		option_commit =3D 0;
>>  	}
>> =20
>> +	if (!allow_fast_forward && fast_forward_only)
>> +		die("You cannot combine --no-ff with --ff-only.");
>=20
> Are these the only nonsensical combinations?  How should this interac=
t
> with other options, e.g. --squash or --message?

They are the only options I can think of that flatly contradict each ot=
her.

Combining --squash and --ff-only will succeed if the current HEAD can b=
e
fast-forwarded and will abort otherwise. I don't know how useful that
would be in practice, but I see no strong reason to forbid it.

The -m option will always be ignored, of course, and there will be
the usual warning if fast-forward is possible:

   Fast forward (no commit created; -m option ignored)

I don't think there is any need to explicitly forbid the combination
of -m and --ff-only.

I should probably update the commit message in the re-roll to include
the information in the previous paragraphs.

>> @@ -969,8 +975,11 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>>  	}
>> =20
>>  	for (i =3D 0; i < use_strategies_nr; i++) {
>> -		if (use_strategies[i]->attr & NO_FAST_FORWARD)
>> +		if (use_strategies[i]->attr & NO_FAST_FORWARD) {
>>  			allow_fast_forward =3D 0;
>> +			if (fast_forward_only)
>> +				die("You cannot combine --ff-only with the merge strategy '%s'.=
", use_strategies[i]->name);
>> +		}
>=20
> I am not convinced this tests the right condition nor it is placed at=
 the
> right place in the codepath---even if a specified strategy happens to
> allow fast-forward, wouldn't it be nonsense to say
>=20
>     $ git merge --ff-only -s resolve that-one
>=20
> in the first place?  Note that I am not saying "I am convinced this i=
s
> wrong."

Re-thinking it, I think that the test should be removed. It seemed like
a good idea at the time to point out which strategy that prevented the=20
fast-forward, but if there is a list of merge strategies, the test will=
 prevent
--ff-only to succeed if *any* of merge strategies cannot fast-forward.
(Also, but I am not sure about this, a merge strategy that does not all=
ow
fast-forward might allow up-to-date.)

Therefore, I will remove the test in the re-roll.


Thanks for the comments!

/Bj=C3=B6rn
