From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Fri, 21 Jan 2011 12:58:35 -0800
Message-ID: <7v39omotxg.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino> <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 21:59:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgO4T-0007H5-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 21:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab1AUU6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 15:58:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1AUU6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 15:58:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D64B251E;
	Fri, 21 Jan 2011 15:59:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lSv45W75tEWOppfSP5BTj6q/asY=; b=xNZxEY
	Ai50ip6o8asdU+IEvnkjWsXLMepg6Ymb/xvQv/6Zkk59bJHgcr3iZ9jUyjiWjkiV
	7H/nOg3Egt1yoGxmFM+xMCYNkrvBi5VyQyuJacD4UC5uJpA9gbA5CTL4eYT0xcPf
	qr0LItKM3N1QGaD/2ZJDA46HZ1LTW+CObFXRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E2clmdoOOfs5GFT/9Ip4ICoDUlRnSqGL
	Mi4sjd09SSLF+DDm1S/SHLVTD9xJnF7oDFFhexiurqZnbrQJ/zBc9796bY2rnCHc
	JcXImuHANowdFIAwMLKouQUZjZPIBu4a3TfKBScgngOreBoy/4TVKOqV60u6Hj94
	yuszyG/hHmU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C63E6251B;
	Fri, 21 Jan 2011 15:59:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BECE2517; Fri, 21 Jan 2011
 15:59:24 -0500 (EST)
In-Reply-To: <7vpqrssl5d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 19 Jan 2011 12\:17\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56D284EA-25A1-11E0-BB2F-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165393>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, thanks for a nice summary.
> ...
>
>> 5. The interaction with core.bare and implicit bareness are not
>>    obvious.  Clearly core.bare should conflict with core.worktree,
>>    but can GIT_WORK_TREE override that?  Maybe
>>    check_repository_format_gently is the right place for this check
>>    (rather than the setup procedure).
>
> IIRC, we on purpose added support to allow GIT_WORK_TREE to tentatively
> lift bareness of a repository so that people can
>
> 	cd /var/tmp
>         GIT_WORK_TREE=. git --git-dir=/srv/git/jgit.git checkout -f
>
> to get a snapshot easily.
>
>> (1) and (2) have been resolved by your work (nice!), (3) seems like
>> a case of "don't do that, then", and (4) out to error out in
>> setup_nongit (though my patch doesn't take care of that).  Given an
>> answer to (5) we could wholeheartedly and consistently support
>> worktree with implicit gitdir, as a new feature.
>
> As long as we really can support it _consistently_, I wouldn't see a big
> problem in resurrecting the historical accident as a feature.  You earlier
> said gitolite also misuses the interface, but does the usage pattern it
> has the same as the one in the debian script you had trouble with, and do
> they expect the same behaviour?

I was re-reading this thread, and changed my mind; I think we should have
this series to avoid unnecessary regression, with or without clarifying
(5), before 1.7.4 final.

Even if some scripts you had trouble with started using GIT_WORK_TREE
without specifying GIT_DIR because they misunderstood what these are
designed to do, as long as the combination has been working consistently
with the expectation of these scripts, ans as long as we can keep the same
behaviour, I don't see a reason to change it.
