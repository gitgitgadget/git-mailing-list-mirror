From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Mon, 23 Jun 2014 13:55:32 +0200
Message-ID: <vpqtx7bn8ln.fsf@anie.imag.fr>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 13:55:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz2qa-0001ZZ-0W
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 13:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaFWLzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 07:55:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54477 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbaFWLzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 07:55:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5NBtV3P012111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2014 13:55:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5NBtWuQ025162;
	Mon, 23 Jun 2014 13:55:32 +0200
In-Reply-To: <1403518300-23053-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 23 Jun 2014 03:11:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Jun 2014 13:55:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252342>

Tanay Abhra <tanayabh@gmail.com> writes:

> +/* for NULL values, 'util' for each `string_list_item` is flagged as 1 */

It's a void *, so just saying that it is flagged as 1 does not say how
it's encoded. How about "... is an 'int *' pointing to the value 1".

And actually, you can save one malloc by encoding the value directly in
the util pointer itself like

#define NULL_FLAG (void *)1

	item->util = NULL_FLAG;

I find this a bit ugly, but I think Git already uses this in a few
places (git grep 'void \*) *1' for examples).

Or you can use a pointer to a single static value:

static const int boolean_null_flag = 1; // Or even without = 1.

and then

	item->util = &boolean_null_flag;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
