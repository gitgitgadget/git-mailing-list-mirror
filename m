From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Wed, 21 Nov 2007 17:15:59 +0100
Message-ID: <A57F69DB-8AEC-4E48-8309-866D1B72C261@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IusJ5-0003Zz-GK
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760742AbXKUQRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 11:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759864AbXKUQRY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:17:24 -0500
Received: from wincent.com ([72.3.236.74]:55181 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759926AbXKUQRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 11:17:23 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALGG0Fh020181;
	Wed, 21 Nov 2007 10:16:00 -0600
In-Reply-To: <20071121152118.GG24108@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65674>

El 21/11/2007, a las 16:21, Jeff King escribi=F3:

> On Wed, Nov 21, 2007 at 01:36:39PM +0100, Wincent Colaiuta wrote:
>
>> +if ($#ARGV =3D=3D 0) {
>> +	patch_update_file($ARGV[0]);
>> +}
>
> Why only one file? How about something like this instead:
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index fb1e92a..8036c95 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -804,5 +804,8 @@ sub main_loop {
> }
>
> refresh();
> +foreach my $file (@ARGV) {
> +	patch_update_file($file);
> +}
> status_cmd();
> main_loop();

Yes, that makes sense. I wasn't sure how to handle multiple files, but =
=20
I guess just looping through them is fine.

> On top of that, it would be great to be able to do something like
>
>  git-add -i *.c
>
> and just get prompted for changed files (right now, you only get
> prompted for changed files, but unchanged files seem to print a =20
> spurious
> newline).

That spurious newline comes from the last line of the =20
patch_update_file function (previously named patch_update_cmd):

	print "\n";

The solution will be to do an early return, printing nothing for those =
=20
unchanged files (and same thing for untracked files). Will look into it=
=2E

> And at any rate, this would require fixing 3/4 to handle the multiple
> files from git-add.
>
> What do you think?

Should have some time later this evening or tomorrow to incorporate =20
your suggestions.

Cheers,
Wincent
