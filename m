From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] unpack-trees.c: check return value of lstat()
Date: Sun, 06 Mar 2011 20:50:15 +0100
Message-ID: <4D73E577.1010604@web.de>
References: <201103062013.52793.tboegi@web.de> <vpqfwr0hwu0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	drizzd@aon.at, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Mar 06 20:50:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwJyg-0002A9-UE
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 20:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1CFTut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 14:50:49 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54905 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab1CFTus (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 14:50:48 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id D120F199E42FD;
	Sun,  6 Mar 2011 20:50:16 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PwJy4-00018U-00; Sun, 06 Mar 2011 20:50:16 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <vpqfwr0hwu0.fsf@bauges.imag.fr>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19yqRfOkTD5bMPpLtKGSSNdx+Jrj5kpic8gwy9g
	ZpAmqkjO92wzNX0iN69Qp32hO+8xUKKhG+tEMR5l2iTCsn/35x
	54zl+QLxI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168527>

On 06.03.11 20:29, Matthieu Moy wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> +		if (!lstat(path, &st))
>> +			return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
>> +			                          error_type, o);
>>  	} else if (!lstat(ce->name, &st))
>=20
> What happens if lstat returns a non-0 value?
The result of "st" is 100% garbage, and should not be passed to anybody=
=2E
Not checking the return value (error or not) is not a good thing.
Developers might be tempted to write unreliable code...
>=20
> Anyway, this seems to have been fixed by a93e53018 (Wed Jan 12 20:28:=
09
> 2011, unpack-trees: handle lstat failure for existing file) already.
>=20
Hm,
v1.7.4 says:
commit e39212ab08e8d37dda5d8fd32b54099fe01dbbdb
Merge: 716958c 9e08273
(so far so good)
My git looks like this:

static int verify_absent_1(struct cache_entry *ce,
				 enum unpack_trees_error_types error_type,
				 struct unpack_trees_options *o)
{
[snip]
	else if (len > 0) {
		char path[PATH_MAX + 1];
		memcpy(path, ce->name, len);
		path[len] =3D 0;
		lstat(path, &st);
                ^^^^^^^^^^^^^^^^^^
		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
				error_type, o);


(And I had to correct drizzd@aon.a -> drizzd@aon.at)
/Torsten
