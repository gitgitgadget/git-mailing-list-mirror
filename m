From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 12 Oct 2011 23:42:59 +0200
Message-ID: <4E9609E3.1000300@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu> <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu> <20111011161652.GA15629@sigill.intra.peff.net> <7vr52jfm8i.fsf@alter.siamese.dyndns.org> <7vmxd7flkw.fsf@alter.siamese.dyndns.org> <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org> <20111011230749.GA29785@sigill.intra.peff.net> <7vehyjcckp.fsf@alter.siamese.dyndns.org> <20111012021128.GA32149@sigill.intra.peff.net> <7v39eyddoc.fsf@alter.siamese.dyndns.org> <20111012045004.GA22413@sigill.intra.peff.net> <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu> <7vr52i9j8g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:43:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6aN-0003fI-Eb
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab1JLVnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 17:43:25 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52083 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab1JLVnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 17:43:22 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9CLh05M002813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Oct 2011 23:43:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vr52i9j8g.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183419>

On 10/12/2011 08:07 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 10/12/2011 07:49 PM, Junio C Hamano wrote:
>>> diff --git a/refs.c b/refs.c
>>> index e3692bd..e54c482 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -994,12 +994,34 @@ const char *ref_fetch_rules[] = {
>>>  	NULL
>>>  };
>>>  
>>> +static int refname_ok_at_root_level(const char *str, int len)
>>> +{
>>> +	int seen_non_root_char = 0;
>>> +
>>> +	while (len--) {
>>> +		char ch = *str++;
>>> +
>>> +		if (ch == '/')
>>> +			return 1;
>>> +		/*
>>> +		 * Only accept likes of .git/HEAD, .git/MERGE_HEAD at
>>> +		 * the root level as a ref.
>>> +		 */
>>> +		if (ch != '_' && (ch < 'A' || 'Z' < ch))
>>> +			seen_non_root_char = 1;
>>> +	}
>>> +	return !seen_non_root_char;
>>> +}
>>> +
>>
>> Nit: the seen_non_root_char variable can be replaced by an early "return
>> 0" from the loop and "return 1" if the loop falls through.
> 
> Hmm, I thought that would fail when you feed "refs/heads/master" to the
> function.

You're right.  My brain must be scrambled from all of the rebasing that
I have been doing ;-)

How about adding

/*
 * Accept strings that are either ALL_CAPS or include a '/'.
 */

(I think the underscore is implied by the example, but the comment could
be expanded if necessary to be explicit.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
