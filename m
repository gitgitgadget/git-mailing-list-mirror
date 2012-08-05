From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: add hint for translators in
 handle_change_delete()
Date: Sun, 05 Aug 2012 13:03:33 -0700
Message-ID: <7vwr1d2jje.fsf@alter.siamese.dyndns.org>
References: <1344189332-27082-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 22:03:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy73N-0006LU-DT
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 22:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab2HEUDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 16:03:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab2HEUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 16:03:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE4F9A65;
	Sun,  5 Aug 2012 16:03:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fs8O9nd91CUgtnR3FkO5MnJdeg8=; b=mC1VOU
	x9GWWM38DwvlNor0Pul9W9KAJcdpWWYk+Jx0FY4M4lx4XnOO+zQYXFU1dMJJc53f
	Wdi/pyNtBSWezQrtL13kbF3ClmEYzaJJ7XIe2lyYPq2BU3WtV/hGIUAXRjrx7rZc
	quuLcE3lfRdXr59TzXBBcu18Hrvpnq7szG6xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e/0G/BkxU/ma92gpopu0pe+vPFW5kCZ2
	JuVBnCbiP4vixRKrPdqzu69w4BjGtl2LNo1I+xkWS7ZD5pLaR3xeZB/o+5zHvpns
	LB4qqkq/IlrHq3kPBj9oCyDiSbiCWNETacsWbVJPIVHDfEHiH5QawUMmtOcJLF4R
	ZvUi4jhjrCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 888559A64;
	Sun,  5 Aug 2012 16:03:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9C139A61; Sun,  5 Aug 2012
 16:03:34 -0400 (EDT)
In-Reply-To: <1344189332-27082-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Sun, 5 Aug 2012 19:55:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A35156F0-DF38-11E1-B00F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202920>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The outputs in handle_change_delete() contain a lot of placeholders.
> This could end up in confusion to translators since two parts of them
> are translated separately. Add a hint for translators that they can
> easily understand it without study the code.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> This patch is based on a confusion on my own of the values of the
> replacements. The first idea of Thomas was to remove the legos of
> the static replacements. After thinking about and trying, it would
> end up in a lot more of lines in this function mainly caused by the
> different outputs. It might be nicer to just add a hint for translators
> to describe the static replacements.

Annotating only the first and then the fourth without explaining
others did not help me when I tried to guess what the message was
trying to say without looking at the variable names (which are not
directly available to people who work on *.po files).

I wonder something along this line to annotate all placeholders in
the order they appear might be easier to read:

    /*
     * TRANSLATORS: this message has many placeholders.
     *
     * CONFLICT (
     * %s=<translation of noun "rename" or "modify">/delete):
     * %s=<name of the path being merged> deleted in
     * %s=<name of a branch> and
     * %s=<translation of verb pp "renamed" or "modified"> in
     * %s=<name of a branch>. Version
     * %s=<name of a branch> of
     * %s=<name of the path being merged> left in tree.
     */



>  merge-recursive.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8903a73..7f661f2 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1035,6 +1035,9 @@ static void handle_change_delete(struct merge_options *o,
>  		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
>  	} else if (!a_sha) {
>  		if (!renamed) {
> +			/* TRANSLATORS: The first %s will be "rename" or "modify",
> + 			   the fourth %s will be "renamed" or "modified". These replacements
> +			   are translated separately. This counts for the next four messages. */
>  			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>  			       "and %s in %s. Version %s of %s left in tree."),
>  			       change, path, o->branch1, change_past,
