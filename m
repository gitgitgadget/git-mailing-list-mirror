From: Junio C Hamano <gitster@pobox.com>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 13:01:57 -0700
Message-ID: <7v8wvscqtm.fsf@gitster.siamese.dyndns.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
 <20080723140441.GA9537@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 22:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkYT-00079u-5u
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 22:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbYGWUCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbYGWUCG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 16:02:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202AbYGWUCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 16:02:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F1DB2395A2;
	Wed, 23 Jul 2008 16:02:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B31BB3959E; Wed, 23 Jul 2008 16:01:59 -0400 (EDT)
In-Reply-To: <20080723140441.GA9537@elte.hu> (Ingo Molnar's message of "Wed,
 23 Jul 2008 16:04:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 383B2894-58F2-11DD-BA2B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89763>

Ingo Molnar <mingo@elte.hu> writes:

> hm, it's very slow:
>
>   $ time git branch --no-merged
>   [...]
>
>   real    0m9.177s
>   user    0m9.027s
>   sys     0m0.129s
>
> when running it on tip/master:
>
>   http://people.redhat.com/mingo/tip.git/README

Hmmm, does not reproduce for me with a copy of that repository.

$ time git branch -a --no-merged mingo/master
  linus/master
  mingo/acpi-for-len
  mingo/auto-cpus4096-next
  mingo/auto-kmemcheck-next
  mingo/auto-test
  mingo/auto-test-fixes
  mingo/core/futex-64bit
  mingo/core/kill-the-BKL
  mingo/core/percpu-zerobased
  mingo/cpus4096-for-linus
  mingo/kmemcheck-for-linus
  mingo/stackprotector-for-linus
  mingo/timers/for-linus
  mingo/tip
  mingo/tracing/ftrace
  mingo/tracing/immediates
  mingo/tracing/markers
  mingo/tracing/stopmachine-allcpus
  mingo/tracing/textedit
  mingo/x86/acpi-rename-acpi_nmi
  mingo/x86/audit-speedup
  mingo/x86/crashdump
  mingo/x86/header-guards
  mingo/x86/prototypes
  mingo/x86/sparse-fixes
  mingo/x86/unify-mce
  mingo/x86/x2apic

real    0m1.442s
user    0m1.360s
sys     0m0.084s

With the patch I posted earlier, the time becomes:

real    0m0.600s
user    0m0.560s
sys     0m0.040s
