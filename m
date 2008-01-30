From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] git-relink: avoid hard linking in objects/info directory
Date: Wed, 30 Jan 2008 08:34:36 +0100
Message-ID: <b77c1dce0801292334p7c348744re6a7fdbb0f17d5b3@mail.gmail.com>
References: <479FAB9A.9040009@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7TX-00084S-MF
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 08:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbYA3Hek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 02:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYA3Hej
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 02:34:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:12545 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbYA3Hej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 02:34:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so228991wah.23
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 23:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LtQ1GXR1nBmKrNyWyzQMrS/VTZllEHl/soIlr6vW+rM=;
        b=BH2UlxtoCH4VQjgN+h/btH8SbH1bEKQk4uhtF6ROAk/WihBy/XyWPLQphofkD8tVGzrQKbNwcFH+bZskOxM2rFokcYGLuO6jE8SFAbO4J74SKfpvT58jRj2LWF7oYhlIgQYNVsI72hBZ4hJaWeRbcVhlzf7mnVAKKC3TXk9HQ1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tprIzGqVaTS6P14JNKWQlm8HfQA9iQquZr3/6BX3zFoi2EytOfJJEhxJF1Ob7t2kmXflvZuTgxI1UcslWBVhoTDU8Kc2BidNqpZfKPGLdEEEvlV+wRK2eTiTKkZPWQI51xpa7xZrncsEpmh1XhY18DpNWstAs+//PVSbdHLeKYg=
Received: by 10.142.203.13 with SMTP id a13mr140000wfg.210.1201678476343;
        Tue, 29 Jan 2008 23:34:36 -0800 (PST)
Received: by 10.142.212.20 with HTTP; Tue, 29 Jan 2008 23:34:36 -0800 (PST)
In-Reply-To: <479FAB9A.9040009@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72045>

On 29/01/2008, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> git-relink is intended to search for packs and loose objects in
> common between two repositories and to replace the one set with
> hard links to the other. Files other than packs and loose objects
> should not be touched, so add the "info" sub-directory to the
> pattern of directory excludes.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  git-relink.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-relink.perl b/git-relink.perl
> index f6b4f6a..d267404 100755
> --- a/git-relink.perl
> +++ b/git-relink.perl
> @@ -40,7 +40,7 @@ my $master_dir = pop @dirs;
>  opendir(D,$master_dir . "objects/")
>         or die "Failed to open $master_dir/objects/ : $!";
>
> -my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
> +my @hashdirs = grep !/^(\.{1,2}|info)$/, readdir(D);

That looks a bit fragile. If the intent is to get a list of files in
$master_dir, why not simply say:

my @hashdirs = grep -f, readdir(D);

That will appropriately skip ., .. and any other dirs.
