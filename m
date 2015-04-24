From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/5] ref_transaction_commit(): remove the local flags
 variables
Date: Fri, 24 Apr 2015 23:15:09 +0200
Message-ID: <553AB25D.9090201@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu> <1429875349-29736-5-git-send-email-mhagger@alum.mit.edu> <20150424173005.GC30592@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylkwc-0000nt-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 23:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946014AbbDXVPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 17:15:24 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64866 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946001AbbDXVPV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 17:15:21 -0400
X-AuditID: 1207440d-f79976d000005643-6f-553ab260d154
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D3.94.22083.062BA355; Fri, 24 Apr 2015 17:15:12 -0400 (EDT)
Received: from [192.168.69.130] (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OLFAfn006650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 17:15:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20150424173005.GC30592@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqJuwySrU4OAaVYuuK91MFg29V5gt
	frT0MFts3tzO4sDisWBTqcez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ3xYOc6xoJ+
	3ooZE7+xNzCe5+pi5OSQEDCRuDH/LyuELSZx4d56ti5GLg4hgcuMEjtvHWCEcC4wSdyaPpsF
	pIpXQFui/eVCZhCbRUBVYtfhxUwgNpuArsSinmYwW1QgSKL12lRGiHpBiZMzn4D1igjISnw/
	vBEsziyQITFp3SywOcICoRK3/lyAWjafUeLaz1awkzgF9CRuPp/FBtGgLvFn3iVmCFteonnr
	bOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFC
	App3B+P/dTKHGAU4GJV4eGfMsQwVYk0sK67MPcQoycGkJMrr3W8VKsSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEl78XKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuC9
	tQGoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UrfHFwHgFSfEA7T0N0s5bXJCY
	CxSFaD3FqCglzrt0I1BCACSRUZoHNxaWpl4xigN9Kcx7FaSdB5ji4LpfAQ1mAho8c6kFyOCS
	RISUVANjsP3dmXdMen5dyp2z4S2D1q1EXcU0V6bN7v/utAb9fpCbx7A5cI/Z+rh0TQePs4/q
	v5re2/rs5oVPR6NjtUVOzOxr+jjZtaR08zH763qWP2aGTLLWantWqGKiqXRh+Vb+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267756>

On 04/24/2015 07:30 PM, Jeff King wrote:
> On Fri, Apr 24, 2015 at 01:35:48PM +0200, Michael Haggerty wrote:
> 
>> Instead, work directly with update->flags. This has the advantage that
>> the REF_DELETING bit, set in the first loop, can be read in the third
>> loop instead of having to compute the same expression again. Plus, it
>> was kindof confusing having both update->flags and flags, which
>> sometimes had different values.
> 
> Hmm. I think this is losing the distinction of "flags the caller has
> passed in to us" versus "flags we are using locally only during the
> transaction_commit routine". If callers look at the flags in the
> REF_TRANSACTION_CLOSED state, do they care about seeing these new flags?
> 
> My guess is probably not in practice, and "leaking" these flags is an
> acceptable tradeoff for keeping the transaction_commit function simpler.
> But I haven't looked that closely.

"struct ref_update" is opaque to callers outside of the refs module, and
ref_update::flags is not read anywhere outside of
ref_transaction_commit() (and its value is passed to
lock_ref_sha1_basic()). So I don't think we have to be shy about storing
our own internal information there.

In fact, REF_DELETING, REF_ISPRUNING, REF_HAVE_NEW, and REF_HAVE_OLD are
also private to the refs module.

I suppose we could mask out all the "private" bits in the flags
parameter passed by the caller, to make sure that the caller hasn't
accidentally set other bits. I think that would be more defensive than
our usual practice, but I don't mind doing it if people think it would
be prudent.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
