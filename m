From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] worktree: new config file hierarchy
Date: Wed, 27 Jan 2016 14:22:08 -0800
Message-ID: <xmqq7fiu7je7.fsf@gitster.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, max@max630.net, git@drmicha.warpmail.net,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:22:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOYTh-00061Y-A5
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 23:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966035AbcA0WWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 17:22:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964843AbcA0WWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 17:22:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 996C23E3A9;
	Wed, 27 Jan 2016 17:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pTJlv2hibe12
	i85+PaljYUafWe4=; b=i/017GyFa2LHmoIVX7yN0zelOttwdyvWY5DbUeq907bB
	uFKKgmqrnX8TSFouJz9K6zDOBn6kV+HKrWXvEiK3a5UEPzkXKl/6yjZbjImCUQD7
	aWm/7j8Vktc6x90WrvYDuWLCv1/IHWP1ABeUeE0THDy/ZMNGS/VPQ8PfkCcxoI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eDQqcr
	R2ZpNphtPBRo6RJx9ld5FmTk/IFVP4SxkTFqMGpmBnFxd515AuENInB4iutRQlpt
	n7T3/tuq9KTVnZVl46CDHuAdG+onKz204BO9JuUX7+5f48ME8SxD1S7CddUcTtD+
	a101saSF3yTHjOMtanOlZmqds52hIPBTbL4X4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 919323E3A8;
	Wed, 27 Jan 2016 17:22:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 172BE3E3A7;
	Wed, 27 Jan 2016 17:22:10 -0500 (EST)
In-Reply-To: <1453808685-21235-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 26
 Jan 2016 18:44:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 682FF40A-C544-11E5-BB71-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ($C stands for $GIT_COMMON_DIR for the rest of the message)
>
> In main worktree, we read these config files in this order:
>
> 1) system config
> 2) XDG config
> 3) user config
> 4) $GIT_DIR/config
>
> Currently linked worktrees share the same config file at step 4 with
> main worktree. The problem is, not all config variables can be
> shared. We need per-repo vars and per-worktree ones.
>
> With this patch, since worktree v1, the repo config file (or worktree
> config file in multi worktree context) is no longer shared. Main
> worktree reads $C/config.  Linked worktrees read $C/worktrees/xxx/con=
fig
> and a new file, $C/worktrees/config. Sharing is done via this new
> file. The read hierarchy for a worktree becomes
>
> 1) system config
> 2) XDG config
> 3) user config
> 4) $C/common/config
> 5) $C/worktrees/xxx/config (or $C/config for main worktree)
>
> Compare to an alternative scheme where $C/config contains both shared
> variables and main-worktree-only ones, this is a cleaner design.
>
> * We do not have to check every single variable name to see if it's
>   shared or per-worktree when reading config files.
>
> * We do not enforce any particular variable split. If a variable
>   is in $C/worktrees/config, it is shared. Putting core.worktree in
>   $C/worktrees/config is punished the same way the variable is put in
>   $HOME/.gitconfig, for example.
>
> * We will provide a new "git config --repo" to access this new config
>   file. In single-worktree context, or worktree v0, --repo is an alia=
s
>   of --local.
>
> There is one problem though. We store worktree version in config file
> and expect that all worktrees must share the same version (i.e. read
> the same config file). But the share-ness of per-repo config files is
> changed based on worktree version. Where do we put extensions.worktre=
e
> then?

I cannot see why it cannot live in $C/common/config, which would be
read as the fourth alternative in your earlier enumeration.  What I
am missing?
