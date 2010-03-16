From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Tue, 16 Mar 2010 01:46:56 +0100
Message-ID: <4B9ED500.2040705@lsrfire.ath.cx>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>	 <4B9E69A4.2080304@lsrfire.ath.cx>	 <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>	 <4B9EBFEB.5070108@lsrfire.ath.cx> <40aa078e1003151650m549bafdbwdd849e23349ce6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 16 01:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrKw9-0001ka-8W
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 01:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937248Ab0CPArF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 20:47:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:54835 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937235Ab0CPArD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 20:47:03 -0400
Received: from [10.0.1.100] (p57B7CEE7.dip.t-dialin.net [87.183.206.231])
	by india601.server4you.de (Postfix) with ESMTPSA id 1862B2F804E;
	Tue, 16 Mar 2010 01:47:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <40aa078e1003151650m549bafdbwdd849e23349ce6a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142285>

Am 16.03.2010 00:50, schrieb Erik Faye-Lund:
> It's still just nitpicking, and I appreciate the feed-back. I'm a
> little bit hesitant here though, for the following reasons:
> - All other users of OPT__ABBREV (with the exception of ls-files,
> ls-tree and show-ref) initialize abbrev to it's default value (but
> they all use DEFAULT_ABBREV).
> - ls-files and ls-tree (but not show-ref) both does the following,
> when using abbrev: "abbrev ? find_unique_abbrev(ce->sha1,abbrev) :
> sha1_to_hex(ce->sha1)".
> - ls-files, ls-tree and show-ref, all seems to default "abbrev" to
> zero (by making it a static global).
> - I want to be consistent with the existing code.
>=20
> So, basically, ls-files and ls-tree seems to think
> find_unique_abbrev() does not correctly (for this purpose) handle
> abbrev=3D0. However, show-ref does seem to assume so. Looking at the
> implementation of find_unique_abbrev(), it is clear that it does. But
> as I said: I want to be consistent, and the variation from show-ref
> (basically what you're suggesting) is the least common one.
>=20
> So I guess I can either:
> 1) Change the code to be consistent with show-ref, and submit an
> additional patch to make ls-files and ls-tree consistent with this.
> This might have a performance-impact though, since
> find_unique_abbrev() does some extra work (checking the sha1 for
> existence and an extra buffer-copy).
> 2) Change the code as you suggest, and not care so much about consist=
ency.
> 3) Leave the code to be functionally consistent with those who
> initialize abbrev to DEFAULT_ABBREV (but with a different default,
> which in itself is slightly inconsistent).
>=20
> I'm leaning towards 3) for now, but I don't have any strong feelings.

If you do 2) then it stands 2:2 (ls-files, ls-tree vs. show-ref, cherry=
). :)

find_unique_abbrev() could be streamlined to degrade to sha1_to_hex()
early on if len is 0 or >=3D 40, without any existence check or copy..

Ren=E9
