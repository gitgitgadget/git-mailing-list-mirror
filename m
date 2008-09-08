From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t6023-merge-file: Work around non-portable sed usage
Date: Mon, 08 Sep 2008 14:06:02 -0500
Message-ID: <cNVNi0DglMtk8yH2LYJQdUZ7rfXlu4pff2TkbJj4KU6hnx-n_IQ3nw@cipher.nrlssc.navy.mil>
References: <1220898558-73783-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcm57-0003tf-Qb
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYIHTGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 15:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYIHTGT
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:06:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54396 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbYIHTGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 15:06:19 -0400
Received: by mail.nrlssc.navy.mil id m88J62dF005997; Mon, 8 Sep 2008 14:06:02 -0500
In-Reply-To: <1220898558-73783-1-git-send-email-arjen@yaph.org>
X-OriginalArrivalTime: 08 Sep 2008 19:06:02.0520 (UTC) FILETIME=[EFCDE180:01C911E5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95291>

Arjen Laarhoven wrote:
> OS X sed doesn't understand '\n' on the right side of a substitution.
> Use a valid substitution character instead and use 'tr' to convert
> those to a newline.
> 
> Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
> ---
> This patch prevents the "diff3 -m" feature in next (commit
> e0af48e49682ea) from breaking the tests which are added in that
> commit.
> 
>  t/t6023-merge-file.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 42620e0..5e18d68 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -150,8 +150,8 @@ test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
>  
>  '
>  
> -sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit;/" < new6.txt > new8.txt
> -sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit --/" < new7.txt > new9.txt
> +sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit;/"< new6.txt | tr '%' '\012' > new8.txt
> +sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit --/" < new7.txt | tr '%' '\012' > new9.txt
>  
>  test_expect_success 'ZEALOUS_ALNUM' '
>  

I was just encountering this myself.

sed can be fixed without the use of tr by replacing '\n' with an explicit newline like:

sed -e 's/deerit./&\
\
\
\
/' -e "s/locavit,/locavit;/" < new6.txt > new8.txt

Of course it doesn't fit on one line though.

-brandon
