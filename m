From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git submodule update and the --merge flag when submodule is yet
 to be checked out
Date: Fri, 18 Mar 2011 14:01:18 -0700
Message-ID: <7vipvgw3c1.fsf@alter.siamese.dyndns.org>
References: <AANLkTikJo_pjSAmVV3wjWi04io4zWb-_P5p81TYj9tq6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Spencer E. Olson" <olsonse@umich.edu>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Carl =?utf-8?Q?F=C3=BCrstenberg?= <azatoth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gnh-0001BQ-E3
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab1CRVBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 17:01:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949Ab1CRVBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 17:01:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C349418B;
	Fri, 18 Mar 2011 17:03:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K0T7G4iPo4Zu
	+QHEyvEmW8DOkCM=; b=uRZ/yfbTCdgWd6svC22zw8Q8AIeYJBqeXNwxPK+ff7up
	WAt7u5obpT3VTHWbGmJ+pp5+PcYXgVYhBKd061bAMAtHH+njPXosBqogjkplf8R/
	fzP8LTloAKqkPUohVAJ1xJXyo9GoVteePJTWIwG0A3bbdDQLgZW0/PM5uN3IgWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ucy45Q
	7kllNlCyj7vvj7MuQnfw3ihPGgsG5Vzo2KB2vC6Gf7t/eD9sLuAWebl1PeRrakSO
	09Paqyezdb+/yowcus6qJdFPz4vXb9XG75Q82VtU+uRpyGwfhPf+YfQ7+SrdtN+8
	PqZUq2hDAyzIWi3r2hpNwHO0bTdXzMpYE88Yo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47D3B4182;
	Fri, 18 Mar 2011 17:03:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F06774175; Fri, 18 Mar 2011
 17:02:54 -0400 (EDT)
In-Reply-To: <AANLkTikJo_pjSAmVV3wjWi04io4zWb-_P5p81TYj9tq6@mail.gmail.com>
 ("Carl =?utf-8?Q?F=C3=BCrstenberg=22's?= message of "Fri, 18 Mar 2011
 19:25:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B62FC86-51A3-11E0-A3F7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169358>

Carl F=C3=BCrstenberg <azatoth@gmail.com> writes:

> Sorry for re-posting the question but I though I should explain the
> issue better and to fix the subject line.
> sub
> When you are cloning repository containing submodules, and you are
> using the --merge flag to "git submodule update" the first time, then
> the submodule instance in question will assume you want to delete all
> files present in the module.

Is this something we fixed last month?

commit 1b4735d9f3e0b7ea62c7c22f0afcb45e10c46c7e
Author: Spencer E. Olson <olsonse@umich.edu>
Date:   Thu Feb 17 09:18:45 2011 -0700

    submodule: no [--merge|--rebase] when newly cloned
   =20
    "git submodule update" can be run with either the "--merge" or "--r=
ebase"
    option, or submodule.<name>.update configuration variable can be se=
t to
    "merge" or "rebase, to cause local work to get integrated when upda=
ting
    the submodule.
   =20
    When a submodule is newly cloned, however, it does not have a check=
 out
    when a rebase or merge is attempted, leading to a failure.  For new=
ly
    cloned submodules, simply check out the appropriate revision.  Ther=
e is no
    local work to integrate with for them.
   =20
    Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
    Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
