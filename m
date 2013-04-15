From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Sun, 14 Apr 2013 18:39:44 -0700
Message-ID: <7vli8k4lnj.fsf@alter.siamese.dyndns.org>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
 <7v8v4k6hp2.fsf@alter.siamese.dyndns.org>
 <79879228B71A45A48A961F5B1880B61F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYOe-0005eQ-GC
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab3DOBjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:39:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab3DOBjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:39:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22ED711E4C;
	Mon, 15 Apr 2013 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i+REW2xlOaGmSGGNioCrBYTX+sY=; b=Q7sXYm
	A0lVZSbixV1bm2Bq9Km1f3lJtVzYAC4QJ6Gb9HLkU+FEQG3ZxuBFkr8gFs+g9vCL
	rjWnTnap9ZETM74gGmsQPaFgiwIMMdrK15aiS52SoRwq3szShdj4sBoTroxt5Uzu
	WAaarwsYQTUPrhTDih3KALYfqARKZgTvVA5KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ABMDu5G3htGJxjDN7q40LZUeZVy/jwo4
	DbxCMnwfhy1rmB2/KTrWyw0X0t2E9cAwmVWL54qS98rdPlqpv+48LVObTtxZP4Fg
	Cw6jRhzam8V45nK2/kXGCAVeLKe9/XsAsIRWyFWqEIZ1aai9GHSA54TdP1pXf73c
	A/3eGhHMN5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1627C11E4B;
	Mon, 15 Apr 2013 01:39:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68BF911E4A; Mon, 15 Apr
 2013 01:39:46 +0000 (UTC)
In-Reply-To: <79879228B71A45A48A961F5B1880B61F@PhilipOakley> (Philip Oakley's
 message of "Sun, 14 Apr 2013 22:26:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A96E7BC-A56D-11E2-AB0A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221179>

"Philip Oakley" <philipoakley@iee.org> writes:

>> If the "parsing" is done for white/blacklist purposes, is there a
>> need to straight-jacket the verison string format like this series?
>
> The purpose is to document what we felt we could guarantee, and that
> which was open to variation, so that those, like the Git-Gui, can code
> in a sensible check for the version. Two digits (X.Y) should pass the
> existing Git Gui check.
>
> I'll drop the length limit, and keep to an X.Y check
>
> Is the end of t0000-basic.sh a sensible place for the check?

Sorry, but I still do not understand what you are trying to achieve.

What kind of benefit are you envisioning out of this?  For a future
version, people would not know what incompatibilities it would
introduce, so

	case "$(git version)" in
	"git verison"[2-9].*)
        	echo unsupported version
                exit 1
                ;;
	esac

is a nonsense check.

For all released versions, people know how they looked like and we
do not have anything further to specify.  Git 1.5.0 will forever
identify itself as:

	$ git version
        git version 1.5.0

Worse yet, for an untagged version, you may get something like

	git version 1.8.2.1-515-g78d2372

and it may or may not behave the same way as 1.8.2.1 depending on
what trait you are interested in.
