From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v2 2/2] completion: add git status
Date: Thu, 2 Jun 2016 17:04:58 +0200
Message-ID: <025de231-53a3-bc71-1564-aad8f4e096c1@virtuell-zuhause.de>
References: <20160601040542.GA18978@sigill.intra.peff.net>
	 <6e722a5fb64b73373ac6450ec9600e98745df29d.1464769152.git.thomas.braun@virtuell-zuhause.de>
	 <1464773857.4315.1.camel@virtuell-zuhause.de>
	 <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 17:13:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8UJa-0007P7-E4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 17:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbcFBPNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 11:13:38 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:51894 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932873AbcFBPNg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 11:13:36 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b8UJS-0003kK-34; Thu, 02 Jun 2016 17:13:34 +0200
FCC: imap://wp1126771-182009@wp156.webpack.hosteurope.de/Gesendete Objekte
X-Identity-Key: id2
X-Account-Key: account1
X-Enigmail-Draft-Status: N1110
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0;
 uuencode=0; attachmentreminder=0
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464880416;74cfb77c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296204>

Am 01.06.2016 um 14:15 schrieb SZEDER G=C3=A1bor:
>=20
> Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:
>=20
>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>> ---
>>  contrib/completion/git-completion.bash | 29
>> +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index addea89..77343da 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1782,6 +1782,35 @@ _git_stage ()
>>      _git_add
>>  }
>>
>> +_git_status ()
>> +{
>> +    case "$cur" in
>> +    --ignore-submodules=3D*)
>> +        __gitcomp "none untracked dirty all" ""
>> "${cur##--ignore-submodules=3D}"
>> +        return
>> +        ;;
>> +    --untracked-files=3D*)
>> +        __gitcomp "$__git_untracked_file_modes" ""
>> "${cur##--untracked-files=3D}"
>> +        return
>> +        ;;
>> +    --column=3D*)
>> +        __gitcomp "
>> +            always never auto column row plain dense nodense
>> +            " "" "${cur##--column=3D}"
>> +        return
>> +        ;;
>> +    --*)
>> +        __gitcomp "
>> +            --short --branch --porcelain --long --verbose
>> +            --untracked-files=3D --ignore-submodules=3D --ignored
>> +            --column=3D --no-column
>> +            "
>> +        return
>> +        ;;
>> +    esac
>> +    __git_complete_file
>=20
> __git_complete_file()'s job is to complete the '<rev>:<path>' notatio=
n,
> e.g. 'master:Mak<TAB>',  which is not what we want here, because this
> notation doesn't make sense for 'git status' and because 'git status
> <TAB>' would then offer refs instead of files.

Correct. I might have been mislead by the name ;)

> I think there are two choices what to do instead:
>=20
>   - Don't do anything :)  Bash will then fall back to filename
>     completion, which is quite close to what we want here (and in thi=
s
>     case the return statements from the other case arms can go away a=
s
>     well).  The drawback is that all ignored files in the current
>     working directory will show up after 'git status <TAB>'.
>=20
>   - use __git_complete_index_file() with appropriate options, perhaps
>     '--cached --others', but I didn't think this through.  For bonus
>     points pass additional options when certain 'git status' options =
are
>     already present on the command line, e.g. pass '--ignored', too, =
if
>     it is present.

I went for the bonus points way. If that is too involved I can also go
back to "Don't do anything".
