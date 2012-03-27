From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Isolate If-Modified-Since handling in gitweb
Date: Tue, 27 Mar 2012 13:18:56 -0700
Message-ID: <7vzkb1hk5r.fsf@alter.siamese.dyndns.org>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
 <201203272124.23145.jnareb@gmail.com>
 <20120327195558.GA32699@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:19:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCcrB-0002l1-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 22:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab2C0UTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 16:19:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab2C0US7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 16:18:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64DDA5585;
	Tue, 27 Mar 2012 16:18:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+05DM3d//pdOPlft75d7tmE2U+E=; b=vK+3Cg
	4TljYkOTA4PIC5DKA1wvv2BECMlJ2KQhJ7wi//7RkEAJLKAyZ9Kv+t9LqkR8Hm4l
	YmbYTi5/mK+lOSTilp3Y1ur59REoZVxSS6YGo/eN3OASWxq6i/dCA296LXycC0P0
	U23YCnSQvZ0PbjLlUGu8f5kb8y+ysCyezuHH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKAAIJX8VdO/HJxDHGmMhRA5wZy/eZNj
	fVOGIDhWaQAKibKV70+OoPM3fYFszw5/QYthYGU6WxuiELfhk+5F0U/flFvBUpzr
	ztiwHUMhme0/ByGo2Dn0RhT7clvV/jpBOvA37k+e6+WQHMXSwszmUwOrfmFDA8sR
	HueHlUdMpFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3665580;
	Tue, 27 Mar 2012 16:18:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBDF6557F; Tue, 27 Mar 2012
 16:18:57 -0400 (EDT)
In-Reply-To: <20120327195558.GA32699@odin.tremily.us> (W. Trevor King's
 message of "Tue, 27 Mar 2012 15:55:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15525A2A-784A-11E1-A109-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194082>

"W. Trevor King" <wking@drexel.edu> writes:

> On Tue, Mar 27, 2012 at 08:24:22PM +0100, Jakub Narebski wrote:
>> No, the status line was omitted unintentionally, thanks for fixing this.
>> I guess that web server (at least Apache) adds it if it is missing.
>
> From the CGI 1.1 specs [1], section 9.2:
>
>   If the script does not return a Status header, then "200 OK" should
>   be assumed.
>
> So, perhaps it is better to skip the Status header on success (less
> for the server to parse).

I do not think it matters either way.  It is just a single header line, no?

The code is certainly more explicit with your patch.
