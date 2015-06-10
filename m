From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 7/7] send-email: suppress leading and trailing whitespaces before alias expansion
Date: Wed, 10 Jun 2015 10:32:26 +0200
Message-ID: <vpqa8w89d5x.fsf@anie.imag.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:32:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2bRA-00086m-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 10:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbbFJIcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 04:32:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51468 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbbFJIcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 04:32:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A8WPRl018937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 10:32:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A8WQTS014938;
	Wed, 10 Jun 2015 10:32:26 +0200
In-Reply-To: <1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 9 Jun 2015 20:50:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jun 2015 10:32:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5A8WPRl018937
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434529949.27941@LeO3j2g6aetdoufhxf/7qg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271276>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> As alias file formats supported by git send-email doesn't take
> whitespace into account, it is useless to consider whitespaces in
> alias name. remove leading and trailing whitespace before expanding

s/remove/Remove/

> allow to recognize strings like " alias" or "alias\t" passed by --to,
> --cc, --bcc options or by the git send-email prompt.
>
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>  git-send-email.perl   |  1 +
>  t/t9001-send-email.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3d144bd..34c8b8b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -787,6 +787,7 @@ sub expand_aliases {
>  my %EXPANDED_ALIASES;
>  sub expand_one_alias {
>  	my $alias = shift;
> +	$alias =~ s/^\s+|\s+$//g;
>  	if ($EXPANDED_ALIASES{$alias}) {
>  		die "fatal: alias '$alias' expands to itself\n";
>  	}

You should explain why you need that, when the previous patch was
already about removing whitespaces around addresses. I finally
understood that this was needed because alias expansion comes before
sanitize_address, but the commit message should have told me that.

Actually, once you have this, PATCH 6/7 becomes useless, right? (at
least, the test passes if I revert it)

It seems to me that doing this space trimming just once, inside or right
after split_at_commas would be clearer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
