From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report, v1.7.12.1 -- Documentation/git-bundle.xml:130:
 parser error
Date: Sun, 30 Sep 2012 00:34:18 -0700
Message-ID: <7vipawge11.fsf@alter.siamese.dyndns.org>
References: <20120930030819.b5195ee0.hesco@yourmessagedelivered.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hesco@yourmessagedelivered.com
X-From: git-owner@vger.kernel.org Sun Sep 30 09:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIE2p-00026w-Rh
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab2I3HeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:34:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab2I3HeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:34:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C2229CE8;
	Sun, 30 Sep 2012 03:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d2R5Zw6Rfjzz6EgMk1AuXR28JTY=; b=bIB5dk
	1F5cdOG2tPD2B6iTNbf7gY3f6fvhijv5uTjyBMogBxz4XAI7WPVV3T2973EAtM8G
	CkLzuzROi1RitJDXR3XsTwNqjfB0TEmMT1LuWDlMpKpjYx4Ncsiv5Dqe0uaaLlDG
	QicWmJMVSJCwEyKuqx+DQblQYyGxceVPUauV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDwHg4DsRR6QGlxoV3oVNGuU3TTpiBRG
	c7lZbbxDgvGm/KwIoNcM96tl2ueUEvsq4/+HYLmFF/LnyhNtzgjH57SeSQ8hxuou
	jxxjo9MItobKEn0FVbsoYTV0R5dRdAPPM7uItw/stjEq+HSpGA34gwAyZNQ2tqDM
	07WY4lzC8Q0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A2B29CE7;
	Sun, 30 Sep 2012 03:34:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 749A29CE6; Sun, 30 Sep 2012
 03:34:20 -0400 (EDT)
In-Reply-To: <20120930030819.b5195ee0.hesco@yourmessagedelivered.com> (Hugh
 Esco's message of "Sun, 30 Sep 2012 03:08:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F87F290-0AD1-11E2-BC1C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206674>

Hugh Esco <hesco@yourmessagedelivered.com> writes:

> doing a source install of git v1.7.12.1, 
> on the `make all doc` step, I get:
>
> xmlto: input does not validate (status 1)
> /usr/local/git-git-51993a4/Documentation/git-bundle.xml:130: parser error : Opening and ending tag mismatch: subscript line 130 and literal
> such as <literal>master<subscript>1</literal> cannot be packaged, but are perfec
>                                              ^
> /usr/local/git-git-51993a4/Documentation/git-bundle.xml:134: parser error : Opening and ending tag mismatch: literal line 134 and subscript
> specified explicitly (e.g. <literal>^master</subscript>10</literal>), or implici
>                                                        ^
> make[1]: *** [git-bundle.1] Error 1
> make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
> make: *** [doc] Error 2
>
> -------------------------------------------
> and the patch which permitted me to proceed
> -------------------------------------------
>
> 130c130
>> such as <literal>master</literal><subscript>1</subscript> cannot be packaged, but are perfectly suitable for

PLEASE STOP.

git-anything.xml files are _not_ the source files we edit, so
patches to them are not useful for us.

I suspect that a tilde inside literal `` environment is mishandled
in your versions of the documentation toolchain.  Either you would
need to upgrade some tool in the toolchain, or we would need patches
to the source that would look like:

	-such as `master~1` cannot be packaged,...
        +such as `master{tilde}1` cannot be packaged,...

to work around this problem if the version of the problematic tool
you are using is widespread.
