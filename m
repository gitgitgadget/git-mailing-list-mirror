From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 17 Jan 2012 16:07:05 +0100
Message-ID: <4F158E99.2020906@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu> <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu> <4EE7CDF2.3040408@alum.mit.edu> <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 16:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnAdg-0001fU-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 16:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab2AQPHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 10:07:52 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55679 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab2AQPHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 10:07:51 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0HF75O9022794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Jan 2012 16:07:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188707>

On 12/14/2011 12:24 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> ...  But there are so many calls to the
>> for_each_ref*() family of functions that I wasn't able to determine
>> exactly which should allow for extra refs and which shouldn't.
> 
> Only the ones that follow add_extra_ref() in the control flow.
> 
> builtin/clone.c adds them in setup_reference() to deal with --reference.
> The objects known to be complete in these repositories we borrow from
> need to be marked complete on our end (i.e. clone does not have to fetch)
> and transport_fetch_refs() that eventually goes to fetch_refs_via_pack()
> that calls fetch_pack() uses this information. All three for_each_ref()
> calls in builtin/fetch-pack.c are about "what are the objects that we know
> are complete?" and needs to pay attention to extra refs.
> 
> Having said that, I have a slight suspicion that you might be able to
> eliminate this one in clone.  setup_reference() adds the reference
> repository to the $GIT_DIR/objects/info/alternates, and the fetch logic
> already knows to account for the refs in alternate repositories via
> insert_alternate_refs() callchain.

If I comment out the call from add_one_reference() to add_extra_ref()
then I get a single failure, in t5700:

not ok - 8 fetched no objects
#	! grep "^want" "$U"

So your suspicion does not seem to be borne out (at least not in the
naivest form).

Still studying...
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
