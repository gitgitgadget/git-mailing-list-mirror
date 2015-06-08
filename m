From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-bisect.sh : create a file if the bisection is in old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen outside the program without having to read BISECT_TERMS. This will have to be changed in further versions if new terms are introduced.
Date: Mon, 08 Jun 2015 13:48:32 +0200
Message-ID: <vpq616yctf3.fsf@anie.imag.fr>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
	<CAPig+cQnrKEx_=WHw5gjA9SVtDObXWOJ3augZbhvNUuD8o19aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	j_franck7@msn.com, valentinduperray@gmail.com,
	thomasxnguy@gmail.com, lucienkong@hotmail.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:49:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vXu-0007To-MP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbbFHLsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:48:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58596 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbbFHLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 07:48:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58BmUN2000307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 13:48:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58BmWk6002137;
	Mon, 8 Jun 2015 13:48:32 +0200
In-Reply-To: <CAPig+cQnrKEx_=WHw5gjA9SVtDObXWOJ3augZbhvNUuD8o19aA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 5 Jun 2015 16:03:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 13:48:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58BmUN2000307
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434368915.4806@LeGJJWfYizUtA9bU93x8kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271026>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jun 5, 2015 at 12:34 PM, Louis Stuber
> <stuberl@ensimag.grenoble-inp.fr> wrote:
>> git-bisect.sh :

No space before : in english.

>> create a file if the bisection is in old/new mode, named
>> "BISECT_OLDNEWMODE", so it can easily be seen outside the program
>> without having to read BISECT_TERMS. This will have to be changed in
>> further versions if new terms are introduced.
>
> Documentation/SubmittingPatches contains instructions for how to write
> a good commit message.

For french-speaking people, and Ensimag students in particular, I'd add

  http://ensiwiki.ensimag.fr/index.php/%C3%89crire_de_bons_messages_de_commit_avec_Git

> Also, wrap the commit message to 70-72 columns.

As much as possible, the summary line should even be shorter (so that
"git log --oneline" fits on a 80-chars terminal).

> This commit message doesn't do a very good job of explaining the
> problem this change is trying to solve or justifying why this solution
> is preferable.

Actually, the commit message explains one reason why this is not a good
solution: the idea of having $GIT_DIR/BISECT_TERMS was to keep the
solution generic.

Had the initial codebase been better factored, this patch series would
have been really trivial, but we hardcoded "good" and "bad" in many
places, and now changing it is hard. Introducing BISECT_TERMS is a step
forward, it avoids hardcoding the terms here and there in the code.
To me, introducing BISECT_OLDNEWMODE is a step backward, it's one more
place where we hardcode the terms.

> Justification is particularly important considering the
> ominous-sounding final sentence of the commit message (which itself
> seems to imply that this is not a very good change).

Ah, indeed, we're saying the same thing.

>> -                               echo "old" >>"$GIT_DIR/BISECT_TERMS"
>> +                               echo "old" >>"$GIT_DIR/BISECT_TERMS" &&
>> +                               echo "" > "$GIT_DIR/BISECT_OLDNEWMODE"

No space after > (noted by Eric elsewhere)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
