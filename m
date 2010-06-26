From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Sat, 26 Jun 2010 12:14:59 +0000
Message-ID: <AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
	<1277418881-11286-1-git-send-email-avarab@gmail.com>
	<7v1vbvkorf.fsf@alter.siamese.dyndns.org>
	<AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
	<7v1vbukcu8.fsf@alter.siamese.dyndns.org>
	<20100626061305.GB10290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 14:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSUHu-0006Qf-9S
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 14:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab0FZMPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 08:15:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36179 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab0FZMPA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 08:15:00 -0400
Received: by iwn41 with SMTP id 41so2861329iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gRgOuCq686YNKV9kgWOzJNhIMjT89zrA8pKaQArul7E=;
        b=ISCQsvT4kfEEAnUI3HKIkmOsJHGOgcYNLtNngoiYh38rjVmWHMR6q7GZIRR8T1GwB2
         31+oxv68tPhiFp/65V8nqewM1UzE8s25fBahj8bbWSADja31IgsjJABRUNgW9a+bpQ02
         YbLQDaQARofpyEVaiwkQMA4DsT/c29My18Rbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hYelVUIQO7w4ppLHDLvWX2f8Kvb6Qydduc8POqDkyxZ6Y4w9k4z4F9MluJNX9Vzi9I
         51JnehYHKqTn0OpoFyiamtJAaKvZnXBNVOwKcYAALQ/zsiQ5zB/+AhZtuls3iEPkNaao
         ebrKFxEp/7AnLcuW/L7MCtKidH6N16ytnOdNI=
Received: by 10.231.82.74 with SMTP id a10mr2043633ibl.183.1277554499630; Sat, 
	26 Jun 2010 05:14:59 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 26 Jun 2010 05:14:59 -0700 (PDT)
In-Reply-To: <20100626061305.GB10290@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149739>

On Sat, Jun 26, 2010 at 06:13, Jeff King <peff@peff.net> wrote:

> Or even easier: is there a reason that "git fetch -q" would not do wh=
at
> you (=C3=86var) want?

That'd reduce the verbosity level, which'd skip some messages that I
might want. E.g.:

		if (verbosity >=3D 0) {
			fprintf(stderr, " x %-*s %-*s -> %s\n",
				TRANSPORT_SUMMARY_WIDTH, "[deleted]",
				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));

Anyway, it looks like the only correct way to do this with Git in
general is to:

    1. Capture stderr and stdout
    2. Check the exit code, and if it's non-zero print both

But it sounds like we need some general discussion on what stdout and
stderr should be used for in Git with regards to progress messages,
errors and other similar things.
