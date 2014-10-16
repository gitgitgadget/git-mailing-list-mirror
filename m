From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] core.filemode may need manual action
Date: Thu, 16 Oct 2014 13:12:10 -0700
Message-ID: <xmqq61fju63p.fsf@gitster.dls.corp.google.com>
References: <54401CAD.4090606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:13:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XerQ8-0005qO-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbaJPUNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Oct 2014 16:13:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752503AbaJPUNH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 16:13:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51D901637A;
	Thu, 16 Oct 2014 16:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4SQcXM5zQd9c
	wUWSaXQCMaVJ6s8=; b=tvkJeheqOMxy4WBwK16GVxukIiFjMf2iA/dullShkWMT
	wa/UoPtwbG82/P08C+JyrffXWVRNh6jWmPd6xxwfCYJSPa27+BGo/SMkIT+NHsf4
	FHOuAgzXmFdtUIBe/6s3jNG32RjKhYH82kDdar1mmz80/7wlSQwdJDgTt/WQUq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ua5Shq
	Hx4oSQaYNqO/dhOwUfnWmBguPsLgiWFOOV59ZwtVzab4yljpbc/HSn1hrqSHnGVS
	Fw0Cd5KTxeoxVpyeTadWa9FALP+kA85IWj9kWORxUlVHQDCFT32ShmCyTSaYwDus
	zk4gK0j9HROadZIp2q6gSEOxBsF2l0tNHnZeI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 498EC16379;
	Thu, 16 Oct 2014 16:13:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64D6C1633C;
	Thu, 16 Oct 2014 16:12:11 -0400 (EDT)
In-Reply-To: <54401CAD.4090606@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 16 Oct 2014 21:29:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B67C1B6A-5570-11E4-8156-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> core.filemode is set automatically when a repo is created.
> But when a repo is exported via CIFS or cygwin is mixed with Git for =
Windows
> core.filemode may better be set manually to false.
> Update and improve the documentation.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> Does this reflect the discussion via email ?
> Or is more tweaking needed ?
>
>
>  Documentation/config.txt | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4333636..b4fea43 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -204,8 +204,23 @@ advice.*::
>  --
> =20
>  core.fileMode::
> -	If false, the executable bit differences between the index and
> -	the working tree are ignored; useful on broken filesystems like FAT=
=2E
> +	Tells Git if the executable bit of files in the working tree
> +	is to be honored.
> +
> +	Some filesystems lose the executable bit when a file that is
> +	marked as executable is checked out, or checks out an
> +	non-executable file with executable bit on.  "git init" and
> +	"git clone" probe the filesystem to see if it records
> +	executable bit correctly when they create a new repository
> +	and this variable is automatically set as necessary.
> +
> +	A repository, however, may be on a filesystem that records
> +	the filemode correctly, and this variable is set to 'true'
> +	when created, but later may be made accessible from another
> +	environment that loses the filemode (e.g. exporting ext4 via
> +	CIFS mount, visiting a Cygwin managed repository with
> +	MsysGit).  In such a case, it may be necessary to set this
> +	variable to 'false'.
>  	See linkgit:git-update-index[1].
>  +
>  The default is true, except linkgit:git-clone[1] or linkgit:git-init=
[1]

I suspect that the above will not format very well.  Hint: what is
the lone "+" line before "The default is true..." doing there?

Aside from "Is MsysGit the old name for Git for Windows"? raised by
others, I think it may be worthwhile to mention Eclipse, as that is
where the original (by the way, it would have been nice if you left
some pointer to the original discussion when saying "the discussion
via email"---it took me a while to recall what you are talking
about) from Hilco Wijbenga was about ([$gmane/257689]).  So, perhaps
s/with MsysGit/with Eclipse or Git for Windows/; or something.

Other than that, I do not see anything wrong in there.  Thanks.

As a separate topic, however, we may want to start thinking about
adding a cheat-sheet on platform-specific bits to our documentation.

The alphabetical listing of configuration variables we see here is a
very good way for people to go from variable names to what they do
(e.g. find a variable defined in configuration file of a neighbour
or be instructed to set a variable by project lead and want to learn
why setting the variable to the value is a good idea), but not a
good way to go in the other direction (e.g. have trouble running Git
on a filesystem that mangles filenames and want to find out if there
already is a way to work it around).

The cheat-sheet could be just a list of configuration and
environment variables e.g. "Those on Windows may want to check into
these settings".


[Reference]

$gmane/257689:

    http://thread.gmane.org/gmane.comp.version-control.git/257558/focus=
=3D257689
