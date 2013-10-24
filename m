From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: RFE: support change-id generation natively
Date: Wed, 23 Oct 2013 22:11:53 -0600
Message-ID: <8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr> <201310212029.01589.thomas@koch.ro> <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com> <201310211249.49568.mfick@codeaurora.org> <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com> <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com> <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com> <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 06:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZCHD-00016S-50
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 06:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab3JXEL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Oct 2013 00:11:57 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:41882 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3JXEL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Oct 2013 00:11:57 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2B67413EF1D;
	Thu, 24 Oct 2013 04:11:56 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 1B9D513F281; Thu, 24 Oct 2013 04:11:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.2.108] (c-75-70-3-152.hsd1.co.comcast.net [75.70.3.152])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nasser@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id D707A13EF1D;
	Thu, 24 Oct 2013 04:11:54 +0000 (UTC)
In-Reply-To: <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236564>


On Oct 23, 2013, at 8:07 PM, Duy Nguyen wrote:

> On Wed, Oct 23, 2013 at 11:00 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>=20
>>> On Wed, Oct 23, 2013 at 2:50 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>> It would be just the matter of updating commit_tree_extended() in
>>>> commit.c to:
>>>>=20
>>>> - detect the need to add a new Change-Id: trailer;
>>>>=20
>>>> - call hash_sha1_file() on the commit object buffer (assuming that
>>>>   a commit object that you can actually "git cat-file commit" usin=
g
>>>>   the change Id does not have to exist anywhere for Gerrit to
>>>>   work---otherwise you would need to call write_sha1_file()
>>>>   instead) before adding Change-Id: trailer;
>>>>=20
>>>> - add Change-Id: trailer to the buffer; and then finally
>>>>=20
>>>> - let the existing write_sha1_file() to write it out.
>>>=20
>>> I'm not objecting special support for Gerrit, but if the change is
>>> just commit_tree_extended() why don't we just ship the commit hook =
in
>>> a new "Gerrit" template?
>>=20
>> It is not clear to me how you envision to make it work.
>=20
> I don't have the source code.

Now you do: https://gerrit.googlesource.com/gerrit/+/master/gerrit-serv=
er/src/main/resources/com/google/gerrit/server/tools/root/hooks/commit-=
msg

> But the commit-msg hook document [1]
> describes roughly what you wrote below, except the tree part. And I
> suppose the hook has been working fine so far. Reading back the
> original post, James ruled out always-active hooks in general and
> wanted the control per command line. Perhaps we should add
> --no-hooks[=3D<name>,<name>] to "git commit"? Or maybe it's still
> inconvenient and --change-id is best.
>=20
> [1] http://gerrit-documentation.googlecode.com/svn/Documentation/2.0/=
cmd-hook-commit-msg.html
>=20
>> Na=EFvely thinking, an obvious place to do this kind of thing may be
>> the "commit-msg" hook, where the hook reads what the user prepared,
>> finds that there is no existing "Change-Id:" trailer, and decides to
>> add one.
>>=20
>> But what value would it add on that line as the Id?
>>=20
>> It wants to use the name of the commit object that would result if
>> it were to return without further editing the given message, but we
>> do not give such a commit object name to the hook, so the hook needs
>> to duplicate the logic to come up with one.  It may be doable (after
>> all, builtin/commit.c is open source), but we do not give the hook
>> the commit object header (i.e. it does not know what the tree,
>> parent(s), author, committer lines would say, nor it does not know
>> if we are going to add an encoding line), so the hook needs to guess
>> what we will put there, too.
> --=20
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
