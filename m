From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 08:17:29 -0700
Message-ID: <7v61xgraba.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
	<7vli6crau5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVlI-0004a2-On
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab3FNPRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:17:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3FNPRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:17:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE8E5258A0;
	Fri, 14 Jun 2013 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bWynlhE/rGVNYpAidy4GEazJLpU=; b=gR7vKF
	yHqdkjIp3A8G8k5r82+fgLppCUESHZih3sfCu4NLoByRmAaB5vCwa6Tk5cwcMqIZ
	eTvWTQeF28LaJWukcO+XQd/OqUEHEcNbMH5PlyiDka5GZCS/CofOXf+L8ZMhvAYu
	GDkFIiMFMFllIsFunzDdHBE1fx6sfglfIsg94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kmTpD/V/734yjrHfkSx9QVs0S3ogAxlj
	XYWoS3AhuZ45dwEXhsFfGfuoTDVTuUgjljm7NMvm65xXscITVUuyHkL7BkpoD8uS
	4QSFE3TwjX0Iy6uubgkiaU1oHkZozgB0Ft+5HfQqQ5CIAms+sCJhz0ZuNmdZmgs5
	pgFsVEJLofY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E0A2589E;
	Fri, 14 Jun 2013 15:17:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4091F2589B;
	Fri, 14 Jun 2013 15:17:31 +0000 (UTC)
In-Reply-To: <7vli6crau5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Jun 2013 08:06:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 884B4B54-D505-11E2-85FC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227885>

Junio C Hamano <gitster@pobox.com> writes:

>> +	# Possible stray $dotest directory
>> +	if test -d "$dotest"; then
>> +	case "$skip,$resolved,$abort" in
>> +		,,t)
>> +			rm -fr "$dotest"
>> +			exit 0
>> +			;;
>> +		*)
>> +			die "$(eval_gettext "Stray $dotest directory found.
>> +Use \"git am --abort\" to remove it.")"
>> +			;;
>> +	esac
>
> These two case arms are indented one level too deep (will locally
> touch up).

And then the message triggers at the second test in t3420 when
applied on top of 587947750bd7 (rebase: implement --[no-]autostash
and rebase.autostash, 2013-05-12) or 45acb7592825 (Merge branch
'rr/rebase-autostash', 2013-06-11).
