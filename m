From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override
 committer information
Date: Thu, 20 Jan 2011 11:00:12 -0800
Message-ID: <7vaaivs8n7.fsf@alter.siamese.dyndns.org>
References: <igadki$4tb$2@dough.gmane.org>
 <1294568989-5848-1-git-send-email-artagnon@gmail.com>
 <20110109172431.GA7718@burratino> <201101111542.15185.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stephen Kelly <steveire@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 20 20:00:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfzkN-0003GQ-5P
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 20:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1ATTAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 14:00:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab1ATTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 14:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 984454B3B;
	Thu, 20 Jan 2011 14:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=1eIrtAG1Tz4ke6SjROG+TpsoSPI=; b=TV8hxB
	JbdvOZ7cRSKePz+CoC+n2vQoTIO/qNi35HNBxmWCoXj7f4+bZBuyOHD3u/brBKDY
	M0Ag30ijBuY4f1Ym8AF+TmrXzlqFe+XeRSxlrEEB13L7h4+NNG59RFmVYz64zb23
	L0uQ+kqLPjb64UgDGrcSPStExr9BR5nWqwNo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nk6adTyp9RRxIsT4ufvIP+J5eMYTh2TH
	KgF58Fds23kprCljScQDUtj4nerAedak1TsnRyeaijwmoWATcDYpe9CeVXRL8oON
	cDWX1Ze1loWf9dUa/CasXuAzNXVKxfPRCfa5MMCuvChOa89opOMJaeMuuBMSHZN0
	ekviAeYotMg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35ADB4B3A;
	Thu, 20 Jan 2011 14:01:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B2BD4B31; Thu, 20 Jan 2011
 14:00:58 -0500 (EST)
In-Reply-To: <201101111542.15185.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 11 Jan 2011 15\:42\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2EEE2EA-24C7-11E0-B24B-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165322>

Thomas Rast <trast@student.ethz.ch> writes:

> Well, now that I'm rethinking it, the weird thing is that it does not
> override in the way that the user intuitively might expect.
>
> Assume we also had user.authoremail for completeness, and you do
>
>   git config --global user.authoremail author@example.com
>   git config --global user.committeremail committer@example.com
>   git config user.email user@example.com
>
> Probably the user would expect this to result in a uniform
> user@example.com identity for the current repo, but I don't think we
> can twist it that way with the current config infrastructure.  The
> obvious option of having user.{author,committer}* override the more
> generic user.* would be contrary to that intuition.

The thing is that the "intuition" is not so cut-and-dried.  "email" is
indeed more generic than "authoremail", so it is intuitive for the latter
to override the former.  But "$HOME/.gitconfig" is fallback default for
the repository specific .git/config so it also is intuitive for anything
in the latter to override whatever is in the former.  Now you have a
conflicting "more specific authoremail in more generic $HOME/.gitconfig vs
more generic email in more specific .git/config---which wins?" situation.

Is there a way to document the rule of precedence clearly?  For this
particular case, recommending against setting author/committer-email in
the fallback default $HOME/.gitconfig in the Documentation/config.txt
might be sufficient.

But I am still not convinced why two need to be custom-set differently
when both need to name _you_.  After all, Author and Committer are both
identifiers taken from the same namespace to identify real people, so if
you want to use one value for the committer to name _you_, I don't see a
sane reason why you want a different name to name the same _you_ in the
author field.

The specific use case in the thread talks about KDE workflow interpreting
the committer identifier in a particular way as a reason for it to be set
to a particular value, but does not clarify why the author has to be
different from that particular value for the committer.
