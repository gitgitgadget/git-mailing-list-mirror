From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v5 02/10] for-each-ref: clean up code
Date: Mon, 08 Jun 2015 16:37:25 +0200
Message-ID: <vpqd2168dwa.fsf@anie.imag.fr>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-2-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yBJ-0002WS-I2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 16:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbbFHOhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 10:37:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36006 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbbFHOhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 10:37:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58EbNvs009619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 16:37:23 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58EbPQR006291;
	Mon, 8 Jun 2015 16:37:25 +0200
In-Reply-To: <1433574581-23980-2-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 6 Jun 2015 12:39:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 16:37:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58EbNvs009619
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434379048.08244@ZQs6KaxokbBbmkey7RbZcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271036>

Karthik Nayak <karthik.188@gmail.com> writes:

> In 'grab_single_ref()' remove the extra count variable 'cnt' and
> use the variable 'grab_cnt' of structure 'grab_ref_cbdata' directly
> instead.
>
> Change comment in 'struct ref_sort' to reflect changes in code.

I don't see how the comment change is related to the code change:

>  struct ref_sort {
>  	struct ref_sort *next;
> -	int atom; /* index into used_atom array */
> +	int atom; /* index into 'struct atom_value *' array */
>  	unsigned reverse : 1;
>  };
>  
> @@ -881,7 +881,6 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>  {
>  	struct grab_ref_cbdata *cb = cb_data;
>  	struct refinfo *ref;
> -	int cnt;
>  
>  	if (flag & REF_BAD_NAME) {
>  		  warning("ignoring ref with broken name %s", refname);
> @@ -898,10 +897,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>  	 */
>  	ref = new_refinfo(refname, sha1, flag);
>  
> -	cnt = cb->grab_cnt;
> -	REALLOC_ARRAY(cb->grab_array, cnt + 1);
> -	cb->grab_array[cnt++] = ref;
> -	cb->grab_cnt = cnt;
> +	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
> +	cb->grab_array[cb->grab_cnt++] = ref;
>  	return 0;
>  }

Did you squash the comment change into the wrong commit?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
