From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Tue, 9 Dec 2014 07:59:55 -0000
Organization: OPDS
Message-ID: <39592B1FCE234EA58078EBFB34171859@PhilipOakley>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org> <1417878270-4364-2-git-send-email-philipoakley@iee.org> <1418096636.19104.31.camel@segulix>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: =?ISO-8859-15?Q?S=E9rgio_Basto?= <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyFiF-00043Q-9w
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 09:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbaLIH77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 02:59:59 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:44878 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaLIH76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 02:59:58 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261112>

=46rom: "S=E9rgio Basto" <sergio@serjux.com>
> On S=E1b, 2014-12-06 at 15:04 +0000, Philip Oakley wrote:
>> Many users misunderstand the --assume-unchanged contract, believing
>> it means Git won't look at the flagged file.
>>
>> Be explicit that the --assume-unchanged contract is by the user that
>> they will NOT change the file so that Git does not need to look (and
>> expend, for example, lstat(2) cycles)
>>
>> Mentioning "Git stops checking" does not help the reader, as it is
>> only one possible consequence of what that assumption allows Git to
>> do, but
>>
>>    (1) there are things other than "stop checking" that Git can do
>>        based on that assumption; and
>>    (2) Git is not obliged to stop checking; it merely is allowed to.
>>
>> Also, this is a single flag bit, correct the plural to singular, and
>> the verb, accordingly.
>>
>> Drop the stale and incorrect information about "poor-man's ignore",
>> which is not what this flag bit is about at all.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/git-update-index.txt | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/git-update-index.txt=20
>> b/Documentation/git-update-index.txt
>> index e0a8702..da1ccbc 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -78,20 +78,18 @@ OPTIONS
>>          Set the execute permissions on the updated files.
>>
>>  --[no-]assume-unchanged::
>> - When these flags are specified, the object names recorded
>> - for the paths are not updated.  Instead, these options
>> - set and unset the "assume unchanged" bit for the
>> - paths.  When the "assume unchanged" bit is on, Git stops
>> - checking the working tree files for possible
>> - modifications, so you need to manually unset the bit to
>> - tell Git when you change the working tree file. This is
>> + When this flag is specified, the object names recorded
>> + for the paths are not updated.  Instead, this option
>> + sets/unsets the "assume unchanged" bit for the
>> + paths.  When the "assume unchanged" bit is on, the user
>> + promises not to change the file and allows Git to assume
>> + that the working tree file matches what is recorded in
>> + the index.  If you want to change the working tree file,
>> + you need to unset the bit to tell Git.  This is
>>  sometimes helpful when working with a big project on a
>>  filesystem that has very slow lstat(2) system call
>>  (e.g. cifs).
>>  +
>> -This option can be also used as a coarse file-level mechanism
>> -to ignore uncommitted changes in tracked files (akin to what
>> -`.gitignore` does for untracked files).
>>  Git will fail (gracefully) in case it needs to modify this file
>>  in the index e.g. when merging in a commit;
>>  thus, in case the assumed-untracked file is changed upstream,
>
> I don't understand why you insist that we have a contract,

The misunderstanding (which even I had until recently), was the same as=
=20
your misunderstanding, and is also repeated (wrongly) in the=20
documentation that the flag is about ignoring changes to files.

That is completely wrong, and not why the flag was invented (as I=20
understand it).

The flag was invented because Git bran very slowly on some file systems=
=20
(e.g. cifs lstat(2) system calls) to the point that it was deemed=20
unacceptable. The solution was to tell git to stop doing those lstat=20
calls because the user had flagged it's unchanged nature.

The problem was then that, as a side effect, in the main, Git wouldn't=20
notice any changes to such marked files (but some commands do notice;-)=
=20
so some people used it as a "poor man's ignore" flag, and that=20
misinformation stuck. Unfortunately you have been caught in that trap.

While many seek code (change) based solutions, I see clearer=20
documentation (especially for the intermediate rather than expert users=
)=20
as a good first step. People do read the documentation, though often in=
=20
retrospect, so my patch seeks to clarify the existing situation. That i=
s=20
"please git, update the index, you can assume these files are=20
unchanged".

Another thread has pointed out that the misunderstanding as also=20
repeated on another page, so I'll need to see if a patch is forthcoming=
=20
for that!

> when :
> "git diff .", "git diff -a" and "git commit -a" have a different
> behavior of "git commit ." , this is not about any contract this is
> about coherency and be user friendly .
>
> At least if you want keep things like that, wrote in doc, clearly,=20
> that
> assume-unchanged flag *is not*, to git ignoring changes in tracked=20
> files
> and currently not ignore files for git commit <path> and may not work=
=20
> in
> other cases .
>
> Also don't understand why --assumed-untracked shouldn't deal with
> changed files instead fallback in "the user promises not to change th=
e
> file" and sometimes works others not.
>
> Also if this is the contract when a file is different from commit,
> should warning the user that is not in contract (modify files that ar=
e
> assumed-untracked )
>
I hope my explanation helps in explaining how we have come to this=20
perhaps unhelpful situation.
--
Philip=20
