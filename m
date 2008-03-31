From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff-index: careful when inspecting work tree items
Date: Sun, 30 Mar 2008 20:12:06 -0700
Message-ID: <7v7ifjsi2h.fsf@gitster.siamese.dyndns.org>
References: <200803290813.08419.chriscool@tuxfamily.org>
 <7v4panyduy.fsf@gitster.siamese.dyndns.org>
 <7vprtbu45f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 05:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgAS9-0004Th-HY
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 05:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbYCaDMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 23:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYCaDMO
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 23:12:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbYCaDMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 23:12:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9173E190C;
	Sun, 30 Mar 2008 23:12:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0D1C9190B; Sun, 30 Mar 2008 23:12:08 -0400 (EDT)
In-Reply-To: <7vprtbu45f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 30 Mar 2008 17:29:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78548>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 52dbac3..a8e107a 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> ...
> @@ -489,8 +516,11 @@ static int get_stat_data(struct cache_entry *ce,
>  	if (!cached) {
>  		int changed;
>  		struct stat st;
> -		if (lstat(ce->name, &st) < 0) {
> -			if (errno == ENOENT && match_missing) {
> +		changed = check_work_tree_entity(ce, &st, NULL);

This "NULL" should be "cbdata->symcache".
