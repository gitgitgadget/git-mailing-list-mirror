From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] send-email: don't call unquote_rfc2047 unnecessarily
Date: Sat, 14 Feb 2009 00:50:00 -0500
Message-ID: <76718490902132150w59d48581ke1c6394809bf810a@mail.gmail.com>
References: <200902140032.19922.trast@student.ethz.ch>
	 <1234583491-61260-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 06:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDR6-00053s-UZ
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 06:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbZBNFuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 00:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbZBNFuE
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 00:50:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:4529 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZBNFuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 00:50:02 -0500
Received: by rv-out-0506.google.com with SMTP id g9so351897rvb.5
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 21:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h9Aw206CR/R882HjpMmgi4fgzSBwx04nTixmIECg/9c=;
        b=IcnNoJwB/0yGu4ATNlJ4j2Ey5tYE9+jxLW/QXFM5hZpkXcaCD72HLJDYwz02u9ed0a
         dhFbTTYBpMUdhicg3O2zPxTotvwM7iZ5FYm7879myLp0Lx8r/fHDtk7+4zkFtsPGHp9x
         Wh8jKXoaWuAPBhCq4huaVPty+oA7yvtnOP1sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=if1lJwj26hv36xruPmnmvFrjBBjfcL/qL2N3EBAyWotBOdwlHhh9cTfdlmiKhOS5YR
         WlRo76ZcAl6jhxmBSA/ACDbDgrjL0DQvWD9nLy2iOFdairvk5+fCwLL2J9yVZNALQfsa
         d3O9TQj9pP5m+xgXMB0tIk5dVU4P/yHuOVNg4=
Received: by 10.141.142.15 with SMTP id u15mr1512310rvn.112.1234590600496; 
	Fri, 13 Feb 2009 21:50:00 -0800 (PST)
In-Reply-To: <1234583491-61260-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109824>

On Fri, Feb 13, 2009 at 10:51 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> From: Jay Soffian <jaysoffian@gmail.com>
>
> If --suppress-cc=author then there is no need to unquote the From:
> address.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a2e0b94..2a3e3e8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -958,8 +958,8 @@ foreach my $t (@files) {
>                                $subject = $1;
>                        }
>                        elsif (/^From:\s+(.*)$/) {
> +                               next if $suppress_cc{'author'};
>                                ($author, $author_encoding) = unquote_rfc2047($1);
> -                               next if ($suppress_cc{'author'});
>                                printf("(mbox) Adding cc: %s from line '%s'\n",
>                                        $1, $_) unless $quiet;
>                                push @cc, $1;

Crap. Ignore this one from the series. $author is used later and we
have to parse it regardless. This is brittle code, but I should've
realize it.

j.
