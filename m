From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too early
Date: Wed, 14 Jul 2010 13:36:16 -0700
Message-ID: <7v630hyf5r.fsf@alter.siamese.dyndns.org>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 22:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ8h8-0004Yo-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 22:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693Ab0GNUga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 16:36:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473Ab0GNUg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 16:36:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFA39C4B82;
	Wed, 14 Jul 2010 16:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HNTDoYINTBPO
	ZcfvoPlY3qBMtGo=; b=ev35xZbcyjX6NmT9c4WSxxttiyDpOzf2NX2WNZCtFt5P
	OqdFs1gCxWfkyELe98K/3OKyh6Gj9HcdH+T19qWb0xblYO7sJryZ9BbXY9Y5zf9G
	MP8YzFJU+eBA4ZSnwdi6w96jMKLyxucvkdQUa3SXjgRh48PSZEHn0Dli5rlSuVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=svEJIy
	sjn9Cv9tTNmUmaGksNQCLXk/W/LBfX/yiyC7SjO2/ZHY0/7aTdL/d40SfDlZJUtD
	mhUlym3l7ZdRnk3QCPj9K4h2A0RDWjqGSijMIkVSErOdTcBWIppA7oFgI0zJ0xWJ
	8GU5vOzfUQ0rZ5LJDx1VDMVOPanMMOFpqGPs4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E675C4B80;
	Wed, 14 Jul 2010 16:36:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82044C4B7F; Wed, 14 Jul
 2010 16:36:18 -0400 (EDT)
In-Reply-To: <7vpqzacs3h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 28 Jun 2010 22\:42\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 779878A2-8F87-11DF-BBF0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151033>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Patch is against master.  There is a small semantic conflict with
>> jn/grep-open: SIMPLEPAGER should be changed to SIMPLEPAGERTTY in the
>> prerequisites for the test_default_pager function.  Please let me
>> know if I should push a merge commit to help resolve that.
>
> Thanks for advance warning; please double check the merge result in '=
pu'
> when I push it out...

I hate an enumeration that pretends to be exhausitive but is not.

    So delay the pager startup when possible:
   =20
    1. run_argv() already commits pager choice inside run_builtin() if =
a
       command is found.  For commands that use RUN_SETUP, waiting unti=
l
       then fixes the problem described above: once git knows where to
       look, it happily respects the core.pager setting.

=2E.. and for commands that do not use RUN_SETUP, what happens?

    2. list_common_cmds_help() prints out 29 lines and exits....
    3. help_unknown_cmd() prints out a few lines to stderr.  It is not
       important to paginate this, so don=E2=80=99t.

Missing from the above enumeration are are external commands.  They dep=
end
on commit_pager_choice() to be called before execv_dashed_external() ge=
ts
called.  For example, "git -p request-pull $args" no longer works with
this patch.

Sigh..
