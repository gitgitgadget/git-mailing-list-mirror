From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed, 4 Dec 2013 16:11:42 +0100
Message-ID: <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com> <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 16:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoE7o-0007GX-DY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 16:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759Ab3LDPMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 10:12:24 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:65296 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab3LDPMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 10:12:23 -0500
Received: by mail-we0-f173.google.com with SMTP id u57so9627520wes.32
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 07:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jMLHRsGbIqzH/Pt54VYmHteAcqLgvmwAoarBTkacOOw=;
        b=RvSYeuYnPdPAB2Y3GdpI2IhSgs8mF4aVx8dT1aB4ROVJZx2Ri9J+TPG7Uho+G23lKQ
         NDo9prk3ih3ixQEVEVcKQnSVU446v34+lp7Gr1A6kYwENQX12YVtINNtHnG2nNDh/UwX
         XXCrd/mMdp8TmxgmNgqULKEENVgQVwfNNKq79a3ggE+CyG5hfQk4C4e1SomZrr/qxGQO
         Cp1JEYtGdr39uVCDLUiUoyJEe6KV11XJN5Ky5eUDyP0WGFAkP/KP6F9eXYU8C2SxPEMD
         rCtVLeY/G956o3lKejfUllj9W5241WgRiFM2KeKB+ZSl7U+gncAULShkFt1KJ0kt0AXe
         8JWg==
X-Received: by 10.180.39.140 with SMTP id p12mr7847235wik.12.1386169942679;
 Wed, 04 Dec 2013 07:12:22 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 07:11:42 -0800 (PST)
In-Reply-To: <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238784>

On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endocode.com> wrote:

> So future reader will know what does it mean without running "perldoc
> perlvar".

Hmmm... shouldn't future reader know it anyway?  It is not that cryptic.
I'd say it is idiomatic Perl.

Besides, it is not the only place where we set input record separator to NUL,
to match corresponding option to git command to separate records with NUL
(the '-z' option in this case).  Others are git_get_path_by_hash(),
parse_commit(),
and parse_commits(), git_tree(), not including places where we set $/ to undef
to slurp whole file: git_get_link_target(), git_blobdiff() for $format
== 'plain', etc.

> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
>  gitweb/gitweb.perl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..ee61f9e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2629,6 +2629,8 @@ sub git_parse_project_config {
>         my $section_regexp = shift;
>         my %config;
>
> +       # input record separator, so getline does end on null, not
> +       # newline
>         local $/ = "\0";

It is here because of '-z' option below (to account for values with
embedded newlines).

>
>         open my $fh, "-|", git_cmd(), "config", '-z', '-l',
> --
> 1.8.3.1
>



-- 
Jakub Narebski
