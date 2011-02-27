From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Sun, 27 Feb 2011 02:46:45 -0800
Message-ID: <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 11:47:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pte9f-0003aa-6b
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 11:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab1B0KrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 05:47:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1B0KrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 05:47:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 864DD2B77;
	Sun, 27 Feb 2011 05:48:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+wnQgSTf0FeU
	dScx7ZAf+o0G0cs=; b=kyavhpfB0hNEtXJOP4aexifAZgT0qKudWzc2RwhKbhWH
	V8O8UWfHiWCmh1xmym+NQqTvvNxwpZMvdSz1/po3qXDJ+iUIp8g+Sl9j+Io/CCLg
	kzA0RFJP4EdX88SadJLc64I7C2LM1aGaNASCjDAmRn8CcPyldz8VodYEXhyGfUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xlWJaL
	IJePcXvu+y71l9mLX5UbG1x59zWgUQfYHvDQFbhT0hz4DHzX1cFYSc11GGV8NYWS
	YtbKK8qgc39HOA+4qjeGiI7wbOHctAK2XnTxwVU+r4J8yPkiyE88J8/P+NhTY1aM
	SheB3ANEJHVVePh9ceN2nGhxQvcbwDyQhpdAw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 264042B76;
	Sun, 27 Feb 2011 05:48:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A1402B75; Sun, 27 Feb 2011
 05:48:06 -0500 (EST)
In-Reply-To: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\,  7 Feb
 2011 09\:27\:23 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13B6AAEE-425F-11E0-85DD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168021>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Migration plan:
>
> I'm bad at this. Can we start with a patch that warns users to do "gi=
t
> add -u ." when they do "git add -u"? Hopefully they would have their
> fingers retraied by the time the behavior is changed in 1.8.0.

Perhaps in this order:

Step 1, as soon as possible:

 * Introduce "static int make_update_global;" file scope static to
   builtin/add.c and default to 0;

 * Introduce "add.make_update_global" configuration variable, and toggl=
e
   the above variable when it is explicitly given; also record the fact
   that you actually saw this variable in the config parser regardless =
of
   the value that is given;

 * Document the configuration variable as a new feature, without
   indicating that that will be the new default in the future, but
   strongly recommending that existing scripts should be updated and ne=
w
   scripts should be written the variable in mind---namely, their use o=
f
   "add -u" should use "." if they are relying on the current "limit to
   cwd" behaviour.

 * Ship this as 1.7.X and see how well the new feature is accepted in t=
he
   wider user community.  If the feature is not widely used, there is n=
o
   point in proceeding further.

Step 2, two cycles (i.e. 6-8 months) before 1.8.0, provided if the
previous step is proven positive:

 * When "git add -u" is run without any pathspec, and when the user doe=
s
   not have the configuration variable, warn loudly that the default
   behaviour will change in 1.8.0, and tell the users that the current
   behaviour is still available by setting the configuration variable.

Step 3, at 1.8.0 and probably one or two more cycles:

 * When "git add -u" is run without any pathspec, and when the user doe=
s
   not have the configuration variable, warn loudly that the default
   behaviour _has_ changed in 1.8.0, to help people who migrated from
   early 1.7.X before Step 2 directly to 1.8.X series.

Step 4, 3 cycles after 1.8.0:

 * Drop the warning.

> PS. What about -A?

I personally think it should change exactly the same way as "-u" for
consistency, but I had the impression that the list concensus was to ke=
ep
the current behaviour.

Has anybody been keeping tallies on the discussion around

  http://thread.gmane.org/gmane.comp.version-control.git/166135/focus=3D=
166457

We seem to have lost track.  All I recall was that I changed my mind an=
d
migrated from the third camp (the command defaults to whichever somebod=
y
thought would be more convenient, lacking consistency across command se=
t)
to "it would be more convenient to default to full-tree when there is n=
o
pathspec, as limiting to cwd with '.' is easier" camp myself, but the
discussion is not about my personal preference but about seeing if we h=
ave
an overwhelming majority consensus, so...
