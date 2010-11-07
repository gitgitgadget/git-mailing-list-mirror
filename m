From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 8/8] Remove pack file handling dependency from wrapper.o
Date: Sun, 07 Nov 2010 17:10:01 +0100
Message-ID: <4CD6CF59.5040801@lsrfire.ath.cx>
References: <20101106113905.GA27405@burratino> <20101106115237.GH27641@burratino> <4CD5996F.6010809@lsrfire.ath.cx> <20101106184251.GA14288@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 17:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF7p8-0004BE-TV
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 17:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab0KGQKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 11:10:25 -0500
Received: from india601.server4you.de ([85.25.151.105]:58948 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab0KGQKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 11:10:24 -0500
Received: from [10.0.1.100] (p4FC57E39.dip.t-dialin.net [79.197.126.57])
	by india601.server4you.de (Postfix) with ESMTPSA id CC3052F807B;
	Sun,  7 Nov 2010 17:10:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101106184251.GA14288@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160886>

Am 06.11.2010 19:42, schrieb Jonathan Nieder:
> Ren=C3=A9 Scharfe wrote:
>=20
>> Ugh.  Having to remember setting this handler is tedious.
>>
>> Can it be set automatically once the first pack is loaded?  A quick =
look
>> suggests that use_pack() would be the right place to do it.
>=20
> Maybe add_packed_git()?
>=20
> use_pack() is called by:
>=20
>  pack-objects::check_pack_inflate
>  pack-objects::copy_pack_data
>  pack-objects::check_object
>  check_pack_crc
>  verify_pack
>  get_size_from_delta
>  sha1_file::get_delta_base
>  sha1_file::unpack_object_header
>  packed_object_info_detail
>  sha1_file::unpack_compressed_entry
>=20
> some of which would make me worry about thread-safety.

Possibly, but if that's the case then we have a thread-safety issue
already: use_pack() updates pack_mapped, which is used by
release_pack_memory() to see how much can be freed.  Just saying.

Ren=C3=A9
