From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] remote show: list tracked remote branches with -n
Date: Tue, 10 Jun 2008 12:12:28 -0700
Message-ID: <7vod69cder.fsf@gitster.siamese.dyndns.org>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
 <1213109509-7013-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K69Hk-0003cV-UQ
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 21:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbYFJTMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbYFJTMn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 15:12:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbYFJTMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 15:12:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C39E724A7;
	Tue, 10 Jun 2008 15:12:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 199FA24A4; Tue, 10 Jun 2008 15:12:30 -0400 (EDT)
In-Reply-To: <1213109509-7013-1-git-send-email-dkr+ml.git@free.fr> (Olivier
 Marin's message of "Tue, 10 Jun 2008 16:51:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3114F79A-3721-11DD-8429-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84535>

Olivier Marin <dkr+ml.git@free.fr> writes:

> From: Olivier Marin <dkr@freesurf.fr>
>
> Signed-off-by: Olivier Marin <dkr@freesurf.fr>
> ---
>  builtin-remote.c  |   25 +++++++++++++++++++++++--
>  t/t5505-remote.sh |    3 ++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index 851bdde..de4a4f2 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -444,6 +444,25 @@ static int get_remote_ref_states(const char *name,
>  	return 0;
>  }
>  
> +static int append_ref_to_tracked_list(const char *refname,
> +	const unsigned char *sha1, int flags, void *cb_data)
> +{
> +	struct ref_states *states = cb_data;
> +	struct strbuf buf;
> +
> +	strbuf_init(&buf, 0);
> +	strbuf_addf(&buf, "%s/", states->remote->name);
> +	if (strncmp(buf.buf, refname, buf.len)) {
> +		strbuf_release(&buf);
> +		return 0;
> +	}

Doesn't this have the same issue Shawn fixed in 7ad2458 (Make "git-remote
rm" delete refs acccording to fetch specs, 2008-06-01)?
