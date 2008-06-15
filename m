From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Make git reflog expire honour core.sharedRepository.
Date: Sun, 15 Jun 2008 15:47:51 -0700
Message-ID: <7vhcbuco2w.fsf@gitster.siamese.dyndns.org>
References: <1213565862-23247-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, joerg@debian.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K812a-0005Zq-MR
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 00:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYFOWsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 18:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYFOWsP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 18:48:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbYFOWsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 18:48:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EC4B90BE;
	Sun, 15 Jun 2008 18:48:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D31A290BC; Sun, 15 Jun 2008 18:48:05 -0400 (EDT)
In-Reply-To: <1213565862-23247-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Sun, 15 Jun 2008 23:37:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21173F1E-3B2D-11DD-8A27-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85148>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-reflog.c       |    1 +
>  t/t1301-shared-repo.sh |   15 +++++++++++++++
>  2 files changed, 16 insertions(+), 0 deletions(-)
>
>  Some people like to have logAllRefUpdates even for bare repositories, and if
>  shared, git-gc breaks them.
>
> diff --git a/builtin-reflog.c b/builtin-reflog.c
> index 897d1dc..430929f 100644
> --- a/builtin-reflog.c
> +++ b/builtin-reflog.c
> @@ -308,6 +308,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
>  		} else if (cmd->updateref && commit_ref(lock)) {
>  			status |= error("Couldn't set %s", lock->ref_name);
>  		}
> +		adjust_shared_perm(log_file);

Why is it sane to do this unconditionally, instead of putting in another
else or something?
