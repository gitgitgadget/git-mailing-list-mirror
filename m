From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] git-submodule: Try harder to describe the status of a submodule
Date: Mon, 2 Jul 2007 08:44:09 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27011D03ED@az33exm24.fsl.freescale.net>
References: <118297160163-git-send-email-Emilian.Medve@Freescale.com> <7v1wfwpuy2.fsf@assigned-by-dhcp.pobox.com> <598D5675D34BE349929AF5EDE9B03E27011CFFED@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 17:44:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5O4Z-0007xC-DS
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 17:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXGBPoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 11:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXGBPoP
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 11:44:15 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:33131 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXGBPoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 11:44:14 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l62FiAKL003497
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 08:44:11 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l62FiAcD024146
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 10:44:10 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27011CFFED@az33exm24.fsl.freescale.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-submodule: Try harder to describe the status of a submodule
Thread-Index: Ace5PEmGzO9ex5ncSkKbabNzVZB7zgAR/sUgAM6yLyA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51376>

Hello Junio,


I noticed the 1.5.2.3 tag and the plans for 1.5.3-rc1 and I was
wondering when do you think you'll apply your submodule patch? Is there
any way I can help with it?


Thanks,
Emil.


This e-mail, and any associated attachments have been classified as:
--------------------------------------------------------------------
[x] Public
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Medve Emilian-EMMEDVE1
Sent: Thursday, June 28, 2007 8:01 AM
To: git@vger.kernel.org
Subject: RE: [PATCH] git-submodule: Try harder to describe the status of
a submodule

Hello Junio,


Alright, let's go with your patch.


Cheers,
Emil.


This e-mail, and any associated attachments have been classified as:
--------------------------------------------------------------------
[x] Public
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary


-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Wednesday, June 27, 2007 11:25 PM
To: Medve Emilian-EMMEDVE1
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-submodule: Try harder to describe the status of
a submodule

Emil Medve <Emilian.Medve@Freescale.com> writes:

> Some repositories might not use/have annotated tags (for example
repositories created with
> git-cvsimport) or might not have tags at all and could cause
git-submodule status to fail because
> git-describe might fail.
>
> This change makes git-submodule status try harder in displaying the
status of a module by
> considering lightweight tags, subsequent tags and branches.

Why are we suddenly seeing these loooooooong lines...

> +get_revname()
> +{
> +	_revname=$(git-describe --tags "$1" 2>/dev/null || git-describe
--contains "$1" 2>/dev/null)
> +	if test -z "$_revname" -o "$_revname" = "undefined"
> +	then
> +		_revname=$(git-describe --all "$1" 2>/dev/null | cut -d
/ -f2-)
> +		test -z "$_revname" && _revname=undefined
> +	fi

I really do not think using --all is useful.  If you do not have
a tag and the rev cannot be described, what damage does it incur?

We still say "$sha1 $path" in the output anyway, and ($revname)
is only "it makes it nicer" appendix.

> @@ -155,7 +174,7 @@ modules_list()
>  			say "-$sha1 $path"
>  			continue;
>  		fi
> -		revname=$(unset GIT_DIR && cd "$path" && git-describe
$sha1)
> +		revname=$(unset GIT_DIR && cd "$path" && get_revname
$sha1)
>  		if git diff-files --quiet -- "$path"
>  		then
>  			say " $sha1 $path ($revname)"

In that sense, I would prefer mine much better. If a rev is
indescribable, your version would say:

	" dddddddddddddddddddddddddddddddddddddddd subdir (undefined)"

while mine would have said:

	" dddddddddddddddddddddddddddddddddddddddd subdir"
