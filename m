From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 06/11] branch: roll show_detached HEAD into regular ref_list
Date: Wed, 29 Jul 2015 11:56:07 +0200
Message-ID: <vpqwpxjmgnc.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-6-git-send-email-Karthik.188@gmail.com>
	<vpqlhe0xwpv.fsf@anie.imag.fr>
	<CAOLa=ZR4DSzdnR8+3eiVTCX92aeFu2o6=iDm7QpdOewizSuxng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:56:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKO68-0001td-15
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 11:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbbG2J4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 05:56:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35109 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbbG2J4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 05:56:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6T9u6sG000886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 11:56:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6T9u7qO014897;
	Wed, 29 Jul 2015 11:56:07 +0200
In-Reply-To: <CAOLa=ZR4DSzdnR8+3eiVTCX92aeFu2o6=iDm7QpdOewizSuxng@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 00:49:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 11:56:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6T9u6sG000886
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438768569.07984@+Y2ZpSfpMzzhouTMjBb5Yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274885>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Jul 28, 2015 at 6:31 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> -static void show_detached(struct ref_list *ref_list, int maxwidth)
>>> -{
>>> -     struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
>>> -
>>> -     if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
>>
>> I'm not sure what this if was doing, and why you can get rid of it. My
>> understanding is that with_commit comes from --contains, and in the
>> previous code the filtering was done at display time (detached HEAD was
>> not shown if it was not contained in commits specified with --contains).
>>
>> Eventually, you'll use ref-filter to do this filtering so you won't need
>> this check at display time.
>>
>> But am I correct that for a few commits, you ignore --contains on
>> detached HEAD?
>>
>
> No we don't ignore --contains on detached HEAD.
>
> Since detached HEAD now gets its data from append_ref(). The function
> also checks for the --contains option.

Ah, OK. Previously, detached HEAD and branches were completely
different, each having its own if (is_descendant_of(...)), and you're
now using only one in append_ref() before removing it completely in
favor of ref-filter.

That would deserve an explanation for other reviewers I think.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
