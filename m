From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for 	user-friendliness
Date: Wed, 14 Jul 2010 08:59:25 -0500
Organization: Digium, Inc.
Message-ID: <4C3DC2BD.6020907@digium.com>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>	<1279076475-27730-5-git-send-email-gdb@mit.edu> <AANLkTil4XkVXM-96Jb7UOpH2CZBmtXEf7eEIIgrsqhg5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jul 14 15:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ2Un-00026i-Nk
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 15:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab0GNN72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 09:59:28 -0400
Received: from mail.digium.com ([216.207.245.2]:36734 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588Ab0GNN71 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 09:59:27 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OZ2Ug-0001W3-Pd
	for git@vger.kernel.org; Wed, 14 Jul 2010 08:59:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id B4778D8025
	for <git@vger.kernel.org>; Wed, 14 Jul 2010 08:59:26 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5xaUWbGpoGr0 for <git@vger.kernel.org>;
	Wed, 14 Jul 2010 08:59:26 -0500 (CDT)
Received: from [172.19.1.105] (173-24-201-108.client.mchsi.com [173.24.201.108])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 4DEC1D8023
	for <git@vger.kernel.org>; Wed, 14 Jul 2010 08:59:26 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <AANLkTil4XkVXM-96Jb7UOpH2CZBmtXEf7eEIIgrsqhg5@mail.gmail.com>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150989>

On 07/14/2010 04:04 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Wed, Jul 14, 2010 at 03:01, Greg Brockman <gdb@mit.edu> wrote:
>> +               execl(prog, prog, (char *) NULL);
>=20
> Why the casting of NULL? It's not done in the builtin/help.c code.
>=20
> Anyway, if it was cast it should be to (const char *), shouldn't it?

When a NULL sentinel is passed to a varargs function that only
understands 'char *' arguments, the NULL must be cast specifically,
otherwise it will appear in the varargs array as an int or a long.
execl() is an example of a varargs function that only uses varargs
functionality to accept a variable *number* of arguments, it does not
allow for arguments of differing types, so it does not check the types
of its arguments at all. On any platform where an int and a pointer are
not the same size, this can cause a serious problem. When we came acros=
s
this problem in Asterisk, we added a macro called SENTINEL (that just
expands to the proper type for the target platform) that is used in
these cases, so that it is clear to the reader of the code what is goin=
g on.

--=20
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
