From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to 'ref-filter'
Date: Tue, 26 May 2015 17:49:49 +0200
Message-ID: <vpqpp5nfiea.fsf@anie.imag.fr>
References: <556317F8.2070609@gmail.com>
	<1432557943-25337-1-git-send-email-karthik.188@gmail.com>
	<xmqqegm4bmtg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 17:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxH7O-000096-JV
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbbEZPuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 11:50:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53683 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037AbbEZPuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 11:50:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4QFnlK0005036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 May 2015 17:49:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4QFnnf6030030;
	Tue, 26 May 2015 17:49:49 +0200
In-Reply-To: <xmqqegm4bmtg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 May 2015 10:15:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 26 May 2015 17:49:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4QFnlK0005036
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433260188.76827@0XfjC0uMio3wFL4632Poaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269948>

Junio C Hamano <gitster@pobox.com> writes:

> Yuck; I can see what you are doing but can you imitate what the more
> experienced people (e.g. peff, mhagger) do when restructuring
> existing code and do things in smaller increments?

Seconded. Some reasons/guide to split:

* Split trivial and non-trivial stuff. I can quickly review a
  "rename-only" patch even if it's a bit long (essentially, I'll check
  that you did find-and-replace properly), but reviewing a mix of
  renames and actual code change is hard.

* Split controversial and non-controversial stuff. For example, you
  changed the ordering of fields in a struct. Perhaps it was not a good
  idea. Perhaps it was a good idea, but then you want this reordering to
  be alone in its patch so that you can explain why it's a good idea in
  the commit message (you'll see me use the word "why" a lot when
  talking about commit messages; not a coincidence).

* Split code movement and other stuff. For example extraction of
  match_name_as_path() would be trivial if made in its own patch.

I'd also make a separate patch "introduce the ref_list data-structure"
to introduce struct ref_list and basic helper functions (constructors,
mutators, destructors).

It will take time and may appear to be counter-productive at first, but
you'll get used to it, and you'll end up being actually more productive
this way (well, maybe not "you" but the set "you + reviewers").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
