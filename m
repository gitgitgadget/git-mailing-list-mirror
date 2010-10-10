From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] completion: Support the DWIM mode for git checkout
Date: Sun, 10 Oct 2010 16:18:26 -0700
Message-ID: <DE3CFB0F-A774-4170-A74D-3BE400E33CEC@sb.org>
References: <1286496492-65221-1-git-send-email-kevin@sb.org> <20101010211634.GA4730@neumann>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Oct 11 01:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P55DM-0001TB-N8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 01:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab0JJXSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 19:18:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41930 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab0JJXSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 19:18:30 -0400
Received: by pwj4 with SMTP id 4so737902pwj.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 16:18:29 -0700 (PDT)
Received: by 10.142.224.14 with SMTP id w14mr4516526wfg.206.1286752709702;
        Sun, 10 Oct 2010 16:18:29 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id x8sm7429087wff.23.2010.10.10.16.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 16:18:28 -0700 (PDT)
In-Reply-To: <20101010211634.GA4730@neumann>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158729>

On Oct 10, 2010, at 2:16 PM, SZEDER G=E1bor wrote:

> Hi,
>=20
>=20
> On Thu, Oct 07, 2010 at 05:08:12PM -0700, Kevin Ballard wrote:
>> Signed-off-by: Kevin Ballard <kevin@sb.org>
>> ---
>=20
> I think the commit message should add some details about how the patc=
h
> changes the completion script's behavior.  At least I didn't know
> offhand what "DWIM mode for git checkout" is, and once I found it
> (70c9ac2 (DWIM "git checkout frotz" to "git checkout -b frotz
> origin/frotz", 2009-10-18), right?), I didn't know how the completion
> script is supposed to support that, and once I applied the patch and
> played around a bit, I was surprised that only 'git checkout h<tab>'
> includes the 'html' branch but 'git checkout <tab>' don't.

Good point. I'll write a real commit message for the next version. And =
another good point about 'git checkout <tab>'. I don't remember why, bu=
t for some reason I explicitly avoided DWIM mode if the current word wa=
s empty. But you're right, there's no good reason to do that.

>> contrib/completion/git-completion.bash |   35 ++++++++++++++++++++++=
+++++++--
>> 1 files changed, 32 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index f83f019..be0498c 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>=20
>=20
>> @@ -988,7 +1007,17 @@ _git_checkout ()
>> 			"
>> 		;;
>> 	*)
>> -		__gitcomp "$(__git_refs)"
>> +		# check if --track, --no-track, or --no-guess was specified
>> +		# if so, disable DWIM mode
>> +		local i c=3D1 track=3D1
>> +		while [ $c -lt $COMP_CWORD ]; do
>> +			i=3D"${COMP_WORDS[c]}"
>> +			case "$i" in
>> +			--track|--no-track|--no-guess) track=3D''; break ;;
>> +			esac
>> +			c=3D$((++c))
>> +		done
>> +		__gitcomp "$(__git_refs '' $track)"
>=20
> You could use the __git_find_on_cmdline() helper function instead.

I'll look into that, thanks.

-Kevin Ballard