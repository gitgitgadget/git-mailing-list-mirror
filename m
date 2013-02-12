From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Tue, 12 Feb 2013 10:03:20 -0800
Message-ID: <7vr4klh0k7.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:03:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KCy-0000ew-VR
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933659Ab3BLSDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:03:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933628Ab3BLSDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:03:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1302CC59A;
	Tue, 12 Feb 2013 13:03:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y38I3q5Yhk4RQMApyPMbumF+3oM=; b=BR2RCA
	exGkv1/SmTFpPXHKmnXmqSaK59TdhHHA5390064HJo80pBgqq9xO+ExVxOSn/RfG
	ZBhh8B0HTC87L2qRetQzXk+fQGbMvr/U5l/Ke+fpm5ndesValCgi/5858NIb06hl
	TCpBC55M+Uqrl3XLEOvbKZdoockToqIRB0eNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JX5pRtIX9jBNGJYwGpZwaC720A5L5q2l
	sHkLjrMpAPMZ3o2NkG0k0OWvG7OtiemZNiV7tga/SqjYSBi63Lhg6p4YA4gOCLEF
	bLgbgZJh25XnPGUQvsg58lqSkF60IKmdZo3GRPFCe+qWqJcp220BNkNCmi9u1CNW
	lBQaQLE8CqQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 075BDC598;
	Tue, 12 Feb 2013 13:03:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A43AC597; Tue, 12 Feb 2013
 13:03:21 -0500 (EST)
In-Reply-To: <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com> (Phil
 Hord's message of "Tue, 12 Feb 2013 12:11:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CA9978C-753E-11E2-95EE-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216168>

Phil Hord <phil.hord@gmail.com> writes:

>> +       if test $# = 0
>> +       then
>> +               die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
>> +       fi
>> +
>> +       module_list "$@" |
>> +       while read mode sha1 stage sm_path
>> +       do
>> +               die_if_unmatched "$mode"
>> +               name=$(module_name "$sm_path") || exit
>> +               url=$(git config submodule."$name".url)
>> +               if test -z "$url"
>> +               then
>> +                       say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
>
> Is it safe to shelter the user a little bit more from the git
> internals here and say instead:
>
>    Submodule '\$sm_path' is not initialized.

Sounds like a sensible suggestion.

> Also, I think this code will show this message for each submodule on
> 'git submodule deinit .'  But I think I would prefer to suppress it in
> that case.  If I have not explicitly stated which submodules to
> deinit,...

But isn't it the way to explicitly say "everything under the sun"?
After all, what does the message say to "git submodule deinit"?
