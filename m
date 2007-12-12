From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 00:02:20 +0100
Message-ID: <0B657FBB-A1D9-4C86-BC80-C33F92D7AF77@wincent.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com> <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com> <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vk5nj7jkp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2abh-0001AZ-8V
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 00:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbXLLXCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 18:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbXLLXCu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 18:02:50 -0500
Received: from wincent.com ([72.3.236.74]:45553 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbXLLXCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 18:02:50 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCN2MJX003381;
	Wed, 12 Dec 2007 17:02:22 -0600
In-Reply-To: <7vk5nj7jkp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68108>

El 12/12/2007, a las 21:18, Junio C Hamano escribi=F3:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> When you select the context menu item "Split Hunk" in the diff area,
>> git-gui will now split the current hunk so that a new hunk starts at
>> the current position.
>>
>> For this to work, apply has to be called with --unidiff-zero, since
>> the new hunks can start or stop with a "-" or "+" line.
>> ...
>
> I still have conceptual problem with this whole thing.  For example,
> what does that MEAN to split this hunk from your patch...
>
>> @@ -296,7 +369,7 @@ proc apply_hunk {x y} {
>> 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
>> 	if {![lock_index apply_hunk]} return
>>
>> -	set apply_cmd {apply --cached --whitespace=3Dnowarn}
>> +	set apply_cmd {apply --cached --whitespace=3Dnowarn --unidiff-zero=
}
>> 	set mi [lindex $file_states($current_diff_path) 0]
>> 	if {$current_diff_side eq $ui_index} {
>> 		set failed_msg [mc "Failed to unstage selected hunk."]
>
> ... by clicking between the '-' and '+' lines, and apply only one =20
> half?
>
> Well, the question was not very well stated.  I know what it means --
> remove that old line, without replacing with the corrected/updated =20
> one.
> The real question is how would that be useful?

I don't know if it would be useful, but I think the more important =20
concern here is consistency. ie. it should split hunks the same way =20
"git add -i" does. Both "git gui" and "git add -i" are official parts =20
of Git, so in the interests of coherency they should share the same =20
concept of "what it means to split a hunk".

"git add -i" considers any hunk where a there are multiple groups of =20
deletions and/or insertions separated by context lines to be =20
"splittable" (on the boundaries defined by those intervening context =20
line), and all others to be unsplittable. I think this is a fairly =20
intuitive way to conceptualize splitting, so if it comes down to =20
making "git gui" split like "git add -i", or making "git add -i" split =
=20
like this patch proposes that "git gui" should do it, then I'd vote =20
for the former.

Cheers,
Wincent
