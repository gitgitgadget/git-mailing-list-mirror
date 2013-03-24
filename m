From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Sat, 23 Mar 2013 22:13:15 -0700
Message-ID: <7vhak14bys.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
 <7vsj3pdcm5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kHFHtsy1Eh+jnY-JNSDUYd2xtiavhPNjaT8H3mJvYZkA@mail.gmail.com>
 <20130322182550.GF12223@google.com> <7vehf76uai.fsf@alter.siamese.dyndns.org>
 <CALkWK0nspPEaA3BLjgV6Qv2UgXRbDft1d6SmRCiVNJoxpqLFwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 06:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJdFi-0008NT-9h
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 06:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab3CXFNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 01:13:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab3CXFNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 01:13:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451D68934;
	Sun, 24 Mar 2013 01:13:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQg8ggJc5pdn0Wv9cB4M0Nuhh9M=; b=ht+TjM
	aO2LpDAsSSrOrIyLyEu/M5Bm2khtA3jxMy1l2tQkwa5gqCvtuWMy/rn0E/EjUaSl
	qWzw9VdDhTz1KgS2ECLcQo/vCAcoTOuEzadnwsZh7GGEqttNjKXIw0IO5AdEDmqa
	Y1TGstb3ELK9cDV/NXtJ6uLecs7umQZ/JO8n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MLsD8llebFToEzDQKRJ9BOiqduPBnBBt
	vKA5B3HqX9L+2u84MAIvagopasEeBlpW3gn3G7cd+BZjGyKfH1o2uds4A+H5z86i
	vwJi1Vxqso0Tf2ZYNIMz1XrrG5VUGmNCSDP+QEEtl4jq/tn33XhXYrKm7+2rGKeb
	GjJ6YlKJ4aQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A7B38933;
	Sun, 24 Mar 2013 01:13:17 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BAFC8931; Sun, 24 Mar 2013
 01:13:16 -0400 (EDT)
In-Reply-To: <CALkWK0nspPEaA3BLjgV6Qv2UgXRbDft1d6SmRCiVNJoxpqLFwg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 23 Mar 2013 18:21:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88FADA4C-9441-11E2-B0E3-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218934>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>
>> FWIW, I am not convinced yet why we would even want "git continue"
>> in the first place, so I won't be the one who would be suggesting a
>> migration path.
>
> Okay, I'm confused now.  You were the one who suggested a unified "git
> continue" in the first place, if my memory serves me right.  Why are
> you doubting it now?

AFAIR, the only thing I said about "continue" was that in a more
rational future where many "git frotz" commands that can stop and
ask the user to help exist, after the user helps the command by
creating the desired outcome in the index, the way the user signals
that she is done helping would be "git frotz --continue", and the
"After helping 'git merge', conclude it with 'git commit'" would be
an odd-man-out, and adding 'git merge --continue' may not be a bad
idea to make things more consistent.  Originally the way to help
"am" (with or without "-3") was to say "am --resolved", but that has
long been fixed to also take "am --continue".

So if you are adding "git merge --continue", that would be fine by
me, but I never said "git continue" subcommand would make any sense
at all.
