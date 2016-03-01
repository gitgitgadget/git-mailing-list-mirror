From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] bundle doc: 'verify' is not about verifying the bundle
Date: Tue, 1 Mar 2016 22:42:52 -0000
Organization: OPDS
Message-ID: <499EFADFE03B4EDFA48F7E0B99A0E36D@PhilipOakley>
References: <xmqqd1rd7uey.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:51:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aat8H-0006cX-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 23:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbcCAWvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 17:51:05 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:63060 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcCAWvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 17:51:04 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Mar 2016 17:51:03 EST
Received: from PhilipOakley ([92.16.242.215])
	by smtp.talktalk.net with SMTP
	id at0EaD9S2Nhwbat0EarHbf; Tue, 01 Mar 2016 22:42:51 +0000
X-Originating-IP: [92.16.242.215]
X-Spam: 0
X-Authority: v=2.1 cv=Fsylhzfq c=1 sm=1 tr=0 a=YVmkVu95zOgaQGBLgHYOvg==:117
 a=YVmkVu95zOgaQGBLgHYOvg==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8 a=6CpWEEcn4JxI6UWy6FIA:9
 a=wPNLvfGTeEIA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfH+xKoOgOODISApakjTXC7jpC8fatBkPpkt+ycecH9DYyoAC1d7zF5VFvbKeAEfRBrJS2EVhZlmaO7eWN1E9D2beiKyOuj0XgvUiJczjowiiSSN59a2P
 FeiPEG4Scfb41IsaKUgEZGb7ZgH4v6IQMm2Q6T83uIQVCG9WOwZpBimohd22FNvQxgn2et/ZsmU1v0nXSiUlWKCc/RzQN3/NOW0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288075>

From: "Junio C Hamano" <gitster@pobox.com>
> Even though the command does read the bundle header and checks to
> see if it looks reasonable, the thin-pack data stream that follows
> the header in the bundle file is not checked.  More importantly,
> because the thin-pack data does not have a trailing checksum like
> on-disk packfiles do, there isn't much "verification" the command
> can do without unpacking the objects from the stream even if it
> wanted to.
> 
> The documentation gives an incorrect impression that the thin-pack
> data contained in the bundle is validated, but the command is to
> validate that the receiving repository is ready to accept the
> bundle, not to check the validity of a bundle file.  Rephrase the
> paragraph to clarify this.
> 

This looks good to me.

I was actually looking at this over the weekend with respect to a back-
burner issue about indicating which ref is HEAD within the bundle.
(thread variously $gmane/265001 and it's prior links, though now I'm minded
to add \0HEAD after the correct ref; e.g. '<sha1>  refs/heads/<ref>\0HEAD')

Philip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/git-bundle.txt | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 3a8120c..c0113a8 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -38,11 +38,10 @@ create <file>::
>  'git-rev-list-args' arguments to define the bundle contents.
> 
> verify <file>::
> - Used to check that a bundle file is valid and will apply
> - cleanly to the current repository.  This includes checks on the
> - bundle format itself as well as checking that the prerequisite
> - commits exist and are fully linked in the current repository.
> - 'git bundle' prints a list of missing commits, if any, and exits
> + Verifies that the given 'file' has a valid-looking bundle
> + header, and that your repository has all prerequisite
> + objects necessary to unpack the file as a bundle.  The
> + command prints a list of missing commits, if any, and exits
>  with a non-zero status.
> 
> list-heads <file>::
> -- 
> 2.8.0-rc0-114-g0b3e5e5
> 
> --
