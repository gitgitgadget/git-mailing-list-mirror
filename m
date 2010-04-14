From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [tip:perf/core] perf: Fix endianness argument compatibility with 
	OPT_BOOLEAN() and introduce OPT_INCR()
Date: Wed, 14 Apr 2010 17:12:40 +0200
Message-ID: <j2k40aa078e1004140812s3d9fab4auf559b1e87af60b5b__18406.0360807509$1271258034$gmane$org@mail.gmail.com>
References: <1271147857-11604-1-git-send-email-imunsie@au.ibm.com>
	 <tip-c05556421742eb47f80301767653a4bcb19de9de@git.kernel.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-tip-commits@vger.kernel.org
To: mingo@redhat.com, acme@redhat.com, jkacur@redhat.com,
	a.p.zijlstra@chello.nl, rusty@rustcorp.com.au, efault@gmx.de,
	mitake@dcl.info.waseda.ac.jp, imunsie@au1.ibm.com,
	fweisbec@gmail.c
X-From: git-owner@vger.kernel.org Wed Apr 14 17:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O24He-0008G3-8g
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 17:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab0DNPMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 11:12:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:35809 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab0DNPMm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 11:12:42 -0400
Received: by ey-out-2122.google.com with SMTP id d26so55252eyd.19
        for <multiple recipients>; Wed, 14 Apr 2010 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1qBTt4vfllTdIprnp77jKTpFp67De6PQMcN0ZLxD5pc=;
        b=iEuGB0z2hUpz9kxyYnAty9n/V3oedcMEfnMtU4WSjEBxTp9aeEbnb/ESsAKJd4sgOI
         yZTeMT/stGKdYmzOm/mssQMw049X8Z8T0HmXfibYwFf3Z72hhY1oNLHMTAvzKTRY1C1+
         /ASgLbM2Htd6x/06cf1qXidWWin6MbgPT/Ay0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Z17dJCpzme5AVEoVWih7Sf4Lc0RvfWGXQRG22bv/sfyK38e+7GLFWRH9v1NwYe7c5O
         2LtCU+Bt+IXJhqcgzyflg1wljqKstU+g/ISIG3xwBTd2L7RqbewgsK1mGO3S5D5z2Qje
         0WOzF5we3X9+yntt7lievn0mN/H2pPLGEvKu4=
Received: by 10.216.73.8 with HTTP; Wed, 14 Apr 2010 08:12:40 -0700 (PDT)
In-Reply-To: <tip-c05556421742eb47f80301767653a4bcb19de9de@git.kernel.org>
Received: by 10.216.88.143 with SMTP id a15mr5050059wef.6.1271257960737; Wed, 
	14 Apr 2010 08:12:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144883>

I'd just like to point out that I'm commenting from the Git
pont-of-view, since this patch was CC'ed to the Git mailing-list.

On Wed, Apr 14, 2010 at 11:36 AM, tip-bot for Ian Munsie
<imunsie@au.ibm.com> wrote:
> Commit-ID: =A0c05556421742eb47f80301767653a4bcb19de9de
> Gitweb: =A0 =A0 http://git.kernel.org/tip/c05556421742eb47f8030176765=
3a4bcb19de9de
> Author: =A0 =A0 Ian Munsie <imunsie@au.ibm.com>
> AuthorDate: Tue, 13 Apr 2010 18:37:33 +1000
> Committer: =A0Ingo Molnar <mingo@elte.hu>
> CommitDate: Wed, 14 Apr 2010 11:26:44 +0200
>
> perf: Fix endianness argument compatibility with OPT_BOOLEAN() and in=
troduce OPT_INCR()
>
> Parsing an option from the command line with OPT_BOOLEAN on a
> bool data type would not work on a big-endian machine due to the
> manner in which the boolean was being cast into an int and
> incremented.

We don't use C99 features like the "bool"-type in Git, so this
shouldn't really be a problem in our end.

> For example, running 'perf probe --list' on a
> PowerPC machine would fail to properly set the list_events bool
> and would therefore print out the usage information and
> terminate.
>

I don't know what this 'perf'-thing is, but it sounds like it's some
external client for the parse-options-API that uses OPT_BOOLEAN
incorrectly.

Looking at linux-next.git, it seems so. The code in tools/perf/ seems
to use OPT_BOOLEAN with C99 bools, and it seems to have imported git's
parse-options API (in commit 0780060124011b94af55830939c86cc0916be0f5,
it seems).

I'd suggest either fixing the call-sites to use int, or just keeping
these changes in linux-next.git.

--=20
Erik "kusma" Faye-Lund
