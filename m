From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [StGIT BUG] StGIT errors out on rebasing patch deleting file with Unicode filename
Date: Mon, 2 Jun 2008 17:47:34 +0200
Message-ID: <200806021747.35243.jnareb@gmail.com>
References: <200806011046.51872.jnareb@gmail.com> <200806020939.05902.jnareb@gmail.com> <b0943d9e0806020626s3a1009d6q2a4cdb2526be9c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3CH8-00077x-F0
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYFBPru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 11:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYFBPru
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:47:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:11753 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYFBPrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:47:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so441294nfc.21
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=0F51p+lDi2XMTXdtgI7riQvcDHow7vZXzjINbhZNfhY=;
        b=xCWgGR+7eQ8SUrKkRXFy3cEX5iz39G/vCjsvp2yUqbL9IzbDFtqZjDGcv7M+bG+HplfEn/MCJVffvYLzyAgki63OaL5iMWeMQRLFXecYdCqUqoNES6oigWrl9kBOTT8pWgqSEtckgLwvkpyW/CBOt1A/sNqVKz0tbJq1zXoedbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QroQ6cP66FbOL7gO88VbhgOt5GNfOPOfDHBcadeBzj4k43fRdjDGoh97xiZ/CIw+0R1MpUEA9W1Nk6MyXu26BrIemBQnDemuXKeXwr0nIlg893joW5dn4h+nKEUQvVvneApeMAc2QdN55F4W2JqG8M0WnuMUdgQTjLvcsnQvTig=
Received: by 10.210.115.15 with SMTP id n15mr816716ebc.28.1212421665394;
        Mon, 02 Jun 2008 08:47:45 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.244.52])
        by mx.google.com with ESMTPS id i4sm30839836nfh.1.2008.06.02.08.47.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 08:47:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0806020626s3a1009d6q2a4cdb2526be9c8d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83534>

Dnia poniedzia=B3ek 2. czerwca 2008 15:26, Catalin Marinas napisa=B3:
> 2008/6/2 Jakub Narebski <jnareb@gmail.com>:
>> On Sun, 1 June 2008, Jakub Narebski wrote:
>>
>>> StGIT errors out on rebasing patch which deletes file with Unicode
>>> characters in filename (with characters outside US-ASCII in filenam=
e).
>>> The patch in question is patch deleting gitweb/test/* in git direct=
ory,
>>> and is present already on the 'origin' branch (the branch we rebase
>>> onto), so stg-rebase should result in an empty patch (as first patc=
h).
>>>
>>>  "gitweb/test/M\303\244rchen" |    2 --
>>>  gitweb/test/file with spaces |    4 ----
>>>  gitweb/test/file+plus+sign   |    6 ------
>>>  3 files changed, 0 insertions(+), 12 deletions(-)
>>>  delete mode 100644 gitweb/test/M=E4rchen
>>>  delete mode 100644 gitweb/test/file with spaces
>>>  delete mode 100644 gitweb/test/file+plus+sign
>>>
>>> I guess the error is caused by using unescaped (quoted) filename.
>>
>> You can WORKAROUND this bug by setting core.quotepath to false.  Thi=
s
>> allowed me to make stg-rebase.
>=20
> I can add a workaround in StGIT to actually ignore the exception
> raised by os.remove() but I don't know how to convert the quoted file
> name back to its unicode value in Python.

In Perl it is as simple as (see unquote() in gitweb/gitweb.perl)

	if ($str =3D~ m/^"(.*)"$/) {
		# needs unquoting
		$str =3D $1;
		$str =3D~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
	}

where

	sub unq {

		#...

		if ($seq =3D~ m/^[0-7]{1,3}$/) {
			# octal char sequence
			return chr(oct($seq));
		} elsif (exists $es{$seq}) {
			# C escape sequence, aka character escape code
			return $es{$seq};
		}
		# quoted ordinary character
		return $seq;

Although I haven't tested this extensively.

Or you can just use '-z' switch to git-diff-tree and/or git-ls-files,
to get filename without quoting (but then you use '\0' as record
delimiter, not "\n").

--=20
Jakub Narebski
Poland
