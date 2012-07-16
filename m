From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 12:21:23 -0700
Message-ID: <7v629n1pho.fsf@alter.siamese.dyndns.org>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
 <vpqhat7wujb.fsf@bauges.imag.fr> <500445CC.2020404@alum.mit.edu>
 <7vtxx738dz.fsf@alter.siamese.dyndns.org> <500465E3.8040501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqqrM-0001VO-7p
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2GPTV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:21:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2GPTV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:21:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6C18B34;
	Mon, 16 Jul 2012 15:21:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KGh3fEWRBr9MC/TPySJJiXXSa/4=; b=s1GQNl
	smbazNeNzQFbgzpe4SzLQG/EkYxSkiRfh/Mnz2UpYEx0e6pyYH5OYsCgoxqS3/36
	bIsxdDZCr82Y/vUjBy9oME+Qh9yYwxq4hdAYErTX9LDJZxCnS6MRIUlLIkp+EK7E
	UhZD3yhinIiVMgyXrwnZLyaOou+rVV6io+oVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oiP8i7Cpt1btea7X7JJHfwKuxXAzkGNm
	z2RMKHOPchnPTK3ysahkXG9gPnTqBA9ozE4ouK7z7PKy4g6OfcUODKpwPM0vDIIC
	ND5uWQDi7VWPkJDcZRmxBxOQysC7zG55zxdedSlxU3O76y89md+HutvS4BdP0Xvr
	A6EYWz59k/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C91D38B33;
	Mon, 16 Jul 2012 15:21:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 833318B32; Mon, 16 Jul 2012
 15:21:24 -0400 (EDT)
In-Reply-To: <500465E3.8040501@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 16 Jul 2012 21:05:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ED8D9EC-CF7B-11E1-AACE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201552>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 07/16/2012 07:47 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> It's already supported:
>>>
>>>      git config hooks.announcelist \
>>>          "nosy@example.com, overwhelmed@example.com, phb@example.com"
>>>      git config hooks.refchangelist \
>>>          "nosy@example.com, overwhelmed@example.com"
>>>      git config hooks.commitlist "nosy@example.com"
>>
>> Sad.  Is the "post-recieve email" squatting on the _whole_ hooks.*
>> namespace, not postreceiveemailhook.* or something more reasonably
>> limited?
>
> Yes.  I didn't like this either, but I copied this aspect of the old
> script in the interest of compatibility.
>
> If we want to change this, now would be a good time, before the new
> script starts using more of the hooks namespace.  One could choose a
> new namespace and deprecate the old one, optionally in multiple steps:
>
> 1. Only read new options from new namespace; read old options from new
> namespace or (if the new names are not set) falling back to the old
> namespace.
>
> 2. Deprecate the old namespace, emitting warnings if the old names are
> still set but continuing to use them.
>
> 3. Stop supporting the old namespace, but emit warnings if the old
> names are still set.
>
> 4. Stop looking in the old namespace altogether.
>
> Though, given that hook scripts have to be enabled/upgraded
> per-repository, usually on a central server, probably doing only steps
> 2 and 4 would be enough.

It would be sufficient to add a README that gives a one-time
migration instruction (bonus point if a script to automate the
process is given) in the commit that replaces the old script with
the new one.
