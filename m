From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] test-lib.sh: add test_utf8() function
Date: Fri, 07 Jan 2011 10:45:11 -0800
Message-ID: <7vtyhk7du0.fsf@alter.siamese.dyndns.org>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
 <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost>
 <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
 <8559d90bff6fca1c18f1cbf3530f2f4cc695f9f4.1294312018.git.yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:45:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHJZ-00086z-TB
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab1AGSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:45:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab1AGSpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:45:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47F072DCC;
	Fri,  7 Jan 2011 13:45:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gFhVMCFt3NvUngCOD0Uk9MkFhxY=; b=ISu61G
	WfpApkMCP5JbHkweL7N2f681Boz5eDvEvT9Zga3khiZeh7gYtUaiMkJ6AXx/zxDv
	XcZ5DjfenQoLXCsioGkDorDc18OpnfzXq3Y6ktW6UbdJryeVgwWpTOwRsv93ICop
	bs63xDIH25oAoUAlYFjQA90sekQihO46SYnL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iIKts0VZz//KoI9/QGEYmmTqw3xlJ3y7
	CMjr3NAbui9gl9uW2UZG+TGOmoXzrQXDzgkmlz41AG5lNWfpaBiV2c9dUAMAAvRr
	F4B88W7NdcCHhchUoF7eY1FS1FufDqcPAwMjD0tc6N8eF5lBPfAOYRtkF7BuQiBN
	BTVg9btIVw4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EFA52DCB;
	Fri,  7 Jan 2011 13:45:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 815E02DC9; Fri,  7 Jan 2011
 13:45:52 -0500 (EST)
In-Reply-To: <8559d90bff6fca1c18f1cbf3530f2f4cc695f9f4.1294312018.git.yann@droneaud.fr>
 (Yann Droneaud's message of "Thu\,  6 Jan 2011 15\:22\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C6A8664-1A8E-11E0-BBAE-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164737>

Yann Droneaud <yann@droneaud.fr> writes:

> +# check UTF-8 locale availability
> +test_utf8 () {
> +    if test_have_prereq PERL ; then
> +	# output an en_US.UTF-8 locale compatible name
> +	GIT_LC_UTF8=`$PERL_PATH $GIT_BUILD_DIR/t/lib-locale.pl`
> +    fi
> +    if test -z "$GIT_LC_UTF8" ; then
> +	return 1
> +    else
> +	test_set_prereq UTF8
> +	return 0
> +    fi
> +}

Nice abstraction to have a helper function that picks a locale to be used
when we want to test UTF-8 thingy.  Perhaps pick_utf8_locale might be a
better name, though. 

The comment in the function is not wrong per-se, but it and the
implementation in 1/4 may be too restrictive---all it needs to do is to
pick a locale that is UTF-8, and it does not necessarily have to be en_US,
no?
