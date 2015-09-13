From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 6/8] branch.c: use 'ref-filter' data structures
Date: Sun, 13 Sep 2015 14:26:40 +0200
Message-ID: <vpqy4gatshr.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 14:26:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb6Mz-0003vh-UC
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 14:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbbIMM0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 08:26:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41022 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198AbbIMM0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 08:26:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8DCQdFp019964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 13 Sep 2015 14:26:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8DCQeQv004213;
	Sun, 13 Sep 2015 14:26:40 +0200
In-Reply-To: <1442129035-31386-7-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 13 Sep 2015 12:53:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 13 Sep 2015 14:26:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8DCQdFp019964
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442752000.58195@ihz3AKYuN9rUE3MVkg39AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277780>

Karthik Nayak <karthik.188@gmail.com> writes:

>  	/* Print detached HEAD before sorting and printing the rest */
> -	if (detached) {
> -		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
> -			       detached, remote_prefix);
> -		index -= 1;
> +	if (filter->kind & FILTER_REFS_DETACHED_HEAD) {
> +		print_ref_item(array.items[array.nr - 1], maxwidth, filter, remote_prefix);
> +		free_array_item(array.items[array.nr - 1]);
> +		array.nr--;

Ah, this answers my previous remark: indeed, you are removing the
element from the array completely after this patch. You may want to
modify the previous patch to start doing it earlier, but I think it's
not worth the trouble: I agree with the final state, only the
intermediate state is suboptimal (but still acceptable to me at least).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
