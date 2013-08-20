From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 14:45:49 -0400
Message-ID: <5213B95D.3040409@windriver.com>
References: <5213873A.6010003@windriver.com> <xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:46:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqwi-0003Qb-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab3HTSqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:46:20 -0400
Received: from mail1.windriver.com ([147.11.146.13]:60436 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab3HTSqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:46:19 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r7KIjhD3018252
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 20 Aug 2013 11:45:43 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.2.342.3; Tue, 20 Aug 2013
 11:45:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232628>

On 13-08-20 01:57 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> TL;DR -- "git apply --reject" implies verbose, but the similar
>> "git apply --check" does not, which seems inconsistent.
> 
> Hmmm, I am of two minds.  From purely idealistic point of view, I
> can see why defaulting both to non-verbose may look a more
> attractive way to go, but I have my reservations that is more than
> the usual change-aversion.

OK, so given your feedback, how do you feel about a patch to the
documentation that indicates to use "-v" in combination with the
"--check" to get equivalent "patch --dry-run" behaviour?   If that
had existed, I'd have not gone rummaging around in the source, so
that should be good enough to help others avoid the same...

P.
--

> 
> Historically, "check" was primarily meant to see if the patch is
> applicable cleanly in scripts, and we never thought it would make
> any sense to make it verbose by default.  
> 
> On the other hand, the operation of "reject", which was a much later
> invention, was primarily meant to be observed by humans to see how
> the patch failed to cleanly apply and where, to help them decide
> where to look in the target to wiggle the rejected hunk into (even
> when it is driven from a script).  It did not make much sense to
> squelch its output.
> 
> In addition, because "check" is an idempotent operation that does
> not touch anything in the index or the working tree, running with
> "check" and then "check verbose" is possible if somebody runs it
> without verbose and then decides later that s/he wants to see the
> details.  But "reject" does touch the working tree files with
> applicable hunks, so after a quiet "reject", there is no way to see
> the verbose output like you can with "check".
> 
